From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3 v2] f2fs: check the page status filled from disk
Date: Tue, 5 Jan 2016 20:10:46 -0800
Message-ID: <20160106040727.GA8472@jaegeuk.gateway>
References: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 - use get_lock_data_page and return error, suggested by Chao

>From 4882f227e71b482c53e55a5c3ad559d33f620a20 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 1 Jan 2016 22:03:47 -0800
Subject: [PATCH] f2fs: check the page status filled from disk

After reading a page, we need to check whether there is any error.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 89a978c..0bfa02a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -442,12 +442,11 @@ repeat:
 	} else {
 		f2fs_put_page(page, 1);
 
-		page = get_read_data_page(inode, index, READ_SYNC, true);
+		/* if ipage exists, blkaddr should be NEW_ADDR */
+		f2fs_bug_on(F2FS_I_SB(inode), ipage);
+		page = get_lock_data_page(inode, index, true);
 		if (IS_ERR(page))
-			goto repeat;
-
-		/* wait for read completion */
-		lock_page(page);
+			return page;
 	}
 got_it:
 	if (new_i_size && i_size_read(inode) <
-- 
2.6.3
