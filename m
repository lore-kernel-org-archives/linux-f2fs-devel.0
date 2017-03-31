From: heyunlei <heyunlei@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid IO split due to mixed
 WB_SYNC_ALL and WB_SYNC_NONE
Date: Fri, 31 Mar 2017 11:41:54 +0800
Message-ID: <fa85e856-723e-e6eb-acff-888934a979b6@huawei.com>
References: <20170329204815.9175-1-jaegeuk@kernel.org>
 <20170329204815.9175-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329204815.9175-2-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

I try this patch and find it can fix below case:

    kworker/u16:3-423   [002] ....   183.812347: submit_bio: kworker/u16:3(423): WRITE block 104749352 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812380: submit_bio: fio(2122): WRITE block 104749360 on mmcblk0p50 (24 sectors)
    kworker/u16:3-423   [002] ....   183.812388: submit_bio: kworker/u16:3(423): WRITE block 104749384 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812403: submit_bio: fio(2122): WRITE block 104749392 on mmcblk0p50 (8 sectors)
    kworker/u16:3-423   [002] ....   183.812404: submit_bio: kworker/u16:3(423): WRITE block 104749400 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812427: submit_bio: fio(2122): WRITE block 104749408 on mmcblk0p50 (16 sectors)
    kworker/u16:3-423   [002] ....   183.812429: submit_bio: kworker/u16:3(423): WRITE block 104749424 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812450: submit_bio: fio(2122): WRITE block 104749432 on mmcblk0p50 (16 sectors)
    kworker/u16:3-423   [002] ....   183.812455: submit_bio: kworker/u16:3(423): WRITE block 104749448 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812470: submit_bio: fio(2122): WRITE block 104749456 on mmcblk0p50 (8 sectors)
    kworker/u16:3-423   [002] ....   183.812476: submit_bio: kworker/u16:3(423): WRITE block 104749464 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812492: submit_bio: fio(2122): WRITE block 104749472 on mmcblk0p50 (16 sectors)
    kworker/u16:3-423   [002] ....   183.812497: submit_bio: kworker/u16:3(423): WRITE block 104749488 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812512: submit_bio: fio(2122): WRITE block 104749496 on mmcblk0p50 (8 sectors)
    kworker/u16:3-423   [002] ....   183.812514: submit_bio: kworker/u16:3(423): WRITE block 104749504 on mmcblk0p50 (8 sectors)
              fio-2122  [003] ....   183.812532: submit_bio: fio(2122): WRITE block 104749512 on mmcblk0p50 (16 sectors)

    ... ...

Thanks.

On 2017/3/30 4:48, Jaegeuk Kim wrote:
> If two threads try to flush dirty pages in different inodes respectively,
> f2fs_write_data_pages() will produce WRITE and WRITE_SYNC one at a time,
> resulting in a lot of 4KB seperated IOs.
>
> So, this patch gives higher priority to WB_SYNC_ALL IOs and gathers write
> IOs with a big WRITE_SYNC'ed bio.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c  | 15 +++++++++++++--
>  fs/f2fs/f2fs.h  |  3 +++
>  fs/f2fs/super.c |  2 ++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8f36080b47c4..b1cac6d85bcb 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1605,8 +1605,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				last_idx = page->index;
>  			}
>
> -			if (--wbc->nr_to_write <= 0 &&
> -			    wbc->sync_mode == WB_SYNC_NONE) {
> +			/* give a priority to WB_SYNC threads */
> +			if ((atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) ||
> +					--wbc->nr_to_write <= 0) &&
> +					wbc->sync_mode == WB_SYNC_NONE) {
>  				done = 1;
>  				break;
>  			}
> @@ -1662,9 +1664,18 @@ static int f2fs_write_data_pages(struct address_space *mapping,
>
>  	trace_f2fs_writepages(mapping->host, wbc, DATA);
>
> +	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
> +	if (wbc->sync_mode == WB_SYNC_ALL)
> +		atomic_inc(&sbi->wb_sync_req);
> +	else if (atomic_read(&sbi->wb_sync_req))
> +		goto skip_write;
> +
>  	blk_start_plug(&plug);
>  	ret = f2fs_write_cache_pages(mapping, wbc);
>  	blk_finish_plug(&plug);
> +
> +	if (wbc->sync_mode == WB_SYNC_ALL)
> +		atomic_dec(&sbi->wb_sync_req);
>  	/*
>  	 * if some pages were truncated, we cannot guarantee its mapping->host
>  	 * to detect pending bios.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 32d6f674c114..fd39db681226 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -888,6 +888,9 @@ struct f2fs_sb_info {
>  	/* # of allocated blocks */
>  	struct percpu_counter alloc_valid_block_count;
>
> +	/* writeback control */
> +	atomic_t wb_sync_req;			/* count # of WB_SYNC threads */
> +
>  	/* valid inode count */
>  	struct percpu_counter total_valid_inode_count;
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2d78f3c76d18..cb65e6d0d275 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1566,6 +1566,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	for (i = 0; i < NR_COUNT_TYPE; i++)
>  		atomic_set(&sbi->nr_pages[i], 0);
>
> +	atomic_set(&sbi->wb_sync_req, 0);
> +
>  	INIT_LIST_HEAD(&sbi->s_list);
>  	mutex_init(&sbi->umount_mutex);
>  	mutex_init(&sbi->wio_mutex[NODE]);
>
