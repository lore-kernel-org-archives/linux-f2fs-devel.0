From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: disable roll-forward when active_logs
 = 2
Date: Wed, 12 Nov 2014 07:43:12 +0900
Message-ID: <20141111224312.GA16657@lcm>
References: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
 <20141110095437.GE14659@lcm>
 <20141110150759.GB25172@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20141110150759.GB25172@jaegeuk-mac02.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Nov 10, 2014 at 07:07:59AM -0800, Jaegeuk Kim wrote:
> Hi Changman,
> 
> On Mon, Nov 10, 2014 at 06:54:37PM +0900, Changman Lee wrote:
> > On Sat, Nov 08, 2014 at 11:36:05PM -0800, Jaegeuk Kim wrote:
> > > The roll-forward mechanism should be activated when the number of active
> > > logs is not 2.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/file.c    | 2 ++
> > >  fs/f2fs/segment.c | 4 ++--
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 46311e7..54722a0 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -132,6 +132,8 @@ static inline bool need_do_checkpoint(struct inode *inode)
> > >  		need_cp = true;
> > >  	else if (test_opt(sbi, FASTBOOT))
> > >  		need_cp = true;
> > > +	else if (sbi->active_logs == 2)
> > > +		need_cp = true;
> > >  
> > >  	return need_cp;
> > >  }
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 2fb3d7f..16721b5d 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -1090,8 +1090,8 @@ static int __get_segment_type_4(struct page *page, enum page_type p_type)
> > >  		else
> > >  			return CURSEG_COLD_DATA;
> > >  	} else {
> > > -		if (IS_DNODE(page) && !is_cold_node(page))
> > > -			return CURSEG_HOT_NODE;
> > > +		if (IS_DNODE(page) && is_cold_node(page))
> > > +			return CURSEG_WARM_NODE;
> > 
> > Hi Jaegeuk,
> > 
> > We should take hot/cold seperation into account as well.
> > In case of dir inode, it will be mixed with COLD_NODE.
> > If it's trade-off, let's notice it kindly as comments.
> 
> NAK.
> This patch tries to fix a bug, which is not a trade-off.
> We should write files' direct node blocks in CURSEG_WARM_NODE for recovery.
> 
> Thanks,

Okay, a word of 'trade-off' is wrong. We must be able to do recovery.
However, we break a rule of hot/cold separation we want. So I thought we
should notice its negative effect.
Anyway, how about putting WARM and HOT together instead HOT and COLD?
We can distinguish enough if they are direct node and have fsync_mark at
recovery time although HOT/WARM are mixed.
Let me know if there is my misundertanding.

Thanks,

> 
> > 
> > Regards,
> > Changman
> > 
> > >  		else
> > >  			return CURSEG_COLD_NODE;
> > >  	}
> > > -- 
> > > 2.1.1
> > > 
> > > 
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
