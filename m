From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: remove unneed reada during build free nids
Date: Fri, 9 Feb 2018 11:58:42 +0800
Message-ID: <1518148722-31212-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1ek04M-0007A7-7q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 04:13:50 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ek04I-00032s-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 04:13:50 +0000
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

This patch remove unneed reada during build free nids.
If few nids left, three will introduce a lot of no hit
read io.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 833b46b..ad28965 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2033,10 +2033,6 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 			return;
 	}
 
-	/* readahead nat pages to be scanned */
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
-							META_NAT, true);
-
 	down_read(&nm_i->nat_tree_lock);
 
 	while (1) {
@@ -2052,7 +2048,12 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		if (unlikely(nid >= nm_i->max_nid))
 			nid = 0;
 
-		if (++i >= FREE_NID_PAGES)
+		/* bg build, no more than 8 pages */
+		if ((!sync || mount) && ++i >= FREE_NID_PAGES)
+			break;
+
+		/* fg build, until free nids is not zero */
+		if (sync && !mount && nm_i->nid_cnt[FREE_NID])
 			break;
 	}
 
@@ -2063,9 +2064,6 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 	scan_curseg_cache(sbi);
 
 	up_read(&nm_i->nat_tree_lock);
-
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
-					nm_i->ra_nid_pages, META_NAT, false);
 }
 
 void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
