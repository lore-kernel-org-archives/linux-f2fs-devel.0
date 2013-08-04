From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH 3/3] f2fs: remove redundant code from f2fs_write_begin
Date: Sun,  4 Aug 2013 23:10:28 +0900
Message-ID: <1375625428-2869-1-git-send-email-linkinjeon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

This code is being used for nobh_write_end() function.
But since now f2fs_write_end function is added so
there is no need for this code.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/data.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19cd7c6..ae1558e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -635,9 +635,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	int err = 0;
 	int ilock;
 
-	/* for nobh_write_end */
-	*fsdata = NULL;
-
 	f2fs_balance_fs(sbi);
 repeat:
 	page = grab_cache_page_write_begin(mapping, index, flags);
-- 
1.7.9.5
