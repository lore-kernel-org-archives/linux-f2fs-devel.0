From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: remove request_list check in is_idle()
Date: Tue, 16 Oct 2018 19:19:18 -0700
Message-ID: <20181017021918.GA77619@jaegeuk-macbookpro.roam.corp.google.com>
References: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
 <003df7ce-626c-e32b-909b-909b87e0c8f3@kernel.org>
 <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
 <20181016192314.GB29774@jaegeuk-macbookpro.roam.corp.google.com>
 <2c67b341-15c3-a9d1-e52d-4b51e5be8920@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gCbQk-0000jJ-VY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 02:19:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCbQj-00AjMf-6L
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 02:19:26 +0000
Content-Disposition: inline
In-Reply-To: <2c67b341-15c3-a9d1-e52d-4b51e5be8920@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-f2fs-devel@lists.sourceforge.net

On 10/17, Chao Yu wrote:
> Hi Jaegeuk, Jens,
> 
> On 2018/10/17 3:23, Jaegeuk Kim wrote:
> > Thanks Jens,
> > 
> > On top of the patch killing the dead code, I wrote another one to detect
> > the idle time by the internal account logic like below. IMHO, it'd be
> > better to decouple f2fs with other layers, if possible.
> > 
> > Thanks,
> > 
> >>From 85daf5190671b3d98ef779bdea77b4a046658708 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 16 Oct 2018 10:20:53 -0700
> > Subject: [PATCH] f2fs: account read IOs and use IO counts for is_idle
> > 
> > This patch adds issued read IO counts which is under block layer.
> 
> I think the problem here is, in android environment, there is multiple
> kinds of filesystems used in one device (emmc or ufs), so, if f2fs only be
> aware of IOs from itself, still we can face IO conflict between f2fs and
> other filesystem (ext4 used in system/... partition), it is possible when
> we are trigger GC/discard intensively such as in gc_urgent mode, user can
> be stuck when loading data from system partition.

IMO, we don't need to worry about gc_urgent too much, since it will be set at
the given android idle time. Other than that, I think it won't trigger GC and
discard too frequently which would be able to affect /system operations.
The new interface would be nice to have, but give more complexity on backporting
work in old kernels and newer as well across the layers.

