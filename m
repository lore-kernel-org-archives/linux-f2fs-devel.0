From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid potential race on
 sbi->unusable_block_count access/update
Date: Sun, 5 May 2019 11:40:46 +0800
Message-ID: <20190505034046.17905-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hN81S-0003wn-Lp
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 May 2019 03:41:06 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hN81Q-00677I-9q
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 May 2019 03:41:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, drosen@google.com

Use sbi.stat_lock to protect sbi->unusable_block_count accesss/udpate, in
order to avoid potential race on it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/segment.c    | 5 ++++-
 fs/f2fs/super.c      | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 805a33088e82..ed70b68b2b38 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1536,7 +1536,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
 	clear_sbi_flag(sbi, SBI_NEED_CP);
 	clear_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
+
+	spin_lock(&sbi->stat_lock);
 	sbi->unusable_block_count = 0;
+	spin_unlock(&sbi->stat_lock);
+
 	__set_cp_next_pack(sbi);
 
 	/*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8388d2abacb5..8dee063c833f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2169,8 +2169,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			 * before, we must track that to know how much space we
 			 * really have.
 			 */
-			if (f2fs_test_bit(offset, se->ckpt_valid_map))
+			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
+				spin_lock(&sbi->stat_lock);
 				sbi->unusable_block_count++;
+				spin_unlock(&sbi->stat_lock);
+			}
 		}
 
 		if (f2fs_test_and_clear_bit(offset, se->discard_map))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dce4416cb1d8..d40cae0cba56 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1226,10 +1226,13 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
+
+	spin_lock(&sbi->stat_lock);
 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
 		buf->f_bfree = 0;
 	else
 		buf->f_bfree -= sbi->unusable_block_count;
+	spin_unlock(&sbi->stat_lock);
 
 	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
 		buf->f_bavail = buf->f_bfree -
@@ -1508,7 +1511,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	if (err)
 		goto out_unlock;
 
+	spin_lock(&sbi->stat_lock);
 	sbi->unusable_block_count = 0;
+	spin_unlock(&sbi->stat_lock);
+
 out_unlock:
 	mutex_unlock(&sbi->gc_mutex);
 restore_flag:
-- 
2.18.0.rc1
