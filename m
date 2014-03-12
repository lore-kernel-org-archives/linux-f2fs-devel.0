From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH 2/2 v2] f2fs: call set_dirty_dir_page if inode is directory.
Date: Wed, 12 Mar 2014 12:36:58 +0900
Message-ID: <1394595418.14427.1.camel@lcm>
References: <1394591233-14080-1-git-send-email-cm224.lee@samsung.com>
 <1394591233-14080-2-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1394591233-14080-2-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

It's trivial patch. I think it's more clear but you might feel messy.
No matter what you choose, I don't care.

o Changes from v1
 move checking if inode is dir in remove_dirty_dir_inode into upper,
too.

-- >8 --

>From bfc47691321d08b27880d98448058df578725356 Mon Sep 17 00:00:00 2001
From: Changman Lee <cm224.lee@samsung.com>
Date: Tue, 11 Mar 2014 22:18:18 -0400
Subject: [PATCH] f2fs: call set/remove_dirty_dir_page if inode is
directory.

It's more legible and efficient to call set/remove_dirty_dir_page only
if inode->i_mode is directory before calling it.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |    7 -------
 fs/f2fs/data.c       |    6 ++++--
 fs/f2fs/dir.c        |    3 ++-
 fs/f2fs/inode.c      |    6 ++++--
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1e03ca5..c6d8a55 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -578,9 +578,6 @@ void set_dirty_dir_page(struct inode *inode, struct
page *page)
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct dir_inode_entry *new;
 
-	if (!S_ISDIR(inode->i_mode))
-		return;
-
 	new = f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
 	new->inode = inode;
 	INIT_LIST_HEAD(&new->list);
@@ -611,12 +608,8 @@ void add_dirty_dir_inode(struct inode *inode)
 void remove_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-
 	struct list_head *this, *head;
 
-	if (!S_ISDIR(inode->i_mode))
-		return;
-
 	spin_lock(&sbi->dir_inode_lock);
 	if (atomic_read(&F2FS_I(inode)->dirty_dents)) {
 		spin_unlock(&sbi->dir_inode_lock);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index acd0159..6a05df0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -884,7 +884,8 @@ static int f2fs_write_data_pages(struct
address_space *mapping,
 
 	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 
-	remove_dirty_dir_inode(inode);
+	if (S_ISDIR(inode->i_mode))
+		remove_dirty_dir_inode(inode);
 
 	wbc->nr_to_write -= excess_nrtw;
 	return ret;
@@ -1043,7 +1044,8 @@ static int f2fs_set_data_page_dirty(struct page
*page)
 
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
-		set_dirty_dir_page(inode, page);
+		if (S_ISDIR(inode->i_mode))
+			set_dirty_dir_page(inode, page);
 		return 1;
 	}
 	return 0;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f3a80ce..e97ab2e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -380,7 +380,8 @@ put_error:
 	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
 	truncate_inode_pages(&inode->i_data, 0);
 	truncate_blocks(inode, 0);
-	remove_dirty_dir_inode(inode);
+	if (S_ISDIR(inode->i_mode))
+		remove_dirty_dir_inode(inode);
 error:
 	remove_inode_page(inode);
 	return ERR_PTR(err);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d518e37..76aef0e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -273,8 +273,10 @@ void f2fs_evict_inode(struct inode *inode)
 			inode->i_ino == F2FS_META_INO(sbi))
 		goto no_delete;
 
-	f2fs_bug_on(atomic_read(&F2FS_I(inode)->dirty_dents));
-	remove_dirty_dir_inode(inode);
+	if (S_ISDIR(inode->i_mode)) {
+		f2fs_bug_on(atomic_read(&F2FS_I(inode)->dirty_dents));
+		remove_dirty_dir_inode(inode);
+	}
 
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
-- 
1.7.10.4



