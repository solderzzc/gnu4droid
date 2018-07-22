#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <libgen.h>
#include <dlfcn.h>
#include <math.h>
#include "alien_module_api.h"

#define UNUSED __attribute__((unused))

alien_driver_private_t drv_private;
alien_module_functions_ptr module_funcs;

int server_width  = 0;
int server_height = 0;
uint8_t *pixmap_data;

void server_randr_modelist_clear(UNUSED alien_driver_private_ptr unused){}
int8_t server_randr_modelist_add_mode(UNUSED alien_driver_private_ptr unused, uint16_t width, uint16_t height){
	printf("Adding mode %dx%d to the list\n", width, height);
	if (server_width == 0 && server_height == 0) {
		server_width = width;
		server_height = height;
		printf("added mode %dx%d\n", width, height);
		return 0;
	}
	printf("adding mode %dx%d failed\n", width, height);
	return -1;
}
void server_mode_set(UNUSED alien_driver_private_ptr unused, UNUSED int8_t token){
	printf("Setting mode %dx%d\n", server_width, server_height);
	
	if (pixmap_data) {
		printf("Destroying old pixmap\n");
		module_funcs->screen_destroy_pixmap(&drv_private, pixmap_data);
	}
	
	printf("Creating new pixmap with size %dx%d\n", server_width, server_height);
	pixmap_data = module_funcs->screen_create_pixmap(&drv_private, server_width, server_height);
	printf("mode %dx%d is set\n", server_width, server_height);
}

void redrawImage(uint32_t *image, int w, int h) {
	static double it = 0;
	uint8_t color = sin(it)*256;
	int i, j; 
	
	for (i = 0; i < w; i++) for (j = 0; j < h; j++)
	image [ i + j*w ] = (i << 16)  | (j << 8) | (color<< 0);
	it+=0.05;
	if(it >= M_PI) it = 0;
}

int main (int argc, char **argv){
	int i, ret;
	char* module_path;
	const char* error;
	void *module_handle;
	alien_module_initialize_ptr module_initialize;
	
	if (argc !=2) { 
		printf("usage: %s <module>\n", basename(argv[0]));
		exit(1);
	}
	
	module_path = argv[1];
	
	drv_private.randr.modelist_clear = server_randr_modelist_clear;
	drv_private.randr.modelist_add_mode = server_randr_modelist_add_mode;
	drv_private.randr.mode_set = server_mode_set;
	
	module_handle = dlopen(module_path, RTLD_NOW);
	if (!module_handle){
		printf("%s\n", dlerror());
		exit(1);
	}
	
	dlerror();
	
	module_initialize = (alien_module_initialize_ptr) dlsym(module_handle, "alien_module_initialize");
	
	error = dlerror();
	if (error) {
		printf("%s\n", error);
		exit(1);
	}
	
	module_funcs = module_initialize(&drv_private);
	if (!module_funcs){
		printf("Module initialize failed\n");
		exit(1);
	}
	
	ret = module_funcs->screen_initialize(&drv_private);
	if (!ret) {
		printf("Screen initialize failed\n");
		exit(1);
	}
	
	for (i=0; i<200; i++){
		redrawImage(pixmap_data, server_width, server_height);
		module_funcs->screen_image_update(&drv_private);
		usleep(10000);
	}
	
	module_funcs->screen_destroy_pixmap(&drv_private, pixmap_data);
	module_funcs->screen_finalize(&drv_private);
	
	dlclose(module_handle);
	return 0;
}
