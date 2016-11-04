From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] fsck.f2fs: No need to write a new cp if
	nothing to flush
Date: Fri, 4 Nov 2016 17:34:10 +0800
Message-ID: <20161104093411.14921-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c2anN-0001vn-GL
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 09:28:21 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c2anM-0007Nn-BA
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 09:28:21 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch avoid to write a new cp if no journal info

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index dd7a081..f2055e4 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1447,7 +1447,7 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	}
 }
 
-static void flush_sit_journal_entries(struct f2fs_sb_info *sbi)
+static int flush_sit_journal_entries(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
@@ -1474,10 +1474,12 @@ static void flush_sit_journal_entries(struct f2fs_sb_info *sbi)
 		rewrite_current_sit_page(sbi, segno, sit_blk);
 		free(sit_blk);
 	}
+
 	journal->n_sits = 0;
+	return i;
 }
 
-static void flush_nat_journal_entries(struct f2fs_sb_info *sbi)
+static int flush_nat_journal_entries(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
@@ -1491,7 +1493,7 @@ static void flush_nat_journal_entries(struct f2fs_sb_info *sbi)
 next:
 	if (i >= nats_in_cursum(journal)) {
 		journal->n_nats = 0;
-		return;
+		return i;
 	}
 
 	nid = le32_to_cpu(nid_in_journal(journal, i));
@@ -1515,9 +1517,11 @@ next:
 
 void flush_journal_entries(struct f2fs_sb_info *sbi)
 {
-	flush_nat_journal_entries(sbi);
-	flush_sit_journal_entries(sbi);
-	write_checkpoint(sbi);
+	int n_nats = flush_nat_journal_entries(sbi);
+	int n_sits = flush_sit_journal_entries(sbi);
+
+	if (n_nats || n_sits)
+		write_checkpoint(sbi);
 }
 
 void flush_sit_entries(struct f2fs_sb_info *sbi)
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
