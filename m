From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove unneeded set_cold_node()
Date: Fri, 9 Mar 2018 14:24:22 +0800
Message-ID: <20180309062422.71686-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When setting COLD_BIT_SHIFT flag in node block, we only need to call
set_cold_node() in new_node_page() and recover_inode_page() during
node page initialization. So remove unneeded set_cold_node() in other
places.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c   | 2 --
 fs/f2fs/inode.c | 1 -
 fs/f2fs/node.c  | 3 ++-
 fs/f2fs/node.h  | 4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3644db9177cb..9a0d103b5052 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -396,8 +396,6 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		page = get_node_page(F2FS_I_SB(dir), inode->i_ino);
 		if (IS_ERR(page))
 			return page;
-
-		set_cold_node(inode, page);
 	}
 
 	if (new_name) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2e397473e69b..c85cccc2e800 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -462,7 +462,6 @@ void update_inode(struct inode *inode, struct page *node_page)
 	}
 
 	__set_inode_rdev(inode, ri);
-	set_cold_node(inode, node_page);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7817080236e0..43cab3ab14a5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1079,7 +1079,7 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 
 	f2fs_wait_on_page_writeback(page, NODE, true);
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
-	set_cold_node(dn->inode, page);
+	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 	if (set_page_dirty(page))
@@ -2322,6 +2322,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
+	set_cold_node(page, false);
 
 	src = F2FS_INODE(page);
 	dst = F2FS_INODE(ipage);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index b051196b5d5b..d105c4154544 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -425,12 +425,12 @@ static inline void clear_inline_node(struct page *page)
 	ClearPageChecked(page);
 }
 
-static inline void set_cold_node(struct inode *inode, struct page *page)
+static inline void set_cold_node(struct page *page, bool is_dir)
 {
 	struct f2fs_node *rn = F2FS_NODE(page);
 	unsigned int flag = le32_to_cpu(rn->footer.flag);
 
-	if (S_ISDIR(inode->i_mode))
+	if (is_dir)
 		flag &= ~(0x1 << COLD_BIT_SHIFT);
 	else
 		flag |= (0x1 << COLD_BIT_SHIFT);
-- 
2.15.0.55.gc2ece9dc4de6
