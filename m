From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/7] f2fs: reorder nat cache lock in cache_nat_entry
Date: Sun, 14 Feb 2016 18:53:33 +0800
Message-ID: <00fc01d16716$0a657de0$1f3079a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In cache_nat_entry, if we fail to hit nat cache, we try to load nat
entries from journal of current segment cache or NAT pages for updating,
during the whole updating process, write lock of nat_tree_lock will be
held to avoid inconsistent condition.

But this way may cause low efficient when updating nat cache, because it
serializes accessing in journal cache or reading NAT pages.

Here, we reorder lock and update flow like below:

 - get_node_info
  - down_read(nat_tree_lock)
  - lookup nat cache --- hit -> unlock & return
  - lookup journal cache --- hit -> unlock & goto update
  - up_read(nat_tree_lock)
update:
  - down_write(nat_tree_lock)
  - cache_nat_entry
   - lookup nat cache --- nohit -> update
  - up_write(nat_tree_lock)

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 94b8016..966176b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -257,15 +257,20 @@ static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid)
 	return new;
 }
 
-static void cache_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid,
+static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 						struct f2fs_nat_entry *ne)
 {
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 
 	e = __lookup_nat_cache(nm_i, nid);
 	if (!e) {
 		e = grab_nat_entry(nm_i, nid);
 		node_info_from_raw_nat(&e->ni, ne);
+	} else {
+		f2fs_bug_on(sbi, nat_get_ino(e) != ne->ino ||
+				nat_get_blkaddr(e) != ne->block_addr ||
+				nat_get_version(e) != ne->version);
 	}
 }
 
@@ -371,15 +376,12 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 		ni->ino = nat_get_ino(e);
 		ni->blk_addr = nat_get_blkaddr(e);
 		ni->version = nat_get_version(e);
-	}
-	up_read(&nm_i->nat_tree_lock);
-	if (e)
+		up_read(&nm_i->nat_tree_lock);
 		return;
+	}
 
 	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
 
-	down_write(&nm_i->nat_tree_lock);
-
 	/* Check current segment summary */
 	down_read(&curseg->journal_rwsem);
 	i = lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
@@ -398,8 +400,10 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	node_info_from_raw_nat(ni, &ne);
 	f2fs_put_page(page, 1);
 cache:
+	up_read(&nm_i->nat_tree_lock);
 	/* cache nat entry */
-	cache_nat_entry(NM_I(sbi), nid, &ne);
+	down_write(&nm_i->nat_tree_lock);
+	cache_nat_entry(sbi, nid, &ne);
 	up_write(&nm_i->nat_tree_lock);
 }
 
-- 
2.7.0.2.g1b0b6dd
