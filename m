From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [f2fs-dev PATCH] mkfs.f2fs: fix a segfault when setting
 more than 7 devices
Date: Sun, 22 Jan 2017 17:16:39 +0800
Message-ID: <7ea08c45-3ece-e894-5ca2-80d8a4ac9e0d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cVEGf-0006tu-KV
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 09:16:57 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cVEGe-0006dc-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 09:16:57 +0000
Received: by mail-pg0-f66.google.com with SMTP id 204so10917216pge.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 22 Jan 2017 01:16:56 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

[root@localhost f2fs-tools]# mkfs.f2fs -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 -c /dev/sdb1 /dev/sdb1 

kernel: mkfs.f2fs[9047]: segfault at 2b78a60f ip 0000000000401356 sp 00007fffde05c9c0 error 6 in mkfs.f2fs[400000+5000]

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 mkfs/f2fs_format_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 70ed77a..db1dc94 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -28,7 +28,7 @@ static void mkfs_usage()
 	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -a heap-based allocation [default:1]\n");
-	MSG(0, "  -c [device path]\n");
+	MSG(0, "  -c [device path] up to 7 devices excepts meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -l label\n");
@@ -84,6 +84,11 @@ static void f2fs_parse_options(int argc, char *argv[])
 			c.heap = atoi(optarg);
 			break;
 		case 'c':
+			if (c.ndevs >= MAX_DEVICES) {
+				MSG(0, "Error: Too many devices\n");
+				mkfs_usage();
+			}
+
 			if (strlen(optarg) > MAX_PATH_LEN) {
 				MSG(0, "Error: device path should be less than "
 					"%d characters\n", MAX_PATH_LEN);
@@ -135,12 +140,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 		mkfs_usage();
 	}
 
-	/* [0] : META, [1 to MAX_DEVICES + 1] : NODE/DATA */
+	/* [0] : META, [1 to MAX_DEVICES - 1] : NODE/DATA */
 	c.devices[0].path = strdup(argv[optind]);
-	if (c.ndevs > MAX_DEVICES) {
-		MSG(0, "\tError: Too many devices\n");
-		mkfs_usage();
-	}
 
 	if ((optind + 1) < argc) {
 		if (c.ndevs > 1) {
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
