From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: serialize block allocation of dio
 writes to enhance multithread performance
Date: Thu, 14 Jan 2016 15:54:09 -0800
Message-ID: <20160114235409.GC54633@jaegeuk.gateway>
References: <00c801d14204$5bb4e820$131eb860$@samsung.com>
	<00f501d14dfb$ec78e110$c56aa330$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aJrif-0004xJ-5m
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Jan 2016 23:54:21 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aJrid-0002iZ-8Q for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Jan 2016 23:54:21 +0000
Content-Disposition: inline
In-Reply-To: <00f501d14dfb$ec78e110$c56aa330$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Wed, Jan 13, 2016 at 08:13:36PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Tuesday, December 29, 2015 2:44 PM
> > To: Jaegeuk Kim
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH v2] f2fs: serialize block allocation of dio writes to enhance
> > multithread performance
> > 
> > When performing big dio writes concurrently, our performace will be low
> > because of Thread A's allocation of multi continuous blocks will be
> > interrupted by Thread B, there are two cases as below:
> >  - In Thread B, we may change current segment to a new segment for LFS
> >    allocation if we dio write in the beginning of the file.
> >  - In Thread B, we may allocate blocks in the middle of Thread A's
> >    allocation, which make blocks allocated in Thread A being inconsecutive.
> > 
> > This patch adds writepages mutex lock to make block allocation in dio write
> > being atomic to avoid above issues.
> > 
> > Test environment 1:
> > ubuntu os with linux kernel 4.4-rc4, intel i7-3770, 16g memory,
> > 32g kingston sd card.
> > 
> > fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/mnt/f2fs
> > --filesize=256m --size=16m --bs=2m --direct=1
> > --numjobs=10
> > 
> > before:
> >   WRITE: io=163840KB, aggrb=5125KB/s, minb=512KB/s, maxb=776KB/s, mint=21105msec,
> > maxt=31967msec
> > patched:
> >   WRITE: io=163840KB, aggrb=10424KB/s, minb=1042KB/s, maxb=1172KB/s, mint=13975msec,
> > maxt=15717msec
> > 
> > Test environment 2:
> > Note4 eMMC
> > 
> > fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/data/test/
> > --filesize=256m --size=64m --bs=2m --direct=1
> > --numjobs=16
> > 
> > before:
> >   WRITE: io=1024.0MB, aggrb=103583KB/s, minb=6473KB/s, maxb=8806KB/s, mint=7442msec,
> > maxt=10123msec
> > patched:
> >   WRITE: io=1024.0MB, aggrb=124860KB/s, minb=7803KB/s, maxb=9315KB/s, mint=7035msec,
> > maxt=8398msec
> > 
> > As Yunlei He reported when he test with current patch:
> > "Does share writepages mutex lock have an effect on cache write?
> > Here is AndroBench result on my phone:
> > 
> > Before patch:
> > 			1R1W		8R8W		16R16W
> > Sequential Write	161.31		163.85		154.67
> > Random  Write		9.48		17.66		18.09
> > 
> > After patch:
> > 			1R1W		8R8W		16R16W
> > Sequential Write	159.61		157.24		160.11
> > Random  Write		9.17		8.51		8.8
> > 
> > Unit:Mb/s, File size: 64M, Buffer size: 4k"
> > 
> > The turth is androidbench uses single thread with dio write to test performance
> > of sequential write, and use multi-threads with dio write to test performance
> > of random write. so we can not see any improvement in sequentail write test
> > since serializing dio page allocation can only improve performance in
> > multi-thread scenario, and there is a regression in multi-thread test with 4k
> > dio write, this is because grabbing sbi->writepages lock for serializing block
> > allocation stop the concurrency, so that less small dio bios could be merged,
> > moreover, when there are huge number of small dio writes, grabbing mutex lock
> > per dio increases the overhead.
> 
> Since the whole DIOs in Androbench are IPU, so in mutex_lock/allocate_block/
> mutex_unlock actually we didn't allocating blocks, but blocking the concurrency
> by grabing sbi->writepages.

