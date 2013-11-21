From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: merge read IOs at ra_nat_pages()
Date: Thu, 21 Nov 2013 18:35:50 +0900
Message-ID: <1385026550-21055-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VjQgu-0004GY-9I
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Nov 2013 09:36:52 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjQgs-0003Tl-AX for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Nov 2013 09:36:52 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWL00L4EXCJ81Q0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Nov 2013 18:36:43 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch changes the policy of submitting read bios at ra_nat_pages.

Previously, f2fs submits small read bios with block plugging.
But, with this patch, f2fs itself merges read bios first and then submits a
large bio, which can reduce the bio handling overheads.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b843a5b..c06871f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -89,13 +89,10 @@ static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
 {
 	struct address_space *mapping = sbi->meta_inode->i_mapping;
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct blk_plug plug;
 	struct page *page;
 	pgoff_t index;
 	int i;
 
-	blk_start_plug(&plug);
-
 	for (i = 0; i < FREE_NID_PAGES; i++, nid += NAT_ENTRY_PER_BLOCK) {
 		if (nid >= nm_i->max_nid)
 			nid = 0;
@@ -108,12 +105,11 @@ static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
 			f2fs_put_page(page, 1);
 			continue;
 		}
-		if (f2fs_readpage(sbi, page, index, READ))
-			continue;
+		submit_read_page(sbi, page, index, READ_SYNC);
 
 		f2fs_put_page(page, 0);
 	}
-	blk_finish_plug(&plug);
+	f2fs_submit_read_bio(sbi, READ_SYNC);
 }
 
 static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
