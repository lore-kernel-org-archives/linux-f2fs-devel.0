From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: don't wait writeback for datas
	during checkpoint
Date: Thu, 17 Nov 2016 11:06:09 +0800
Message-ID: <bec14358-32e1-2178-afb2-6c8d3ff9cfdb@huawei.com>
References: <20161116024120.61866-1-yuchao0@huawei.com>
	<20161116191828.GB57609@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c7D27-0000ED-Pk
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 03:06:39 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c7D24-0001XX-Hn
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 03:06:39 +0000
In-Reply-To: <20161116191828.GB57609@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/11/17 3:18, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Wed, Nov 16, 2016 at 10:41:20AM +0800, Chao Yu wrote:
>> Normally, while committing checkpoint, we will wait on all pages to be
>> writebacked no matter the page is data or metadata, so in scenario where
>> there are lots of data IO being submitted with metadata, we may suffer
>> long latency for waiting writeback during checkpoint.
>>
>> Indeed, we only care about persistence for pages with metadata, but not
>> pages with data, as file system consistent are only related to metadate,
>> so in order to avoid encountering long latency in above scenario, let's
>> recognize and reference metadata in submitted IOs, wait writeback only
>> for metadatas.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3: clean up codes as Jaegeuk suggested.
>>  fs/f2fs/checkpoint.c |  2 +-
>>  fs/f2fs/data.c       | 37 +++++++++++++++++++++++++++++++------
>>  fs/f2fs/debug.c      |  7 ++++---
>>  fs/f2fs/f2fs.h       |  8 +++++---
>>  fs/f2fs/file.c       |  2 --
>>  fs/f2fs/gc.c         |  2 --
>>  fs/f2fs/segment.c    |  1 -
>>  7 files changed, 41 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 7bece59..5039ed8 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1003,7 +1003,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
>>  	for (;;) {
>>  		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
>>  
>> -		if (!atomic_read(&sbi->nr_wb_bios))
>> +		if (!get_pages(sbi, F2FS_WB_CP_DATA))
>>  			break;
>>  
>>  		io_schedule_timeout(5*HZ);
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 66d2aee..4115689 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -29,6 +29,28 @@
>>  #include "trace.h"
>>  #include <trace/events/f2fs.h>
>>  
>> +static bool __is_cp_guaranteed(struct page *page)
>> +{
>> +	struct address_space *mapping = page->mapping;
>> +	struct inode *inode;
>> +	struct f2fs_sb_info *sbi;
>> +
>> +	if (!mapping)
>> +		return false;
>> +
>> +	inode = mapping->host;
>> +	sbi = F2FS_I_SB(inode);
>> +
>> +	if (inode->i_ino == F2FS_META_INO(sbi) ||
>> +			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
>> +			S_ISDIR(inode->i_mode) ||
>> +			is_cold_data(page))
>> +		return true;
>> +	return false;
>> +}
>> +
>> +#define WB_DATA_TYPE(p)	(__is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
> 
> I moved this into f2fs.h.

Indeed, I wanted to, but it looks that they are invoked only in data.c, and
f2fs.h grows bigger and bigger, so I keep it in data.c. Anyway, agree and thanks
for the cleanup.

How do you think of letting me clean up f2fs.h by split *.c related macros and
function in f2fs.h into *.h (data.h extent.h...)?

Thanks,

> 
> Thanks,
> 
>> +
>>  static void f2fs_read_end_io(struct bio *bio)
>>  {
>>  	struct bio_vec *bvec;
>> @@ -73,6 +95,7 @@ static void f2fs_write_end_io(struct bio *bio)
>>  
>>  	bio_for_each_segment_all(bvec, bio, i) {
>>  		struct page *page = bvec->bv_page;
>> +		enum count_type type = WB_DATA_TYPE(page);
>>  
>>  		fscrypt_pullback_bio_page(&page, true);
>>  
>> @@ -80,9 +103,11 @@ static void f2fs_write_end_io(struct bio *bio)
>>  			mapping_set_error(page->mapping, -EIO);
>>  			f2fs_stop_checkpoint(sbi, true);
>>  		}
>> +		dec_page_count(sbi, type);
>> +		clear_cold_data(page);
>>  		end_page_writeback(page);
>>  	}
>> -	if (atomic_dec_and_test(&sbi->nr_wb_bios) &&
>> +	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
>>  				wq_has_sleeper(&sbi->cp_wait))
>>  		wake_up(&sbi->cp_wait);
>>  
>> @@ -111,7 +136,6 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>>  				struct bio *bio, enum page_type type)
>>  {
>>  	if (!is_read_io(bio_op(bio))) {
>> -		atomic_inc(&sbi->nr_wb_bios);
>>  		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
>>  			current->plug && (type == DATA || type == NODE))
>>  			blk_finish_plug(current->plug);
>> @@ -272,6 +296,11 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>>  		verify_block_addr(sbi, fio->old_blkaddr);
>>  	verify_block_addr(sbi, fio->new_blkaddr);
>>  
>> +	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
>> +
>> +	if (!is_read)
>> +		inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>> +
>>  	down_write(&io->io_rwsem);
>>  
>>  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
>> @@ -284,8 +313,6 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>>  		io->fio = *fio;
>>  	}
>>  
>> -	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
>> -
>>  	if (bio_add_page(io->bio, bio_page, PAGE_SIZE, 0) <
>>  							PAGE_SIZE) {
>>  		__submit_merged_bio(io);
>> @@ -1296,7 +1323,6 @@ static int f2fs_write_data_page(struct page *page,
>>  	if (err && err != -ENOENT)
>>  		goto redirty_out;
>>  
>> -	clear_cold_data(page);
>>  out:
>>  	inode_dec_dirty_pages(inode);
>>  	if (err)
>> @@ -1699,7 +1725,6 @@ static int f2fs_write_end(struct file *file,
>>  		goto unlock_out;
>>  
>>  	set_page_dirty(page);
>> -	clear_cold_data(page);
>>  
>>  	if (pos + copied > i_size_read(inode))
>>  		f2fs_i_size_write(inode, pos + copied);
>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>> index 2fdf233..67a04d8 100644
>> --- a/fs/f2fs/debug.c
>> +++ b/fs/f2fs/debug.c
>> @@ -50,7 +50,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>>  	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
>>  	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
>>  	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
>> -	si->wb_bios = atomic_read(&sbi->nr_wb_bios);
>> +	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
>> +	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
>>  	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
>>  	si->rsvd_segs = reserved_segments(sbi);
>>  	si->overp_segs = overprovision_segments(sbi);
>> @@ -313,8 +314,8 @@ static int stat_show(struct seq_file *s, void *v)
>>  		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
>>  				si->ext_tree, si->zombie_tree, si->ext_node);
>>  		seq_puts(s, "\nBalancing F2FS Async:\n");
>> -		seq_printf(s, "  - inmem: %4d, wb_bios: %4d\n",
>> -			   si->inmem_pages, si->wb_bios);
>> +		seq_printf(s, "  - inmem: %4d, wb_cp_data: %4d, wb_data: %4d\n",
>> +			   si->inmem_pages, si->nr_wb_cp_data, si->nr_wb_data);
>>  		seq_printf(s, "  - nodes: %4d in %4d\n",
>>  			   si->ndirty_node, si->node_pages);
>>  		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f264c1b..34405dc 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -682,6 +682,8 @@ enum count_type {
>>  	F2FS_DIRTY_META,
>>  	F2FS_INMEM_PAGES,
>>  	F2FS_DIRTY_IMETA,
>> +	F2FS_WB_CP_DATA,
>> +	F2FS_WB_DATA,
>>  	NR_COUNT_TYPE,
>>  };
>>  
>> @@ -849,7 +851,6 @@ struct f2fs_sb_info {
>>  	block_t discard_blks;			/* discard command candidats */
>>  	block_t last_valid_block_count;		/* for recovery */
>>  	u32 s_next_generation;			/* for NFS support */
>> -	atomic_t nr_wb_bios;			/* # of writeback bios */
>>  
>>  	/* # of pages, see count_type */
>>  	atomic_t nr_pages[NR_COUNT_TYPE];
>> @@ -1263,7 +1264,8 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
>>  {
>>  	atomic_inc(&sbi->nr_pages[count_type]);
>>  
>> -	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES)
>> +	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
>> +		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA)
>>  		return;
>>  
>>  	set_sbi_flag(sbi, SBI_IS_DIRTY);
>> @@ -2219,7 +2221,7 @@ struct f2fs_stat_info {
>>  	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
>>  	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
>>  	int total_count, utilization;
>> -	int bg_gc, wb_bios;
>> +	int bg_gc, nr_wb_cp_data, nr_wb_data;
>>  	int inline_xattr, inline_inode, inline_dir, orphans;
>>  	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
>>  	unsigned int bimodal, avg_vblocks;
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index e821c39..dd1c5c3 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -96,8 +96,6 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
>>  	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
>>  		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
>>  
>> -	/* if gced page is attached, don't write to cold segment */
>> -	clear_cold_data(page);
>>  out:
>>  	sb_end_pagefault(inode->i_sb);
>>  	f2fs_update_time(sbi, REQ_TIME);
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 11ff05e..c4b3c32 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -695,8 +695,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>  			congestion_wait(BLK_RW_ASYNC, HZ/50);
>>  			goto retry;
>>  		}
>> -
>> -		clear_cold_data(page);
>>  	}
>>  out:
>>  	f2fs_put_page(page, 1);
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 078c571..d8aa703 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -290,7 +290,6 @@ static int __commit_inmem_pages(struct inode *inode,
>>  			/* record old blkaddr for revoking */
>>  			cur->old_addr = fio.old_blkaddr;
>>  
>> -			clear_cold_data(page);
>>  			submit_bio = true;
>>  		}
>>  		unlock_page(page);
>> -- 
>> 2.8.2.311.gee88674
> 
> .
> 


------------------------------------------------------------------------------
