From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 3/3] f2fs: fix unlocked nat set cache operation
Date: Mon,  9 Mar 2015 11:00:55 +0800
Message-ID: <1425870055-27694-3-git-send-email-wanpeng.li@linux.intel.com>
References: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YUoDu-0007ai-Sl
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 03:19:18 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YUoDu-0006tM-06 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 03:19:18 +0000
In-Reply-To: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

nm_i->nat_tree_lock is used to sync both the operations of nat entry
cache tree and nat set cache tree, however, it isn't held when flush 
nat entries during checkpoint which lead to potential race, this patch 
fix it by holding the lock when gang lookup nat set cache and delete 
item from nat set cache.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8751375..14e4387 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1837,6 +1837,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	struct f2fs_nat_block *nat_blk;
 	struct nat_entry *ne, *cur;
 	struct page *page = NULL;
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
 	/*
 	 * there are two steps to flush nat entries:
@@ -1890,7 +1891,9 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 
 	f2fs_bug_on(sbi, set->entry_cnt);
 
+	down_write(&nm_i->nat_tree_lock);
 	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
+	up_write(&nm_i->nat_tree_lock);
 	kmem_cache_free(nat_entry_set_slab, set);
 }
 
@@ -1918,6 +1921,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	if (!__has_cursum_space(sum, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
+	down_write(&nm_i->nat_tree_lock);
 	while ((found = __gang_lookup_nat_set(nm_i,
 					set_idx, SETVEC_SIZE, setvec))) {
 		unsigned idx;
@@ -1926,6 +1930,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 			__adjust_nat_entry_set(setvec[idx], &sets,
 							MAX_NAT_JENTRIES(sum));
 	}
+	up_write(&nm_i->nat_tree_lock);
 
 	/* flush dirty nats in nat entry set */
 	list_for_each_entry_safe(set, tmp, &sets, set_list)
-- 
1.9.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
