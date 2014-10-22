From: Jan Kara <jack@suse.cz>
Subject: [PATCH] f2fs: Fix possible data corruption in f2fs_write_begin()
Date: Wed, 22 Oct 2014 15:21:47 +0200
Message-ID: <1413984107-7920-1-git-send-email-jack@suse.cz>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, stable@vger.kernel.org, Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_write_begin() doesn't initialize the 'dn' variable if the inode has
inline data. However it uses its contents to decide whether it should
just zero out the page or load data to it. Thus if we are unlucky we can
zero out page contents instead of loading inline data into a page.

CC: stable@vger.kernel.org
CC: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/data.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8e58c4cc2cb9..f988b01b6f89 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1007,21 +1007,19 @@ inline_data:
 		goto out;
 	}
 
-	if (dn.data_blkaddr == NEW_ADDR) {
+	if (f2fs_has_inline_data(inode)) {
+		err = f2fs_read_inline_data(inode, page);
+		if (err) {
+			page_cache_release(page);
+			goto fail;
+		}
+	} else if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	} else {
-		if (f2fs_has_inline_data(inode)) {
-			err = f2fs_read_inline_data(inode, page);
-			if (err) {
-				page_cache_release(page);
-				goto fail;
-			}
-		} else {
-			err = f2fs_submit_page_bio(sbi, page, dn.data_blkaddr,
-							READ_SYNC);
-			if (err)
-				goto fail;
-		}
+		err = f2fs_submit_page_bio(sbi, page, dn.data_blkaddr,
+					   READ_SYNC);
+		if (err)
+			goto fail;
 
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
-- 
1.8.1.4
