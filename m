From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 RESEND] f2fs: refactor flush_nat_entries codes
 for reducing NAT writes
Date: Fri, 20 Jun 2014 17:41:58 +0800
Message-ID: <003a01cf8c6b$ff39a170$fdace450$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WxvLh-0007ix-8J
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Jun 2014 09:43:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WxvLe-0004r2-HU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Jun 2014 09:43:09 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7G00A9TOBMY890@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Jun 2014 18:42:58 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Although building NAT journal in cursum reduce the read/write work for NAT
block, but previous design leave us lower performance when write checkpoint
frequently for these cases:
1. if journal in cursum has already full, it's a bit of waste that we flush all
   nat entries to page for persistence, but not to cache any entries.
2. if journal in cursum is not full, we fill nat entries to journal util
   journal is full, then flush the left dirty entries to disk without merge
   journaled entries, so these journaled entries may be flushed to disk at next
   checkpoint but lost chance to flushed last time.

In this patch we merge dirty entries located in same NAT block to nat entry set,
and linked all set to list, sorted ascending order by entries' count of set.
Later we flush entries in sparse set into journal as many as we can, and then
flush merged entries to disk. In this way we can not only gain in performance,
but also save lifetime of flash device.

In my testing environment, it shows this patch can help to reduce NAT block
writes obviously. In hard disk test case: cost time of fsstress is stablely
reduced by about 5%.

1. virtual machine + hard disk:
fsstress -p 20 -n 200 -l 5
		node num	cp count	nodes/cp
based		4599.6		1803.0		2.551
patched		2714.6		1829.6		1.483

2. virtual machine + 32g micro SD card:
fsstress -p 20 -n 200 -l 1 -w -f chown=0 -f creat=4 -f dwrite=0
-f fdatasync=4 -f fsync=4 -f link=0 -f mkdir=4 -f mknod=4 -f rename=5
-f rmdir=5 -f symlink=0 -f truncate=4 -f unlink=5 -f write=0 -S

		node num	cp count	nodes/cp
based		84.5		43.7		1.933
patched		49.2		40.0		1.23

Our latency of merging op shows not bad when handling extreme case like:
merging a great number of dirty nats:
latency(ns)	dirty nat count
3089219		24922
5129423		27422
4000250		24523

