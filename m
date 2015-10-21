From: Josh Dener <denerjosh@yahoo.com>
Subject: Re: Reservation amount
Date: Wed, 21 Oct 2015 20:27:30 +0000 (UTC)
Message-ID: <1035949239.1178810.1445459250089.JavaMail.yahoo@mail.yahoo.com>
References: <028101d10bc2$600e83e0$202b8ba0$@samsung.com>
Reply-To: Josh Dener <denerjosh@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <denerjosh@yahoo.com>) id 1Zp01z-0001WF-Qv
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Oct 2015 20:30:43 +0000
Received: from nm34-vm6.bullet.mail.ne1.yahoo.com ([98.138.229.86])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zp01y-0007c5-Nj
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Oct 2015 20:30:43 +0000
In-Reply-To: <028101d10bc2$600e83e0$202b8ba0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi,


The explanation makes sense to me too, however I have two concerns:

* For this to work, you need to choose as victim the segment with the least valid blocks. But I think the search space is always limited by max_victim_search. So you can choose a bunch of segments with 99% valid blocks, even if there are segments with 1% valid blocks elsewhere.

* There should be a limit for the new fractional overprovisioning. With 0.01% OVP you don't need 20000 segments. ~1024 should always suffice (times segs_per_sec).

Thanks,


On Wednesday, October 21, 2015 5:36 AM, Chao Yu <chao2.yu@samsung.com> wrote:
> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, October 21, 2015 2:32 AM
> To: Chao Yu
> Cc: 'Chao Yu'; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] Reservation amount
> 
> On Tue, Oct 20, 2015 at 11:31:45PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Tuesday, October 20, 2015 2:59 AM
> > > To: Chao Yu; Chao Yu
> > > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] Reservation amount
> > >
> > > Hello,
> > >
> > > On Mon, Oct 19, 2015 at 06:44:40PM +0800, Chao Yu wrote:
> > > > Hi Jaegeuk,
> > > >
> > > > > -----Original Message-----
> > > > > From: Josh Dener [mailto:denerjosh@yahoo.com]
> > > > > Sent: Sunday, October 18, 2015 12:58 PM
> > > > > To: linux-f2fs-devel@lists.sourceforge.net
> > > > > Subject: [f2fs-dev] Reservation amount
> > > > >
> > > > > Hi,
> > > > >
> > > > > Where does this formula come from?
> > > > >
> > > > >
> > > > > config.reserved_segments =
> > > > >
> > > > >     (2 * (100 / config.overprovision + 1) + 6)
> > >
> > > What I've intended here was to handle the worst case of foreground gc.
> > > If a data segment is selected as a victim, all the valid data blocks would be
> > > migrated, resulting in producing a same number of dirty node blocks in the worse
> > > case. Then, checkpoint should write such the node blocks in order to reclaim the
> > > prefree segments accordingly. Therefore, we require x2 segments.
> > > 6 means the number of active segments, which is actually not a exact number
> > > though. :)
> >
> > Ah, I see, but one more thing is why using (100 / config.overprovision) as
> > the base segment number of reserved segments calculation? Let me guess, is
> > that not accurate too? the intention here is to balance in between ovp and
> > rsv segments number, not leading the (ovp + rsv) number higher? :)
> 
> For example, if ovp is 20%, we select 5 victim segments to reclaim one free
> segment in the worst case. During this migration, we need additional 4 free
> segments to write valid blocks in the victim segments.
> Other remaining added segments are just to keep as a buffer to prepare any
> abnormal situation.

I can understand now, if ovp is 20%, in worst case, each potential victim
segment may contain ~4/5 * blk_per_seg valid blocks, so we will write all
blocks (4/5 * blk_per_seg * 5) of 5 selected victim segments to reserved
4 segments, eventually we can reclaim one free segment.

So actually '100 / config.overprovision' is used to calculate the victim
segment number which we can reclaim one free segment from in the worst case.

Thanks a lot for your explanation! :)


Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > >
> > > Thanks,
> > >
> > > >
> > > > I'm interest in this too, could you sharing more detail about policy
> > > > of overprovision and reserved space calculation?
> > > >
> > > > Thanks,
> > > >
> > > > >
> > > > >
> > > > > Is there a formal justification for it?
> > > > >
> > > > > Thanks.
> > > > >
> > > > > ------------------------------------------------------------------------------
> > > > > _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
