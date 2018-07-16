From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: keep meta pages in cp_error state
Date: Mon, 16 Jul 2018 17:40:24 +0800
Message-ID: <75771f42-d3ab-73d4-8cd8-98ee7d26a49b@huawei.com>
References: <20180715011112.11475-1-jaegeuk@kernel.org>
 <20180715011112.11475-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180715011112.11475-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/15 9:11, Jaegeuk Kim wrote:
> It turns out losing meta pages in shutdown period makes f2fs very unstable
> so that I could see many unexpected error conditions.
> 
> Let's keep meta pages for fault injection and sudden power-off tests.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 9f1c96caebda..37ec0f16448e 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -242,11 +242,8 @@ static int __f2fs_write_meta_page(struct page *page,
>  
>  	trace_f2fs_writepage(page, META);
>  
> -	if (unlikely(f2fs_cp_error(sbi))) {
> -		dec_page_count(sbi, F2FS_DIRTY_META);
> -		unlock_page(page);
> -		return 0;
> -	}
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		goto redirty_out;
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
>  	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
> @@ -1129,6 +1126,9 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
>  		if (!get_pages(sbi, F2FS_WB_CP_DATA))
>  			break;
>  
> +		if (unlikely(f2fs_cp_error(sbi)))
> +			break;
> +
>  		io_schedule_timeout(5*HZ);
>  	}
>  	finish_wait(&sbi->cp_wait, &wait);
> @@ -1202,8 +1202,12 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
>  
>  	/* writeout cp pack 2 page */
>  	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
> -	f2fs_bug_on(sbi, err);
> +	if (unlikely(err && f2fs_cp_error(sbi))) {
> +		f2fs_put_page(page, 1);
> +		return;
> +	}
>  
> +	f2fs_bug_on(sbi, err);
>  	f2fs_put_page(page, 0);
>  
>  	/* submit checkpoint (with barrier if NOBARRIER is not set) */
> @@ -1229,7 +1233,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	while (get_pages(sbi, F2FS_DIRTY_META)) {
>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>  		if (unlikely(f2fs_cp_error(sbi)))
> -			return -EIO;
> +			break;
>  	}
>  
>  	/*
> @@ -1309,7 +1313,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
>  							FS_CP_META_IO);
>  			if (unlikely(f2fs_cp_error(sbi)))
> -				return -EIO;
> +				break;
>  		}
>  	}
>  
> @@ -1350,9 +1354,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	/* wait for previous submitted meta pages writeback */
>  	wait_on_all_pages_writeback(sbi);
>  
> -	if (unlikely(f2fs_cp_error(sbi)))
> -		return -EIO;
> -
>  	/* flush all device cache */
>  	err = f2fs_flush_device_cache(sbi);
>  	if (err)
> @@ -1364,9 +1365,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	f2fs_release_ino_entry(sbi, false);
>  
> -	if (unlikely(f2fs_cp_error(sbi)))
> -		return -EIO;
> -
>  	clear_sbi_flag(sbi, SBI_IS_DIRTY);
>  	clear_sbi_flag(sbi, SBI_NEED_CP);
>  	__set_cp_next_pack(sbi);
> @@ -1381,7 +1379,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_DENTS));
>  
> -	return 0;
> +	return unlikely(f2fs_cp_error(sbi));

return unlikely(f2fs_cp_error(sbi)) ? -EIO : 0;

>  }
>  
>  /*
> 
