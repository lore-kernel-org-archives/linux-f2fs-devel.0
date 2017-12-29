From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: stop checkpoint only from fault
 injection
Date: Fri, 29 Dec 2017 16:59:34 +0800
Message-ID: <665883a3-f065-e531-0730-c41b227df589@huawei.com>
References: <20171229020056.60558-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171229020056.60558-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/29 10:00, Jaegeuk Kim wrote:
> If we got EIO by block layer, we still can proceed since EIO can be recovered.
> But, if we injected stop_checkpoint, we must stop everything.
> 
> This should fix generic/441 failure in xfstests.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 16 ++++------------
>  fs/f2fs/data.c       |  8 ++------
>  fs/f2fs/f2fs.h       |  2 +-
>  fs/f2fs/file.c       |  8 ++++----
>  fs/f2fs/gc.c         |  2 +-
>  fs/f2fs/inode.c      |  2 +-
>  fs/f2fs/segment.c    |  2 +-
>  7 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 14d2fedaf3ca..ce92243549dd 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -26,11 +26,10 @@
>  static struct kmem_cache *ino_entry_slab;
>  struct kmem_cache *inode_entry_slab;
>  
> -void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
> +void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
>  {
>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
> -	if (!end_io)
> -		f2fs_flush_merged_writes(sbi);
> +	f2fs_flush_merged_writes(sbi);
>  }
>  
>  /*
> @@ -89,18 +88,11 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
>  	}
>  
>  	lock_page(page);
> -	if (unlikely(page->mapping != mapping)) {
> +	/* If there is any IO error when accessing device, let's try again. */
> +	if (unlikely(page->mapping != mapping || !PageUptodate(page))) {

If IO error is not recovered, we will run into endless loop?

>  		f2fs_put_page(page, 1);
>  		goto repeat;
>  	}
> -
> -	/*
> -	 * if there is any IO error when accessing device, make our filesystem
> -	 * readonly and make sure do not write checkpoint with non-uptodate
> -	 * meta page.
> -	 */
> -	if (unlikely(!PageUptodate(page)))
> -		f2fs_stop_checkpoint(sbi, false);
>  out:
>  	return page;
>  }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b9fab6186f28..29523013c5a3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -101,18 +101,14 @@ static void f2fs_write_end_io(struct bio *bio)
>  			ClearPagePrivate(page);
>  			unlock_page(page);
>  			mempool_free(page, sbi->write_io_dummy);
> -
> -			if (unlikely(bio->bi_status))
> -				f2fs_stop_checkpoint(sbi, true);
>  			continue;
>  		}
>  
>  		fscrypt_pullback_bio_page(&page, true);
>  
> -		if (unlikely(bio->bi_status)) {
> +		if (unlikely(bio->bi_status))
>  			mapping_set_error(page->mapping, -EIO);
> -			f2fs_stop_checkpoint(sbi, true);

If we do not stop checkpoint here, fs meta/node data and user data can be
more and more corrupted and inconsistent... at least, we should stop
checkpoint if there is EIO when we writeback fs meta/node data.

Thanks,

> -		}
> +
>  		dec_page_count(sbi, type);
>  		clear_cold_data(page);
>  		end_page_writeback(page);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b32eacf11270..f06fb7b332c7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2741,7 +2741,7 @@ int rw_hint_to_seg_type(enum rw_hint hint);
>  /*
>   * checkpoint.c
>   */
> -void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
> +void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi);
>  struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
>  struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
>  struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 66a51e9fbe83..7ccf3e7ff498 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1840,21 +1840,21 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  	case F2FS_GOING_DOWN_FULLSYNC:
>  		sb = freeze_bdev(sb->s_bdev);
>  		if (sb && !IS_ERR(sb)) {
> -			f2fs_stop_checkpoint(sbi, false);
> +			f2fs_stop_checkpoint(sbi);
>  			thaw_bdev(sb->s_bdev, sb);
>  		}
>  		break;
>  	case F2FS_GOING_DOWN_METASYNC:
>  		/* do checkpoint only */
>  		f2fs_sync_fs(sb, 1);
> -		f2fs_stop_checkpoint(sbi, false);
> +		f2fs_stop_checkpoint(sbi);
>  		break;
>  	case F2FS_GOING_DOWN_NOSYNC:
> -		f2fs_stop_checkpoint(sbi, false);
> +		f2fs_stop_checkpoint(sbi);
>  		break;
>  	case F2FS_GOING_DOWN_METAFLUSH:
>  		sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
> -		f2fs_stop_checkpoint(sbi, false);
> +		f2fs_stop_checkpoint(sbi);
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 9bffef153a12..538396ea4d29 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -56,7 +56,7 @@ static int gc_thread_func(void *data)
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
>  			f2fs_show_injection_info(FAULT_CHECKPOINT);
> -			f2fs_stop_checkpoint(sbi, false);
> +			f2fs_stop_checkpoint(sbi);
>  		}
>  #endif
>  
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 234322889e65..daac3d142c2c 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -441,7 +441,7 @@ void update_inode_page(struct inode *inode)
>  			cond_resched();
>  			goto retry;
>  		} else if (err != -ENOENT) {
> -			f2fs_stop_checkpoint(sbi, false);
> +			f2fs_stop_checkpoint(sbi);
>  		}
>  		return;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b03f65e5dfdc..890d483ad21e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -454,7 +454,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
>  		f2fs_show_injection_info(FAULT_CHECKPOINT);
> -		f2fs_stop_checkpoint(sbi, false);
> +		f2fs_stop_checkpoint(sbi);
>  	}
>  #endif
>  
> 
