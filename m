From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: add F2FS_DIRTY_DATA to has_not_enough_free_secs and
 need_SSR
Date: Sat, 25 Feb 2017 12:20:45 +0800
Message-ID: <58B1061D.3090209@huawei.com>
References: <1487940393-26654-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487940393-26654-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Continue to get mailing wrong message and can not receive some of emails from linux-f2fs-devel@lists.sourceforge.net, very strange, so send again.

The benefit is much, let me give an example to make the point more clear, the reserved_sections for a 64G image is
about 500M, and if the current free_sections is 600M, and the IO pattern is like this:

Before this patch:
 time 1: node & dent * imeta 20M to write, 100M data to write
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + reserved_sections(sbi);
then has_not_enough_free_secs returns false, since 600M > 20M + 500M

time 2: node & dent * imeta 20M*2  to write, 100M*2 data to write
   free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + reserved_sections(sbi);
then has_not_enough_free_secs returns false, since 600M > 20M*2 + 500M

time 3: node & dent * imeta 20M*3  to write, 100M*3 data to write
   free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + reserved_sections(sbi);
then has_not_enough_free_secs returns false, since 600M > 20M*3 + 500M

time 4: node & dent * imeta 20M*4  to write, 100M*4 data to write
   free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + reserved_sections(sbi);
then has_not_enough_free_secs returns false, since 600M > 20M*4 + 500M

then here comes a sync, and wait for all the node & dent * imeta and data to flush to the flash device
what will happen after this sync?
the free_sections will decrease to 600M-20M*4(node & dent * imeta)-100M*4(data) = 120M
next time in f2fs_balance_fs:
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + reserved_sections(sbi);
  120M  <= 0 + 500M

then f2fs_gc will gc_more times and times again until free_sections increases from 120M to 500M......
It will cost a lot of time!

After this patch:
time 1: node & dent * imeta 20M to write, 100M data to write
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + data + reserved_sections(sbi);
then has_not_enough_free_secs returns true, since 600M < 20M + 100M  + 500M
this time f2fs_gc will only gc_more for the gap 20M + 100M  + 500M - 600M = 20M

time 2: node & dent * imeta 20M*2 to write, 100M*2 data to write
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + data + reserved_sections(sbi);
then has_not_enough_free_secs returns true, since 600M + 20M (gc_more from time 1) < 20M*2 + 100M*2  + 500M
this time f2fs_gc will only gc_more for the gap 20M*2 + 100M *2 + 500M - (600M + 20M) = 120M

time 3: node & dent * imeta 20M*3 to write, 100M*3 data to write
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + data + reserved_sections(sbi);
then has_not_enough_free_secs returns true, since 600M + 20M (gc_more from time 1) + 120M (gc_more from time 2) < 20M*3 + 100M*3  + 500M
this time f2fs_gc will only gc_more for the gap 20M*3 + 100M *3 + 500M - (600M + 20M + 120M) = 120M

time 4: node & dent * imeta 20M*4 to write, 100M*4 data to write
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + data + reserved_sections(sbi);
then has_not_enough_free_secs returns true, since 600M + 20M (gc_more from time 1) + 120M (gc_more from time 2) + 120M (gc_more from time 3) < 20M*4 + 100M*4  + 500M
this time f2fs_gc will only gc_more for the gap 20M*4 + 100M *4 + 500M - (600M + 20M + 120M + 120M) = 120M

then here comes a sync, and wait for all the node & dent * imeta and data to flush to the flash device
what will happen after this sync?
the free_sections will decrease to 600M + 20M (gc_more from time 1) + 120M (gc_more from time 2) + 120M (gc_more from time 3) +120M (gc_more from time 4) - 20M*4(node & dent * imeta)-100M*4(data) = 500M
next time in f2fs_balance_fs:
  free_sections(sbi) <= node_secs + 2 * dent_secs + imeta_secs + reserved_sections(sbi);
  500M  <= 0 + 500M
this time f2fs_gc will only gc for 1 free segment, comparing with the current design without the patch, which has to gc_more from 120M to 500M....

You see, after the patch, gc_more are separated to 4 times but the old design make gc_more to one time, which will cost much performance.

Besides, after the patch, we can make sure the reserved_sections are remained unused and free all the time, which can avoid the segment using up case!

So now we can use the patch I sent last time, which changes the mkfs.f2fs to reduce the reserved_segments a lot and use SSR, I remember you pointed out an
issue that if there are not enough SSR segments then there is a problem, now I can solve your issue with this patch, since we can make sure the reserved_sections
are free all the time, then we are always able to make gc to have more free segments (or just take up the reserved_segments for temporary use when SSR segments
are not enough for performance).

Finally, the performance can be improved and the reserved_segments can be reduced a lot.

However, if this path is not allowed finally, I still suggest to reduce the reserved_segments to a smaller number, this is to avoid the amount of gc_more segments
after the sync in my example, because you have to gc_more until free_sections equals to reserved_segments, so the smaller the reserved_segment is, the smaller
times f2f2_gc will gc_more.

Anyway, I will test the patch in device for stability.

On 2017/2/24 20:46, Yunlong Song wrote:
> Currently, it miss the part of F2FS_DIRTY_DATA to check whether there is enough
> free segments for the "reserved_sections" originally set in the mkfs.f2fs. As a
> result, it will use the reserved_sections part to write dirty data, and has to
> do gc_more to free a lot of sections together next time. This will cost much
> time to do so many fggc. So let's add the F2FS_DIRTY_DATA part and do a few gc
> gradually each time, which will avoid to do a large number of gc at the same time.
>
> And this will also make sure the pre-set "reserved_sections" is not used all the
> time and can be used anytime for gc when ssr segments are not enough.
>
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index f4020f1..44f2a46 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -490,12 +490,13 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
>  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
>  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
>  	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	int data_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DATA);
>  
>  	if (test_opt(sbi, LFS))
>  		return false;
>  
>  	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> -						reserved_sections(sbi) + 1);
> +						data_secs + reserved_sections(sbi) + 1);
>  }
>  
>  static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
> @@ -504,13 +505,14 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
>  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
>  	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	int data_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DATA);
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		return false;
>  
>  	return (free_sections(sbi) + freed) <=
>  		(node_secs + 2 * dent_secs + imeta_secs +
> -		reserved_sections(sbi) + needed);
> +		data_secs + reserved_sections(sbi) + needed);
>  }
>  
>  static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)


-- 
Thanks,
Yunlong Song
