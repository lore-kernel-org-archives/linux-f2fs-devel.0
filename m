From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to update page flag
Date: Wed, 08 Jul 2015 18:24:38 +0800
Message-ID: <00bc01d0b968$63bcf690$2b36e3b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to update page flag (e.g. Uptodate/cold flag) in
->write_begin.

Otherwise, page will be non-uptodate when we try to write entire
page, and cold data flag in page will not be clean when gced page
is being rewritten.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 056f4f9..a869d80 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1249,8 +1249,10 @@ put_next:
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
 
-	if ((len == PAGE_CACHE_SIZE) || PageUptodate(page))
-		return 0;
+	if (len == PAGE_CACHE_SIZE)
+		goto out_update;
+	if (PageUptodate(page))
+		goto out_clear;
 
 	f2fs_wait_on_page_writeback(page, DATA);
 
@@ -1260,7 +1262,7 @@ put_next:
 
 		/* Reading beyond i_size is simple: memset to zero */
 		zero_user_segments(page, 0, start, end, PAGE_CACHE_SIZE);
-		goto out;
+		goto out_update;
 	}
 
 	if (dn.data_blkaddr == NEW_ADDR) {
@@ -1298,8 +1300,9 @@ put_next:
 			}
 		}
 	}
-out:
+out_update:
 	SetPageUptodate(page);
+out_clear:
 	clear_cold_data(page);
 	return 0;
 
-- 
2.4.2
