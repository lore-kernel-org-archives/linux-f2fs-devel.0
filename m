From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs-tools: fix the wrong message when errno is
	EBUSY
Date: Wed, 10 May 2017 21:16:46 +0800 (CST)
Message-ID: <68cfa509.adaa.15bf28137dd.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1d8RUR-0001SG-C4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 13:17:15 +0000
Received: from m15-36.126.com ([220.181.15.36])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1d8RUM-0001t1-Fd for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 13:17:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

If f2fs is unmounted with the -l option, the process can still use the
file system. In this case, the command mkfs.f2fs, fsck.f2fs, dump.f2fs,
defrag.f2fs, resize.f2fs and sload.f2fs failed due to the device is in
use by the system. At the moment f2fs is already not mounted, so it is
wrong to print error message "Error: Not available on mounted device!",
this patch fixes it.

[root@localhost home]# mkfs.f2fs -f /dev/sdb1
[root@localhost home]# mkdir -p /mnt/f2fs_mnt_point
[root@localhost home]# mount -t f2fs /dev/sdb1 /mnt/f2fs_mnt_point/
[root@localhost home]# cd /mnt/f2fs_mnt_point/
[root@localhost f2fs_mnt_point]# umount /dev/sdb1
umount: /mnt/f2fs_mnt_point: target is busy.
        (In some cases useful info about processes that use
         the device is found by lsof(8) or fuser(1))
[root@localhost f2fs_mnt_point]# umount -l /dev/sdb1
[root@localhost f2fs_mnt_point]# umount /dev/sdb1
umount: /dev/sdb1: not mounted
[root@localhost f2fs_mnt_point]# mkfs.f2fs -f /dev/sdb1

	F2FS-tools: mkfs.f2fs Ver: 1.8.0 (2017-04-28)

Info: Disable heap-based policy
Info: Debug level = 0
Info: Label =
Info: Trim is enabled
	Error: In use by the system!
	Error: Not available on mounted device!
[root@localhost f2fs_mnt_point]# fsck.f2fs /dev/sdb1
	Error: In use by the system!
	Error: Not available on mounted device!
[root@localhost f2fs_mnt_point]# dump.f2fs /dev/sdb1
	Error: In use by the system!
	Error: Not available on mounted device!
[root@localhost f2fs_mnt_point]# defrag.f2fs /dev/sdb1
	Error: In use by the system!
	Error: Not available on mounted device!
[root@localhost f2fs_mnt_point]# resize.f2fs /dev/sdb1
	Error: In use by the system!
	Error: Not available on mounted device!
[root@localhost f2fs_mnt_point]# sload.f2fs /dev/sdb1
	Error: In use by the system!
	Error: Not available on mounted device!

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fsck/main.c             | 2 ++
 mkfs/f2fs_format_main.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index fe127ec..47d6966 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -574,6 +574,8 @@ int main(int argc, char **argv)
 	f2fs_parse_options(argc, argv);
 
 	if (f2fs_devs_are_umounted() < 0) {
+		if (errno == EBUSY)
+			return -1;
 		if (!c.ro || c.func == DEFRAG) {
 			MSG(0, "\tError: Not available on mounted device!\n");
 			return -1;
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 21ceeeb..e645ccb 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -17,6 +17,7 @@
 #include <sys/mount.h>
 #include <time.h>
 #include <uuid/uuid.h>
+#include <errno.h>
 
 #include "config.h"
 #ifdef HAVE_LIBBLKID
@@ -252,7 +253,8 @@ int main(int argc, char *argv[])
 	}
 
 	if (f2fs_devs_are_umounted() < 0) {
-		MSG(0, "\tError: Not available on mounted device!\n");
+		if (errno != EBUSY)
+			MSG(0, "\tError: Not available on mounted device!\n");
 		return -1;
 	}
 
-- 
1.8.3.1
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
