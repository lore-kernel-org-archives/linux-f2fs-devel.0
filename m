From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/4] f2fs: initialize extent tree with on-disk extent info of
 inode
Date: Thu, 19 Mar 2015 19:26:02 +0800
Message-ID: <000201d06237$95bd9f60$c138de20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

With normal extent info cache, we records largest extent mapping between logical
block and physical block into extent info, and we persist extent info in on-disk
inode.

When we enable extent tree cache, if extent info of on-disk inode is exist, and
the extent is not a small fragmented mapping extent. We'd better to load the
extent info into extent tree cache when inode is loaded. By this way we can have
more chance to hit extent tree cache rather than taking more time to read dnode
page for block address.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/inode.c |  4 +---
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a73df90..0c48af91 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -571,6 +571,39 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count - et->count;
 }
 
+static void f2fs_init_extent_tree(struct inode *inode,
+						struct f2fs_extent *i_ext)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et;
+	struct extent_node *en;
+	struct extent_info ei;
+
+	if (le32_to_cpu(i_ext->len) < F2FS_MIN_EXTENT_LEN)
+		return;
+
+	et = __grab_extent_tree(inode);
+
+	write_lock(&et->lock);
+	if (et->count)
+		goto out;
+
+	set_extent_info(&ei, le32_to_cpu(i_ext->fofs),
+		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
+
+	en = __insert_extent_tree(sbi, et, &ei, NULL);
+	if (en) {
+		et->cached_en = en;
+
+		spin_lock(&sbi->extent_lock);
+		list_add_tail(&en->list, &sbi->extent_list);
+		spin_unlock(&sbi->extent_lock);
+	}
+out:
+	write_unlock(&et->lock);
+	atomic_dec(&et->refcount);
+}
+
 static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
@@ -781,6 +814,16 @@ out:
 	return;
 }
 
+void f2fs_init_extent_cache(struct inode *inode, struct f2fs_extent *i_ext)
+{
+	if (test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
+		f2fs_init_extent_tree(inode, i_ext);
+
+	write_lock(&F2FS_I(inode)->ext_lock);
+	get_extent_info(&F2FS_I(inode)->ext, *i_ext);
+	write_unlock(&F2FS_I(inode)->ext_lock);
+}
+
 static bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c5c3ae9..836e5a9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1577,6 +1577,7 @@ int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
 void f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
 void f2fs_destroy_extent_tree(struct inode *);
+void f2fs_init_extent_cache(struct inode *, struct f2fs_extent *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
 struct page *find_data_page(struct inode *, pgoff_t, bool);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b508744..fcd1e7b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -130,9 +130,7 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
-	write_lock(&fi->ext_lock);
-	get_extent_info(&fi->ext, ri->i_ext);
-	write_unlock(&fi->ext_lock);
+	f2fs_init_extent_cache(inode, &ri->i_ext);
 
 	get_inline_info(fi, ri);
 
-- 
2.3.1
