From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: update cur_valid_map_mir together with
 cur_valid_map
Date: Tue, 1 Aug 2017 23:44:06 +0800
Message-ID: <d04ca5c3-f38f-fe48-a073-243e49bc243c@kernel.org>
References: <1501574206-150946-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501574206-150946-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, sylinux@163.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

How about checking consistence in between original and mirror bitmap all
the time as below?

---
 fs/f2fs/segment.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a26c24dae70c..f32a19cf486a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1510,6 +1510,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	struct seg_entry *se;
 	unsigned int segno, offset;
 	long int new_vblocks;
+	bool exist, mir_exist;

 	segno = GET_SEGNO(sbi, blkaddr);

@@ -1526,17 +1527,23 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)

 	/* Update valid block bitmap */
 	if (del > 0) {
-		if (f2fs_test_and_set_bit(offset, se->cur_valid_map)) {
+		exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
 #ifdef CONFIG_F2FS_CHECK_FS
-			if (f2fs_test_and_set_bit(offset,
-						se->cur_valid_map_mir))
-				f2fs_bug_on(sbi, 1);
-			else
-				WARN_ON(1);
-#else
+		mir_exist = f2fs_test_and_set_bit(offset,
+						se->cur_valid_map_mir);
+		if (exist != mir_exist) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
+				"when setting bitmap, blk:%u, old bit:%d",
+				blkaddr, exist);
 			f2fs_bug_on(sbi, 1);
+		}
 #endif
+		if (exist) {
+			f2fs_msg(sbi->sb, KERN_ERR,
+				"Bitmap was set, blk:%u", blkaddr);
+			f2fs_bug_on(sbi, 1);
 		}
+
 		if (f2fs_discard_en(sbi) &&
 			!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
@@ -1547,17 +1554,23 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 				se->ckpt_valid_blocks++;
 		}
 	} else {
-		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
+		exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
 #ifdef CONFIG_F2FS_CHECK_FS
-			if (!f2fs_test_and_clear_bit(offset,
-						se->cur_valid_map_mir))
-				f2fs_bug_on(sbi, 1);
-			else
-				WARN_ON(1);
-#else
+		mir_exist = f2fs_test_and_clear_bit(offset,
+						se->cur_valid_map_mir);
+		if (exist != mir_exist) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
+				"when clearing bitmap, blk:%u, old bit:%d",
+				blkaddr, exist);
 			f2fs_bug_on(sbi, 1);
+		}
 #endif
+		if (!exist) {
+			f2fs_msg(sbi->sb, KERN_ERR,
+				"Bitmap was cleared, blk:%u", blkaddr);
+			f2fs_bug_on(sbi, 1);
 		}
+
 		if (f2fs_discard_en(sbi) &&
 			f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
-- 
2.13.0.90.g1eb437020

On 2017/8/1 15:56, Yunlong Song wrote:
> When cur_valid_map passes the f2fs_test_and_set(,clear)_bit test,
> cur_valid_map_mir update is skipped unlikely, so fix it.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 151968e..6f7731a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1535,6 +1535,10 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  			f2fs_bug_on(sbi, 1);
>  #endif
>  		}
> +#ifdef CONFIG_F2FS_CHECK_FS
> +		else
> +			f2fs_set_bit(offset, se->cur_valid_map_mir);
> +#endif
>  		if (f2fs_discard_en(sbi) &&
>  			!f2fs_test_and_set_bit(offset, se->discard_map))
>  			sbi->discard_blks--;
> @@ -1556,6 +1560,10 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  			f2fs_bug_on(sbi, 1);
>  #endif
>  		}
> +#ifdef CONFIG_F2FS_CHECK_FS
> +		else
> +			f2fs_clear_bit(offset, se->cur_valid_map_mir);
> +#endif
>  		if (f2fs_discard_en(sbi) &&
>  			f2fs_test_and_clear_bit(offset, se->discard_map))
>  			sbi->discard_blks++;
> 
