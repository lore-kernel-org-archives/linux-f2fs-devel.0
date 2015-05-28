From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: hide common code in f2fs_replace_block
Date: Thu, 28 May 2015 19:15:35 +0800
Message-ID: <007501d09937$b7c64620$2752d260$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch clean up codes through:
1.rename f2fs_replace_block to __f2fs_replace_block().
2.introduce new f2fs_replace_block() to include __f2fs_replace_block()
and some common related codes around __f2fs_replace_block().

Then, newly introduced function f2fs_replace_block can be used by
following patch.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h     |  4 ++--
 fs/f2fs/file.c     | 12 ++----------
 fs/f2fs/recovery.c |  9 ++-------
 fs/f2fs/segment.c  | 17 ++++++++++++++++-
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 70cdf7b..1a0716c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1695,8 +1695,8 @@ void write_meta_page(struct f2fs_sb_info *, struct page *);
 void write_node_page(unsigned int, struct f2fs_io_info *);
 void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
 void rewrite_data_page(struct f2fs_io_info *);
-void f2fs_replace_block(struct f2fs_sb_info *, struct f2fs_summary *,
-					block_t, block_t, bool);
+void f2fs_replace_block(struct f2fs_sb_info *, struct dnode_of_data *,
+				block_t, block_t, unsigned char, bool);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
 		block_t, block_t *, struct f2fs_summary *, int);
 void f2fs_wait_on_page_writeback(struct page *, enum page_type);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b4ba74..aec96d3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -854,18 +854,10 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
 				set_data_blkaddr(&dn);
 			} else if (new_addr != NEW_ADDR) {
 				struct node_info ni;
-				struct f2fs_summary sum;
 
 				get_node_info(sbi, dn.nid, &ni);
-				set_summary(&sum, dn.nid, dn.ofs_in_node,
-								ni.version);
-
-				f2fs_replace_block(sbi, &sum, old_addr,
-								new_addr, true);
-
-				dn.data_blkaddr = new_addr;
-				set_data_blkaddr(&dn);
-				f2fs_update_extent_cache(&dn);
+				f2fs_replace_block(sbi, &dn, old_addr, new_addr,
+							ni.version, true);
 			}
 
 			f2fs_put_dnode(&dn);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9de2587..24a8c1d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -360,7 +360,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int start, end;
 	struct dnode_of_data dn;
-	struct f2fs_summary sum;
 	struct node_info ni;
 	int err = 0, recovered = 0;
 
@@ -420,13 +419,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			if (err)
 				goto err;
 
-			set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
-
 			/* write dummy data page */
-			f2fs_replace_block(sbi, &sum, src, dest, false);
-			dn.data_blkaddr = dest;
-			set_data_blkaddr(&dn);
-			f2fs_update_extent_cache(&dn);
+			f2fs_replace_block(sbi, &dn, src, dest,
+							ni.version, false);
 			recovered++;
 		}
 		dn.ofs_in_node++;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 492c59e..5545468 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1302,7 +1302,7 @@ void rewrite_data_page(struct f2fs_io_info *fio)
 	f2fs_submit_page_mbio(fio);
 }
 
-void f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				block_t old_blkaddr, block_t new_blkaddr,
 				bool recover_curseg)
 {
@@ -1362,6 +1362,21 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
+void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
+				block_t old_addr, block_t new_addr,
+				unsigned char version, bool recover_curseg)
+{
+	struct f2fs_summary sum;
+
+	set_summary(&sum, dn->nid, dn->ofs_in_node, version);
+
+	__f2fs_replace_block(sbi, &sum, old_addr, new_addr, recover_curseg);
+
+	dn->data_blkaddr = new_addr;
+	set_data_blkaddr(dn);
+	f2fs_update_extent_cache(dn);
+}
+
 static inline bool is_merged_page(struct f2fs_sb_info *sbi,
 					struct page *page, enum page_type type)
 {
-- 
2.3.3
