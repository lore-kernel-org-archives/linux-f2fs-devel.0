From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: produce more nids and reduce readahead nats
Date: Fri, 17 Jun 2016 18:03:44 -0700
Message-ID: <20160618010346.17794-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The readahead nat pages are more likely to be reclaimed quickly, so it'd better
to gather more free nids in advance.

And, let's keep some free nids as much as possible.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 ++
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/node.c       | 9 ++++++---
 fs/f2fs/node.h       | 5 +++--
 fs/f2fs/segment.c    | 4 +++-
 fs/f2fs/shrinker.c   | 5 +++--
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8534b98..2b43d40 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -941,6 +941,8 @@ out:
 static void unblock_operations(struct f2fs_sb_info *sbi)
 {
 	up_write(&sbi->node_write);
+
+	build_free_nids(sbi);
 	f2fs_unlock_all(sbi);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3019286..bd82b6d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1985,6 +1985,7 @@ void move_node_page(struct page *, int);
 int fsync_node_pages(struct f2fs_sb_info *, struct inode *,
 			struct writeback_control *, bool);
 int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
+void build_free_nids(struct f2fs_sb_info *);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b448c8f..729fb1e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1765,7 +1765,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	}
 }
 
-static void build_free_nids(struct f2fs_sb_info *sbi)
+void build_free_nids(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -1774,7 +1774,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 	nid_t nid = nm_i->next_scan_nid;
 
 	/* Enough entries */
-	if (nm_i->fcnt > NAT_ENTRY_PER_BLOCK)
+	if (nm_i->fcnt >= NAT_ENTRY_PER_BLOCK)
 		return;
 
 	/* readahead nat pages to be scanned */
@@ -1912,12 +1912,15 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
+	if (nm_i->fcnt <= MAX_FREE_NIDS)
+		return 0;
+
 	if (!mutex_trylock(&nm_i->build_lock))
 		return 0;
 
 	spin_lock(&nm_i->free_nid_list_lock);
 	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 || nm_i->fcnt <= NAT_ENTRY_PER_BLOCK)
+		if (nr_shrink <= 0 || nm_i->fcnt <= MAX_FREE_NIDS)
 			break;
 		if (i->state == NID_ALLOC)
 			continue;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 673ce92..fc76845 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -15,9 +15,10 @@
 #define	NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
 
 /* # of pages to perform synchronous readahead before building free nids */
-#define FREE_NID_PAGES 4
+#define FREE_NID_PAGES	8
+#define MAX_FREE_NIDS	(NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES)
 
-#define DEF_RA_NID_PAGES	4	/* # of nid pages to be readaheaded */
+#define DEF_RA_NID_PAGES	0	/* # of nid pages to be readaheaded */
 
 /* maximum readahead size for node during getting data blocks */
 #define MAX_RA_NODE		128
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 782975e..6d16ecf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -371,7 +371,9 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 		try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
 
 	if (!available_free_memory(sbi, FREE_NIDS))
-		try_to_free_nids(sbi, NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES);
+		try_to_free_nids(sbi, MAX_FREE_NIDS);
+	else
+		build_free_nids(sbi);
 
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 93606f2..46c9154 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -13,6 +13,7 @@
 #include <linux/f2fs_fs.h>
 
 #include "f2fs.h"
+#include "node.h"
 
 static LIST_HEAD(f2fs_list);
 static DEFINE_SPINLOCK(f2fs_list_lock);
@@ -25,8 +26,8 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	if (NM_I(sbi)->fcnt > NAT_ENTRY_PER_BLOCK)
-		return NM_I(sbi)->fcnt - NAT_ENTRY_PER_BLOCK;
+	if (NM_I(sbi)->fcnt > MAX_FREE_NIDS)
+		return NM_I(sbi)->fcnt - MAX_FREE_NIDS;
 	return 0;
 }
 
-- 
2.8.3