change log from v1:
 o fix wrong logic in add_nat_entry when grab a new nat entry set.
 o swith to create slab cache in create_node_manager_caches.
 o use GFP_ATOMIC instead of GFP_NOFS to avoid potential long latency.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |    2 +
 fs/f2fs/node.c |  261 ++++++++++++++++++++++++++++++++++++++------------------
 fs/f2fs/node.h |    7 ++
 3 files changed, 185 insertions(+), 85 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 58df97e..a55f67d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -256,6 +256,8 @@ struct f2fs_nm_info {
 	unsigned int nat_cnt;		/* the # of cached nat entries */
 	struct list_head nat_entries;	/* cached nat entry list (clean) */
 	struct list_head dirty_nat_entries; /* cached nat entry list (dirty) */
+	struct list_head nat_entry_set;	/* nat entry set list */
+	unsigned int dirty_nat_cnt;	/* total num of nat entries in set */
 
 	/* free node ids management */
 	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9dfb9a0..86bde75 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -25,6 +25,7 @@
 
 static struct kmem_cache *nat_entry_slab;
 static struct kmem_cache *free_nid_slab;
+static struct kmem_cache *nat_entry_set_slab;
 
 bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 {
@@ -88,12 +89,8 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 
 	/* get current nat block page with lock */
 	src_page = get_meta_page(sbi, src_off);
-
-	/* Dirty src_page means that it is already the new target NAT page. */
-	if (PageDirty(src_page))
-		return src_page;
-
 	dst_page = grab_meta_page(sbi, dst_off);
+	f2fs_bug_on(PageDirty(src_page));
 
 	src_addr = page_address(src_page);
 	dst_addr = page_address(dst_page);
@@ -1742,7 +1739,90 @@ skip:
 	return err;
 }
 
-static bool flush_nats_in_journal(struct f2fs_sb_info *sbi)
+static struct nat_entry_set *grab_nat_entry_set(void)
+{
+	struct nat_entry_set *nes =
+			f2fs_kmem_cache_alloc(nat_entry_set_slab, GFP_ATOMIC);
+
+	nes->entry_cnt = 0;
+	INIT_LIST_HEAD(&nes->set_list);
+	INIT_LIST_HEAD(&nes->entry_list);
+	return nes;
+}
+
+static void release_nat_entry_set(struct nat_entry_set *nes,
+						struct f2fs_nm_info *nm_i)
+{
+	f2fs_bug_on(!list_empty(&nes->entry_list));
+
+	nm_i->dirty_nat_cnt -= nes->entry_cnt;
+	list_del(&nes->set_list);
+	kmem_cache_free(nat_entry_set_slab, nes);
+}
+
+static void adjust_nat_entry_set(struct nat_entry_set *nes,
+						struct list_head *head)
+{
+	struct nat_entry_set *next = nes;
+
+	if (list_is_last(&nes->set_list, head))
+		return;
+
+	list_for_each_entry_continue(next, head, set_list)
+		if (nes->entry_cnt <= next->entry_cnt)
+			break;
+
+	list_move_tail(&nes->set_list, &next->set_list);
+}
+
+static void add_nat_entry(struct nat_entry *ne, struct list_head *head)
+{
+	struct nat_entry_set *nes;
+	nid_t start_nid = START_NID(ne->ni.nid);
+
+	list_for_each_entry(nes, head, set_list) {
+		if (nes->start_nid == start_nid) {
+			list_move_tail(&ne->list, &nes->entry_list);
+			nes->entry_cnt++;
+			adjust_nat_entry_set(nes, head);
+			return;
+		}
+	}
+
+	nes = grab_nat_entry_set();
+
+	nes->start_nid = start_nid;
+	list_move_tail(&ne->list, &nes->entry_list);
+	nes->entry_cnt++;
+	list_add(&nes->set_list, head);
+}
+
+static void merge_nats_in_set(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct list_head *dirty_list = &nm_i->dirty_nat_entries;
+	struct list_head *set_list = &nm_i->nat_entry_set;
+	struct nat_entry *ne, *tmp;
+
+	write_lock(&nm_i->nat_tree_lock);
+	list_for_each_entry_safe(ne, tmp, dirty_list, list) {
+		if (nat_get_blkaddr(ne) == NEW_ADDR)
+			continue;
+		add_nat_entry(ne, set_list);
+		nm_i->dirty_nat_cnt++;
+	}
+	write_unlock(&nm_i->nat_tree_lock);
+}
+
+static bool __has_cursum_space(struct f2fs_summary_block *sum, int size)
+{
+	if (nats_in_cursum(sum) + size <= NAT_JOURNAL_ENTRIES)
+		return true;
+	else
+		return false;
+}
+
+static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -1750,12 +1830,6 @@ static bool flush_nats_in_journal(struct f2fs_sb_info *sbi)
 	int i;
 
 	mutex_lock(&curseg->curseg_mutex);
-
-	if (nats_in_cursum(sum) < NAT_JOURNAL_ENTRIES) {
-		mutex_unlock(&curseg->curseg_mutex);
-		return false;
-	}
-
 	for (i = 0; i < nats_in_cursum(sum); i++) {
 		struct nat_entry *ne;
 		struct f2fs_nat_entry raw_ne;
@@ -1765,23 +1839,21 @@ static bool flush_nats_in_journal(struct f2fs_sb_info *sbi)
 retry:
 		write_lock(&nm_i->nat_tree_lock);
 		ne = __lookup_nat_cache(nm_i, nid);
-		if (ne) {
-			__set_nat_cache_dirty(nm_i, ne);
-			write_unlock(&nm_i->nat_tree_lock);
-			continue;
-		}
+		if (ne)
+			goto found;
+
 		ne = grab_nat_entry(nm_i, nid);
 		if (!ne) {
 			write_unlock(&nm_i->nat_tree_lock);
 			goto retry;
 		}
 		node_info_from_raw_nat(&ne->ni, &raw_ne);
+found:
 		__set_nat_cache_dirty(nm_i, ne);
 		write_unlock(&nm_i->nat_tree_lock);
 	}
 	update_nats_in_cursum(sum, -i);
 	mutex_unlock(&curseg->curseg_mutex);
-	return true;
 }
 
 /*
@@ -1792,80 +1864,87 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_summary_block *sum = curseg->sum_blk;
-	struct nat_entry *ne, *cur;
-	struct page *page = NULL;
-	struct f2fs_nat_block *nat_blk = NULL;
-	nid_t start_nid = 0, end_nid = 0;
-	bool flushed;
-
-	flushed = flush_nats_in_journal(sbi);
-
-	if (!flushed)
-		mutex_lock(&curseg->curseg_mutex);
-
-	/* 1) flush dirty nat caches */
-	list_for_each_entry_safe(ne, cur, &nm_i->dirty_nat_entries, list) {
-		nid_t nid;
-		struct f2fs_nat_entry raw_ne;
-		int offset = -1;
-
-		if (nat_get_blkaddr(ne) == NEW_ADDR)
-			continue;
+	struct nat_entry_set *nes, *tmp;
+	struct list_head *head = &nm_i->nat_entry_set;
+	bool to_journal = true;
 
-		nid = nat_get_nid(ne);
+	/* merge nat entries of dirty list to nat entry set temporarily */
+	merge_nats_in_set(sbi);
 
-		if (flushed)
-			goto to_nat_page;
+	if (!__has_cursum_space(sum, nm_i->dirty_nat_cnt)) {
+		/*
+		 * if there are no enough space in journal to store dirty nat
+		 * entries, remove all entries from journal and merge them
+		 * into nat entry set.
+		 */
+		remove_nats_in_journal(sbi);
+		merge_nats_in_set(sbi);
+	}
 
-		/* if there is room for nat enries in curseg->sumpage */
-		offset = lookup_journal_in_cursum(sum, NAT_JOURNAL, nid, 1);
-		if (offset >= 0) {
-			raw_ne = nat_in_journal(sum, offset);
-			goto flush_now;
-		}
-to_nat_page:
-		if (!page || (start_nid > nid || nid > end_nid)) {
-			if (page) {
-				f2fs_put_page(page, 1);
-				page = NULL;
-			}
-			start_nid = START_NID(nid);
-			end_nid = start_nid + NAT_ENTRY_PER_BLOCK - 1;
+	if (!nm_i->dirty_nat_cnt)
+		return;
 
-			/*
-			 * get nat block with dirty flag, increased reference
-			 * count, mapped and lock
-			 */
+	/*
+	 * there are two steps to flush nat entries:
+	 * #1, flush nat entries to journal in current hot data summary block.
+	 * #2, flush nat entries to nat page.
+	 */
+	list_for_each_entry_safe(nes, tmp, head, set_list) {
+		struct f2fs_nat_block *nat_blk;
+		struct nat_entry *ne, *cur;
+		struct page *page;
+		nid_t start_nid = nes->start_nid;
+
+		if (to_journal && !__has_cursum_space(sum, nes->entry_cnt))
+			to_journal = false;
+
+		if (to_journal) {
+			mutex_lock(&curseg->curseg_mutex);
+		} else {
 			page = get_next_nat_page(sbi, start_nid);
 			nat_blk = page_address(page);
+			f2fs_bug_on(!nat_blk);
 		}
 
-		f2fs_bug_on(!nat_blk);
-		raw_ne = nat_blk->entries[nid - start_nid];
-flush_now:
-		raw_nat_from_node_info(&raw_ne, &ne->ni);
-
-		if (offset < 0) {
-			nat_blk->entries[nid - start_nid] = raw_ne;
-		} else {
-			nat_in_journal(sum, offset) = raw_ne;
-			nid_in_journal(sum, offset) = cpu_to_le32(nid);
-		}
+		/* flush dirty nats in nat entry set */
+		list_for_each_entry_safe(ne, cur, &nes->entry_list, list) {
+			struct f2fs_nat_entry *raw_ne;
+			nid_t nid = nat_get_nid(ne);
+			int offset;
+
+			if (to_journal) {
+				offset = lookup_journal_in_cursum(sum,
+							NAT_JOURNAL, nid, 1);
+				f2fs_bug_on(offset < 0);
+				raw_ne = &nat_in_journal(sum, offset);
+				nid_in_journal(sum, offset) = cpu_to_le32(nid);
+			} else {
+				raw_ne = &nat_blk->entries[nid - start_nid];
+			}
+			raw_nat_from_node_info(raw_ne, &ne->ni);
 
-		if (nat_get_blkaddr(ne) == NULL_ADDR &&
+			if (nat_get_blkaddr(ne) == NULL_ADDR &&
 				add_free_nid(sbi, nid, false) <= 0) {
-			write_lock(&nm_i->nat_tree_lock);
-			__del_from_nat_cache(nm_i, ne);
-			write_unlock(&nm_i->nat_tree_lock);
-		} else {
-			write_lock(&nm_i->nat_tree_lock);
-			__clear_nat_cache_dirty(nm_i, ne);
-			write_unlock(&nm_i->nat_tree_lock);
+				write_lock(&nm_i->nat_tree_lock);
+				__del_from_nat_cache(nm_i, ne);
+				write_unlock(&nm_i->nat_tree_lock);
+			} else {
+				write_lock(&nm_i->nat_tree_lock);
+				__clear_nat_cache_dirty(nm_i, ne);
+				write_unlock(&nm_i->nat_tree_lock);
+			}
 		}
+
+		if (to_journal)
+			mutex_unlock(&curseg->curseg_mutex);
+		else
+			f2fs_put_page(page, 1);
+
+		release_nat_entry_set(nes, nm_i);
 	}
-	if (!flushed)
-		mutex_unlock(&curseg->curseg_mutex);
-	f2fs_put_page(page, 1);
+
+	f2fs_bug_on(!list_empty(head));
+	f2fs_bug_on(nm_i->dirty_nat_cnt);
 }
 
 static int init_node_manager(struct f2fs_sb_info *sbi)
@@ -1894,6 +1973,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
 	INIT_LIST_HEAD(&nm_i->dirty_nat_entries);
+	INIT_LIST_HEAD(&nm_i->nat_entry_set);
 
 	mutex_init(&nm_i->build_lock);
 	spin_lock_init(&nm_i->free_nid_list_lock);
@@ -1974,19 +2054,30 @@ int __init create_node_manager_caches(void)
 	nat_entry_slab = f2fs_kmem_cache_create("nat_entry",
 			sizeof(struct nat_entry));
 	if (!nat_entry_slab)
-		return -ENOMEM;
+		goto fail;
 
 	free_nid_slab = f2fs_kmem_cache_create("free_nid",
 			sizeof(struct free_nid));
-	if (!free_nid_slab) {
-		kmem_cache_destroy(nat_entry_slab);
-		return -ENOMEM;
-	}
+	if (!free_nid_slab)
+		goto destory_nat_entry;
+
+	nat_entry_set_slab = f2fs_kmem_cache_create("nat_entry_set",
+			sizeof(struct nat_entry_set));
+	if (!nat_entry_set_slab)
+		goto destory_free_nid;
 	return 0;
+
+destory_free_nid:
+	kmem_cache_destroy(free_nid_slab);
+destory_nat_entry:
+	kmem_cache_destroy(nat_entry_slab);
+fail:
+	return -ENOMEM;
 }
 
 void destroy_node_manager_caches(void)
 {
+	kmem_cache_destroy(nat_entry_set_slab);
 	kmem_cache_destroy(free_nid_slab);
 	kmem_cache_destroy(nat_entry_slab);
 }
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 7281112..8a116a4 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -89,6 +89,13 @@ enum mem_type {
 	DIRTY_DENTS	/* indicates dirty dentry pages */
 };
 
+struct nat_entry_set {
+	struct list_head set_list;	/* link with all nat sets */
+	struct list_head entry_list;	/* link with dirty nat entries */
+	nid_t start_nid;		/* start nid of nats in set */
+	unsigned int entry_cnt;		/* the # of nat entries in set */
+};
+
 /*
  * For free nid mangement
  */
-- 
1.7.9.5



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
