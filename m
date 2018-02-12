From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add bug on back during flush nat entries
Date: Mon, 12 Feb 2018 11:42:34 +0800
Message-ID: <1518406954-29047-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1el5FM-0001me-FX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Feb 2018 03:57:40 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1el5FL-0007e6-1q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Feb 2018 03:57:40 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: heyunlei@huawei.com

This patch add two bug on check back during flush nat entries,
nat_tree_lock will prevent race from node block allocation
in write_begin.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 833b46b..ced986d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2519,10 +2519,9 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	}
 
 	/* Allow dirty nats by node block allocation in write_begin */
-	if (!set->entry_cnt) {
-		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
-		kmem_cache_free(nat_entry_set_slab, set);
-	}
+	f2fs_bug_on(sbi, set->entry_cnt);
+	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
+	kmem_cache_free(nat_entry_set_slab, set);
 }
 
 /*
@@ -2566,8 +2565,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	list_for_each_entry_safe(set, tmp, &sets, set_list)
 		__flush_nat_entry_set(sbi, set, cpc);
 
+	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
 	up_write(&nm_i->nat_tree_lock);
-	/* Allow dirty nats by node block allocation in write_begin */
 }
 
 static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
