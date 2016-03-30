From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: use PGP_LOCK to check its truncation
Date: Wed, 30 Mar 2016 13:24:55 -0700
Message-ID: <1459369496-61911-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, after trylock_page is succeeded, it doesn't check its mapping.
In order to fix that, we can just give PGP_LOCK to pagecache_get_page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 118321b..2f2810e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1202,13 +1202,10 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	if (!inode)
 		return;
 
-	page = pagecache_get_page(inode->i_mapping, 0, FGP_NOWAIT, 0);
+	page = pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
 	if (!page)
 		goto iput_out;
 
-	if (!trylock_page(page))
-		goto release_out;
-
 	if (!PageUptodate(page))
 		goto page_out;
 
-- 
2.6.3
