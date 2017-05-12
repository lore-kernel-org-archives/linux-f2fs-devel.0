From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: introduce io_list for serialize
	data/node IOs
Date: Fri, 12 May 2017 10:49:42 -0700
Message-ID: <20170512174942.GB11924@jaegeuk.local>
References: <20170508163322.8087-1-chao@kernel.org>
	<20170508163322.8087-3-chao@kernel.org>
	<20170511183600.GA8058@jaegeuk.local>
	<4a903110-321e-ca20-8436-0b6630363b50@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d9EhM-0000e3-1Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 May 2017 17:49:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9EhK-0007sx-Fr
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 May 2017 17:49:52 +0000
Content-Disposition: inline
In-Reply-To: <4a903110-321e-ca20-8436-0b6630363b50@huawei.com>
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
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 05/12, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/5/12 2:36, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On 05/09, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> Serialize data/node IOs by using fifo list instead of mutex lock,
> >> it will help to enhance concurrency of f2fs, meanwhile keeping LFS
> >> IO semantics.
> > 
> > I'm not against to give it a try, but not sure how much we can get a benefit
> > from this approach frankly. Have you got a trouble on any lock contention from
> > the below io_rwsem or mutex?
> 
> Yes, because submitting IOs can be blocked in block layer since there may be:
> - limitation of some resources, e.g. request number.
> - IO throttle
> Holding a global mutex lock in the path is not good idea, as it may cause
> potential hungtask or concurrency performance regression.
> 
> So I add this patch to relief impacting of global mutex.

