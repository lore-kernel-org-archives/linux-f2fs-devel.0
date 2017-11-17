From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: no need to read nat block if
 nat_block_bitmap is set
Date: Fri, 17 Nov 2017 16:13:38 +0800
Message-ID: <1510906418-11829-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eFbyk-0008Ug-Rf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Nov 2017 08:26:26 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFbyi-0000Hr-PB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Nov 2017 08:26:26 +0000
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
Cc: ning.jia@huawei.com, heyunlei@huawei.com

No need to read nat block if nat_block_bitmap is set.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fe1fc66..104b44c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1949,9 +1949,6 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
 	int i;
 
-	if (test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
-		return;
-
 	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
 
 	i = start_nid % NAT_ENTRY_PER_BLOCK;
@@ -2056,11 +2053,16 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 	down_read(&nm_i->nat_tree_lock);
 
 	while (1) {
-		struct page *page = get_current_nat_page(sbi, nid);
+		struct page *page;
 
+		if (test_bit_le(NAT_BLOCK_OFFSET(nid),
+					nm_i->nat_block_bitmap)) {
+			goto skip;
+		}
+		page = get_current_nat_page(sbi, nid);
 		scan_nat_page(sbi, page, nid);
 		f2fs_put_page(page, 1);
-
+skip:
 		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
 		if (unlikely(nid >= nm_i->max_nid))
 			nid = 0;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
