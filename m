From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix to return exact trimmed size
Date: Thu,  4 Jun 2015 10:10:18 -0700
Message-ID: <1433437818-47609-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now, we add all the candidates for trim commands and then finally issue
discard commands.
So, we should count the trimmed size in back-end.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 46283a1..1eb3437 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -544,7 +544,6 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
 	list_add_tail(&new->list, head);
 done:
 	SM_I(sbi)->nr_discards += end - start;
-	cpc->trimmed += end - start;
 }
 
 static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
@@ -646,6 +645,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (cpc->reason == CP_DISCARD && entry->len < cpc->trim_minlen)
 			goto skip;
 		f2fs_issue_discard(sbi, entry->blkaddr, entry->len);
+		cpc->trimmed += entry->len;
 skip:
 		list_del(&entry->list);
 		SM_I(sbi)->nr_discards -= entry->len;
-- 
2.1.1
