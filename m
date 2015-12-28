From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH 2/2] f2fs: export a threshold in sysfs for
 controlling dio serialization
Date: Mon, 28 Dec 2015 14:52:05 -0800
Message-ID: <20151228225204.GB61500@jaegeuk.local>
References: <006e01d14157$68bc0dd0$3a342970$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <006e01d14157$68bc0dd0$3a342970$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Mon, Dec 28, 2015 at 06:05:45PM +0800, Chao Yu wrote:
> As Yunlei He reported when he test with the patch ("f2fs: enhance
> multithread dio write performance"):
> "Does share writepages mutex lock have an effect on cache write?
> Here is AndroBench result on my phone:
> 
> Before patch:
> 			1R1W		8R8W		16R16W
> Sequential Write	161.31		163.85		154.67
> Random  Write		9.48		17.66		18.09
> 
> After patch:
> 			1R1W		8R8W		16R16W
> Sequential Write	159.61		157.24		160.11
> Random  Write		9.17		8.51		8.8
> 
> Unit:Mb/s, File size: 64M, Buffer size: 4k"
> 
> The turth is androidbench uses single thread with dio write to test performance
> of sequential write, and use multi-threads with dio write to test performance
> of random write. so we can not see any improvement in sequentail write test
> since serializing dio page allocation can only improve performance in
> multi-thread scenario, and there is a regression in multi-thread test with 4k
> dio write, this is because grabbing sbi->writepages lock for serializing block
> allocation stop the concurrency, so that less small dio bios could be merged,
> moreover, when there are huge number of small dio writes, grabbing mutex lock
> per dio increases the overhead.
> 
> After all, serializing dio could only be used for concurrent scenario of
> big dio, so this patch introduces a threshold in sysfs to provide user the
> interface of defining 'a big dio' with specified page number, which could
> be used to control wthether serialize or not that kind of dio with specified
> page number.

Can you merge two patches together?

And, if this is correct, can we investigate the lock effect in
f2fs_write_data_pages too?

What if we add a condition for the lock like this?

	if (get_dirty_pages(inode) > serialzed_pages)
		mutex_lock();

Thanks,

> 
> Though, this is only RFC patch since the optimization works in rare scenario.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 12 ++++++++++++
>  fs/f2fs/data.c                          |  3 ++-
>  fs/f2fs/f2fs.h                          |  3 +++
>  fs/f2fs/super.c                         |  3 +++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 0345f2d..560a4f1 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -92,3 +92,15 @@ Date:		October 2015
>  Contact:	"Chao Yu" <chao2.yu@samsung.com>
>  Description:
>  		 Controls the count of nid pages to be readaheaded.
> +
> +What:		/sys/fs/f2fs/<disk>/serialized_dio_pages
> +Date:		December 2015
> +Contact:	"Chao Yu" <chao2.yu@samsung.com>
> +Description:
> +		 It is a threshold with the unit of page size.
> +                 If DIO page count is equal or big than the threshold,
> +                 whole process of block address allocation of dio pages
> +                 will become atomic like buffered write.
> +                 It is used to maximize bandwidth utilization in the
> +                 scenario of concurrent write with dio vs buffered or
> +                 dio vs dio.
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6b24446..abcd100 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1660,7 +1660,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
>  
>  	if (rw == WRITE) {
> -		bool serialized = (F2FS_BYTES_TO_BLK(count) >= 64);
> +		bool serialized = (F2FS_BYTES_TO_BLK(count) >=
> +						sbi->serialized_dio_pages);
>  
>  		if (serialized)
>  			mutex_lock(&sbi->writepages);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3406e99..8f35dd7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -333,6 +333,8 @@ enum {
>  
>  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
>  
> +#define DEF_SERIALIZED_DIO_PAGES	64	/* default serialized dio pages */
> +
>  /* vector size for gang look-up from extent cache that consists of radix tree */
>  #define EXT_TREE_VEC_SIZE	64
>  
> @@ -784,6 +786,7 @@ struct f2fs_sb_info {
>  	unsigned int total_valid_inode_count;	/* valid inode count */
>  	int active_logs;			/* # of active logs */
>  	int dir_level;				/* directory level */
> +	int serialized_dio_pages;		/* serialized direct IO pages */
>  
>  	block_t user_block_count;		/* # of user blocks */
>  	block_t total_valid_block_count;	/* # of valid blocks */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 75704d9..ebe9bd4 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -218,6 +218,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
>  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, serialized_dio_pages, serialized_dio_pages);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, cp_interval);
>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> @@ -234,6 +235,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(min_fsync_blocks),
>  	ATTR_LIST(max_victim_search),
>  	ATTR_LIST(dir_level),
> +	ATTR_LIST(serialized_dio_pages),
>  	ATTR_LIST(ram_thresh),
>  	ATTR_LIST(ra_nid_pages),
>  	ATTR_LIST(cp_interval),
> @@ -1125,6 +1127,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  		atomic_set(&sbi->nr_pages[i], 0);
>  
>  	sbi->dir_level = DEF_DIR_LEVEL;
> +	sbi->serialized_dio_pages = DEF_SERIALIZED_DIO_PAGES;
>  	sbi->cp_interval = DEF_CP_INTERVAL;
>  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
>  
> -- 
> 2.6.3
> 
