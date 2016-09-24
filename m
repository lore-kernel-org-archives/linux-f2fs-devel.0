From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: remove redundant value definition
Date: Sat, 24 Sep 2016 12:29:18 +0800
Message-ID: <1474691358-17191-2-git-send-email-heyunlei@huawei.com>
References: <1474691358-17191-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bneVh-0008T9-9s
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 04:24:21 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bneVf-0003zc-Fs
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 04:24:21 +0000
In-Reply-To: <1474691358-17191-1-git-send-email-heyunlei@huawei.com>
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

This patch remove redundant value definition in build_sit_entries

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e78501c..fbcc172 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2305,6 +2305,8 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = curseg->journal;
+	struct seg_entry *se;
+	struct f2fs_sit_entry sit;
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
@@ -2317,11 +2319,10 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 		end = (start_blk + readed) * sit_i->sents_per_block;
 
 		for (; start < end && start < MAIN_SEGS(sbi); start++) {
-			struct seg_entry *se = &sit_i->sentries[start];
 			struct f2fs_sit_block *sit_blk;
-			struct f2fs_sit_entry sit;
 			struct page *page;
 
+			se = &sit_i->sentries[start];
 			page = get_current_sit_page(sbi, start);
 			sit_blk = (struct f2fs_sit_block *)page_address(page);
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
@@ -2347,8 +2348,6 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 
 	down_read(&curseg->journal_rwsem);
 	for (i = 0; i < sits_in_cursum(journal); i++) {
-		struct f2fs_sit_entry sit;
-		struct seg_entry *se;
 		unsigned int old_valid_blocks;
 
 		start = le32_to_cpu(segno_in_journal(journal, i));
-- 
1.9.1


------------------------------------------------------------------------------
