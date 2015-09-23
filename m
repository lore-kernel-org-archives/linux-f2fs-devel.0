From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Thu, 24 Sep 2015 01:39:38 +0200
Message-ID: <20150923233937.GE3463@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<20150923220823.GE36564@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zetda-0001X8-Oe
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:39:46 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZetdZ-0005q7-GW
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:39:46 +0000
Content-Disposition: inline
In-Reply-To: <20150923220823.GE36564@jaegeuk-mac02.mot.com>
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

On Wed, Sep 23, 2015 at 03:08:23PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >    root@shag:/sys/fs/f2fs/dm-1# df -H /mnt
> >    Filesystem                Size  Used Avail Use% Mounted on
> >    /dev/mapper/vg_test-test  138G  137G  803k 100% /mnt
> 
> Could you please share /sys/kernel/debug/f2fs/status?

Uh, sorry, I planned to, but forgot, probably because I thought the result
was so good it didn't need any checking :)

> So, I'm convinced that your inital test set "-o1 -s128", which was an unlucky
> trial. :)

hmm... since the point is to simulate a full 8TB partition, having large
overprovision/reserved space AND large section size might actually have been
a good test, as it would simulate the TB case better, which would also have
larger overprovisioning and the larger section size.

In the end, I might settle with -s64, and currently do tests with -s90.

I was just scared that overprovisioning might turn out ot be extremely large
with 8TB.

I have since then dropped -o from all my mkfs.f2fs invocations, seeing
that the resulting filesystem does not actually have 5% overprovisioning.

> Subject: [PATCH] mkfs.f2fs: fix wrong ovp space calculation on large section

Hmm, the latest change in
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git is from
august 10 - do I need to select a branch (I am not good with git)?

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
