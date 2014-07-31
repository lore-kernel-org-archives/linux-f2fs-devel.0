From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/2] f2fs: invalidate xattr node page when evict inode
Date: Thu, 31 Jul 2014 21:13:11 +0800
Message-ID: <017301cfacc1$4b476730$e1d63590$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When inode is evicted, all the page cache belong to this inode should be
released including the xattr node page. But previously we didn't do this, this
patch fixed this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0e69aa9..8a5403b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -267,10 +267,16 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 void f2fs_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	trace_f2fs_evict_inode(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 
+	if (fi->i_xattr_nid)
+		invalidate_mapping_pages(NODE_MAPPING(sbi),
+					fi->i_xattr_nid, fi->i_xattr_nid);
+
 	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
 			inode->i_ino == F2FS_META_INO(sbi))
 		goto out_clear;
-- 
2.0.1.474.g72c7794
