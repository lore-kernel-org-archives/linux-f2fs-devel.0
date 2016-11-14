From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: don't wait writeback for datas
	during checkpoint
Date: Mon, 14 Nov 2016 15:32:34 -0800
Message-ID: <20161114233234.GA33697@jaegeuk>
References: <20161114110412.110237-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c6Qk2-0008Ef-1K
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Nov 2016 23:32:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c6Qjz-0002BI-9y
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Nov 2016 23:32:46 +0000
Content-Disposition: inline
In-Reply-To: <20161114110412.110237-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Mon, Nov 14, 2016 at 07:04:12PM +0800, Chao Yu wrote:
> Normally, while committing checkpoint, we will wait on all pages to be
> writebacked no matter the page is data or metadata, so in scenario where
> there are lots of data IO being submitted with metadata, we may suffer
> long latency for waiting writeback during checkpoint.
> 
> Indeed, we only care about persistence for pages with metadata, but not
> pages with data, as file system consistent are only related to metadate,
> so in order to avoid encountering long latency in above scenario, let's
> recognize and reference metadata in submitted IOs, wait writeback only
> for metadatas.

Hmm, another concern comes, which is related to GCed data like below scenario.

1. Write data X
2. Sync
3. Move data X by GC
4. Checkpoint
5. Power-cut

In this case, we should guarantee data X which was migrated by GC during #3.
If we don't care about end_io in #4 Checkpoint, we can lose the data after
#5 Power-cut.

