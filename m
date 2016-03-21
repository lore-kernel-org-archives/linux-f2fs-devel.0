From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Mon, 21 Mar 2016 09:03:59 -0700
Message-ID: <20160321160359.GB6196@jaegeuk.gateway>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
	<20160321103032.GA2739@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ai2JX-0001C3-7G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 16:04:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ai2JR-0003nE-Kn
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 16:04:19 +0000
Content-Disposition: inline
In-Reply-To: <20160321103032.GA2739@schmorp.de>
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

On Mon, Mar 21, 2016 at 11:30:38AM +0100, Marc Lehmann wrote:
> On Mon, Mar 21, 2016 at 11:18:35AM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > > As you pointed out, it seems there is a bug in sanity check routine, which
> > > doesn't cover the large section case.
> > 
> > Actually, there is a bug in f2fs-tools 1.6.0, it will trigger sanity check failure
> > in f2fs kernel module since in mkfs.f2fs we will align segment_count and
> > segment_count_main with different size if parameter -s or -z is configured larger
> > than 1.
> > 
> > Following commit in dev branch of f2fs-tools has fixed this issue, could you test this
> > patch firstly?
> > ("mkfs.f2fs: set segment_count in super block correctly")
> 
> Stupid question from my side, does that mean we have to reformat existing
> volumes? Because mkfs clearly won't fix existing volumes, so fixing mkfs
> will not fix the issue.

Exactly.
The f2fs patch should be merged to take into account such the backward
compatibility.
And, I don't think wrong segment_count hurts the f2fs behavior.

Thanks,

> 
> A fix in the f2fs or fsck.f2fs would be needed for existing volumes.
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
