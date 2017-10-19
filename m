From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: retry ENOMEM for quota_read|write
Date: Thu, 19 Oct 2017 09:56:16 -0700
Message-ID: <20171019165617.79128-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This gives another chance to read or write quota data.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fc3b74e53670..2c6e9adce464 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1351,8 +1351,13 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
 repeat:
 		page = read_mapping_page(mapping, blkidx, NULL);
-		if (IS_ERR(page))
+		if (IS_ERR(page)) {
+			if (PTR_ERR(page) == -ENOMEM) {
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				goto repeat;
+			}
 			return PTR_ERR(page);
+		}
 
 		lock_page(page);
 
@@ -1395,10 +1400,14 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	while (towrite > 0) {
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
-
+retry:
 		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
 							&page, NULL);
 		if (unlikely(err)) {
+			if (err == -ENOMEM) {
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				goto retry;
+			}
 			if (len == towrite)
 				return err;
 			break;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
