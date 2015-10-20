From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Reservation amount
Date: Tue, 20 Oct 2015 11:32:04 -0700
Message-ID: <20151020183204.GB32128@jaegeuk-mac02.mot.com>
References: <906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
	<906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
	<014701d10a5b$43b78f60$cb26ae20$@samsung.com>
	<20151019185923.GB23660@jaegeuk-mac02.mot.com>
	<COL402-EAS296A596B8869D84469F261AB390@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zobhm-0003L5-KF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Oct 2015 18:32:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zobhl-0002ej-9g for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Oct 2015 18:32:14 +0000
Content-Disposition: inline
In-Reply-To: <COL402-EAS296A596B8869D84469F261AB390@phx.gbl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchaochina@hotmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Tue, Oct 20, 2015 at 11:31:45PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, October 20, 2015 2:59 AM
> > To: Chao Yu; Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] Reservation amount
> > 
> > Hello,
> > 
> > On Mon, Oct 19, 2015 at 06:44:40PM +0800, Chao Yu wrote:
> > > Hi Jaegeuk,
> > >
> > > > -----Original Message-----
> > > > From: Josh Dener [mailto:denerjosh@yahoo.com]
> > > > Sent: Sunday, October 18, 2015 12:58 PM
> > > > To: linux-f2fs-devel@lists.sourceforge.net
> > > > Subject: [f2fs-dev] Reservation amount
> > > >
> > > > Hi,
> > > >
> > > > Where does this formula come from?
> > > >
> > > >
> > > > config.reserved_segments =
> > > >
> > > >     (2 * (100 / config.overprovision + 1) + 6)
> > 
> > What I've intended here was to handle the worst case of foreground gc.
> > If a data segment is selected as a victim, all the valid data blocks would be
> > migrated, resulting in producing a same number of dirty node blocks in the worse
> > case. Then, checkpoint should write such the node blocks in order to reclaim the
> > prefree segments accordingly. Therefore, we require x2 segments.
> > 6 means the number of active segments, which is actually not a exact number
> > though. :)
> 
> Ah, I see, but one more thing is why using (100 / config.overprovision) as
> the base segment number of reserved segments calculation? Let me guess, is
> that not accurate too? the intention here is to balance in between ovp and
> rsv segments number, not leading the (ovp + rsv) number higher? :)

For example, if ovp is 20%, we select 5 victim segments to reclaim one free
segment in the worst case. During this migration, we need additional 4 free
segments to write valid blocks in the victim segments.
Other remaining added segments are just to keep as a buffer to prepare any
abnormal situation.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > >
> > > I'm interest in this too, could you sharing more detail about policy
> > > of overprovision and reserved space calculation?
> > >
> > > Thanks,
> > >
> > > >
> > > >
> > > > Is there a formal justification for it?
> > > >
> > > > Thanks.
> > > >
> > > > ------------------------------------------------------------------------------
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
