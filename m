From: Jan Kara <jack@suse.cz>
Subject: [PATCH] f2fs: Avoid returning uninitialized value to userspace from f2fs_trim_fs()
Date: Tue, 21 Oct 2014 14:07:33 +0200
Message-ID: <1413893253-7321-1-git-send-email-jack@suse.cz>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If user specifies too low end sector for trimming, f2fs_trim_fs() will
use uninitialized value as a number of trimmed blocks and returns it to
userspace. Initialize number of trimmed blocks early to avoid the
problem.

Coverity-id: 1248809
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 923cb76fdc46..3c31221affe6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1004,6 +1004,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 						range->len < sbi->blocksize)
 		return -EINVAL;
 
+	cpc.trimmed = 0;
 	if (end <= MAIN_BLKADDR(sbi))
 		goto out;
 
@@ -1015,7 +1016,6 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	cpc.trim_start = start_segno;
 	cpc.trim_end = end_segno;
 	cpc.trim_minlen = range->minlen >> sbi->log_blocksize;
-	cpc.trimmed = 0;
 
 	/* do checkpoint to issue discard commands safely */
 	write_checkpoint(sbi, &cpc);
-- 
1.8.1.4
