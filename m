From: "LiFan" <fanofcode.li@samsung.com>
Subject: [PATCH RESEND v2] f2fs: validate before set/clear free
 nat bitmap
Date: Tue, 14 Nov 2017 15:20:32 +0800
Message-ID: <002201d35d19$3837e870$a8a7b950$@samsung.com>
References: <CGME20171114072142epcas5p1e7543c4f118db48ff8ad417894f964d2@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <fanofcode.li@samsung.com>) id 1eEVXd-0007eW-0X
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Nov 2017 07:21:53 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eEVXa-00033N-E8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Nov 2017 07:21:52 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20171114072143epoutp01885772d7d26dc592763cb4988556a804~24s7l4W6l1229212292epoutp01C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Nov 2017 07:21:43 +0000 (GMT)
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Chao Yu' <chao@kernel.org>, 'Chao Yu' <yuchao0@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In flush_nat_entries, all dirty nats will be flushed and if their new address
isn't NULL_ADDR, their bitmaps will be updated, the free_nid_count of the
bitmaps will be increased regardless of whether the nats have already been
occupied before. This could lead to wrong free_nid_count.
So this patch checks the status of the bits before actually set/clear them.

Fixes: 586d1492f301 ("f2fs: skip scanning free nid bitmap of full NAT blocks")

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index d234c6e..b965a53 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1906,15 +1906,18 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
 		return;
 
-	if (set)
+	if (set) {
+		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
+			return;
 		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
-	else
-		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
-
-	if (set)
 		nm_i->free_nid_count[nat_ofs]++;
-	else if (!build)
-		nm_i->free_nid_count[nat_ofs]--;
+	} else {
+		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
+			return;
+		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
+		if (!build)
+			nm_i->free_nid_count[nat_ofs]--;
+	}
 }
 
 static void scan_nat_page(struct f2fs_sb_info *sbi,
--
2.7.4



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
