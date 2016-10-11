From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/8] f2fs: fix to release discard entries during
	checkpoint
Date: Tue, 11 Oct 2016 22:57:00 +0800
Message-ID: <20161011145706.5028-2-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyWY-000524-8p
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWX-0001lE-KN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:22 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In f2fs_fill_super, if there is any IO error occurs during recovery,
cached discard entries will be leaked, in order to avoid this, make
write_checkpoint() handle memory release by itself, besides, move
clear_prefree_segments to write_checkpoint for readability.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 9 ++++++---
 fs/f2fs/super.c      | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eacc697..654f5d7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1184,7 +1184,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
-	clear_prefree_segments(sbi, cpc);
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
 	clear_sbi_flag(sbi, SBI_NEED_CP);
 
@@ -1261,8 +1260,12 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* unlock all the fs_lock[] in do_checkpoint() */
 	err = do_checkpoint(sbi, cpc);
-
-	f2fs_wait_all_discard_bio(sbi);
+	if (err) {
+		release_discard_addrs(sbi);
+	} else {
+		clear_prefree_segments(sbi, cpc);
+		f2fs_wait_all_discard_bio(sbi);
+	}
 
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6132b4c..bfa4414 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -738,7 +738,6 @@ static void f2fs_put_super(struct super_block *sb)
 	 * In addition, EIO will skip do checkpoint, we need this as well.
 	 */
 	release_ino_entry(sbi, true);
-	release_discard_addrs(sbi);
 
 	f2fs_leave_shrinker(sbi);
 	mutex_unlock(&sbi->umount_mutex);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
