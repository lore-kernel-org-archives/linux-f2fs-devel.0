From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Thu, 24 Sep 2015 01:30:22 +0200
Message-ID: <20150923233022.GD3463@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<011201d0f5dd$c3a4f650$4aeee2f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZetUc-0001HG-9e
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:30:30 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZetUb-0005dF-49
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:30:30 +0000
Content-Disposition: inline
In-Reply-To: <011201d0f5dd$c3a4f650$4aeee2f0$@samsung.com>
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
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Wed, Sep 23, 2015 at 04:55:57PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> >    echo 1 >gc_idle
> >    echo 1000 >gc_max_sleep_time
> >    echo 5000 >gc_no_gc_sleep_time
> 
> One thing I note is that gc_min_sleep_time is not be set in your script,
> so in some condition gc may still do the sleep with gc_min_sleep_time (30
> seconds by default) instead of gc_max_sleep_time which we expect.

Ah, sorry, I actually set gc_min_sleep_time to 100, but forgot to include
it.

> In 4.3 rc1 kernel, we have add a new ioctl to trigger in batches gc, maybe
> we can use it as one option.

Yes, such an ioctl could be useful to me, although I do not intend to have
background gc off.

I assume that the ioctl will block for the time it runs, and I can ask it
to do up to 16 batches in one go (by default)? That sounds indeed very
useful to have.

What is "one batch" in terms of gc, one section?

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
