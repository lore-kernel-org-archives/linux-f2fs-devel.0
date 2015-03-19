From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/4] f2fs: preserve extent info for extent cache
Date: Thu, 19 Mar 2015 19:27:51 +0800
Message-ID: <000301d06237$dd05c2d0$97114870$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YYYdD-0002IW-KA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Mar 2015 11:28:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YYYdB-0001zY-Dh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Mar 2015 11:28:55 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NLG006OEIJXW3A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Mar 2015 20:28:45 +0900 (KST)
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

This patch tries to preserve last extent info in extent tree cache into on-disk
inode, so this can help us to reuse the last extent info next time for
performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c  | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h  |  8 ++++++++
 fs/f2fs/inode.c |  5 +++++
 3 files changed, 62 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0c48af91..e761540 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -718,6 +718,55 @@ update_extent:
 	atomic_dec(&et->refcount);
 }
 
+void f2fs_preserve_extent_tree(struct inode *inode)
+{
+	struct extent_tree *et;
+	struct extent_info *ext = &F2FS_I(inode)->ext;
+	bool sync = false;
+
+	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
+		return;
+
+	et = __find_extent_tree(F2FS_I_SB(inode), inode->i_ino);
+	if (!et) {
+		if (ext->len) {
+			ext->len = 0;
+			update_inode_page(inode);
+		}
+		return;
+	}
+
+	read_lock(&et->lock);
+	if (et->count) {
+		struct extent_node *en;
+
+		if (et->cached_en) {
+			en = et->cached_en;
+		} else {
+			struct rb_node *node = rb_first(&et->root);
+
+			if (!node)
+				node = rb_last(&et->root);
+			en = rb_entry(node, struct extent_node, rb_node);
+		}
+
+		if (__is_extent_same(ext, &en->ei))
+			goto out;
+
+		*ext = en->ei;
+		sync = true;
+	} else if (ext->len) {
+		ext->len = 0;
+		sync = true;
+	}
+out:
+	read_unlock(&et->lock);
+	atomic_dec(&et->refcount);
+
+	if (sync)
+		update_inode_page(inode);
+}
+
 void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 836e5a9..9b0c75f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -362,6 +362,13 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
 	ei->len = len;
 }
 
+static inline bool __is_extent_same(struct extent_info *ei1,
+						struct extent_info *ei2)
+{
+	return (ei1->fofs == ei2->fofs && ei1->blk == ei2->blk &&
+						ei1->len == ei2->len);
+}
+
 static inline bool __is_extent_mergeable(struct extent_info *back,
 						struct extent_info *front)
 {
@@ -1579,6 +1586,7 @@ void f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
 void f2fs_destroy_extent_tree(struct inode *);
 void f2fs_init_extent_cache(struct inode *, struct f2fs_extent *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
+void f2fs_preserve_extent_tree(struct inode *);
 struct page *find_data_page(struct inode *, pgoff_t, bool);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fcd1e7b..599d328 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -333,7 +333,12 @@ void f2fs_evict_inode(struct inode *inode)
 no_delete:
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
+
+	/* update extent info in inode */
+	if (inode->i_nlink)
+		f2fs_preserve_extent_tree(inode);
 	f2fs_destroy_extent_tree(inode);
+
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
-- 
2.3.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
