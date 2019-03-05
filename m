From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to add refcount once page is
 tagged PG_private
Date: Tue, 5 Mar 2019 17:52:32 +0800
Message-ID: <20190305095233.126601-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h16kr-00016V-Qo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Mar 2019 09:52:57 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h16kp-00BCl4-EQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Mar 2019 09:52:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As Gao Xiang reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202749

f2fs may skip pageout() due to incorrect page reference count.

The problem here is that MM defined the rule [1] very clearly that
once page was set with PG_private flag, we should increment the
refcount in that page, also main flows like pageout(), migrate_page()
will assume there is one additional page reference count if
page_has_private() returns true.

But currently, f2fs won't add/del refcount when changing PG_private
flag. Anyway, f2fs should follow MM's rule to make MM's related flows
running as expected.

[1] https://lore.kernel.org/lkml/2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com/

Reported-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 11 +++++++++--
 fs/f2fs/data.c       | 32 ++++++++++++++++++++------------
 fs/f2fs/dir.c        |  6 +++++-
 fs/f2fs/node.c       |  6 +++++-
 fs/f2fs/segment.c    | 23 +++++++++++++++++------
 5 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c65a1e8e1e95..4e0e93af5ce0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -406,7 +406,11 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
-		SetPagePrivate(page);
+
+		if (!PagePrivate(page)) {
+			get_page(page);
+			SetPagePrivate(page);
+		}
 		f2fs_trace_pid(page);
 		return 1;
 	}
@@ -957,7 +961,10 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
 	inode_inc_dirty_pages(inode);
 	spin_unlock(&sbi->inode_lock[type]);
 
-	SetPagePrivate(page);
+	if (!PagePrivate(page)) {
+		get_page(page);
+		SetPagePrivate(page);
+	}
 	f2fs_trace_pid(page);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f3becd46362..46924d4f69d0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2715,8 +2715,11 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return f2fs_drop_inmem_page(inode, page);
 
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	if (PagePrivate(page)) {
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+		f2fs_put_page(page, 0);
+	}
 }
 
 int f2fs_release_page(struct page *page, gfp_t wait)
@@ -2730,8 +2733,11 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 		return 0;
 
 	clear_cold_data(page);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	if (PagePrivate(page)) {
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+		f2fs_put_page(page, 0);
+	}
 	return 1;
 }
 
@@ -2799,12 +2805,8 @@ int f2fs_migrate_page(struct address_space *mapping,
 			return -EAGAIN;
 	}
 
-	/*
-	 * A reference is expected if PagePrivate set when move mapping,
-	 * however F2FS breaks this for maintaining dirty page counts when
-	 * truncating pages. So here adjusting the 'extra_count' make it work.
-	 */
-	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
+	/* one extra reference was held for atomic_write page */
+	extra_count = atomic_written ? 1 : 0;
 	rc = migrate_page_move_mapping(mapping, newpage,
 				page, mode, extra_count);
 	if (rc != MIGRATEPAGE_SUCCESS) {
@@ -2825,9 +2827,15 @@ int f2fs_migrate_page(struct address_space *mapping,
 		get_page(newpage);
 	}
 
-	if (PagePrivate(page))
+	if (PagePrivate(page)) {
+		get_page(newpage);
 		SetPagePrivate(newpage);
-	set_page_private(newpage, page_private(page));
+		set_page_private(newpage, page_private(page));
+
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+		f2fs_put_page(page, 0);
+	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 103f3686a045..fbbafb04a431 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -728,7 +728,11 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(page);
 		clear_page_dirty_for_io(page);
-		ClearPagePrivate(page);
+		if (PagePrivate(page)) {
+			set_page_private(page, 0);
+			ClearPagePrivate(page);
+			f2fs_put_page(page, 0);
+		}
 		ClearPageUptodate(page);
 		clear_cold_data(page);
 		inode_dec_dirty_pages(dir);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f6ff84e29749..ce97a9885105 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1961,7 +1961,11 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
-		SetPagePrivate(page);
+
+		if (!PagePrivate(page)) {
+			get_page(page);
+			SetPagePrivate(page);
+		}
 		f2fs_trace_pid(page);
 		return 1;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e730c334abba..2d77dd133a4e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -191,8 +191,11 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 
 	f2fs_trace_pid(page);
 
-	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
-	SetPagePrivate(page);
+	if (!PagePrivate(page)) {
+		get_page(page);
+		SetPagePrivate(page);
+		set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
+	}
 
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
@@ -280,8 +283,11 @@ static int __revoke_inmem_pages(struct inode *inode,
 			ClearPageUptodate(page);
 			clear_cold_data(page);
 		}
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
+		if (PagePrivate(page)) {
+			set_page_private(page, 0);
+			ClearPagePrivate(page);
+			f2fs_put_page(page, 0);
+		}
 		f2fs_put_page(page, 1);
 
 		list_del(&cur->list);
@@ -370,8 +376,13 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
 	kmem_cache_free(inmem_entry_slab, cur);
 
 	ClearPageUptodate(page);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+
+	if (PagePrivate(page)) {
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+		f2fs_put_page(page, 0);
+	}
+
 	f2fs_put_page(page, 0);
 
 	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
-- 
2.18.0.rc1
