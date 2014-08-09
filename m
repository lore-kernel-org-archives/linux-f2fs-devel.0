From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/5] f2fs: enable inline dir handling
Date: Sat, 09 Aug 2014 10:49:38 +0800
Message-ID: <00c201cfb37c$b26f7800$174e6800$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XFwk1-0005HW-Ig
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:50:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XFwjz-0002x5-LQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:50:45 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA000LZTQKC4I10@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 11:50:36 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Add inline dir functions into normal dir ops' function to handle inline ops.
Besides, we enable inline dir mode when a new dir inode is created if
inline_data option is on.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c   | 26 ++++++++++++++++++++++++++
 fs/f2fs/namei.c |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 154a5fa..0e681e0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -201,6 +201,9 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 
+	if (f2fs_has_inline_data(dir))
+		return find_in_inline_dir(dir, child, res_page);
+
 	if (npages == 0)
 		return NULL;
 
@@ -227,6 +230,9 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p)
 	struct f2fs_dir_entry *de;
 	struct f2fs_dentry_block *dentry_blk;
 
+	if (f2fs_has_inline_data(dir))
+		return f2fs_parent_inline_dir(dir, p);
+
 	page = get_lock_data_page(dir, 0);
 	if (IS_ERR(page))
 		return NULL;
@@ -304,6 +310,9 @@ static int make_empty_dir(struct inode *inode,
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dir_entry *de;
 
+	if (f2fs_has_inline_data(inode))
+		return make_empty_inline_dir(inode, parent, page);
+
 	dentry_page = get_new_data_page(inode, page, 0, true);
 	if (IS_ERR(dentry_page))
 		return PTR_ERR(dentry_page);
@@ -464,6 +473,14 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	int err = 0;
 	int i;
 
+	if (f2fs_has_inline_data(dir)) {
+		err = f2fs_add_inline_entry(dir, name, inode);
+		if (!err || err != -EAGAIN)
+			return err;
+		else
+			err = 0;
+	}
+
 	dentry_hash = f2fs_dentry_hash(name);
 	level = 0;
 	current_depth = F2FS_I(dir)->i_current_depth;
@@ -573,6 +590,9 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	int i;
 
+	if (f2fs_has_inline_data(dir))
+		return f2fs_delete_inline_entry(dentry, page, dir, inode);
+
 	lock_page(page);
 	f2fs_wait_on_page_writeback(page, DATA);
 
@@ -631,6 +651,9 @@ bool f2fs_empty_dir(struct inode *dir)
 	struct f2fs_dentry_block *dentry_blk;
 	unsigned long nblock = dir_blocks(dir);
 
+	if (f2fs_has_inline_data(dir))
+		return f2fs_empty_inline_dir(dir);
+
 	for (bidx = 0; bidx < nblock; bidx++) {
 		dentry_page = get_lock_data_page(dir, bidx);
 		if (IS_ERR(dentry_page)) {
@@ -670,6 +693,9 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
 	unsigned char d_type = DT_UNKNOWN;
 
+	if (f2fs_has_inline_data(inode))
+		return f2fs_read_inline_dir(file, ctx);
+
 	bit_pos = ((unsigned long)ctx->pos % NR_DENTRY_IN_BLOCK);
 
 	/* readahead for multi pages of dir */
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 648b968..06b93ee 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -54,6 +54,10 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		nid_free = true;
 		goto out;
 	}
+
+	if (test_opt(sbi, INLINE_DATA) && S_ISDIR(inode->i_mode))
+		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+
 	trace_f2fs_new_inode(inode, 0);
 	mark_inode_dirty(inode);
 	return inode;
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
