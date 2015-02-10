From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: check node page contents all the time
Date: Tue, 10 Feb 2015 13:58:42 -0800
Message-ID: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In get_node_page, if the page is up-to-date, we assumed that the page was not
reclaimed at all.
But, sometimes it was reported that its contents was missing.
So, just for sure, let's check its mapping and contents.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ea22c32..1e354ff 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1036,11 +1036,11 @@ repeat:
 	err = read_node_page(page, READ_SYNC);
 	if (err < 0)
 		return ERR_PTR(err);
-	else if (err == LOCKED_PAGE)
-		goto got_it;
+	else if (err != LOCKED_PAGE)
+		lock_page(page);
 
-	lock_page(page);
 	if (unlikely(!PageUptodate(page) || nid != nid_of_node(page))) {
+		ClearPageUptodate(page);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
@@ -1048,7 +1048,6 @@ repeat:
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
-got_it:
 	return page;
 }
 
-- 
2.1.1
