From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] libf2fs: avoid build warning
Date: Mon, 31 Oct 2016 21:25:39 -0700
Message-ID: <20161101042539.32122-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c1Qdx-0007ZQ-2h
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Nov 2016 04:25:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c1Qdw-0008KU-7X
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Nov 2016 04:25:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This avoids the below warnings.

libf2fs_zoned.c:39:8: warning: ignoring return value of 'fscanf', declared with attribute warn_unused_result [-Wunused-result]
fscanf(file, "%s", str);
      ^
libf2fs_zoned.c: In function 'f2fs_get_zone_blocks':
libf2fs_zoned.c:72:8: warning: ignoring return value of 'fscanf', declared with attribute warn_unused_result [-Wunused-result]
fscanf(file, "%s", str);
      ^

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs_zoned.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 4ef4f1d..93b48f1 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -26,6 +26,7 @@ void f2fs_get_zoned_model()
 {
 	char str[128];
 	FILE *file;
+	int res;
 
 	/* Check that this is a zoned block device */
 	snprintf(str, sizeof(str),
@@ -36,9 +37,12 @@ void f2fs_get_zoned_model()
 		goto not_zoned;
 
 	memset(str, 0, sizeof(str));
-	fscanf(file, "%s", str);
+	res = fscanf(file, "%s", str);
 	fclose(file);
 
+	if (res != 1)
+		goto not_zoned;
+
 	if (strcmp(str, "host-aware") == 0) {
 		c.zoned_model = F2FS_ZONED_HA;
 		return;
@@ -57,6 +61,7 @@ int f2fs_get_zone_blocks()
 	uint64_t sectors;
 	char str[128];
 	FILE *file;
+	int res;
 
 	/* Get zone size */
 	c.zone_blocks = 0;
@@ -69,9 +74,12 @@ int f2fs_get_zone_blocks()
 		return -1;
 
 	memset(str, 0, sizeof(str));
-	fscanf(file, "%s", str);
+	res = fscanf(file, "%s", str);
 	fclose(file);
 
+	if (res != 1)
+		return -1;
+
 	sectors = atol(str);
 	if (!sectors)
 		return -1;
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
