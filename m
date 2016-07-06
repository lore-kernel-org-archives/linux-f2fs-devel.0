From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: shrink critical region in spin_lock
Date: Wed,  6 Jul 2016 09:06:29 -0700
Message-ID: <20160706160632.78272-3-jaegeuk@kernel.org>
References: <20160706160632.78272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bKpLY-0005bT-MM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bKpLX-0007VB-Ur
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:44 +0000
In-Reply-To: <20160706160632.78272-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch shrinks the critical region in spin_lock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a05f65b..a51f230 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1156,30 +1156,23 @@ static inline void f2fs_i_blocks_write(struct inode *, blkcnt_t, bool);
 static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
 {
-	block_t	valid_block_count;
-
-	spin_lock(&sbi->stat_lock);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(FAULT_BLOCK)) {
-		spin_unlock(&sbi->stat_lock);
+	if (time_to_inject(FAULT_BLOCK))
 		return false;
-	}
 #endif
-	valid_block_count =
-		sbi->total_valid_block_count + (block_t)(*count);
-	if (unlikely(valid_block_count > sbi->user_block_count)) {
-		*count = sbi->user_block_count - sbi->total_valid_block_count;
+	spin_lock(&sbi->stat_lock);
+	sbi->total_valid_block_count += (block_t)(*count);
+	if (unlikely(sbi->total_valid_block_count > sbi->user_block_count)) {
+		*count -= sbi->total_valid_block_count - sbi->user_block_count;
+		sbi->total_valid_block_count = sbi->user_block_count;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
 			return false;
 		}
 	}
-	/* *count can be recalculated */
-	f2fs_i_blocks_write(inode, *count, true);
-	sbi->total_valid_block_count =
-		sbi->total_valid_block_count + (block_t)(*count);
 	spin_unlock(&sbi->stat_lock);
 
+	f2fs_i_blocks_write(inode, *count, true);
 	percpu_counter_add(&sbi->alloc_valid_block_count, (*count));
 	return true;
 }
@@ -1191,9 +1184,9 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
 	f2fs_bug_on(sbi, inode->i_blocks < count);
-	f2fs_i_blocks_write(inode, count, false);
 	sbi->total_valid_block_count -= (block_t)count;
 	spin_unlock(&sbi->stat_lock);
+	f2fs_i_blocks_write(inode, count, false);
 }
 
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
-- 
2.8.3


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
