From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: introduce FITRIM in f2fs_ioctl
Date: Wed, 1 Oct 2014 08:07:14 -0700
Message-ID: <20141001150714.GB24084@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1411447990-37919-1-git-send-email-jaegeuk@kernel.org>
	<1411447990-37919-2-git-send-email-jaegeuk@kernel.org>
	<006001cfdc74$178dcdc0$46a96940$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XZLUt-0006Ee-U7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Oct 2014 15:07:19 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XZLUr-00078a-OB for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Oct 2014 15:07:19 +0000
Content-Disposition: inline
In-Reply-To: <006001cfdc74$178dcdc0$46a96940$@samsung.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Sep 30, 2014 at 02:01:58PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, September 23, 2014 12:53 PM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 2/3] f2fs: introduce FITRIM in f2fs_ioctl
> > 
> > This patch introduces FITRIM in f2fs_ioctl.
> > In this case, f2fs will issue small discards and prefree discards as many as
> > possible for the given area.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Looks good!
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
> > +
> >  	/* zero block will be discarded through the prefree list */
> >  	if (!se->valid_blocks || se->valid_blocks == max_blocks)
> >  		return;
> > 
> > +	dmap = kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> 
> We can afford 64 bytes allocation in stack, how about altering dmap to a local
> array to reduce memory pressure at that moment and avoid delay of allocation?

It's not a big deal.
Fixed.
Thanks,

> 
> > +	if (!dmap)
> > +		return;
> > +

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
