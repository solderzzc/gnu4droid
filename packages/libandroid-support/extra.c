#include <stdio.h>
#include <string.h>
#define LINE_MAX 2048

void * mempcpy (void *dest, const void *src, size_t n){
  return (char *) memcpy (dest, src, n) + n;
}

char * get_argv0(void){
	char cmdline[LINE_MAX], *ret;
	int fd, i, r;
	
	memset(cmdline, 0, sizeof(char)*LINE_MAX);
	
	fd = open("/proc/self/cmdline", O_RDONLY);
	for (i = 1; i < LINE_MAX; i++){
		r = read(fd, &cmdline[i], sizeof(char));
		putchar(0); if (r != 1) break;
		if (cmdline[i] == 0) break;
	}
	close(fd);
	return basename(cmdline);
}

char * get_current_dir_name(void){
	return getcwd(NULL, LINE_MAX);
}

int lockf(int fd, int cmd, off_t ignored_len) {
    return flock(fd, cmd);
}
