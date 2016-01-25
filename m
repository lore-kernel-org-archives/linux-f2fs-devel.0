From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix to overcome inline_data floods
Date: Mon, 25 Jan 2016 11:15:21 -0800
Message-ID: <20160125191521.GA12183@jaegeuk.gateway>
References: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
	<1453580148-61861-2-git-send-email-jaegeuk@kernel.org>
	<000e01d15755$bb6b1990$32414cb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aNmbv-0005eh-17
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 19:15:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNmbt-0004vm-B1 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 19:15:35 +0000
Content-Disposition: inline
In-Reply-To: <000e01d15755$bb6b1990$32414cb0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Mon, Jan 25, 2016 at 05:49:06PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Sunday, January 24, 2016 4:16 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to overcome inline_data floods
> > 
> > The scenario is:
> > 1. create lots of node blocks
> > 2. sync
> > 3. write lots of inline_data
> > -> got panic due to no free space
> > 
> > In that case, we should flush node blocks when writing inline_data in #3,
> > and trigger gc as well.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/gc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 0204433..8686231 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -838,8 +838,15 @@ gc_more:
> > 
> >  	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed)) {
> >  		gc_type = FG_GC;
> > +		/*
> > +		 * If there is no victim and no prefree segment but still not
> > +		 * enough free sections, we should flush dent/node blocks and do
> > +		 * garbage collections.
> > +		 */
> >  		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
> >  			write_checkpoint(sbi, &cpc);
> > +		else if (has_not_enough_free_secs(sbi, 0))
> 
> I think this condition make checkpoint been triggered more frequently,
> could we trigger cp when dent/node block exceed some threshold?

This only happens when there is no victim, no prefree, and no enough free secs,
which is very corner case.
In addition, IMO, this condition is actually to resolve the inline_data issue.

Thanks,

> 
> Thanks,
> 
> > +			write_checkpoint(sbi, &cpc);
> >  	}
> > 
> >  	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
> > --
> > 2.6.3
> > 
> > 
> > ------------------------------------------------------------------------------
> > Site24x7 APM Insight: Get Deep Visibility into Application Performance
> > APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> > Monitor end-to-end web transactions and take corrective actions now
> > Troubleshoot faster and improve end-user experience. Signup Now!
> > http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
