From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: blog article about f2fs on smr drives
Date: Mon, 19 Oct 2015 18:43:36 +0800
Message-ID: <014601d10a5b$173a6660$45af3320$@samsung.com>
References: <20151008135635.GA5459@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Zo7vR-00065s-Ee
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 10:44:21 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zo7vP-0001fR-Gm
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 10:44:21 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NWG0044UR5NVQ70@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 19:44:12 +0900 (KST)
In-reply-to: <20151008135635.GA5459@schmorp.de>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Hello,

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Thursday, October 08, 2015 9:57 PM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] blog article about f2fs on smr drives
> 
> Hi!
> 
> I write a short and very preliminary blog article about hoe to get SMR drives
> to work, fast, with f2fs.
> 
>    http://blog.schmorp.de/2015-10-08-smr-archive-drives-fast-now.html

Really nice experience sharing!

> 
> This is just a heads up - due to external events, I haven't been able to
> look into new developments (such as background_gc=sync), which look evry
> exciting, but I think this informastion needs to get out, as there are a
> lot of people who suffer badly with these drives, mostly due to kernel
> issues, but of course also due to the filesystem situation.

I have tracked your IO trace log, I found an issue which may slow down our
App, so I wrote the patch to optimize the flow mainly for SMR drive.
I think we can tune up with /sys/fs/f2fs/(device)/ra_nid_pages to avoid long
latency of creating node in f2fs.

If you want to have a test with the new tunable parameter, last git tree is
preferred. :)

Thanks,

> 
> --
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