Okay, could you send a modified patch? Then, let me evaluate it.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/checkpoint.c |  1 +
> >>  fs/f2fs/data.c       | 28 ++++++++++++++++++++++++----
> >>  fs/f2fs/f2fs.h       |  5 ++++-
> >>  fs/f2fs/gc.c         |  3 ++-
> >>  fs/f2fs/segment.c    | 20 ++++++++++++++------
> >>  fs/f2fs/segment.h    |  3 ++-
> >>  6 files changed, 47 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index 2a475e83a092..7b3393474f6b 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -162,6 +162,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
> >>  		.op = REQ_OP_READ,
> >>  		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
> >>  		.encrypted_page = NULL,
> >> +		.in_list = false,
> >>  	};
> >>  	struct blk_plug plug;
> >>  
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index 5f001b471252..89eaa8aaa97b 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -393,10 +393,28 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >>  	struct f2fs_bio_info *io;
> >>  	bool is_read = is_read_io(fio->op);
> >>  	struct page *bio_page;
> >> +	struct curseg_info *curseg;
> >>  	int err = 0;
> >>  
> >> +	if (fio->in_list)
> >> +		curseg = CURSEG_I(sbi, fio->seg_type);
> >> +
> >>  	io = __get_bio_info(sbi, fio->op, fio->type, fio->seg_type);
> >>  
> >> +	down_write(&io->io_rwsem);
> >> +next:
> >> +	if (fio->in_list) {
> >> +		spin_lock(&curseg->io_lock);
> >> +		if (list_empty(&curseg->io_list)) {
> >> +			spin_unlock(&curseg->io_lock);
> >> +			goto out_fail;
> >> +		}
> >> +		fio = list_first_entry(&curseg->io_list,
> >> +						struct f2fs_io_info, list);
> >> +		list_del(&fio->list);
> >> +		spin_unlock(&curseg->io_lock);
> >> +	}
> >> +
> >>  	if (fio->old_blkaddr != NEW_ADDR)
> >>  		verify_block_addr(sbi, fio->old_blkaddr);
> >>  	verify_block_addr(sbi, fio->new_blkaddr);
> >> @@ -409,8 +427,6 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >>  	if (!is_read)
> >>  		inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> >>  
> >> -	down_write(&io->io_rwsem);
> >> -
> >>  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
> >>  	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
> >>  			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
> >> @@ -437,9 +453,13 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >>  
> >>  	io->last_block_in_bio = fio->new_blkaddr;
> >>  	f2fs_trace_ios(fio, 0);
> >> +
> >> +	trace_f2fs_submit_page_mbio(fio->page, fio);
> >> +
> >> +	if (fio->in_list)
> >> +		goto next;
> >>  out_fail:
> >>  	up_write(&io->io_rwsem);
> >> -	trace_f2fs_submit_page_mbio(fio->page, fio);
> >>  	return err;
> >>  }
> >>  
> >> @@ -752,7 +772,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
> >>  	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
> >>  
> >>  	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
> >> -						&sum, CURSEG_WARM_DATA);
> >> +					&sum, CURSEG_WARM_DATA, NULL, false);
> >>  	set_data_blkaddr(dn);
> >>  
> >>  	/* update i_size */
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 9129a6229bc8..6b8e9f051aa2 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -802,8 +802,10 @@ struct f2fs_io_info {
> >>  	block_t old_blkaddr;	/* old block address before Cow */
> >>  	struct page *page;	/* page to be written */
> >>  	struct page *encrypted_page;	/* encrypted page */
> >> +	struct list_head list;		/* serialize IOs */
> >>  	bool submitted;		/* indicate IO submission */
> >>  	bool need_lock;		/* indicate we need to lock cp_rwsem */
> >> +	bool in_list;		/* indicate fio is in io_list */
> >>  };
> >>  
> >>  #define is_read_io(rw) ((rw) == READ)
> >> @@ -2274,7 +2276,8 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
> >>  			bool recover_newaddr);
> >>  void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >>  			block_t old_blkaddr, block_t *new_blkaddr,
> >> -			struct f2fs_summary *sum, int type);
> >> +			struct f2fs_summary *sum, int type,
> >> +			struct f2fs_io_info *fio, bool add_list);
> >>  void f2fs_wait_on_page_writeback(struct page *page,
> >>  			enum page_type type, bool ordered);
> >>  void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index 8b267ca30926..ac2f74e40eea 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -590,6 +590,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
> >>  		.op = REQ_OP_READ,
> >>  		.op_flags = 0,
> >>  		.encrypted_page = NULL,
> >> +		.in_list = false,
> >>  	};
> >>  	struct dnode_of_data dn;
> >>  	struct f2fs_summary sum;
> >> @@ -633,7 +634,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
> >>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
> >>  
> >>  	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
> >> -							&sum, fio.seg_type);
> >> +					&sum, fio.seg_type, NULL, false);
> >>  
> >>  	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
> >>  					FGP_LOCK | FGP_CREAT, GFP_NOFS);
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index c047b5d8b9d3..d4975b8f4620 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -2100,7 +2100,8 @@ static int __get_segment_type(struct page *page, enum page_type p_type)
> >>  
> >>  void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >>  		block_t old_blkaddr, block_t *new_blkaddr,
> >> -		struct f2fs_summary *sum, int type)
> >> +		struct f2fs_summary *sum, int type,
> >> +		struct f2fs_io_info *fio, bool add_list)
> >>  {
> >>  	struct sit_info *sit_i = SIT_I(sbi);
> >>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
> >> @@ -2136,6 +2137,14 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >>  	if (page && IS_NODESEG(type))
> >>  		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
> >>  
> >> +	if (add_list) {
> >> +		INIT_LIST_HEAD(&fio->list);
> >> +		fio->in_list = true;
> >> +		spin_lock(&curseg->io_lock);
> >> +		list_add_tail(&fio->list, &curseg->io_list);
> >> +		spin_unlock(&curseg->io_lock);
> >> +	}
> >> +
> >>  	mutex_unlock(&curseg->curseg_mutex);
> >>  }
> >>  
> >> @@ -2145,10 +2154,9 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
> >>  
> >>  	fio->seg_type = __get_segment_type(fio->page, fio->type);
> >>  
> >> -	mutex_lock(&CURSEG_I(fio->sbi, fio->seg_type)->wio_mutex);
> >>  reallocate:
> >>  	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> >> -					&fio->new_blkaddr, sum, fio->seg_type);
> >> +			&fio->new_blkaddr, sum, fio->seg_type, fio, true);
> >>  
> >>  	/* writeout dirty page into bdev */
> >>  	err = f2fs_submit_page_mbio(fio);
> >> @@ -2156,8 +2164,6 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
> >>  		fio->old_blkaddr = fio->new_blkaddr;
> >>  		goto reallocate;
> >>  	}
> >> -
> >> -	mutex_unlock(&CURSEG_I(fio->sbi, fio->seg_type)->wio_mutex);
> >>  }
> >>  
> >>  void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
> >> @@ -2171,6 +2177,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
> >>  		.new_blkaddr = page->index,
> >>  		.page = page,
> >>  		.encrypted_page = NULL,
> >> +		.in_list = false,
> >>  	};
> >>  
> >>  	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
> >> @@ -2978,7 +2985,8 @@ static int build_curseg(struct f2fs_sb_info *sbi)
> >>  		array[i].bio_info.sbi = sbi;
> >>  		array[i].bio_info.bio = NULL;
> >>  
> >> -		mutex_init(&array[i].wio_mutex);
> >> +		spin_lock_init(&array[i].io_lock);
> >> +		INIT_LIST_HEAD(&array[i].io_list);
> >>  	}
> >>  	return restore_curseg_summaries(sbi);
> >>  }
> >> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >> index 701944b462cd..b6f5dffeaa61 100644
> >> --- a/fs/f2fs/segment.h
> >> +++ b/fs/f2fs/segment.h
> >> @@ -283,7 +283,8 @@ struct curseg_info {
> >>  	struct rw_semaphore journal_rwsem;	/* protect journal area */
> >>  	struct f2fs_journal *journal;		/* cached journal info */
> >>  	struct f2fs_bio_info bio_info;		/* for log bios */
> >> -	struct mutex wio_mutex;			/* serialize DATA/NODE IOs */
> >> +	spinlock_t io_lock;			/* serialize DATA/NODE IOs */
> >> +	struct list_head io_list;		/* tracking fios */
> >>  	unsigned char alloc_type;		/* current allocation type */
> >>  	unsigned int segno;			/* current segment number */
> >>  	unsigned short next_blkoff;		/* next block offset to write */
> >> -- 
> >> 2.12.2.575.gb14f27f
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
