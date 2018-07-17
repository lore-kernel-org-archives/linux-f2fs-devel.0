From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: clear the remaining prefree_map of
 the section
Date: Tue, 17 Jul 2018 17:05:54 +0800
Message-ID: <b81bb907-44cd-4cf3-4ddf-a759adec61fb@huawei.com>
References: <1531735421-73669-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ffLw4-0001Z4-4X
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Jul 2018 09:06:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ffLw1-00206f-Qv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Jul 2018 09:06:20 +0000
In-Reply-To: <1531735421-73669-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

On 2018/7/16 18:03, Yunlong Song wrote:
> For the case when sbi->segs_per_sec > 1 with lfs mode, take
> section:segment = 5 for example, if the section prefree_map is
> ...previous section | current section (1 1 0 1 1) | next section...,
> then the start = x, end = x + 1, after start = start_segno +
> sbi->segs_per_sec, start = x + 5, then it will skip x + 3 and x + 4, but
> their bitmap is still set, which will cause duplicated
> f2fs_issue_discard of this same section in the next write_checkpoint, so
> fix it.

I mean:

Subject: [PATCH] f2fs: issue discard align to section in LFS mode

---
 fs/f2fs/segment.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f12dad627fb4..6640c790cf64 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1761,6 +1761,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason & CP_DISCARD);
+	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;

 	mutex_lock(&dirty_i->seglist_lock);

@@ -1772,10 +1773,15 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 		end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
 								start + 1);

-		for (i = start; i < end; i++)
-			clear_bit(i, prefree_map);
+		if (need_align) {
+			start = rounddown(start, sbi->segs_per_sec);
+			end = roundup(start, sbi->segs_per_sec);
+		}

-		dirty_i->nr_dirty[PRE] -= end - start;
+		for (i = start; i < end; i++) {
+			if (test_and_clear_bit(i, prefree_map))
+				dirty_i->nr_dirty[PRE]--;
+		}

 		if (!test_opt(sbi, DISCARD))
 			continue;
@@ -2564,6 +2570,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	struct discard_policy dpolicy;
 	unsigned long long trimmed = 0;
 	int err = 0;
+	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;

 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -2582,6 +2589,12 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);

+	if (need_align) {
+		start_segno = rounddown(start_segno, sbi->segs_per_sec);
+		end_segno = roundup(end_segno, sbi->segs_per_sec);
+		end_segno = min(end_segno, MAIN_SEGS(sbi) - 1);
+	}
+
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
 	cpc.trim_start = start_segno;
-- 
2.18.0.rc1



> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cfff7cf..5dc1d5cc 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1729,6 +1729,15 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  		if (!test_opt(sbi, DISCARD))
>  			continue;
>  
> +		if (test_opt(sbi, LFS) && sbi->segs_per_sec > 1) {
> +			start = rounddown(start, sbi->segs_per_sec);
> +			i = end;
> +			end = roundup(end, sbi->segs_per_sec);
> +			while (++i < end)
> +				if (test_and_clear_bit(i, prefree_map))
> +					dirty_i->nr_dirty[PRE]--;
> +		}
> +
>  		if (force && start >= cpc->trim_start &&
>  					(end - 1) <= cpc->trim_end)
>  				continue;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
