From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/5] f2fs: introduce a batched trim
Date: Thu, 29 Jan 2015 13:41:17 -0800
Message-ID: <20150129214117.GB17521@jaegeuk-mac02>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-5-git-send-email-jaegeuk@kernel.org>
 <003b01d03bc0$a5f23d20$f1d6b760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003b01d03bc0$a5f23d20$f1d6b760$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Thu, Jan 29, 2015 at 08:38:30PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: linux-fsdevel-owner@vger.kernel.org [mailto:linux-fsdevel-owner@vger.kernel.org] On
> > Behalf Of Jaegeuk Kim
> > Sent: Wednesday, January 28, 2015 7:32 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [PATCH 5/5] f2fs: introduce a batched trim
> > 
> > This patch introduces a batched trimming feature, which submits split discard
> > commands.
> 
> I didn't get it, why we should split discard commands. :(
> 
> Does smaller discarding for flash shows better performance or effect or safety?
> Can you please explain more about this patch?

This is to avoid long latency due to huge trim commands.
If fstrim was triggered ranging from 0 to the end of device, we should lock
all the checkpoint-related mutexes, resulting in very long latency.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h    |  1 +
> >  fs/f2fs/segment.c | 15 ++++++++++-----
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index c0b83d6..ec4d16b 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -104,6 +104,7 @@ enum {
> >  	CP_DISCARD,
> >  };
> > 
> > +#define BATCHED_TRIM_SEGMENTS	10
> >  struct cp_control {
> >  	int reason;
> >  	__u64 trim_start;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 31c4e57..6c9c784 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1066,14 +1066,19 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> >  	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
> >  						GET_SEGNO(sbi, end);
> >  	cpc.reason = CP_DISCARD;
> > -	cpc.trim_start = start_segno;
> > -	cpc.trim_end = end_segno;
> >  	cpc.trim_minlen = range->minlen >> sbi->log_blocksize;
> > 
> >  	/* do checkpoint to issue discard commands safely */
> > -	mutex_lock(&sbi->gc_mutex);
> > -	write_checkpoint(sbi, &cpc);
> > -	mutex_unlock(&sbi->gc_mutex);
> > +	for (; start_segno <= end_segno;
> > +				start_segno += BATCHED_TRIM_SEGMENTS + 1) {
> > +		cpc.trim_start = start_segno;
> > +		cpc.trim_end = min_t(unsigned int,
> > +				start_segno + BATCHED_TRIM_SEGMENTS, end_segno);
> > +
> > +		mutex_lock(&sbi->gc_mutex);
> > +		write_checkpoint(sbi, &cpc);
> > +		mutex_unlock(&sbi->gc_mutex);
> > +	}
> >  out:
> >  	range->len = cpc.trimmed << sbi->log_blocksize;
> >  	return 0;
> > --
> > 2.1.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
