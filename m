From: Huajun Li <huajun.li.lee@gmail.com>
Subject: [f2fs-dev 1/1] f2fs-tools: add inline data check
Date: Sat, 26 Oct 2013 00:12:40 +0800
Message-ID: <1382717560-23388-1-git-send-email-huajun.li.lee@gmail.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Weihong Xu <weihong.xu@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Huajun Li <huajun.li@intel.com>

Add inline data check

Signed-off-by: Weihong Xu <weihong.xu@intel.com>
Signed-off-by: Huajun Li <huajun.li@intel.com>
Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 fsck/fsck.c       |    4 ++++
 include/f2fs_fs.h |    5 +++++
 2 files changed, 9 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index cdf68ab..7e263ed 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -338,6 +338,10 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 	if (ftype == F2FS_FT_CHRDEV || ftype == F2FS_FT_BLKDEV ||
 			ftype == F2FS_FT_FIFO || ftype == F2FS_FT_SOCK)
 		goto check;
+	if((node_blk->i.i_inline & F2FS_INLINE_DATA)){
+		DBG(3, "ino[0x%x] has inline data!\n", nid);
+		goto check;
+	}
 
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i); idx++) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index fb7c94c..68f427d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -360,6 +360,11 @@ struct f2fs_extent {
 
 #define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
+#define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
+						F2FS_INLINE_XATTR_ADDRS - 1))
+
+#define INLINE_DATA_OFFSET	(PAGE_CACHE_SIZE - sizeof(struct node_footer) \
+				- sizeof(__le32)*(DEF_ADDRS_PER_INODE + 5 - 1))
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
-- 
1.7.9.5

