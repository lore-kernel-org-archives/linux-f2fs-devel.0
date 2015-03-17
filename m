From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: avoid wrong f2fs_bug_on when truncating inline_data
Date: Tue, 17 Mar 2015 09:57:41 -0700
Message-ID: <1426611461-690-4-git-send-email-jaegeuk@kernel.org>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch removes wrong f2fs_bug_on in truncate_inline_inode.

When there is no space, it can happen a corner case where i_isze is over
MAX_INLINE_SIZE while its inode is still inline_data.

The scenario is
 1. write small data into file #A.
 2. fill the whole partition to 100%.
 3. truncate 4096 on file #A.
 4. write data at 8192 offset.
  --> f2fs_write_begin
    -> -ENOSPC = f2fs_convert_inline_page
    -> f2fs_write_failed
      -> truncate_blocks
        -> truncate_inline_inode
	  BUG_ON, since i_size is 4096.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 153c5e7..d3e0599 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -54,13 +54,6 @@ bool truncate_inline_inode(struct page *ipage, u64 from)
 {
 	void *addr;
 
-	/*
-	 * we should never truncate inline data past max inline data size,
-	 * because we always convert inline inode to normal one before
-	 * truncating real data if new size is past max inline data size.
-	 */
-	f2fs_bug_on(F2FS_P_SB(ipage), from > MAX_INLINE_DATA);
-
 	if (from >= MAX_INLINE_DATA)
 		return false;
 
-- 
2.1.1

