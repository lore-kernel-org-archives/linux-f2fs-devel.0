From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Thu, 1 Oct 2015 14:11:20 +0200
Message-ID: <20151001121120.GA7340@schmorp.de>
References: <20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zhchv-0007V2-6c
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 12:11:31 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zhcht-0003dI-Bg
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 12:11:31 +0000
Content-Disposition: inline
In-Reply-To: <20150929231310.GA6010@jaegeuk-mac02.mot.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On Tue, Sep 29, 2015 at 04:13:10PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > First thing, the allocation-failure-on-mount is still in the backported 3.18
> > f2fs module. If it's supposed to be gone in that version, it's not working:
> > 
> > http://ue.tst.eu/a1bc4796012bd7191ab2ada566d4cd22.txt
> 
> Oops, it seems I missed some other allocations too.
> Could you pull the v3.18 again? I changed the patch.

Hmm, I don't see any relevant change in the log, but I will use the newest
version.

> > (event tracing is cool btw., thanks for showing me :)
> 
> Thank you for the below traces.
> I have two suspicious things from the traces where:
> 
> 1. several inline_data conversion of existing files
> Could you test -o noinline_data and share its trace too?

WOW, THAT HELPED A LOT. While the peak throughput seems quite a bit lower
than 3.18 stock (seems, because this might be caused by less peaky, more
smooth, writes - I am only looking at it with my eyes), it could keep up
with the reading side easily, and performance didn't degrade so far. The
test continues, but here is the trace for the first 368GB:

http://data.plan9.de/f2fs.s64.noinline.trace.xz

I had a cursory look at the previous traces, and didn't see any obvious
problem (if anything, git f2fs seems to leave fewer gaps). However, both
versions do leave quite a few gaps.

I wanted to look at reordering, which might be a problem, too, but didn't
get to that.

Obviously, inline_data was the culprit for the especially bad performance.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
