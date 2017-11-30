From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: pass down write hints to block layer for
 bufferd write
Date: Thu, 30 Nov 2017 14:32:43 +0800
Message-ID: <f5d08de4-b2f8-78f0-2a2e-3d5569e898ef@huawei.com>
References: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Jens Axboe <axboe@kernel.dk>, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/28 8:23, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> This implements which hint is passed down to block layer
> for datas from the specific segment type.
> 
> segment type                     hints
> ------------                     -----
> COLD_NODE & COLD_DATA            WRITE_LIFE_EXTREME
> WARM_DATA                        WRITE_LIFE_NONE
> HOT_NODE & WARM_NODE             WRITE_LIFE_LONG
> HOT_DATA                         WRITE_LIFE_MEDIUM
> META_DATA                        WRITE_LIFE_SHORT

The correspondence looks good to me.

> 
> Many thanks to Chao Yu and Jaegeuk Kim for comments to
> implement this patch.
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
> ---
>  fs/f2fs/data.c    |  1 +
>  fs/f2fs/f2fs.h    |  2 ++
>  fs/f2fs/segment.c | 29 +++++++++++++++++++++++++++++
>  fs/f2fs/super.c   |  2 ++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a7ae418..0919a43 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -437,6 +437,7 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
>  		}
>  		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
>  						BIO_MAX_PAGES, false);
> +		io->bio->bi_write_hint = io->write_hint;

Need to assign bi_write_hint for IPU path?

- rewrite_data_page
 - f2fs_submit_page_bio

>  		io->fio = *fio;
>  	}
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7bcd148..be3cb0c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -969,6 +969,7 @@ struct f2fs_bio_info {
>  	struct rw_semaphore io_rwsem;	/* blocking op for bio */
>  	spinlock_t io_lock;		/* serialize DATA/NODE IOs */
>  	struct list_head io_list;	/* track fios */
> +	enum rw_hint write_hint;

Add missing comment?

>  };
>  
>  #define FDEV(i)				(sbi->devs[i])
> @@ -2674,6 +2675,7 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>  int __init create_segment_manager_caches(void);
>  void destroy_segment_manager_caches(void);
>  int rw_hint_to_seg_type(enum rw_hint hint);
> +enum rw_hint io_type_to_rw_hint(enum page_type page, enum temp_type temp);
>  
>  /*
>   * checkpoint.c
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c117e09..0570db7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2446,6 +2446,35 @@ int rw_hint_to_seg_type(enum rw_hint hint)
>  	}
>  }
>  

It will be better to copy commit log here to declare correspondence
more clearly.

Thanks,

> +enum rw_hint io_type_to_rw_hint(enum page_type page, enum temp_type temp)
> +{
> +	if (page == DATA) {
> +		switch (temp) {
> +		case WARM:
> +			return WRITE_LIFE_NONE;
> +		case COLD:
> +			return WRITE_LIFE_EXTREME;
> +		case HOT:
> +			return WRITE_LIFE_MEDIUM;
> +		default:
> +			return WRITE_LIFE_NOT_SET;
> +		}
> +	} else if (page == NODE) {
> +		switch (temp) {
> +		case WARM:
> +		case HOT:
> +			return WRITE_LIFE_LONG;
> +		case COLD:
> +			return WRITE_LIFE_EXTREME;
> +		default:
> +			return WRITE_LIFE_NOT_SET;
> +		}
> +
> +	} else {
> +		return WRITE_LIFE_SHORT;
> +	}
> +}
> +
>  static int __get_segment_type_2(struct f2fs_io_info *fio)
>  {
>  	if (fio->type == DATA)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a6c5dd4..51c19a0 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2508,6 +2508,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  			sbi->write_io[i][j].bio = NULL;
>  			spin_lock_init(&sbi->write_io[i][j].io_lock);
>  			INIT_LIST_HEAD(&sbi->write_io[i][j].io_list);
> +			sbi->write_io[i][j].write_hint =
> +						io_type_to_rw_hint(i, j);
>  		}
>  	}
>  
> 
