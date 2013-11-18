From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: clean up the do_submit_bio flow
Date: Mon, 18 Nov 2013 18:12:01 +0900
Message-ID: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces PAGE_TYPE_OF_BIO() and cleans up do_submit_bio() with it.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 39 +++++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fe5c2fc..1c783fd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -351,6 +351,7 @@ enum count_type {
  *			with waiting the bio's completion
  * ...			Only can be used with META.
  */
+#define PAGE_TYPE_OF_BIO(type)	(type) > META ? META : (type)
 enum page_type {
 	DATA,
 	NODE,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1f83999..dad5f1a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -837,32 +837,35 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 				enum page_type type, bool sync)
 {
 	int rw = sync ? WRITE_SYNC : WRITE;
-	enum page_type btype = type > META ? META : type;
+	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+	struct bio *bio = sbi->bio[btype];
+	struct bio_private *p;
+
+	if (!bio)
+		return;
+
+	sbi->bio[btype] = NULL;
 
 	if (type >= META_FLUSH)
 		rw = WRITE_FLUSH_FUA;
-
 	if (btype == META)
 		rw |= REQ_META;
 
-	if (sbi->bio[btype]) {
-		struct bio_private *p = sbi->bio[btype]->bi_private;
-		p->sbi = sbi;
-		sbi->bio[btype]->bi_end_io = f2fs_end_io_write;
+	p = bio->bi_private;
+	p->sbi = sbi;
+	bio->bi_end_io = f2fs_end_io_write;
 
-		trace_f2fs_do_submit_bio(sbi->sb, btype, sync, sbi->bio[btype]);
+	trace_f2fs_do_submit_bio(sbi->sb, btype, sync, bio);
 
-		if (type == META_FLUSH) {
-			DECLARE_COMPLETION_ONSTACK(wait);
-			p->is_sync = true;
-			p->wait = &wait;
-			submit_bio(rw, sbi->bio[btype]);
-			wait_for_completion(&wait);
-		} else {
-			p->is_sync = false;
-			submit_bio(rw, sbi->bio[btype]);
-		}
-		sbi->bio[btype] = NULL;
+	if (type == META_FLUSH) {
+		DECLARE_COMPLETION_ONSTACK(wait);
+		p->is_sync = true;
+		p->wait = &wait;
+		submit_bio(rw, bio);
+		wait_for_completion(&wait);
+	} else {
+		p->is_sync = false;
+		submit_bio(rw, bio);
 	}
 }
 
-- 
1.8.4.474.g128a96c

