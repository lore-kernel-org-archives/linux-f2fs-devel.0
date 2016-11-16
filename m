From: "HUANG Weller (CM/ESW12-CN)" <Weller.Huang@cn.bosch.com>
Subject: Re: F2FS still EXPERIMENTAL
Date: Wed, 16 Nov 2016 01:45:06 +0000
Message-ID: <c9e76c2b03dc4dbcbb24bc5c101bb0d4@SGPMBX1004.APAC.bosch.com>
References: <e565c64ec1e345d9ae0e507880a5f2b5@SGPMBX1004.APAC.bosch.com>
	<20161115062948.GA40446@jaegeuk>
	<7d3b52f7cc84431f81748ccb2de9b4fe@SGPMBX1004.APAC.bosch.com>
	<20161115183853.GA45096@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Weller.Huang@cn.bosch.com>) id 1c6pHr-0006pN-IA
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 01:45:19 +0000
Received: from smtp6-v.fe.bosch.de ([139.15.237.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c6pHp-00015E-TR
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 01:45:19 +0000
In-Reply-To: <20161115183853.GA45096@jaegeuk>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

> > > > I am working on the kernel 3.14. I found the  F2FS still EXPERIMENTAL.
> > > > Could you tell me from which kernel version the f2fs is stable version ?
> > >
> > > You can pick a backported f2fs from:
> > >
> > > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-stable.git
> >
> > Thanks for your info.
> > But I didn't see there is a branch for linux-3.14.y. Does it mean I could not use
> the f2fs-stable on 3.14 kernel ?
> 
> Do you have a chance to change your kernel version?

> I've been already maintaining 5 versions actively for android targets, so I'm not
> sure I can add one more kernel version for your experiment purpose. I guess it'd
> not much difficult to make v3.14 based on v3.18 in f2fs-stable.

Hi Kim,
Yes, it is experiment purpose for future. So it doesn't make sense to add one more kernel version on your side.
I can first follow your suggestion to use f2fs from 3.18.
And thanks a lot for your information. 

> Thanks,
> 
> >
> > Huang Weller
> >
> > ----------------------------------------------------------------------
> > -------- _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