Any idea?

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c |  2 +-
>  fs/f2fs/data.c       | 36 ++++++++++++++++++++++++++++++++----
>  fs/f2fs/debug.c      |  7 ++++---
>  fs/f2fs/f2fs.h       |  8 +++++---
>  4 files changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 7bece59..bdf8a50 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1003,7 +1003,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
>  	for (;;) {
>  		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
>  
> -		if (!atomic_read(&sbi->nr_wb_bios))
> +		if (!get_pages(sbi, F2FS_WB_META))
>  			break;
>  
>  		io_schedule_timeout(5*HZ);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 66d2aee..f52cec3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -29,6 +29,26 @@
>  #include "trace.h"
>  #include <trace/events/f2fs.h>
>  
> +static bool f2fs_is_meta_data(struct page *page)
> +{
> +	struct address_space *mapping = page->mapping;
> +	struct f2fs_sb_info *sbi;
> +	struct inode *inode;
> +
> +	/* it is bounce page of encrypted regular inode */
> +	if (!mapping)
> +		return false;
> +
> +	inode = mapping->host;
> +	sbi = F2FS_I_SB(inode);
> +
> +	if ((inode->i_ino == F2FS_META_INO(sbi) &&
> +			page->index < MAIN_BLKADDR(sbi)) ||
> +			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
> +			S_ISDIR(inode->i_mode))
> +		return true;
> +	return false;
> +}
>  static void f2fs_read_end_io(struct bio *bio)
>  {
>  	struct bio_vec *bvec;
> @@ -73,6 +93,7 @@ static void f2fs_write_end_io(struct bio *bio)
>  
>  	bio_for_each_segment_all(bvec, bio, i) {
>  		struct page *page = bvec->bv_page;
> +		bool is_meta = f2fs_is_meta_data(page);
>  
>  		fscrypt_pullback_bio_page(&page, true);
>  
> @@ -80,9 +101,10 @@ static void f2fs_write_end_io(struct bio *bio)
>  			mapping_set_error(page->mapping, -EIO);
>  			f2fs_stop_checkpoint(sbi, true);
>  		}
> +		dec_page_count(sbi, is_meta ? F2FS_WB_META : F2FS_WB_DATA);
>  		end_page_writeback(page);
>  	}
> -	if (atomic_dec_and_test(&sbi->nr_wb_bios) &&
> +	if (!get_pages(sbi, F2FS_WB_META) &&
>  				wq_has_sleeper(&sbi->cp_wait))
>  		wake_up(&sbi->cp_wait);
>  
> @@ -111,7 +133,6 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  				struct bio *bio, enum page_type type)
>  {
>  	if (!is_read_io(bio_op(bio))) {
> -		atomic_inc(&sbi->nr_wb_bios);
>  		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
>  			current->plug && (type == DATA || type == NODE))
>  			blk_finish_plug(current->plug);
> @@ -272,6 +293,15 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>  		verify_block_addr(sbi, fio->old_blkaddr);
>  	verify_block_addr(sbi, fio->new_blkaddr);
>  
> +	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> +
> +	if (!is_read) {
> +		bool is_meta;
> +
> +		is_meta = f2fs_is_meta_data(bio_page);
> +		inc_page_count(sbi, is_meta ? F2FS_WB_META : F2FS_WB_DATA);
> +	}
> +
>  	down_write(&io->io_rwsem);
>  
>  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
> @@ -284,8 +314,6 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>  		io->fio = *fio;
>  	}
>  
> -	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> -
>  	if (bio_add_page(io->bio, bio_page, PAGE_SIZE, 0) <
>  							PAGE_SIZE) {
>  		__submit_merged_bio(io);
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 2fdf233..f2d87de 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -50,7 +50,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
>  	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
>  	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
> -	si->wb_bios = atomic_read(&sbi->nr_wb_bios);
> +	si->nr_wb_meta = get_pages(sbi, F2FS_WB_META);
> +	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
>  	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
>  	si->rsvd_segs = reserved_segments(sbi);
>  	si->overp_segs = overprovision_segments(sbi);
> @@ -313,8 +314,8 @@ static int stat_show(struct seq_file *s, void *v)
>  		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
>  				si->ext_tree, si->zombie_tree, si->ext_node);
>  		seq_puts(s, "\nBalancing F2FS Async:\n");
> -		seq_printf(s, "  - inmem: %4d, wb_bios: %4d\n",
> -			   si->inmem_pages, si->wb_bios);
> +		seq_printf(s, "  - inmem: %4d, wb_meta: %4d, wb_data: %4d\n",
> +			   si->inmem_pages, si->nr_wb_meta, si->nr_wb_data);
>  		seq_printf(s, "  - nodes: %4d in %4d\n",
>  			   si->ndirty_node, si->node_pages);
>  		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 23a937f..4df301c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -682,6 +682,8 @@ enum count_type {
>  	F2FS_DIRTY_META,
>  	F2FS_INMEM_PAGES,
>  	F2FS_DIRTY_IMETA,
> +	F2FS_WB_META,
> +	F2FS_WB_DATA,
>  	NR_COUNT_TYPE,
>  };
>  
> @@ -849,7 +851,6 @@ struct f2fs_sb_info {
>  	block_t discard_blks;			/* discard command candidats */
>  	block_t last_valid_block_count;		/* for recovery */
>  	u32 s_next_generation;			/* for NFS support */
> -	atomic_t nr_wb_bios;			/* # of writeback bios */
>  
>  	/* # of pages, see count_type */
>  	atomic_t nr_pages[NR_COUNT_TYPE];
> @@ -1263,7 +1264,8 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
>  {
>  	atomic_inc(&sbi->nr_pages[count_type]);
>  
> -	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES)
> +	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
> +		count_type == F2FS_WB_META || count_type == F2FS_WB_DATA)
>  		return;
>  
>  	set_sbi_flag(sbi, SBI_IS_DIRTY);
> @@ -2219,7 +2221,7 @@ struct f2fs_stat_info {
>  	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
>  	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
>  	int total_count, utilization;
> -	int bg_gc, wb_bios;
> +	int bg_gc, nr_wb_meta, nr_wb_data;
>  	int inline_xattr, inline_inode, inline_dir, orphans;
>  	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
>  	unsigned int bimodal, avg_vblocks;
> -- 
> 2.8.2.311.gee88674

------------------------------------------------------------------------------
