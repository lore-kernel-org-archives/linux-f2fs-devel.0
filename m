From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs stability problems keep me from testing
Date: Fri, 20 Nov 2015 04:56:14 +0800
Message-ID: <20151119205614.GA10406@jaegeuk.local>
References: <20151117172430.GA6945@schmorp.de>
	<004b01d121e8$10563730$3102a590$@samsung.com>
	<20151119003840.GA5692@schmorp.de>
	<008e01d12269$d210c580$76325080$@samsung.com>
	<20151119022317.GA7115@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZzWFr-0007Fm-3N
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 20:56:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZzWFp-0006WW-SZ for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 20:56:31 +0000
Content-Disposition: inline
In-Reply-To: <20151119022317.GA7115@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Nov 19, 2015 at 03:23:17AM +0100, Marc Lehmann wrote:
> On Thu, Nov 19, 2015 at 09:29:29AM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > Thanks for info your sharing.
> > 
> > If fsck shows nothing problem in the disk, still can't see '/cold1/var' in
> > directory '/cold1' now?
> 
> Ah, sorry if that might not have been clear - after a reboot, fsck showed
> no errors and all files and directories (apparently) were there, i.e. it
> looks like a transient problem, not a problem of the on-disk structure.

So, it seems that the system suffers from memory pressure significantly, which
can incur ENOMEM, as I guess.
Can you catch /sys/kernel/debug/f2fs/status at that moment?

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
