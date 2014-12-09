From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev][PATCH 3/4] f2fs: readahead contiguous current summary
 blocks in checkpoint
Date: Tue, 09 Dec 2014 14:14:22 +0800
Message-ID: <002201d01377$8709b260$951d1720$@samsung.com>
References: <001a01d012b4$dfe9d040$9fbd70c0$@samsung.com>
 <20141208190924.GB18956@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141208190924.GB18956@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 09, 2014 3:09 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH 3/4] f2fs: readahead contiguous current summary blocks in
> checkpoint
> 
> Hi Chao,
> 
> On Mon, Dec 08, 2014 at 03:01:16PM +0800, Chao Yu wrote:
> > Let's add readahead code for reading contiguous compact/normal summary blocks
> > in checkpoint, then we will gain better performance in mount procedure.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/checkpoint.c |  2 +-
> >  fs/f2fs/f2fs.h       |  2 +-
> >  fs/f2fs/segment.c    | 21 ++++++++++++++++++---
> >  3 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index e0ff75e..aa2a21c 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -915,7 +915,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control
> *cpc)
> >  	ckpt->next_free_nid = cpu_to_le32(last_nid);
> >
> >  	/* 2 cp  + n data seg summary + orphan inode blocks */
> > -	data_sum_blocks = npages_for_summary_flush(sbi);
> > +	data_sum_blocks = npages_for_summary_flush(sbi, false);
> >  	if (data_sum_blocks < NR_CURSEG_DATA_TYPE)
> >  		set_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
> >  	else
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index d042813..fc88e8a 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1393,7 +1393,7 @@ void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
> >  void clear_prefree_segments(struct f2fs_sb_info *);
> >  void release_discard_addrs(struct f2fs_sb_info *);
> >  void discard_next_dnode(struct f2fs_sb_info *, block_t);
> > -int npages_for_summary_flush(struct f2fs_sb_info *);
> > +int npages_for_summary_flush(struct f2fs_sb_info *, bool);
> >  void allocate_new_segments(struct f2fs_sb_info *);
> >  int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
> >  struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 9a33e34..e3bec6e 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -731,7 +731,7 @@ static void __add_sum_entry(struct f2fs_sb_info *sbi, int type,
> >  /*
> >   * Calculate the number of current summary pages for writing
> >   */
> > -int npages_for_summary_flush(struct f2fs_sb_info *sbi)
> > +int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
> >  {
> >  	int valid_sum_count = 0;
> >  	int i, sum_in_page;
> > @@ -739,8 +739,13 @@ int npages_for_summary_flush(struct f2fs_sb_info *sbi)
> >  	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
> >  		if (sbi->ckpt->alloc_type[i] == SSR)
> >  			valid_sum_count += sbi->blocks_per_seg;
> > -		else
> > -			valid_sum_count += curseg_blkoff(sbi, i);
> > +		else {
> > +			if (unlikely(for_ra))
> 
> IMO, unlikely is not appropriate for here.

I suppose that for readonly f2fs image, unlikely is not appropriate, as
we always execute the if part when mount.
Anyway, I will remove this and resend the patch.
Thanks for your review!

Regards,
Yu

> 
> Thanks,
