From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: give correct trimmed blocks in fstrim
Date: Sat, 28 Oct 2017 16:52:32 +0800
Message-ID: <20171028085233.34488-4-yuchao0@huawei.com>
References: <20171028085233.34488-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e8MrZ-00007D-1g
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:05 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e8MrX-0002dF-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:04 +0000
In-Reply-To: <20171028085233.34488-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We have supported to issue discard in specified range during fstrim,
it needs to return caller with successfully trimmed bytes in that
range instead of bytes of invalid blocks which are scanned in
checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 -
 fs/f2fs/segment.c | 27 +++++++++++++++++++--------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ddcd8f876938..850457e72002 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -162,7 +162,6 @@ struct cp_control {
 	__u64 trim_start;
 	__u64 trim_end;
 	__u64 trim_minlen;
-	__u64 trimmed;
 };
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f75685418d9f..ab6382ee5111 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1218,21 +1218,27 @@ static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
 	return dropped;
 }
 
-static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
+static unsigned int __wait_one_discard_bio(struct f2fs_sb_info *sbi,
 							struct discard_cmd *dc)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	unsigned int len = 0;
 
 	wait_for_completion_io(&dc->wait);
 	mutex_lock(&dcc->cmd_lock);
 	f2fs_bug_on(sbi, dc->state != D_DONE);
 	dc->ref--;
-	if (!dc->ref)
+	if (!dc->ref) {
+		if (!dc->error)
+			len = dc->len;
 		__remove_discard_cmd(sbi, dc);
+	}
 	mutex_unlock(&dcc->cmd_lock);
+
+	return len;
 }
 
-static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
+static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy,
 						block_t start, block_t end)
 {
@@ -1241,6 +1247,7 @@ static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 					&(dcc->fstrim_list) : &(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
 	bool need_wait;
+	unsigned int trimmed = 0;
 
 next:
 	need_wait = false;
@@ -1253,6 +1260,8 @@ static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 			continue;
 		if (dc->state == D_DONE && !dc->ref) {
 			wait_for_completion_io(&dc->wait);
+			if (!dc->error)
+				trimmed += dc->len;
 			__remove_discard_cmd(sbi, dc);
 		} else {
 			dc->ref++;
@@ -1263,9 +1272,11 @@ static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&dcc->cmd_lock);
 
 	if (need_wait) {
-		__wait_one_discard_bio(sbi, dc);
+		trimmed += __wait_one_discard_bio(sbi, dc);
 		goto next;
 	}
+
+	return trimmed;
 }
 
 static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
@@ -1626,7 +1637,6 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
 									len);
-			cpc->trimmed += len;
 			total_len += len;
 		} else {
 			next_pos = find_next_bit_le(entry->discard_map,
@@ -2330,12 +2340,12 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	block_t start_block, end_block;
 	struct cp_control cpc;
 	struct discard_policy dpolicy;
+	unsigned long long trimmed = 0;
 	int err = 0;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
 
-	cpc.trimmed = 0;
 	if (end <= MAIN_BLKADDR(sbi))
 		goto out;
 
@@ -2385,9 +2395,10 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
 	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
-	__wait_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
+	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+					start_block, end_block);
 out:
-	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
+	range->len = F2FS_BLK_TO_BYTES(trimmed);
 	return err;
 }
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
