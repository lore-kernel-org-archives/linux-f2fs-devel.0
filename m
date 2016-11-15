From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: F2FS still EXPERIMENTAL
Date: Tue, 15 Nov 2016 10:38:53 -0800
Message-ID: <20161115183853.GA45096@jaegeuk>
References: <e565c64ec1e345d9ae0e507880a5f2b5@SGPMBX1004.APAC.bosch.com>
	<20161115062948.GA40446@jaegeuk>
	<7d3b52f7cc84431f81748ccb2de9b4fe@SGPMBX1004.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c6idK-0004D3-RN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Nov 2016 18:39:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c6idJ-0003HH-NS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Nov 2016 18:39:02 +0000
Content-Disposition: inline
In-Reply-To: <7d3b52f7cc84431f81748ccb2de9b4fe@SGPMBX1004.APAC.bosch.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "HUANG Weller (CM/ESW12-CN)" <Weller.Huang@cn.bosch.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On Tue, Nov 15, 2016 at 09:59:25AM +0000, HUANG Weller (CM/ESW12-CN) wrote:
> > Hello,
> > 
> > On Tue, Nov 15, 2016 at 05:45:12AM +0000, HUANG Weller (CM/ESW12-CN) wrote:
> > > Hi  f2fs developers,
> > >
> > > I am working on the kernel 3.14. I found the  F2FS still EXPERIMENTAL.
> > > Could you tell me from which kernel version the f2fs is stable version ?
> > 
> > You can pick a backported f2fs from:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-stable.git
> 
> Thanks for your info. 
> But I didn't see there is a branch for linux-3.14.y. Does it mean I could not use the f2fs-stable on 3.14 kernel ?

Do you have a chance to change your kernel version?

I've been already maintaining 5 versions actively for android targets, so I'm
not sure I can add one more kernel version for your experiment purpose. I guess
it'd not much difficult to make v3.14 based on v3.18 in f2fs-stable.

Thanks,

> 
> Huang Weller 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
