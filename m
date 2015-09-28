From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH v2] f2fs: fix to correct freed section number during gc
Date: Mon, 28 Sep 2015 17:40:43 +0800
Message-ID: <006d01d0f9d1$d61bc690$825353b0$@samsung.com>
References: <01c001d0f777$c4c973d0$4e5c5b70$@samsung.com>
 <20150925180417.GB6269@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150925180417.GB6269@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, September 26, 2015 2:04 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] f2fs: fix to correct freed section number during gc
> 
> On Fri, Sep 25, 2015 at 05:50:55PM +0800, Chao Yu wrote:
> > This patch fixes to maintain the right section count freed in garbage
> > collecting when triggering a foreground gc.
> >
> > Besides, when a foreground gc is running on current selected section, once
> > we fail to gc one segment, it's better to abandon gcing the left segments
> > in current section, because anyway we will select next victim for
> > foreground gc, so gc on the left segments in previous section will become
> > overhead and also cause the long latency for caller.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> > v2:
> >  o avoid calc the wrong value when freed segments across sections.
> >  fs/f2fs/gc.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e932740..256ebd4 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -802,7 +802,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
> >  	unsigned int segno = NULL_SEGNO;
> >  	unsigned int i;
> >  	int gc_type = BG_GC;
> > -	int nfree = 0;
> > +	int sec_freed = 0, seg_freed;
> >  	int ret = -1;
> >  	struct cp_control cpc;
> >  	struct gc_inode_list gc_list = {
> > @@ -817,7 +817,7 @@ gc_more:
> >  	if (unlikely(f2fs_cp_error(sbi)))
> >  		goto stop;
> >
> > -	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
> > +	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed)) {
> >  		gc_type = FG_GC;
> >  		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
> >  			write_checkpoint(sbi, &cpc);
> > @@ -833,13 +833,25 @@ gc_more:
> >  		ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno), sbi->segs_per_sec,
> >  								META_SSA);
> >
> > -	for (i = 0; i < sbi->segs_per_sec; i++)
> > -		nfree += do_garbage_collect(sbi, segno + i, &gc_list, gc_type);
> > +	for (i = 0, seg_freed = 0; i < sbi->segs_per_sec; i++) {
> > +		/*
> > +		 * for FG_GC case, halt gcing left segments once failed one
> > +		 * of segments in selected section to avoid long latency.
> > +		 */
> > +		if (!do_garbage_collect(sbi, segno + i, &gc_list, gc_type) &&
> > +				gc_type == FG_GC)
> > +			break;
> > +		if (gc_type == FG_GC)
> > +			seg_freed++;
> > +	}
> 
> How about?
> 
> 	if (i == sbi->segs_per_sec && gc_type == FG_GC)
> 		sec_free++;

I'll update it. See the following v3 patch.

Thanks,

> 
> > +
> > +	if (seg_freed == sbi->segs_per_sec)
> > +		sec_freed++;
> >
> >  	if (gc_type == FG_GC)
> >  		sbi->cur_victim_sec = NULL_SEGNO;
> >
> > -	if (has_not_enough_free_secs(sbi, nfree))
> > +	if (has_not_enough_free_secs(sbi, sec_freed))
> >  		goto gc_more;
> >
> >  	if (gc_type == FG_GC)
> > --
> > 2.5.2
