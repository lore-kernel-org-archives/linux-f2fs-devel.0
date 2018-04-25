From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: introduce release_discard_addr() for
 cleanup
Date: Wed, 25 Apr 2018 17:38:29 +0800
Message-ID: <20180425093831.124591-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fBGtI-0006Me-53
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 09:39:08 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBGtG-00EKUD-La
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 09:39:08 +0000
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

Introduce release_discard_addr() to include common codes for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9e0c6babacec..d5627195aa8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1609,16 +1609,20 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	return false;
 }
 
+void release_discard_addr(struct discard_entry *entry)
+{
+	list_del(&entry->list);
+	kmem_cache_free(discard_entry_slab, entry);
+}
+
 void release_discard_addrs(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
 	struct discard_entry *entry, *this;
 
 	/* drop caches */
-	list_for_each_entry_safe(entry, this, head, list) {
-		list_del(&entry->list);
-		kmem_cache_free(discard_entry_slab, entry);
-	}
+	list_for_each_entry_safe(entry, this, head, list)
+		release_discard_addr(entry);
 }
 
 /*
@@ -1718,9 +1722,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (cur_pos < sbi->blocks_per_seg)
 			goto find_next;
 
-		list_del(&entry->list);
+		release_discard_addr(entry);
 		dcc->nr_discards -= total_len;
-		kmem_cache_free(discard_entry_slab, entry);
 	}
 
 	wake_up_discard_thread(sbi, false);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
