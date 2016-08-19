From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid unneeded loop in
	build_sit_entries
Date: Fri, 19 Aug 2016 23:13:47 +0800
Message-ID: <1471619627-4174-2-git-send-email-chao@kernel.org>
References: <1471619627-4174-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1balWg-00025V-2v
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 15:16:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1balWf-0006Dy-6z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 15:16:06 +0000
In-Reply-To: <1471619627-4174-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

When building each sit entry in cache, firstly, we will load it from
sit page, and then check all entries in sit journal, if there is one
updated entry in journal, cover cached entry with the journaled one.

Actually, most of check operation is unneeded since we only need
to update cached entries with journaled entries in batch, so
changing the flow as below for more efficient:
1. load all sit entries into cache from sit pages;
2. update sit entries with journal.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 59f578b..a394012 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2262,22 +2262,11 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 			struct f2fs_sit_entry sit;
 			struct page *page;
 
-			down_read(&curseg->journal_rwsem);
-			for (i = 0; i < sits_in_cursum(journal); i++) {
-				if (le32_to_cpu(segno_in_journal(journal, i))
-								== start) {
-					sit = sit_in_journal(journal, i);
-					up_read(&curseg->journal_rwsem);
-					goto got_it;
-				}
-			}
-			up_read(&curseg->journal_rwsem);
-
 			page = get_current_sit_page(sbi, start);
 			sit_blk = (struct f2fs_sit_block *)page_address(page);
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
 			f2fs_put_page(page, 1);
-got_it:
+
 			check_block_count(sbi, start, &sit);
 			seg_info_from_raw_sit(se, &sit);
 
@@ -2289,13 +2278,40 @@ got_it:
 							se->valid_blocks;
 			}
 
-			if (sbi->segs_per_sec > 1) {
-				struct sec_entry *e = get_sec_entry(sbi, start);
-				e->valid_blocks += se->valid_blocks;
-			}
+			if (sbi->segs_per_sec > 1)
+				get_sec_entry(sbi, start)->valid_blocks +=
+							se->valid_blocks;
 		}
 		start_blk += readed;
 	} while (start_blk < sit_blk_cnt);
+
+	down_read(&curseg->journal_rwsem);
+	for (i = 0; i < sits_in_cursum(journal); i++) {
+		struct f2fs_sit_entry sit;
+		struct seg_entry *se;
+		unsigned int old_valid_blocks;
+
+		start = le32_to_cpu(segno_in_journal(journal, i));
+		se = &sit_i->sentries[start];
+		sit = sit_in_journal(journal, i);
+
+		old_valid_blocks = se->valid_blocks;
+
+		check_block_count(sbi, start, &sit);
+		seg_info_from_raw_sit(se, &sit);
+
+		if (f2fs_discard_en(sbi)) {
+			memcpy(se->discard_map, se->cur_valid_map,
+						SIT_VBLOCK_MAP_SIZE);
+			sbi->discard_blks += old_valid_blocks -
+						se->valid_blocks;
+		}
+
+		if (sbi->segs_per_sec > 1)
+			get_sec_entry(sbi, start)->valid_blocks +=
+				se->valid_blocks - old_valid_blocks;
+	}
+	up_read(&curseg->journal_rwsem);
 }
 
 static void init_free_segmap(struct f2fs_sb_info *sbi)
-- 
2.7.2


------------------------------------------------------------------------------
