all: test_module libplatform-x11-simple-window.so

libplatform-x11-simple-window.so:
	gcc platform-x11-simple-window.c -shared -o $@ -lX11 -lXext -lm -fPIC -rdynamic -funwind-tables

test_module:
	gcc module_test.c -o $@ -ldl -lm

clean:
	@rm -f libplatform-x11-simple-window.so test_module

test: test_module libplatform-x11-simple-window.so
	@echo && echo && ./test_module ./libplatform-x11-simple-window.so || echo

.PHONY: clean test
