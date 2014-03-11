From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: recover inline xattr data in roll-forward
 process
Date: Tue, 11 Mar 2014 13:37:38 +0800
Message-ID: <001401cf3cec$2daf5f10$890e1d30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously we do not recover inline xattr data of inode after power-cut, so
inline xattr data may be lost.
We should recover the data during the roll-forward process.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c415cec..e72b258 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1493,6 +1493,37 @@ void recover_node_page(struct f2fs_sb_info *sbi, struct page *page,
 	clear_node_page_dirty(page);
 }
 
+void recover_inline_xattr(struct inode *inode, struct page *page)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	void *src_addr, *dst_addr;
+	size_t inline_size;
+	struct page *ipage;
+	struct f2fs_inode *ri;
+
+	if (!is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR))
+		return;
+
+	if (!IS_INODE(page))
+		return;
+
+	ri = F2FS_INODE(page);
+	if (!(ri->i_inline & F2FS_INLINE_XATTR))
+		return;
+
+	ipage = get_node_page(sbi, inode->i_ino);
+	f2fs_bug_on(IS_ERR(ipage));
+
+	dst_addr = inline_xattr_addr(ipage);
+	src_addr = inline_xattr_addr(page);
+	inline_size = inline_xattr_size(inode);
+
+	memcpy(dst_addr, src_addr, inline_size);
+
+	update_inode(inode, ipage);
+	f2fs_put_page(ipage, 1);
+}
+
 bool recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
@@ -1500,6 +1531,8 @@ bool recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 	nid_t new_xnid = nid_of_node(page);
 	struct node_info ni;
 
+	recover_inline_xattr(inode, page);
+
 	if (ofs_of_node(page) != XATTR_NODE_OFFSET)
 		return false;
 
-- 
1.7.9.5