> 
> So I guess the better way to avoid this is to export IO busy status in
> block layer to filesystem, in f2fs, we can provider effective service in
> background thread at real idle time, and will not impact user.
> 
> Any thoughts?
> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c  | 24 ++++++++++++++++++++++--
> >  fs/f2fs/debug.c |  7 ++++++-
> >  fs/f2fs/f2fs.h  | 22 ++++++++++++++++------
> >  3 files changed, 44 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 8952f2d610a6..5fdc8d751f19 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -52,6 +52,23 @@ static bool __is_cp_guaranteed(struct page *page)
> >  	return false;
> >  }
> >  
> > +static enum count_type __read_io_type(struct page *page)
> > +{
> > +	struct address_space *mapping = page->mapping;
> > +
> > +	if (mapping) {
> > +		struct inode *inode = mapping->host;
> > +		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > +
> > +		if (inode->i_ino == F2FS_META_INO(sbi))
> > +			return F2FS_RD_META;
> > +
> > +		if (inode->i_ino == F2FS_NODE_INO(sbi))
> > +			return F2FS_RD_NODE;
> > +	}
> > +	return F2FS_RD_DATA;
> > +}
> > +
> >  /* postprocessing steps for read bios */
> >  enum bio_post_read_step {
> >  	STEP_INITIAL = 0,
> > @@ -82,6 +99,7 @@ static void __read_end_io(struct bio *bio)
> >  		} else {
> >  			SetPageUptodate(page);
> >  		}
> > +		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
> >  		unlock_page(page);
> >  	}
> >  	if (bio->bi_private)
> > @@ -464,8 +482,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> >  
> >  	__submit_bio(fio->sbi, bio, fio->type);
> >  
> > -	if (!is_read_io(fio->op))
> > -		inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
> > +	inc_page_count(fio->sbi, is_read_io(fio->op) ?
> > +			__read_io_type(page): WB_DATA_TYPE(fio->page));
> >  	return 0;
> >  }
> >  
> > @@ -595,6 +613,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
> >  	}
> >  	ClearPageError(page);
> >  	__submit_bio(F2FS_I_SB(inode), bio, DATA);
> > +	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> >  	return 0;
> >  }
> >  
> > @@ -1593,6 +1612,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
> >  		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
> >  			goto submit_and_realloc;
> >  
> > +		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> >  		ClearPageError(page);
> >  		last_block_in_bio = block_nr;
> >  		goto next_page;
> > diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> > index 026e10f30889..139b4d5c83d5 100644
> > --- a/fs/f2fs/debug.c
> > +++ b/fs/f2fs/debug.c
> > @@ -55,6 +55,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
> >  	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
> >  	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
> >  	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
> > +	si->nr_rd_data = get_pages(sbi, F2FS_RD_DATA);
> > +	si->nr_rd_node = get_pages(sbi, F2FS_RD_NODE);
> > +	si->nr_rd_meta = get_pages(sbi, F2FS_RD_META);
> >  	if (SM_I(sbi) && SM_I(sbi)->fcc_info) {
> >  		si->nr_flushed =
> >  			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
> > @@ -371,7 +374,9 @@ static int stat_show(struct seq_file *s, void *v)
> >  		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
> >  				si->ext_tree, si->zombie_tree, si->ext_node);
> >  		seq_puts(s, "\nBalancing F2FS Async:\n");
> > -		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
> > +		seq_printf(s, "  - IO_R (Data: %4d, Node: %4d, Meta: %4d\n",
> > +			   si->nr_rd_data, si->nr_rd_node, si->nr_rd_meta);
> > +		seq_printf(s, "  - IO_W (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
> >  			"Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
> >  			   si->nr_wb_cp_data, si->nr_wb_data,
> >  			   si->nr_flushing, si->nr_flushed,
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 156e6cd2c812..5c80eca194b5 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -950,6 +950,9 @@ enum count_type {
> >  	F2FS_DIRTY_IMETA,
> >  	F2FS_WB_CP_DATA,
> >  	F2FS_WB_DATA,
> > +	F2FS_RD_DATA,
> > +	F2FS_RD_NODE,
> > +	F2FS_RD_META,
> >  	NR_COUNT_TYPE,
> >  };
> >  
> > @@ -1392,11 +1395,6 @@ static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
> >  	return wait_ms;
> >  }
> >  
> > -static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
> > -{
> > -	return f2fs_time_over(sbi, type);
> > -}
> > -
> >  /*
> >   * Inline functions
> >   */
> > @@ -1787,7 +1785,9 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
> >  	atomic_inc(&sbi->nr_pages[count_type]);
> >  
> >  	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
> > -		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA)
> > +		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA ||
> > +		count_type == F2FS_RD_DATA || count_type == F2FS_RD_NODE ||
> > +		count_type == F2FS_RD_META)
> >  		return;
> >  
> >  	set_sbi_flag(sbi, SBI_IS_DIRTY);
> > @@ -2124,6 +2124,15 @@ static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
> >  	return bio_alloc(GFP_KERNEL, npages);
> >  }
> >  
> > +static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
> > +{
> > +	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
> > +		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
> > +		get_pages(sbi, F2FS_WB_CP_DATA))
> > +		return false;
> > +	return f2fs_time_over(sbi, type);
> > +}
> > +
> >  static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
> >  				unsigned long index, void *item)
> >  {
> > @@ -3116,6 +3125,7 @@ struct f2fs_stat_info {
> >  	int free_nids, avail_nids, alloc_nids;
> >  	int total_count, utilization;
> >  	int bg_gc, nr_wb_cp_data, nr_wb_data;
> > +	int nr_rd_data, nr_rd_node, nr_rd_meta;
> >  	unsigned int io_skip_bggc, other_skip_bggc;
> >  	int nr_flushing, nr_flushed, flush_list_empty;
> >  	int nr_discarding, nr_discarded;
> > 
