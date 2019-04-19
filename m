From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] f2fs-tools: Change sysfs path look up logic
 for zoned block devices
Date: Fri, 19 Apr 2019 01:18:42 +0000
Message-ID: <BN3PR04MB22578448AD68CBA1EAFC5F92ED270@BN3PR04MB2257.namprd04.prod.outlook.com>
References: <20190410085659.9005-1-shinichiro.kawasaki@wdc.com>
 <b28f3e2b-dd92-772a-d1f4-32c547cc41b3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=00520c172=shinichiro.kawasaki@wdc.com>)
 id 1hHIB2-0005Gq-80
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 01:18:52 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHIAz-00F8F6-Rq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 01:18:52 +0000
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>

Hi Chao, thanks for your review.

On 4/17/19 11:21 AM, Chao Yu wrote:
> Hi Shin'ichiro,
> 
> On 2019/4/10 16:56, Shin'ichiro Kawasaki wrote:
>> The mkfs.f2fs checks 'zoned' and 'chunk_sectors' sysfs attributes of
>> zoned block devices to place F2FS areas aligned to block zone
>> boundaries. However, mkfs.f2fs code assumes the given device name has
>> corresponding sysfs path under /sys/block directory. This is not the
>> case when partition devices or symbolic links are specified as the
>> command line argument of mkfs.f2fs. In such a case, mkfs.f2fs fails to
>> read sysfs attributes for zoned block devices, handles the device as a
>> regular block device, and do not align F2FS areas to the block zone
>> boundaries. This results in F2FS write failures because of zone write
>> pointer miss-alignment in sequential write required zones.
>>
>> Change mkfs.f2fs to handle sysfs path correctly. Read symbolic link
>> to get canonical sysfs path. If the device is a partition, cut the last
>> directory name in the sysfs path to refer the holder device attributes.
>>
>> Also introduce read_file() and read_sys_attr() helper functions for
>> code simplicity.
>>
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> ---
>>   lib/libf2fs_zoned.c | 134 ++++++++++++++++++++++++++++++--------------
>>   1 file changed, 91 insertions(+), 43 deletions(-)
>>
>> diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
>> index 6e32f32..e645004 100644
>> --- a/lib/libf2fs_zoned.c
>> +++ b/lib/libf2fs_zoned.c
>> @@ -8,6 +8,7 @@
>>    */
>>   #define _LARGEFILE64_SOURCE
>>   
>> +#define _GNU_SOURCE
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>> @@ -15,6 +16,8 @@
>>   #include <unistd.h>
>>   #include <fcntl.h>
>>   #include <sys/stat.h>
>> +#include <sys/sysmacros.h>
>> +#include <linux/limits.h>
>>   #ifndef ANDROID_WINDOWS_HOST
>>   #include <sys/ioctl.h>
>>   #endif
>> @@ -24,67 +27,112 @@
>>   
>>   #ifdef HAVE_LINUX_BLKZONED_H
>>   
>> +/*
>> + * Read up to 255 characters from the first line of a file. Strip the trailing
>> + * newline.
>> + */
>> +static char *read_file(const char *path)
>> +{
>> +	char line[256], *p = line;
>> +	FILE *f;
>> +
>> +	f = fopen(path, "rb");
>> +	if (!f)
>> +		return NULL;
>> +	if (!fgets(line, sizeof(line), f))
>> +		line[0] = '\0';
>> +	strsep(&p, "\n");
>> +	fclose(f);
>> +
>> +	return strdup(line);
>> +}
>> +
>> +static char *read_sys_attr(const char *dev_path, const char *attr)
>> +{
>> +	struct stat statbuf;
>> +	char *sys_devno_path = NULL;
>> +	char sys_path[PATH_MAX];
>> +	ssize_t sz;
>> +	char *part_attr_path = NULL;
>> +	char *part_str = NULL;
>> +	char *delim = NULL;
>> +	char *attr_path = NULL;
>> +	char *attr_str = NULL;
>> +
>> +	if (stat(dev_path, &statbuf) < 0)
>> +		goto out;
>> +
>> +	if (asprintf(&sys_devno_path, "/sys/dev/block/%d:%d",
>> +		     major(statbuf.st_rdev), minor(statbuf.st_rdev)) < 0)
>> +		goto out;
>> +
>> +	sz = readlink(sys_devno_path, sys_path, sizeof(sys_path) - 1);
>> +	if (sz < 0)
>> +		goto out;
>> +	sys_path[sz] = '\0';
>> +
>> +	/*
>> +	 * If the device is a partition device, cut the device name in the
>> +	 * canonical sysfs path to obtain the sysfs path of the holder device.
>> +	 *   e.g.:  /sys/devices/.../sda/sda1 -> /sys/devices/.../sda
>> +	 */
>> +	if (asprintf(&part_attr_path, "/sys/dev/block/%s/partition",
>> +		     sys_path) < 0)
>> +		goto out;
>> +	part_str = read_file(part_attr_path);
> 
> It needs to handle the error of read_file() here?

I don't think so. The major scenario that read_file() returns NULL is fopen 
fails to read /sys/dev/block/%s/partition. It indicates that the target device 
is not a partition device. The sys_path and following code is still valid for 
the non-partition device.

The other minor read_file() NULL return scenario is strdup() failure because of 
memory shortage. Do you think f2fs-tools need strdup() return value check? If 
you suggest it, I will update the patch.

Thanks!

>> +	if (part_str && *part_str == '1') {
>> +		delim = strrchr(sys_path, '/');
>> +		if (!delim)
>> +			goto out;
>> +		*delim = '\0';
>> +	}
>> +
>> +	if (asprintf(&attr_path, "/sys/dev/block/%s/%s", sys_path, attr) < 0)
>> +		goto out;
>> +
>> +	attr_str = read_file(attr_path);
>> +out:
>> +	free(attr_path);
>> +	free(part_str);
>> +	free(part_attr_path);
>> +	free(sys_devno_path);
>> +	return attr_str;
>> +}
>> +
>>   void f2fs_get_zoned_model(int i)
>>   {
>>   	struct device_info *dev = c.devices + i;
>> -	char str[128];
>> -	FILE *file;
>> -	int res;
>> -
>> -	/* Check that this is a zoned block device */
>> -	snprintf(str, sizeof(str),
>> -		 "/sys/block/%s/queue/zoned",
>> -		 basename(dev->path));
>> -	file = fopen(str, "r");
>> -	if (!file)
>> -		goto not_zoned;
>> -
>> -	memset(str, 0, sizeof(str));
>> -	res = fscanf(file, "%s", str);
>> -	fclose(file);
>> -
>> -	if (res != 1)
>> -		goto not_zoned;
>> -
>> -	if (strcmp(str, "host-aware") == 0) {
>> -		dev->zoned_model = F2FS_ZONED_HA;
>> +	char *model_str;
>> +
>> +	dev->zoned_model = F2FS_ZONED_NONE;
>> +
>> +	model_str = read_sys_attr(dev->path, "queue/zoned");
>> +	if (!model_str)
>>   		return;
>> -	}
>> -	if (strcmp(str, "host-managed") == 0) {
>> +
>> +	if (strcmp(model_str, "host-aware") == 0)
>> +		dev->zoned_model = F2FS_ZONED_HA;
>> +	else if (strcmp(model_str, "host-managed") == 0)
>>   		dev->zoned_model = F2FS_ZONED_HM;
>> -		return;
>> -	}
>>   
>> -not_zoned:
>> -	dev->zoned_model = F2FS_ZONED_NONE;
>> +	free(model_str);
>>   }
>>   
>>   int f2fs_get_zone_blocks(int i)
>>   {
>>   	struct device_info *dev = c.devices + i;
>>   	uint64_t sectors;
>> -	char str[128];
>> -	FILE *file;
>> -	int res;
>> +	char * cs_str;
>>   
>>   	/* Get zone size */
>>   	dev->zone_blocks = 0;
>>   
>> -	snprintf(str, sizeof(str),
>> -		 "/sys/block/%s/queue/chunk_sectors",
>> -		 basename(dev->path));
>> -	file = fopen(str, "r");
>> -	if (!file)
>> -		return -1;
>> -
>> -	memset(str, 0, sizeof(str));
>> -	res = fscanf(file, "%s", str);
>> -	fclose(file);
>> -
>> -	if (res != 1)
>> +	cs_str = read_sys_attr(dev->path, "queue/chunk_sectors");
>> +	if (!cs_str)
>>   		return -1;
>>   
>> -	sectors = atol(str);
>> +	sectors = atol(cs_str);
>> +	free(cs_str);
>>   	if (!sectors)
>>   		return -1;
>>   
>>
> 


-- 
Best Regards,
Shin'ichiro Kawasaki
