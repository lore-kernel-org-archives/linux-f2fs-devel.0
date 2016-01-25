From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH v2 2/4] f2fs: introduce
	f2fs_submit_merged_bio_cond
Date: Mon, 25 Jan 2016 17:50:21 +0800
Message-ID: <000f01d15755$e6955cc0$b3c01640$@samsung.com>
References: <01ac01d151db$0659ef60$130dce20$@samsung.com>
	<20160123202151.GA62021@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aNdnv-0001HX-IM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 09:51:23 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aNdns-0007xZ-8d
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 09:51:23 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1I00XBU616PZ90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 18:51:06 +0900 (KST)
In-reply-to: <20160123202151.GA62021@jaegeuk.hsd1.ca.comcast.net>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, January 24, 2016 4:22 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/4] f2fs: introduce f2fs_submit_merged_bio_cond
> 
> Hi Chao,
> 
> Could you review this patch again?

I did the review, but found nothing, and also I couldn't reproduce this
issue.

> I just got a panic from this patch.
> I have not much time to dig this, so couldn't remain more specific info.
> Let me test this later.

OK, if there is some dmesg info, please share with me. :)

Thanks,

> 
> Thanks,
> 
> On Mon, Jan 18, 2016 at 06:28:11PM +0800, Chao Yu wrote:
> > f2fs use single bio buffer per type data (META/NODE/DATA) for caching
> > writes locating in continuous block address as many as possible, after
> > submitting, these writes may be still cached in bio buffer, so we have
> > to flush cached writes in bio buffer by calling f2fs_submit_merged_bio.
> >
> > Unfortunately, in the scenario of high concurrency, bio buffer could be
> > flushed by someone else before we submit it as below reasons:
> > a) there is no space in bio buffer.
> > b) add a request of different type (SYNC, ASYNC).
> > c) add a discontinuous block address.
> >
> > For this condition, f2fs_submit_merged_bio will be devastating, because
> > it could break the following merging of writes in bio buffer, split one
> > big bio into two smaller one.
> >
> > This patch introduces f2fs_submit_merged_bio_cond which can do a
> > conditional submitting with bio buffer, before submitting it will judge
> > whether:
> >  - page in DATA type bio buffer is matching with specified page;
> >  - page in DATA type bio buffer is belong to specified inode;
> >  - page in NODE type bio buffer is belong to specified inode;
> > If there is no eligible page in bio buffer, we will skip submitting step,
> > result in gaining more chance to merge consecutive block IOs in bio cache.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  v2:
> >  - update comments.
> >  - split ("f2fs: relocate is_merged_page ") from this patch.
> > ---
> >  fs/f2fs/checkpoint.c |  7 ++++-
> >  fs/f2fs/data.c       | 74 +++++++++++++++++++++++++++++++++++++++-------------
> >  fs/f2fs/f2fs.h       |  3 ++-
> >  fs/f2fs/node.c       | 15 ++++++++---
> >  fs/f2fs/segment.c    |  6 ++---
> >  5 files changed, 79 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 3842af9..c75b148 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -235,10 +235,15 @@ static int f2fs_write_meta_page(struct page *page,
> >  	f2fs_wait_on_page_writeback(page, META);
> >  	write_meta_page(sbi, page);
> >  	dec_page_count(sbi, F2FS_DIRTY_META);
> > +
> > +	if (wbc->for_reclaim)
> > +		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, META, WRITE);
> > +
> >  	unlock_page(page);
> >
> > -	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi)))
> > +	if (unlikely(f2fs_cp_error(sbi)))
> >  		f2fs_submit_merged_bio(sbi, META, WRITE);
> > +
> >  	return 0;
> >
> >  redirty_out:
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index b118055..19e9924 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -116,20 +116,18 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
> >  	io->bio = NULL;
> >  }
> >
> > -bool is_merged_page(struct f2fs_sb_info *sbi, struct page *page,
> > -							enum page_type type)
> > +static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
> > +						struct page *page, nid_t ino)
> >  {
> > -	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> > -	struct f2fs_bio_info *io = &sbi->write_io[btype];
> >  	struct bio_vec *bvec;
> >  	struct page *target;
> >  	int i;
> >
> > -	down_read(&io->io_rwsem);
> > -	if (!io->bio) {
> > -		up_read(&io->io_rwsem);
> > +	if (!io->bio)
> >  		return false;
> > -	}
> > +
> > +	if (!inode && !page && !ino)
> > +		return true;
> >
> >  	bio_for_each_segment_all(bvec, io->bio, i) {
> >
> > @@ -144,18 +142,34 @@ bool is_merged_page(struct f2fs_sb_info *sbi, struct page *page,
> >  			target = ctx->w.control_page;
> >  		}
> >
> > -		if (page == target) {
> > -			up_read(&io->io_rwsem);
> > +		if (inode && inode == target->mapping->host)
> > +			return true;
> > +		if (page && page == target)
> > +			return true;
> > +		if (ino && ino == ino_of_node(target))
> >  			return true;
> > -		}
> >  	}
> >
> > -	up_read(&io->io_rwsem);
> >  	return false;
> >  }
> >
> > -void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
> > -				enum page_type type, int rw)
> > +static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
> > +						struct page *page, nid_t ino,
> > +						enum page_type type)
> > +{
> > +	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> > +	struct f2fs_bio_info *io = &sbi->write_io[btype];
> > +	bool ret;
> > +
> > +	down_read(&io->io_rwsem);
> > +	ret = __has_merged_page(io, inode, page, ino);
> > +	up_read(&io->io_rwsem);
> > +	return ret;
> > +}
> > +
> > +static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
> > +				struct inode *inode, struct page *page,
> > +				nid_t ino, enum page_type type, int rw)
> >  {
> >  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> >  	struct f2fs_bio_info *io;
> > @@ -164,6 +178,9 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
> >
> >  	down_write(&io->io_rwsem);
> >
> > +	if (!__has_merged_page(io, inode, page, ino))
> > +		goto out;
> > +
> >  	/* change META to META_FLUSH in the checkpoint procedure */
> >  	if (type >= META_FLUSH) {
> >  		io->fio.type = META_FLUSH;
> > @@ -173,9 +190,24 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
> >  			io->fio.rw = WRITE_FLUSH_FUA | REQ_META | REQ_PRIO;
> >  	}
> >  	__submit_merged_bio(io);
> > +out:
> >  	up_write(&io->io_rwsem);
> >  }
> >
> > +void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
> > +									int rw)
> > +{
> > +	__f2fs_submit_merged_bio(sbi, NULL, NULL, 0, type, rw);
> > +}
> > +
> > +void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
> > +				struct inode *inode, struct page *page,
> > +				nid_t ino, enum page_type type, int rw)
> > +{
> > +	if (has_merged_page(sbi, inode, page, ino, type))
> > +		__f2fs_submit_merged_bio(sbi, inode, page, ino, type, rw);
> > +}
> > +
> >  /*
> >   * Fill the locked page with data located in the block address.
> >   * Return unlocked page.
> > @@ -1215,12 +1247,18 @@ out:
> >  	inode_dec_dirty_pages(inode);
> >  	if (err)
> >  		ClearPageUptodate(page);
> > +
> > +	if (wbc->for_reclaim) {
> > +		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, DATA, WRITE);
> > +		remove_dirty_inode(inode);
> > +	}
> > +
> >  	unlock_page(page);
> >  	f2fs_balance_fs(sbi, need_balance_fs);
> > -	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi))) {
> > +
> > +	if (unlikely(f2fs_cp_error(sbi)))
> >  		f2fs_submit_merged_bio(sbi, DATA, WRITE);
> > -		remove_dirty_inode(inode);
> > -	}
> > +
> >  	return 0;
> >
> >  redirty_out:
> > @@ -1407,7 +1445,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
> >  		locked = true;
> >  	}
> >  	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
> > -	f2fs_submit_merged_bio(sbi, DATA, WRITE);
> > +	f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0, DATA, WRITE);
> >  	if (locked)
> >  		mutex_unlock(&sbi->writepages);
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 79cadd3..6c413b1e 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1882,8 +1882,9 @@ void destroy_checkpoint_caches(void);
> >  /*
> >   * data.c
> >   */
> > -bool is_merged_page(struct f2fs_sb_info *, struct page *, enum page_type);
> >  void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
> > +void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
> > +				struct page *, nid_t, enum page_type, int);
> >  int f2fs_submit_page_bio(struct f2fs_io_info *);
> >  void f2fs_submit_page_mbio(struct f2fs_io_info *);
> >  void set_data_blkaddr(struct dnode_of_data *);
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 342597a..851a80b 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1258,8 +1258,13 @@ continue_unlock:
> >  		goto next_step;
> >  	}
> >
> > -	if (wrote)
> > -		f2fs_submit_merged_bio(sbi, NODE, WRITE);
> > +	if (wrote) {
> > +		if (ino)
> > +			f2fs_submit_merged_bio_cond(sbi, NULL, NULL,
> > +							ino, NODE, WRITE);
> > +		else
> > +			f2fs_submit_merged_bio(sbi, NODE, WRITE);
> > +	}
> >  	return nwritten;
> >  }
> >
> > @@ -1356,9 +1361,13 @@ static int f2fs_write_node_page(struct page *page,
> >  	set_node_addr(sbi, &ni, fio.blk_addr, is_fsync_dnode(page));
> >  	dec_page_count(sbi, F2FS_DIRTY_NODES);
> >  	up_read(&sbi->node_write);
> > +
> > +	if (wbc->for_reclaim)
> > +		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, NODE, WRITE);
> > +
> >  	unlock_page(page);
> >
> > -	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi)))
> > +	if (unlikely(f2fs_cp_error(sbi)))
> >  		f2fs_submit_merged_bio(sbi, NODE, WRITE);
> >
> >  	return 0;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index e16235b..0246acc 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -253,7 +253,8 @@ int commit_inmem_pages(struct inode *inode, bool abort)
> >  	if (!abort) {
> >  		f2fs_unlock_op(sbi);
> >  		if (submit_bio)
> > -			f2fs_submit_merged_bio(sbi, DATA, WRITE);
> > +			f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0,
> > +								DATA, WRITE);
> >  	}
> >  	return err;
> >  }
> > @@ -1421,8 +1422,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
> >  	if (PageWriteback(page)) {
> >  		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
> >
> > -		if (is_merged_page(sbi, page, type))
> > -			f2fs_submit_merged_bio(sbi, type, WRITE);
> > +		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, type, WRITE);
> >  		wait_on_page_writeback(page);
> >  	}
> >  }
> > --
> > 2.6.3
> >


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
