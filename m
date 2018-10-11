From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 1/4] mkfs.f2fs: Added missing statements related
 to error checking.
Date: Thu, 11 Oct 2018 18:20:53 -0400
Message-ID: <0A9E2DD2-E2DA-4C24-A362-8778454B2142@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKI-0003mZ-Kc
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:02 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1gAjKG-006Mhf-St
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:02 +0000
Received: from airport-26.cs.toronto.edu ([128.100.27.26] helo=[172.31.34.138])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKA-0006Sd-9q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 18:20:54 -0400
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

The following patch adds a few missing statements related to error checking.

Signed-off-by: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
---
 mkfs/f2fs_format.c       | 10 ++++++++--
 mkfs/f2fs_format_utils.c |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9b0a0d1..a2685cb 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -991,12 +991,16 @@ static int f2fs_write_super_block(void)
 	u_int8_t *zero_buff;
 
 	zero_buff = calloc(F2FS_BLKSIZE, 1);
+	if (zero_buff == NULL) {
+		MSG(1, "\tError: Calloc Failed for super_blk_zero_buf!!!\n");
+		return -1;
+	}
 
 	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
 		if (dev_write_block(zero_buff, index)) {
-			MSG(1, "\tError: While while writing supe_blk "
+			MSG(1, "\tError: While while writing super_blk "
 					"on disk!!! index : %d\n", index);
 			free(zero_buff);
 			return -1;
@@ -1021,8 +1025,10 @@ static int f2fs_discard_obsolete_dnode(void)
 		return 0;
 
 	raw_node = calloc(sizeof(struct f2fs_node), 1);
-	if (!raw_node)
+	if (raw_node == NULL) {
+		MSG(1, "\tError: Calloc Failed for discard_raw_node!!!\n");
 		return -1;
+	}
 
 	/* avoid power-off-recovery based on roll-forward policy */
 	offset = get_sb(main_blkaddr);
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index bf9ffbd..36b363a 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -51,6 +51,11 @@ static int trim_device(int i)
 	int fd = dev->fd;
 
 	stat_buf = malloc(sizeof(struct stat));
+	if (stat_buf == NULL) {
+		MSG(1, "\tError: Malloc Failed for trim_stat_buf!!!\n");
+		return -1;
+	}
+
 	if (fstat(fd, stat_buf) < 0 ) {
 		MSG(1, "\tError: Failed to get the device stat!!!\n");
 		free(stat_buf);
-- 
2.10.1

Kind regards,
Stathis Maneas
