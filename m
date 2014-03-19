From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 5/5] f2fs: call f2fs_wait_on_page_writeback
 instead of native function
Date: Wed, 19 Mar 2014 09:24:25 +0900
Message-ID: <1395188665-4175-5-git-send-email-jaegeuk.kim@samsung.com>
References: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQ4Kw-0002bH-2U
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:26 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQ4Ku-0006IK-S3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:26 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2N000JSQJQW310@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 09:26:14 +0900 (KST)
In-reply-to: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If a page is on writeback, f2fs can face with deadlock due to under writepages.
This is caused by merging IOs inside f2fs, so if it comes to detect, let's throw
merged IOs, which is implemented by f2fs_wait_on_page_writeback.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  6 ++----
 fs/f2fs/dir.c        |  9 +++------
 fs/f2fs/file.c       |  6 +++---
 fs/f2fs/node.c       | 10 +++++-----
 fs/f2fs/recovery.c   |  2 +-
 5 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2a00c94..d0c5065 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -33,14 +33,12 @@ struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page = NULL;
 repeat:
-	page = grab_cache_page(mapping, index);
+	page = grab_cache_page_write_begin(mapping, index, 0);
 	if (!page) {
 		cond_resched();
 		goto repeat;
 	}
 
-	/* We wait writeback only inside grab_meta_page() */
-	wait_on_page_writeback(page);
 	SetPageUptodate(page);
 	return page;
 }
@@ -168,7 +166,7 @@ static int f2fs_write_meta_page(struct page *page,
 	if (unlikely(is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG)))
 		goto no_write;
 
-	wait_on_page_writeback(page);
+	f2fs_wait_on_page_writeback(page, META);
 	write_meta_page(sbi, page);
 no_write:
 	dec_page_count(sbi, F2FS_DIRTY_META);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f3a80ce..7c9b17c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -253,7 +253,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 		struct page *page, struct inode *inode)
 {
 	lock_page(page);
-	wait_on_page_writeback(page);
+	f2fs_wait_on_page_writeback(page, DATA);
 	de->ino = cpu_to_le32(inode->i_ino);
 	set_de_type(de, inode);
 	kunmap(page);
@@ -352,14 +352,11 @@ static struct page *init_inode_metadata(struct inode *inode,
 		err = f2fs_init_security(inode, dir, name, page);
 		if (err)
 			goto put_error;
-
-		wait_on_page_writeback(page);
 	} else {
 		page = get_node_page(F2FS_SB(dir->i_sb), inode->i_ino);
 		if (IS_ERR(page))
 			return page;
 
-		wait_on_page_writeback(page);
 		set_cold_node(inode, page);
 	}
 
@@ -494,7 +491,7 @@ start:
 	++level;
 	goto start;
 add_dentry:
-	wait_on_page_writeback(dentry_page);
+	f2fs_wait_on_page_writeback(dentry_page, DATA);
 
 	page = init_inode_metadata(inode, dir, name);
 	if (IS_ERR(page)) {
@@ -543,7 +540,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int i;
 
 	lock_page(page);
-	wait_on_page_writeback(page);
+	f2fs_wait_on_page_writeback(page, DATA);
 
 	dentry_blk = (struct f2fs_dentry_block *)kaddr;
 	bit_pos = dentry - (struct f2fs_dir_entry *)dentry_blk->dentry;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a4cc1d6..e755ee5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -76,7 +76,7 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 mapped:
 	/* fill the page */
-	wait_on_page_writeback(page);
+	f2fs_wait_on_page_writeback(page, DATA);
 out:
 	sb_end_pagefault(inode->i_sb);
 	return block_page_mkwrite_return(err);
@@ -245,7 +245,7 @@ static void truncate_partial_data_page(struct inode *inode, u64 from)
 		f2fs_put_page(page, 1);
 		return;
 	}
-	wait_on_page_writeback(page);
+	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
@@ -422,7 +422,7 @@ static void fill_zero(struct inode *inode, pgoff_t index,
 	f2fs_unlock_op(sbi);
 
 	if (!IS_ERR(page)) {
-		wait_on_page_writeback(page);
+		f2fs_wait_on_page_writeback(page, DATA);
 		zero_user(page, start, len);
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5e9c38e..707fd20 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -725,7 +725,7 @@ skip_partial:
 				f2fs_put_page(page, 1);
 				goto restart;
 			}
-			wait_on_page_writeback(page);
+			f2fs_wait_on_page_writeback(page, NODE);
 			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
 			set_page_dirty(page);
 			unlock_page(page);
@@ -814,7 +814,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	page = grab_cache_page(NODE_MAPPING(sbi), dn->nid);
+	page = grab_cache_page_write_begin(NODE_MAPPING(sbi), dn->nid, 0);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -910,7 +910,7 @@ struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 	struct page *page;
 	int err;
 repeat:
-	page = grab_cache_page(NODE_MAPPING(sbi), nid);
+	page = grab_cache_page_write_begin(NODE_MAPPING(sbi), nid, 0);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -1130,7 +1130,7 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 				continue;
 
 			if (ino && ino_of_node(page) == ino) {
-				wait_on_page_writeback(page);
+				f2fs_wait_on_page_writeback(page, NODE);
 				if (TestClearPageError(page))
 					ret = -EIO;
 			}
@@ -1163,7 +1163,7 @@ static int f2fs_write_node_page(struct page *page,
 	if (unlikely(sbi->por_doing))
 		goto redirty_out;
 
-	wait_on_page_writeback(page);
+	f2fs_wait_on_page_writeback(page, NODE);
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 03b28ec..bbef4ed 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -316,7 +316,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto out;
 	}
 
-	wait_on_page_writeback(dn.node_page);
+	f2fs_wait_on_page_writeback(dn.node_page, NODE);
 
 	get_node_info(sbi, dn.nid, &ni);
 	f2fs_bug_on(ni.ino != ino_of_node(page));
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
