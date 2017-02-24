From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add F2FS_DIRTY_DATA to has_not_enough_free_secs
 and need_SSR
Date: Fri, 24 Feb 2017 12:07:23 -0800
Message-ID: <20170224200723.GG39009@jaegeuk.local>
References: <1487940393-26654-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487940393-26654-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/24, Yunlong Song wrote:
> Currently, it miss the part of F2FS_DIRTY_DATA to check whether there is enough
> free segments for the "reserved_sections" originally set in the mkfs.f2fs. As a
> result, it will use the reserved_sections part to write dirty data, and has to
> do gc_more to free a lot of sections together next time. This will cost much
> time to do so many fggc. So let's add the F2FS_DIRTY_DATA part and do a few gc
> gradually each time, which will avoid to do a large number of gc at the same time.
> 
> And this will also make sure the pre-set "reserved_sections" is not used all the
> time and can be used anytime for gc when ssr segments are not enough.

Not sure any side effect of this patch. Let's investigate more severely how to
trigger SSR more eagerly in order to avoid write_checkpoint.

Thanks,

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
> -- 
> 1.8.5.2
