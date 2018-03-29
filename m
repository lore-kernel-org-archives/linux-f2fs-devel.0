From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: support fsverity feature
Date: Wed, 28 Mar 2018 21:18:31 -0700
Message-ID: <20180329041831.98141-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f1P1M-0003xN-Hb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Mar 2018 04:18:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1P1K-0027Cb-Gd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Mar 2018 04:18:40 +0000
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
Cc: Jaegeuk Kim <jaegeuk@google.com>

From: Jaegeuk Kim <jaegeuk@google.com>

This is aligned to f2fs which reserves fsverity feature bit.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 fsck/mount.c            |  3 +++
 include/f2fs_fs.h       | 12 ++++++++----
 mkfs/f2fs_format_main.c |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index a925bb9..e5574c5 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -439,6 +439,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
 		MSG(0, "%s", " encrypt");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_VERITY)) {
+		MSG(0, "%s", " verity");
+	}
 	if (f & cpu_to_le32(F2FS_FEATURE_BLKZONED)) {
 		MSG(0, "%s", " blkzoned");
 	}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index c460050..4dd2106 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -563,6 +563,7 @@ enum {
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
 #define F2FS_FEATURE_LOST_FOUND		0x0200
+#define F2FS_FEATURE_VERITY		0x0400	/* reserved */
 
 #define MAX_VOLUME_NAME		512
 
@@ -745,10 +746,13 @@ struct f2fs_extent {
 /*
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
  */
-#define FADVISE_COLD_BIT       0x01
-#define FADVISE_LOST_PINO_BIT  0x02
-#define FADVISE_ENCRYPT_BIT    0x04
-#define FADVISE_ENC_NAME_BIT   0x08
+#define FADVISE_COLD_BIT	0x01
+#define FADVISE_LOST_PINO_BIT	0x02
+#define FADVISE_ENCRYPT_BIT	0x04
+#define FADVISE_ENC_NAME_BIT	0x08
+#define FADVISE_KEEP_SIZE_BIT	0x10
+#define FADVISE_HOT_BIT		0x20
+#define FADVISE_VERITY_BIT	0x40	/* reserved */
 
 #define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
 #define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 71fd7c2..741600e 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -86,6 +86,8 @@ static void parse_feature(const char *features)
 		features++;
 	if (!strcmp(features, "encrypt")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
+	} else if (!strcmp(features, "verity")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_VERITY);
 	} else if (!strcmp(features, "extra_attr")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR);
 	} else if (!strcmp(features, "project_quota")) {
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
