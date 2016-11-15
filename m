From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: fix to account total free nid correctly
Date: Tue, 15 Nov 2016 09:46:28 +0800
Message-ID: <20161115014628.80442-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c6SqR-0002jM-AY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Nov 2016 01:47:31 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c6SqK-0002cf-5k
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Nov 2016 01:47:31 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Thread A		Thread B		Thread C
- f2fs_create
 - f2fs_new_inode
  - f2fs_lock_op
   - alloc_nid
    alloc last nid
  - f2fs_unlock_op
			- f2fs_create
			 - f2fs_new_inode
			  - f2fs_lock_op
			   - alloc_nid
			    as node count still not
			    be increased, we will
			    loop in alloc_nid
						- f2fs_write_node_pages
						 - f2fs_balance_fs_bg
						  - f2fs_sync_fs
						   - write_checkpoint
						    - block_operations
						     - f2fs_lock_all
 - f2fs_lock_op

While creating new inode, we do not allocate and account nid atomically,
so that when there is almost no free nids left, we may encounter deadloop
like above stack.

In order to avoid that, reuse nm_i::available_nids for accounting free nids
and make nid allocation and counting being atomical during node creation.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/node.c | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6de1fbf..0bba5d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -533,7 +533,7 @@ enum nid_list {
 struct f2fs_nm_info {
 	block_t nat_blkaddr;		/* base disk address of NAT */
 	nid_t max_nid;			/* maximum possible node ids */
-	nid_t available_nids;		/* maximum available node ids */
+	nid_t available_nids;		/* # of available node ids */
 	nid_t next_scan_nid;		/* the next nid to be scanned */
 	unsigned int ram_thresh;	/* control the memory footprint */
 	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d58438f..1b5b31a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1885,11 +1885,13 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		return false;
 	}
 #endif
-	if (unlikely(sbi->total_valid_node_count + 1 > nm_i->available_nids))
-		return false;
-
 	spin_lock(&nm_i->nid_list_lock);
 
+	if (unlikely(nm_i->available_nids == 0)) {
+		spin_unlock(&nm_i->nid_list_lock);
+		return false;
+	}
+
 	/* We should not use stale free nids created by build_free_nids */
 	if (nm_i->nid_cnt[FREE_NID_LIST] && !on_build_free_nids(nm_i)) {
 		f2fs_bug_on(sbi, list_empty(&nm_i->nid_list[FREE_NID_LIST]));
@@ -1900,6 +1902,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		__remove_nid_from_list(sbi, i, FREE_NID_LIST, true);
 		i->state = NID_ALLOC;
 		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
+		nm_i->available_nids--;
 		spin_unlock(&nm_i->nid_list_lock);
 		return true;
 	}
@@ -1951,6 +1954,9 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 		i->state = NID_NEW;
 		__insert_nid_to_list(sbi, i, FREE_NID_LIST, false);
 	}
+
+	nm_i->available_nids++;
+
 	spin_unlock(&nm_i->nid_list_lock);
 
 	if (need_free)
@@ -2222,8 +2228,12 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		raw_nat_from_node_info(raw_ne, &ne->ni);
 		nat_reset_flag(ne);
 		__clear_nat_cache_dirty(NM_I(sbi), ne);
-		if (nat_get_blkaddr(ne) == NULL_ADDR)
+		if (nat_get_blkaddr(ne) == NULL_ADDR) {
 			add_free_nid(sbi, nid, false);
+			spin_lock(&NM_I(sbi)->nid_list_lock);
+			NM_I(sbi)->available_nids++;
+			spin_unlock(&NM_I(sbi)->nid_list_lock);
+		}
 	}
 
 	if (to_journal)
@@ -2298,7 +2308,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
-	nm_i->available_nids = nm_i->max_nid - F2FS_RESERVED_NODE_NUM;
+	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
+							F2FS_RESERVED_NODE_NUM;
 	nm_i->nid_cnt[FREE_NID_LIST] = 0;
 	nm_i->nid_cnt[ALLOC_NID_LIST] = 0;
 	nm_i->nat_cnt = 0;
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
