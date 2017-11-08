From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce scan_curseg_cache for cleanup
Date: Wed, 8 Nov 2017 17:47:36 +0800
Message-ID: <20171108094736.43470-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eCMxn-0001hq-CA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Nov 2017 09:48:03 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eCMxl-00017n-2U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Nov 2017 09:48:03 +0000
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

Commit 4ac912427c42 ("f2fs: introduce free nid bitmap") copied codes
from __build_free_nids() into scan_free_nid_bits(), they are redundant,
introduce one common function scan_curseg_cache for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9c80d48bfe6d..810d84e2ae92 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1971,11 +1971,30 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	}
 }
 
-static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
+static void scan_curseg_cache(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
+	int i;
+
+	down_read(&curseg->journal_rwsem);
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		block_t addr;
+		nid_t nid;
+
+		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
+		nid = le32_to_cpu(nid_in_journal(journal, i));
+		if (addr == NULL_ADDR)
+			add_free_nid(sbi, nid, true);
+		else
+			remove_free_nid(sbi, nid);
+	}
+	up_read(&curseg->journal_rwsem);
+}
+
+static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int i, idx;
 
 	down_read(&nm_i->nat_tree_lock);
@@ -2002,27 +2021,14 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 		}
 	}
 out:
-	down_read(&curseg->journal_rwsem);
-	for (i = 0; i < nats_in_cursum(journal); i++) {
-		block_t addr;
-		nid_t nid;
+	scan_curseg_cache(sbi);
 
-		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
-		nid = le32_to_cpu(nid_in_journal(journal, i));
-		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true);
-		else
-			remove_free_nid(sbi, nid);
-	}
-	up_read(&curseg->journal_rwsem);
 	up_read(&nm_i->nat_tree_lock);
 }
 
 static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = curseg->journal;
 	int i = 0;
 	nid_t nid = nm_i->next_scan_nid;
 
@@ -2072,18 +2078,8 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 	nm_i->next_scan_nid = nid;
 
 	/* find free nids from current sum_pages */
-	down_read(&curseg->journal_rwsem);
-	for (i = 0; i < nats_in_cursum(journal); i++) {
-		block_t addr;
+	scan_curseg_cache(sbi);
 
-		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
-		nid = le32_to_cpu(nid_in_journal(journal, i));
-		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true);
-		else
-			remove_free_nid(sbi, nid);
-	}
-	up_read(&curseg->journal_rwsem);
 	up_read(&nm_i->nat_tree_lock);
 
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
