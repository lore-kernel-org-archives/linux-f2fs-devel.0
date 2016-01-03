From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: check the page status filled from disk
Date: Sat,  2 Jan 2016 17:26:04 -0800
Message-ID: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

After reading a page, we need to check whether there is any error.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 89a978c..11b2111 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -448,6 +448,14 @@ repeat:
 
 		/* wait for read completion */
 		lock_page(page);
+		if (unlikely(!PageUptodate(page))) {
+			f2fs_put_page(page, 1);
+			return ERR_PTR(-EIO);
+		}
+		if (unlikely(page->mapping != mapping)) {
+			f2fs_put_page(page, 1);
+			goto repeat;
+		}
 	}
 got_it:
 	if (new_i_size && i_size_read(inode) <
-- 
2.6.3
