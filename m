From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Multiple Devices
Date: Thu, 23 Feb 2017 14:59:10 -0800
Message-ID: <20170223225910.GI2026@jaegeuk.local>
References: <CALRD3qKBZnj5Hfd_Ka_htPFB1za3Uz+w8C71qLdgFKPfqffCiQ@mail.gmail.com>
	<20170223212935.GF2026@jaegeuk.local>
	<CALRD3q+Lat9SxGJzTDjr=XLwTzAU9oEaovfTiDYr1rMjYwkYvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ch2M4-0007hc-Po
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 22:59:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ch2M4-0004Kf-11
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 22:59:20 +0000
Content-Disposition: inline
In-Reply-To: <CALRD3q+Lat9SxGJzTDjr=XLwTzAU9oEaovfTiDYr1rMjYwkYvA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: riya khanna <riyakhanna1983@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 02/23, riya khanna wrote:
> Thanks! I will give it a try.
> 
> Does it also move blocks from one device to another in the background?

Not yet, we've been working on it.

Thanks,

> 
> On Thu, Feb 23, 2017 at 4:29 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > On 02/23, riya khanna wrote:
> >> Hi,
> >>
> >>
> >> I see support for multiple devices in f2fs-tools. Can f2fs be mounted
> >> on multiple devices?
> >
> > Yup, v4.10 starts to support it.
> >
> > Thanks,
> >
> >>
> >> -Riya
> >>
> >> ------------------------------------------------------------------------------
> >> Check out the vibrant tech community on one of the world's most
> >> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
