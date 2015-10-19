From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Reservation amount
Date: Mon, 19 Oct 2015 11:59:23 -0700
Message-ID: <20151019185923.GB23660@jaegeuk-mac02.mot.com>
References: <906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
	<906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
	<014701d10a5b$43b78f60$cb26ae20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZoFee-0008Du-8W
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:59:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZoFed-0000yI-8U for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:59:32 +0000
Content-Disposition: inline
In-Reply-To: <014701d10a5b$43b78f60$cb26ae20$@samsung.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

On Mon, Oct 19, 2015 at 06:44:40PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Josh Dener [mailto:denerjosh@yahoo.com]
> > Sent: Sunday, October 18, 2015 12:58 PM
> > To: linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] Reservation amount
> > 
> > Hi,
> > 
> > Where does this formula come from?
> > 
> > 
> > config.reserved_segments =
> > 
> >     (2 * (100 / config.overprovision + 1) + 6)

What I've intended here was to handle the worst case of foreground gc.
If a data segment is selected as a victim, all the valid data blocks would be
migrated, resulting in producing a same number of dirty node blocks in the worse
case. Then, checkpoint should write such the node blocks in order to reclaim the
prefree segments accordingly. Therefore, we require x2 segments.
6 means the number of active segments, which is actually not a exact number
though. :)

Thanks,

> 
> I'm interest in this too, could you sharing more detail about policy
> of overprovision and reserved space calculation?
> 
> Thanks,
> 
> > 
> > 
> > Is there a formal justification for it?
> > 
> > Thanks.
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
