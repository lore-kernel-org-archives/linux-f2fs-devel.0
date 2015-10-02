From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: merge meta writes as many possible
Date: Fri,  2 Oct 2015 09:47:50 -0700
Message-ID: <1443804470-2541-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch tries to merge IOs as many as possible when background flusher
conducts flushing the dirty meta pages.

[Before]

...
2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124320, size = 4096
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124560, size = 32768
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 95720, size = 987136
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123928, size = 4096
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123944, size = 8192
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123968, size = 45056
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124064, size = 4096
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 97648, size = 1007616
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123776, size = 8192
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123800, size = 32768
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124624, size = 4096
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 99616, size = 921600
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123608, size = 4096
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123624, size = 77824
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123792, size = 4096
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123864, size = 32768
...

[After]

...
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 92168, size = 892928
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 93912, size = 753664
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 95384, size = 716800
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 96784, size = 712704
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 104160, size = 364544
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 104872, size = 356352
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 105568, size = 278528
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 106112, size = 319488
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 106736, size = 258048
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 107240, size = 270336
f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 107768, size = 180224
...

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ff53405..da5ee7e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -257,7 +257,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 						long nr_to_write)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, end = LONG_MAX;
+	pgoff_t index = 0, end = LONG_MAX, prev = LONG_MAX;
 	struct pagevec pvec;
 	long nwritten = 0;
 	struct writeback_control wbc = {
@@ -277,6 +277,11 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
+			if (prev == LONG_MAX)
+				prev = page->index - 1;
+			if (nr_to_write != LONG_MAX && page->index != prev + 1)
+				break;
+
 			lock_page(page);
 
 			if (unlikely(page->mapping != mapping)) {
@@ -297,6 +302,7 @@ continue_unlock:
 				break;
 			}
 			nwritten++;
+			prev = page->index;
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-- 
2.1.1
