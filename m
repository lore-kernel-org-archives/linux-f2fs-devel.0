From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs crypto: fix racing of accessing encrypted page
 among different competitors
Date: Tue, 13 Oct 2015 09:51:44 -0700
Message-ID: <20151013164904.GA60592@jaegeuk-mac02.mot.com>
References: <019001d101c8$07899880$169cc980$@samsung.com>
 <20151012210004.GB55804@jaegeuk-mac02.mot.com>
 <025a01d1057c$a6f59150$f4e0b3f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <025a01d1057c$a6f59150$f4e0b3f0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Oct 13, 2015 at 02:01:10PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, October 13, 2015 5:00 AM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] f2fs crypto: fix racing of accessing encrypted page among different
> > competitors
> > 
> > On Thu, Oct 08, 2015 at 08:50:39PM +0800, Chao Yu wrote:
> > > >From 0211c6ed82440891b3369851d079f6c69b432b6c Mon Sep 17 00:00:00 2001
> > > From: Chao Yu <chao2.yu@samsung.com>
> > > Date: Thu, 8 Oct 2015 13:27:34 +0800
> > > Subject: [PATCH] f2fs crypto: fix racing of accessing encrypted page among
> > >  different competitors
> > >
> > > Since we use different page cache (normally inode's page cache for R/W
> > > and meta inode's page cache for GC) to cache the same physical block
> > > which is belong to an encrypted inode. Writeback of these two page
> > > cache should be exclusive, but now we didn't handle writeback state
> > > well, so there may be potential racing problem:
> > >
> > > a)
> > > kworker:				f2fs_gc:
> > >  - f2fs_write_data_pages
> > >   - f2fs_write_data_page
> > >    - do_write_data_page
> > >     - write_data_page
> > >      - f2fs_submit_page_mbio
> > > (page#1 in inode's page cache was queued
> > > in f2fs bio cache, and be ready to write
> > > to new blkaddr)
> > > 					 - gc_data_segment
> > > 					  - move_encrypted_block
> > > 					   - pagecache_get_page
> > > 					(page#2 in meta inode's page cache
> > > 					was cached with the invalid datas
> > > 					of physical block located in new
> > > 					blkaddr)
> > > 					   - f2fs_submit_page_mbio
> > > 					(page#1 was submitted, later, page#2
> > > 					with invalid data will be submitted)
> > >
> > > b)
> > > f2fs_gc:
> > >  - gc_data_segment
> > >   - move_encrypted_block
> > >    - f2fs_submit_page_mbio
> > > (page#1 in meta inode's page cache was
> > > queued in f2fs bio cache, and be ready
> > > to write to new blkaddr)
> > > 					user thread:
> > > 					 - f2fs_write_begin
> > > 					  - f2fs_submit_page_bio
> > > 					(we submit the request to block layer
> > > 					to update page#2 in inode's page cache
> > > 					with physical block located in new
> > > 					blkaddr, so here we may read gabbage
> > > 					data from new blkaddr since GC hasn't
> > > 					writebacked the page#1 yet)
> > >
> > > This patch fixes above potential racing problem for encrypted inode.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  fs/f2fs/data.c    | 20 +++++++++++---------
> > >  fs/f2fs/f2fs.h    |  1 +
> > >  fs/f2fs/file.c    |  5 +++++
> > >  fs/f2fs/gc.c      | 13 ++++++++++---
> > >  fs/f2fs/segment.c | 17 +++++++++++++++++
> > >  5 files changed, 44 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 40a0102..d791bd3 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -954,21 +954,14 @@ submit_and_realloc:
> > >
> > >  			if (f2fs_encrypted_inode(inode) &&
> > >  					S_ISREG(inode->i_mode)) {
> > > -				struct page *cpage;
> > >
> > >  				ctx = f2fs_get_crypto_ctx(inode);
> > >  				if (IS_ERR(ctx))
> > >  					goto set_error_page;
> > >
> > >  				/* wait the page to be moved by cleaning */
> > > -				cpage = find_lock_page(
> > > -						META_MAPPING(F2FS_I_SB(inode)),
> > > -						block_nr);
> > > -				if (cpage) {
> > > -					f2fs_wait_on_page_writeback(cpage,
> > > -									DATA);
> > > -					f2fs_put_page(cpage, 1);
> > > -				}
> > > +				f2fs_wait_on_encrypted_page_writeback(
> > > +						F2FS_I_SB(inode), block_nr);
> > >  			}
> > >
> > >  			bio = bio_alloc(GFP_KERNEL,
> > > @@ -1059,6 +1052,11 @@ int do_write_data_page(struct f2fs_io_info *fio)
> > >  	}
> > >
> > >  	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
> > > +
> > > +		/* wait for GCed encrypted page writeback */
> > > +		f2fs_wait_on_encrypted_page_writeback(F2FS_I_SB(inode),
> > > +							fio->blk_addr);
> > > +
> > >  		fio->encrypted_page = f2fs_encrypt(inode, fio->page);
> > >  		if (IS_ERR(fio->encrypted_page)) {
> > >  			err = PTR_ERR(fio->encrypted_page);
> > > @@ -1446,6 +1444,10 @@ put_next:
> > >
> > >  	f2fs_wait_on_page_writeback(page, DATA);
> > >
> > > +	/* wait for GCed encrypted page writeback */
> > > +	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> > > +		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
> > > +
> > >  	if (len == PAGE_CACHE_SIZE)
> > >  		goto out_update;
> > >  	if (PageUptodate(page))
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index a7522a4..dc4d30b 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1778,6 +1778,7 @@ void f2fs_replace_block(struct f2fs_sb_info *, struct dnode_of_data
> > *,
> > >  void allocate_data_block(struct f2fs_sb_info *, struct page *,
> > >  		block_t, block_t *, struct f2fs_summary *, int);
> > >  void f2fs_wait_on_page_writeback(struct page *, enum page_type);
> > > +void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *, block_t);
> > >  void write_data_summaries(struct f2fs_sb_info *, block_t);
> > >  void write_node_summaries(struct f2fs_sb_info *, block_t);
> > >  int lookup_journal_in_cursum(struct f2fs_summary_block *,
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index e2d9910..1d2df88 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -87,6 +87,11 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
> > >  mapped:
> > >  	/* fill the page */
> > >  	f2fs_wait_on_page_writeback(page, DATA);
> > > +
> > > +	/* wait for GCed encrypted page writeback */
> > > +	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> > > +		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
> > > +
> > >  	/* if gced page is attached, don't write to cold segment */
> > >  	clear_cold_data(page);
> > >  out:
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index e7cec86..2493fd6 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -559,14 +559,21 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
> > >  	if (err)
> > >  		goto out;
> > >
> > > -	if (unlikely(dn.data_blkaddr == NULL_ADDR))
> > > +	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
> > > +		ClearPageUptodate(page);
> > >  		goto put_out;
> > > +	}
> > > +
> > > +	/*
> > > +	 * don't cache encrypted data into meta inode until previous dirty
> > > +	 * data were writebacked to avoid racing between GC and flush.
> > > +	 */
> > > +	f2fs_wait_on_page_writeback(page, DATA);
> > >
> > >  	get_node_info(fio.sbi, dn.nid, &ni);
> > >  	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
> > >
> > >  	/* read page */
> > > -	fio.page = page;
> > 
> > Let's remain just to make sure.
> 
> OK.
> 
> > 
> > >  	fio.blk_addr = dn.data_blkaddr;
> > >
> > >  	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi),
> > > @@ -589,7 +596,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
> > >  		goto put_page_out;
> > >
> > >  	set_page_dirty(fio.encrypted_page);
> > > -	f2fs_wait_on_page_writeback(fio.encrypted_page, META);
> > > +	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA);
> > 
> > Why DATA?
> 
> This is because we only submit the encrypted page in to DATA type bio
> cache, so we should check whether the page is cached or not in DATA
> type bio, rather than META type cache. Right?

Oh, right, type was DATA. :)
I'll test this patch with adding the above initialization.

Thanks,

> 
> Thanks,
> 
> > 
> > >  	if (clear_page_dirty_for_io(fio.encrypted_page))
> > >  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
> > >
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 3c546eb..d5d760c 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -1462,6 +1462,23 @@ void f2fs_wait_on_page_writeback(struct page *page,
> > >  	}
> > >  }
> > >
> > > +void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
> > > +							block_t blkaddr)
> > > +{
> > > +	struct page *cpage;
> > > +
> > > +	if (blkaddr == NEW_ADDR)
> > > +		return;
> > > +
> > > +	f2fs_bug_on(sbi, blkaddr == NULL_ADDR);
> > > +
> > > +	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
> > > +	if (cpage) {
> > > +		f2fs_wait_on_page_writeback(cpage, DATA);
> > > +		f2fs_put_page(cpage, 1);
> > > +	}
> > > +}
> > > +
> > >  static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> > >  {
> > >  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> > > --
> > > 2.5.2
