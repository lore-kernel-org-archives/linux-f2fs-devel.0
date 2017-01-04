From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 01/10] f2fs: reassign new segment for mode=lfs
Date: Wed, 4 Jan 2017 14:48:27 -0800
Message-ID: <20170104224827.GB1011@jaegeuk.local>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <702b01ba-5fcb-01a2-0bad-65ea9005b834@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <702b01ba-5fcb-01a2-0bad-65ea9005b834@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/04, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/12/31 2:51, Jaegeuk Kim wrote:
> > Otherwise we can remain wrong curseg->next_blkoff, resulting in fsck failure.
> 
> Could you explain more about this case?

I remember that I hit an fsck failure when I was testing f2fs with an smr drive.
I didn't dig into the error, but the fact is that our roll-forward recovery
doesn't update current segment information at every time, but allocate a new
section at the end of the work like below.
I just enabled it for the LFS mode in order to avoid that failure.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index be9e4d244d75..4e5ffe1d97e4 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1428,9 +1428,6 @@ void allocate_new_segments(struct f2fs_sb_info *sbi)
> >  	unsigned int old_segno;
> >  	int i;
> >  
> > -	if (test_opt(sbi, LFS))
> > -		return;
> > -
> >  	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
> >  		curseg = CURSEG_I(sbi, i);
> >  		old_segno = curseg->segno;
> > 
