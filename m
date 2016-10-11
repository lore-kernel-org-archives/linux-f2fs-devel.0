From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/8] f2fs: give a chance to detach from dirty list
Date: Tue, 11 Oct 2016 22:57:01 +0800
Message-ID: <20161011145706.5028-3-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyWb-0007k3-KG
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWa-0001lI-Ld
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:25 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

If there is no dirty pages in inode, we should give a chance to detach
the inode from global dirty list, otherwise it needs to call another
unnecessary .writepages for detaching.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 8 +++++---
 fs/f2fs/dir.c     | 1 +
 fs/f2fs/gc.c      | 4 +++-
 fs/f2fs/inline.c  | 4 +++-
 fs/f2fs/node.c    | 1 +
 fs/f2fs/segment.c | 4 +++-
 6 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0d0177c..1818781 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1785,12 +1785,14 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 		return;
 
 	if (PageDirty(page)) {
-		if (inode->i_ino == F2FS_META_INO(sbi))
+		if (inode->i_ino == F2FS_META_INO(sbi)) {
 			dec_page_count(sbi, F2FS_DIRTY_META);
-		else if (inode->i_ino == F2FS_NODE_INO(sbi))
+		} else if (inode->i_ino == F2FS_NODE_INO(sbi)) {
 			dec_page_count(sbi, F2FS_DIRTY_NODES);
-		else
+		} else {
 			inode_dec_dirty_pages(inode);
+			remove_dirty_inode(inode);
+		}
 	}
 
 	/* This is atomic written page, keep Private */
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index cbf85f6..d7c0eb3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -742,6 +742,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
 		inode_dec_dirty_pages(dir);
+		remove_dirty_inode(dir);
 	}
 	f2fs_put_page(page, 1);
 }
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 93985c6..e48142f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -673,8 +673,10 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 retry:
 		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
-		if (clear_page_dirty_for_io(page))
+		if (clear_page_dirty_for_io(page)) {
 			inode_dec_dirty_pages(inode);
+			remove_dirty_inode(inode);
+		}
 
 		set_cold_data(page);
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 34234d8..1cf7a74 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -137,8 +137,10 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	fio.old_blkaddr = dn->data_blkaddr;
 	write_data_page(dn, &fio);
 	f2fs_wait_on_page_writeback(page, DATA, true);
-	if (dirty)
+	if (dirty) {
 		inode_dec_dirty_pages(dn->inode);
+		remove_dirty_inode(dn->inode);
+	}
 
 	/* this converted inline_data should be recovered. */
 	set_inode_flag(dn->inode, FI_APPEND_WRITE);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0a9692e..3a393e3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1204,6 +1204,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 
 	ret = f2fs_write_inline_data(inode, page);
 	inode_dec_dirty_pages(inode);
+	remove_dirty_inode(inode);
 	if (ret)
 		set_page_dirty(page);
 page_out:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7f62dd0..bc190cf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -274,8 +274,10 @@ static int __commit_inmem_pages(struct inode *inode,
 
 			set_page_dirty(page);
 			f2fs_wait_on_page_writeback(page, DATA, true);
-			if (clear_page_dirty_for_io(page))
+			if (clear_page_dirty_for_io(page)) {
 				inode_dec_dirty_pages(inode);
+				remove_dirty_inode(inode);
+			}
 
 			fio.page = page;
 			err = do_write_data_page(&fio);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
