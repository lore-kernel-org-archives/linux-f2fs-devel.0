From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH V2] f2fs: change the method of calculating the
 number summary blocks
Date: Tue, 29 Oct 2013 16:21:47 +0800
Message-ID: <002701ced480$0ab1cd10$20156730$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1Vb4Zp-0002gV-Ps
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Oct 2013 08:23:01 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vb4Zj-0007F3-6L for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Oct 2013 08:23:01 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MVF003WM8LS3LD0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Oct 2013 17:22:48 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

npages_for_summary_flush uses (SUMMARY_SIZE + 1) as the size of a
f2fs_summary 
while its actual size is  SUMMARY_SIZE. So the result sometimes is bigger
than actual 
number by one, which causes checkpoint can't be written into disk
contiguously, 
and sometimes summary blocks can't be compacted like they should.
Besides, when writing summary blocks into pages, if remain space in a page
isn't 
big enough for one f2fs_summary, it will be left unused, current code seems
not to 
take it into account.

Signed-off-by: Fan Li <fanofcode.li@samsung.com>
---
 fs/f2fs/segment.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index 487af61..e40cdc4
100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -279,9 +279,8 @@ static void __add_sum_entry(struct f2fs_sb_info *sbi,
int type,
  */
 int npages_for_summary_flush(struct f2fs_sb_info *sbi)  {
-	int total_size_bytes = 0;
 	int valid_sum_count = 0;
-	int i, sum_space;
+	int i, sum_in_page;
 
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		if (sbi->ckpt->alloc_type[i] == SSR)
@@ -290,13 +289,12 @@ int npages_for_summary_flush(struct f2fs_sb_info *sbi)
 			valid_sum_count += curseg_blkoff(sbi, i);
 	}
 
-	total_size_bytes = valid_sum_count * (SUMMARY_SIZE + 1)
-			+ sizeof(struct nat_journal) + 2
-			+ sizeof(struct sit_journal) + 2;
-	sum_space = PAGE_CACHE_SIZE - SUM_FOOTER_SIZE;
-	if (total_size_bytes < sum_space)
+	sum_in_page = (PAGE_CACHE_SIZE - 2 * SUM_JOURNAL_SIZE -
+			SUM_FOOTER_SIZE) / SUMMARY_SIZE;
+	if (valid_sum_count <= sum_in_page)
 		return 1;
-	else if (total_size_bytes < 2 * sum_space)
+	else if ((valid_sum_count - sum_in_page) <=
+		(PAGE_CACHE_SIZE - SUM_FOOTER_SIZE) / SUMMARY_SIZE)
 		return 2;
 	return 3;
 }
--
1.7.9.5



------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
