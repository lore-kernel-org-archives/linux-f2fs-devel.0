From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: blog article about f2fs on smr drives
Date: Thu, 8 Oct 2015 17:45:11 -0700
Message-ID: <20151009004511.GB36104@jaegeuk-mac02.mot.com>
References: <20151008135635.GA5459@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZkLoI-0001Mf-Eb
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Oct 2015 00:45:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZkLoH-0007xq-DF for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Oct 2015 00:45:22 +0000
Content-Disposition: inline
In-Reply-To: <20151008135635.GA5459@schmorp.de>
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

On Thu, Oct 08, 2015 at 03:56:35PM +0200, Marc Lehmann wrote:
> Hi!
> 
> I write a short and very preliminary blog article about hoe to get SMR drives
> to work, fast, with f2fs.
> 
>    http://blog.schmorp.de/2015-10-08-smr-archive-drives-fast-now.html
> 
> This is just a heads up - due to external events, I haven't been able to
> look into new developments (such as background_gc=sync), which look evry
> exciting, but I think this informastion needs to get out, as there are a
> lot of people who suffer badly with these drives, mostly due to kernel
> issues, but of course also due to the filesystem situation.

Cool and pretty much interesting topic to me!

BTW, it might be best to publish this kind of investigation as papers or
presentation later.

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
