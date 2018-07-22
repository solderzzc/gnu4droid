#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <X11/Xlib.h>
#include <X11/extensions/XShm.h>
#include "alien_module_api.h"

#define MOD_PRIV(p) ((struct module_private*)((p)->module_private))
struct module_private {
	Display *display;
	Visual *visual;
	Window window;
	
	XShmSegmentInfo shminfo;
	bool shmattached;
	XImage *image;
};

bool screen_initialize(alien_driver_private_ptr drv_priv){
	struct module_private* mod_priv;
	int8_t cur_mode;
	printf("Screen initializing started\n");
	mod_priv = drv_priv->module_private = malloc (sizeof(struct module_private));
	
	putenv("DISPLAY=:0");
	mod_priv->display=XOpenDisplay(NULL);
	mod_priv->visual=DefaultVisual(mod_priv->display, 0);
	if(mod_priv->visual->class!=TrueColor)
	{
		fprintf(stderr, "Cannot handle non true color visual ...\n");
		return false;
	}
	
	drv_priv->randr.modelist_clear(drv_priv);
	cur_mode = drv_priv->randr.modelist_add_mode(drv_priv, 512, 512);
	drv_priv->randr.modelist_add_mode(drv_priv, 800, 600);
	
	drv_priv->randr.mode_set(drv_priv, cur_mode);
	
	printf("Screen initializing finished\n");
	return true;
}

void *screen_create_pixmap(alien_driver_private_ptr drv_priv, uint16_t width, uint16_t height){
	struct module_private* mod_priv = MOD_PRIV(drv_priv);
	printf("Creating %dx%d window\n", width, height);
	mod_priv->window=XCreateSimpleWindow(mod_priv->display, RootWindow(mod_priv->display, 0), 0, 0, width, height, 1, 0, 0);
	XSelectInput(mod_priv->display, mod_priv->window, ButtonPressMask|ExposureMask|KeyPressMask);
	XMapWindow(mod_priv->display, mod_priv->window);
	
	mod_priv->image = XShmCreateImage(mod_priv->display, mod_priv->visual, 24, ZPixmap, 0, &mod_priv->shminfo, width, height);
	
	mod_priv->shminfo.shmid = shmget(IPC_PRIVATE, mod_priv->image->bytes_per_line * mod_priv->image->height,IPC_CREAT|0777);
	mod_priv->shminfo.shmaddr = mod_priv->image->data = shmat(mod_priv->shminfo.shmid, 0, 0);
	mod_priv->shminfo.readOnly = False;

	XShmAttach(mod_priv->display, &mod_priv->shminfo);
	mod_priv->shmattached = 1;
	
	return mod_priv->image->data;
}

void screen_destroy_pixmap(alien_driver_private_ptr drv_priv, void *pixmap_data){
	struct module_private* mod_priv = MOD_PRIV(drv_priv);
	
	if (pixmap_data == NULL) return;
	
	if (!mod_priv->shmattached) {
		XShmDetach(mod_priv->display, &mod_priv->shminfo);
		mod_priv->shmattached = 0;
	}
	XDestroyWindow(mod_priv->display, mod_priv->window);
}

void screen_image_update(alien_driver_private_ptr drv_priv){
	struct module_private* mod_priv = MOD_PRIV(drv_priv);
	
	XPutImage(mod_priv->display, mod_priv->window, DefaultGC(mod_priv->display, 0), mod_priv->image, 0, 0, 0, 0, mod_priv->image->width, mod_priv->image->height);
}

void screen_finalize(alien_driver_private_ptr drv_priv){	
	printf("Screen finalizing\n");
	struct module_private* mod_priv = MOD_PRIV(drv_priv);
	
	//screen_destroy_pixmap(drv_priv, mod_priv->image->data);
	XCloseDisplay(mod_priv->display);
	free(mod_priv);
	printf("Screen finalized\n");
}

alien_module_functions_t module_funcs = {
	.screen_initialize = screen_initialize,
	.screen_create_pixmap = screen_create_pixmap,
	.screen_destroy_pixmap = screen_destroy_pixmap,
	.screen_image_update = screen_image_update,
	.screen_finalize = screen_finalize,
};

alien_module_functions_ptr alien_module_initialize (alien_driver_private_t* driver_private){
	printf("Debuging X11 module loaded\n");
	return &module_funcs;
}