Hmm, DIO doesn't grab writepages.
And, if we need to check every time, we can lose the bandwidth on every new
appending writes.

How about adding a condition to check whether we need to allocate or not?

For example,
	if (i_size == calculated i_blocks && offset < i_size)
		skip allocation;

Thanks,

> 
> How about grabbing sbi->writepages when it needs to allocate block(s) like
> following patch?
> 
> ---
>  fs/f2fs/data.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ac9e7c6..4439a85 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -458,6 +458,44 @@ got_it:
>  	return page;
>  }
>  
> +static bool __need_allocate_blocks(struct inode *inode, loff_t offset,
> +								size_t count)
> +{
> +	struct dnode_of_data dn;
> +	pgoff_t start = F2FS_BYTES_TO_BLK(offset);
> +	pgoff_t end = start + F2FS_BYTES_TO_BLK(count);
> +	pgoff_t end_offset;
> +
> +	while (start < end) {
> +		int ret;
> +
> +		set_new_dnode(&dn, inode, NULL, NULL, 0);
> +		ret = get_dnode_of_data(&dn, start, LOOKUP_NODE);
> +		if (ret == -ENOENT) {
> +			return true;
> +		} else if (ret) {
> +			return ret;
> +		}
> +
> +		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
> +
> +		while (dn.ofs_in_node < end_offset && start < end) {
> +			block_t blkaddr;
> +
> +			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
> +			if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
> +				f2fs_put_dnode(&dn);
> +				return true;
> +			}
> +			start++;
> +			dn.ofs_in_node++;
> +		}
> +
> +		f2fs_put_dnode(&dn);
> +	}
> +	return false
> +}
> +
>  static int __allocate_data_block(struct dnode_of_data *dn)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> @@ -1620,7 +1658,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	struct file *file = iocb->ki_filp;
>  	struct address_space *mapping = file->f_mapping;
>  	struct inode *inode = mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	size_t count = iov_iter_count(iter);
> +	int rw = iov_iter_rw(iter);
>  	int err;
>  
>  	/* we don't need to use inline_data strictly */
> @@ -1635,20 +1675,24 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	if (err)
>  		return err;
>  
> -	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> +	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
>  
> -	if (iov_iter_rw(iter) == WRITE) {
> -		err = __allocate_data_blocks(inode, offset, count);
> -		if (err)
> -			goto out;
> +	if (rw == WRITE) {
> +		if (__need_allocate_blocks(inode, offset, count) > 0) {
> +			mutex_lock(&sbi->writepages);
> +			err = __allocate_data_blocks(inode, offset, count);
> +			mutex_unlock(&sbi->writepages);
> +			if (err)
> +				goto out;
> +		}
>  	}
>  
>  	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
>  out:
> -	if (err < 0 && iov_iter_rw(iter) == WRITE)
> +	if (err < 0 && rw == WRITE)
>  		f2fs_write_failed(mapping, offset + count);
>  
> -	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
> +	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
>  
>  	return err;
>  }
> -- 
> 2.6.3
> 
> Thanks,
> 
> > 
> > After all, serializing dio could only be used for concurrent scenario of
> > big dio, so this patch also introduces a threshold in sysfs to provide user
> > the interface of defining 'a big dio' with specified page number, which could
> > be used to control wthether serialize or not that kind of dio with specified
> > page number.
> > 
> > The optimization works in rare scenario.
> > 
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> > v2:
> >  - merge another related patch into this one.
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs | 12 ++++++++++++
> >  fs/f2fs/data.c                          | 17 +++++++++++++----
> >  fs/f2fs/f2fs.h                          |  3 +++
> >  fs/f2fs/super.c                         |  3 +++
> >  4 files changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs
> > b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 0345f2d..560a4f1 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -92,3 +92,15 @@ Date:		October 2015
> >  Contact:	"Chao Yu" <chao2.yu@samsung.com>
> >  Description:
> >  		 Controls the count of nid pages to be readaheaded.
> > +
> > +What:		/sys/fs/f2fs/<disk>/serialized_dio_pages
> > +Date:		December 2015
> > +Contact:	"Chao Yu" <chao2.yu@samsung.com>
> > +Description:
> > +		 It is a threshold with the unit of page size.
> > +                 If DIO page count is equal or big than the threshold,
> > +                 whole process of block address allocation of dio pages
> > +                 will become atomic like buffered write.
> > +                 It is used to maximize bandwidth utilization in the
> > +                 scenario of concurrent write with dio vs buffered or
> > +                 dio vs dio.
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 8a89810..d506a0e 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1619,7 +1619,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
> >  	struct file *file = iocb->ki_filp;
> >  	struct address_space *mapping = file->f_mapping;
> >  	struct inode *inode = mapping->host;
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	size_t count = iov_iter_count(iter);
> > +	int rw = iov_iter_rw(iter);
> >  	int err;
> > 
> >  	/* we don't need to use inline_data strictly */
> > @@ -1634,20 +1636,27 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
> >  	if (err)
> >  		return err;
> > 
> > -	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> > +	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
> > +
> > +	if (rw == WRITE) {
> > +		bool serialized = (F2FS_BYTES_TO_BLK(count) >=
> > +						sbi->serialized_dio_pages);
> > 
> > -	if (iov_iter_rw(iter) == WRITE) {
> > +		if (serialized)
> > +			mutex_lock(&sbi->writepages);
> >  		err = __allocate_data_blocks(inode, offset, count);
> > +		if (serialized)
> > +			mutex_unlock(&sbi->writepages);
> >  		if (err)
> >  			goto out;
> >  	}
> > 
> >  	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
> >  out:
> > -	if (err < 0 && iov_iter_rw(iter) == WRITE)
> > +	if (err < 0 && rw == WRITE)
> >  		f2fs_write_failed(mapping, offset + count);
> > 
> > -	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
> > +	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
> > 
> >  	return err;
> >  }
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a339508..293dc4e 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -333,6 +333,8 @@ enum {
> > 
> >  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
> > 
> > +#define DEF_SERIALIZED_DIO_PAGES	64	/* default serialized dio pages */
> > +
> >  /* vector size for gang look-up from extent cache that consists of radix tree */
> >  #define EXT_TREE_VEC_SIZE	64
> > 
> > @@ -784,6 +786,7 @@ struct f2fs_sb_info {
> >  	unsigned int total_valid_inode_count;	/* valid inode count */
> >  	int active_logs;			/* # of active logs */
> >  	int dir_level;				/* directory level */
> > +	int serialized_dio_pages;		/* serialized direct IO pages */
> > 
> >  	block_t user_block_count;		/* # of user blocks */
> >  	block_t total_valid_block_count;	/* # of valid blocks */
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index a2e3a8f..4a2e51e 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -218,6 +218,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
> >  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
> >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
> >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, serialized_dio_pages, serialized_dio_pages);
> >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, cp_interval);
> > 
> >  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> > @@ -234,6 +235,7 @@ static struct attribute *f2fs_attrs[] = {
> >  	ATTR_LIST(min_fsync_blocks),
> >  	ATTR_LIST(max_victim_search),
> >  	ATTR_LIST(dir_level),
> > +	ATTR_LIST(serialized_dio_pages),
> >  	ATTR_LIST(ram_thresh),
> >  	ATTR_LIST(ra_nid_pages),
> >  	ATTR_LIST(cp_interval),
> > @@ -1125,6 +1127,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
> >  		atomic_set(&sbi->nr_pages[i], 0);
> > 
> >  	sbi->dir_level = DEF_DIR_LEVEL;
> > +	sbi->serialized_dio_pages = DEF_SERIALIZED_DIO_PAGES;
> >  	sbi->cp_interval = DEF_CP_INTERVAL;
> >  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
> > 
> > --
> > 2.6.3
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
