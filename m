From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 08/10] f2fs: relax async discard commands more
Date: Wed, 22 Feb 2017 13:15:39 -0800
Message-ID: <20170222211539.GA4003@jaegeuk.local>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-8-jaegeuk@kernel.org>
	<a32a776f-00a3-740b-5b62-7137250f4531@huawei.com>
	<f450fd45-1cf9-1969-007e-7cd72b614e08@huawei.com>
	<20170105194604.GA2064@jaegeuk.local>
	<97193665-85ae-268f-c50c-8b29bc4b57c7@huawei.com>
	<20170106024238.GA6605@jaegeuk.local>
	<509c4a9c-5bf1-a699-7a9b-7d3494dc0861@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgeGM-0008SB-Sj
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 21:15:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgeGL-0007uh-BU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 21:15:50 +0000
Content-Disposition: inline
In-Reply-To: <509c4a9c-5bf1-a699-7a9b-7d3494dc0861@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 02/22, Chao Yu wrote:
> On 2017/1/6 10:42, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On 01/06, Chao Yu wrote:
> >> On 2017/1/6 3:46, Jaegeuk Kim wrote:
> >>> On 01/05, Chao Yu wrote:
> >>>> On 2017/1/4 17:29, Chao Yu wrote:
> >>>>> On 2016/12/31 2:51, Jaegeuk Kim wrote:
> >>>>>> This patch relaxes async discard commands to avoid waiting its end_io during
> >>>>>> checkpoint.
> >>>>>> Instead of waiting them during checkpoint, it will be done when actually reusing
> >>>>>> them.
> >>>>>>
> >>>>>> Test on initial partition of nvme drive.
> >>>>>>
> >>>>>>  # time fstrim /mnt/test
> >>>>>>
> >>>>>> Before : 6.158s
> >>>>>> After : 4.822s
> >>>>>>
> >>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>
> >>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>>>>
> >>>>> One comment below,
> >>>>
> >>>> I still have a comment on this patch.
> >>>>
> >>>>>> -void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
> >>>>>> +/* This should be covered by global mutex, &sit_i->sentry_lock */
> >>>>>> +void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, unsigned int segno)
> >>>>>>  {
> >>>>>>  	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
> >>>>>>  	struct bio_entry *be, *tmp;
> >>>>>> @@ -646,7 +650,15 @@ void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
> >>>>>>  		struct bio *bio = be->bio;
> >>>>>>  		int err;
> >>>>>>  
> >>>>>> -		wait_for_completion_io(&be->event);
> >>>>>> +		if (!completion_done(&be->event)) {
> >>>>>> +			if ((be->start_segno >= segno &&
> >>>>>> +					be->end_segno <= segno) ||
> >>>>>
> >>>>> segno >= be->start_segno && segno < be->end_segno ?
> >>
> >> Still can not understand this judgment condition, we should wait completion of
> >> discard command only when segno is locate in range of [start_segno, end_segno]?
> >>
> >> But now, this condition can be true only when segno, start_segno, end_segno have
> >> equal value.
> >>
> >> Please correct me if I'm wrong.
> > 
> > Urg. I rewrote it to use block addresses.
> > 
> > How about this?
> > 
> >>From fe24461eedd62815e0c56317f010a3a6e3004434 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Thu, 29 Dec 2016 14:07:53 -0800
> > Subject: [PATCH] f2fs: relax async discard commands more
> > 
> > This patch relaxes async discard commands to avoid waiting its end_io during
> > checkpoint.
> > Instead of waiting them during checkpoint, it will be done when actually reusing
> > them.
> > 
> > Test on initial partition of nvme drive.
> > 
> >  # time fstrim /mnt/test
> > 
> > Before : 6.158s
> > After : 4.822s
> 
> We should wait for completion of all discard IOs in fstrim, since we can't
> guarantee discard command can be handled successfully by device after we return
> success to caller. Right?

Do we have to guarantee? I think trim commands just try to give a hint to flash
storage for its healthier status, since it doesn't hurt filesystem consistency
and device/filesystem can freely ignore the commands as well.
If we want to guarantee discarding region, we may need to issue BLKSECDISCARD.

Thanks,

> 
> Thanks,
> 
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c |  7 ++-----
> >  fs/f2fs/f2fs.h       |  4 +++-
> >  fs/f2fs/segment.c    | 23 +++++++++++++++++++----
> >  fs/f2fs/super.c      |  3 +++
> >  4 files changed, 27 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index f73ee9534d83..1a9ba69a22ba 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1254,7 +1254,6 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  		f2fs_bug_on(sbi, prefree_segments(sbi));
> >  		flush_sit_entries(sbi, cpc);
> >  		clear_prefree_segments(sbi, cpc);
> > -		f2fs_wait_all_discard_bio(sbi);
> >  		unblock_operations(sbi);
> >  		goto out;
> >  	}
> > @@ -1273,12 +1272,10 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  
> >  	/* unlock all the fs_lock[] in do_checkpoint() */
> >  	err = do_checkpoint(sbi, cpc);
> > -	if (err) {
> > +	if (err)
> >  		release_discard_addrs(sbi);
> > -	} else {
> > +	else
> >  		clear_prefree_segments(sbi, cpc);
> > -		f2fs_wait_all_discard_bio(sbi);
> > -	}
> >  
> >  	unblock_operations(sbi);
> >  	stat_inc_cp_count(sbi->stat_info);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index bdcfe2a9b532..e0db895fd84c 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -183,6 +183,8 @@ struct discard_entry {
> >  
> >  struct bio_entry {
> >  	struct list_head list;
> > +	block_t lstart;
> > +	block_t len;
> >  	struct bio *bio;
> >  	struct completion event;
> >  	int error;
> > @@ -2111,7 +2113,7 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *, bool);
> >  void invalidate_blocks(struct f2fs_sb_info *, block_t);
> >  bool is_checkpointed_data(struct f2fs_sb_info *, block_t);
> >  void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
> > -void f2fs_wait_all_discard_bio(struct f2fs_sb_info *);
> > +void f2fs_wait_discard_bio(struct f2fs_sb_info *, block_t);
> >  void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
> >  void release_discard_addrs(struct f2fs_sb_info *);
> >  int npages_for_summary_flush(struct f2fs_sb_info *, bool);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 485b9118b418..672bcdefe836 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -625,20 +625,23 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
> >  }
> >  
> >  static struct bio_entry *__add_bio_entry(struct f2fs_sb_info *sbi,
> > -							struct bio *bio)
> > +			struct bio *bio, block_t lstart, block_t len)
> >  {
> >  	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
> >  	struct bio_entry *be = f2fs_kmem_cache_alloc(bio_entry_slab, GFP_NOFS);
> >  
> >  	INIT_LIST_HEAD(&be->list);
> >  	be->bio = bio;
> > +	be->lstart = lstart;
> > +	be->len = len;
> >  	init_completion(&be->event);
> >  	list_add_tail(&be->list, wait_list);
> >  
> >  	return be;
> >  }
> >  
> > -void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
> > +/* This should be covered by global mutex, &sit_i->sentry_lock */
> > +void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
> >  {
> >  	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
> >  	struct bio_entry *be, *tmp;
> > @@ -647,7 +650,15 @@ void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
> >  		struct bio *bio = be->bio;
> >  		int err;
> >  
> > -		wait_for_completion_io(&be->event);
> > +		if (!completion_done(&be->event)) {
> > +			if ((be->lstart <= blkaddr &&
> > +					blkaddr < be->lstart + be->len) ||
> > +					blkaddr == NULL_ADDR)
> > +				wait_for_completion_io(&be->event);
> > +			else
> > +				continue;
> > +		}
> > +
> >  		err = be->error;
> >  		if (err == -EOPNOTSUPP)
> >  			err = 0;
> > @@ -675,6 +686,7 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
> >  		struct block_device *bdev, block_t blkstart, block_t blklen)
> >  {
> >  	struct bio *bio = NULL;
> > +	block_t lblkstart = blkstart;
> >  	int err;
> >  
> >  	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
> > @@ -689,7 +701,8 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
> >  				SECTOR_FROM_BLOCK(blklen),
> >  				GFP_NOFS, 0, &bio);
> >  	if (!err && bio) {
> > -		struct bio_entry *be = __add_bio_entry(sbi, bio);
> > +		struct bio_entry *be = __add_bio_entry(sbi, bio,
> > +						lblkstart, blklen);
> >  
> >  		bio->bi_private = be;
> >  		bio->bi_end_io = f2fs_submit_bio_wait_endio;
> > @@ -1575,6 +1588,8 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >  
> >  	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
> >  
> > +	f2fs_wait_discard_bio(sbi, *new_blkaddr);
> > +
> >  	/*
> >  	 * __add_sum_entry should be resided under the curseg_mutex
> >  	 * because, this function updates a summary entry in the
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index f3697f97e527..461c29043aec 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -770,6 +770,9 @@ static void f2fs_put_super(struct super_block *sb)
> >  		write_checkpoint(sbi, &cpc);
> >  	}
> >  
> > +	/* be sure to wait for any on-going discard commands */
> > +	f2fs_wait_discard_bio(sbi, NULL_ADDR);
> > +
> >  	/* write_checkpoint can update stat informaion */
> >  	f2fs_destroy_stats(sbi);
> >  
> > 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
