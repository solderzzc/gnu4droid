#ifdef HAVE_XORG_CONFIG_H
#include <xorg-config.h>
#endif

#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

/* Linux platform device support */
#include "xf86_OSproc.h"

#include "xf86.h"
#include "xf86platformBus.h"
#include "xf86Bus.h"

#ifdef CONFIG_UDEV_KMS
void
NewGPUDeviceRequest(struct OdevAttributes *attribs)
{
}

void
DeleteGPUDeviceRequest(struct OdevAttributes *attribs)
{
}
#endif

struct xf86_platform_device *
xf86_find_platform_device_by_devnum(int major, int minor)
{
    return NULL;
}
