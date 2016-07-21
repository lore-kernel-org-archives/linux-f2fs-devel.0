From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: avoid data race when deciding checkpoin in f2fs_sync_file
Date: Wed, 20 Jul 2016 20:42:04 -0700
Message-ID: <20160721034205.99473-2-jaegeuk@kernel.org>
References: <20160721034205.99473-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160721034205.99473-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When fs utilization is almost full, f2fs_sync_file should do checkpoint if
there is not enough space for roll-forward later. (i.e. space_for_roll_forward)
So, currently we have no lock for sbi->alloc_valid_block_count, resulting in
race condition.

In rare case, we can get -ENOSPC when doing roll-forward which triggers

	if (is_valid_blkaddr(sbi, dest, META_POR)) {
		if (src == NULL_ADDR) {
			err = reserve_new_block(&dn);
			f2fs_bug_on(sbi, err);
			...
		}
		...
	}
in do_recover_data.

So, this patch avoids that situation in advance.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7a57279..3098109 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1147,24 +1147,33 @@ static inline void f2fs_i_blocks_write(struct inode *, blkcnt_t, bool);
 static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
 {
+	blkcnt_t diff;
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(FAULT_BLOCK))
 		return false;
 #endif
+	/*
+	 * let's increase this in prior to actual block count change in order
+	 * for f2fs_sync_file to avoid data races when deciding checkpoint.
+	 */
+	percpu_counter_add(&sbi->alloc_valid_block_count, (*count));
+
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
 	if (unlikely(sbi->total_valid_block_count > sbi->user_block_count)) {
-		*count -= sbi->total_valid_block_count - sbi->user_block_count;
+		diff = sbi->total_valid_block_count - sbi->user_block_count;
+		*count -= diff;
 		sbi->total_valid_block_count = sbi->user_block_count;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
+			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
 			return false;
 		}
 	}
 	spin_unlock(&sbi->stat_lock);
 
 	f2fs_i_blocks_write(inode, *count, true);
-	percpu_counter_add(&sbi->alloc_valid_block_count, (*count));
 	return true;
 }
 
-- 
2.8.3
