From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 3: full 8TB partition, mount problems,
 fsck error after delete
Date: Wed, 23 Sep 2015 05:50:32 +0200
Message-ID: <20150923035032.GA4946@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150922202202.GA2456@schmorp.de>
	<20150922230850.GB31427@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zeb4t-0008Vw-0o
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 03:50:43 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zeb4q-00050o-Uh
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 03:50:42 +0000
Content-Disposition: inline
In-Reply-To: <20150922230850.GB31427@jaegeuk-mac02.mot.com>
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

On Tue, Sep 22, 2015 at 04:08:50PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Could you check without -o1, since I merged a patch to calculate the best
> overprovision at runtime in f2fs-tools.

I assume I have it, as git pull didn't give me any updates.

> For example, if you set 1%, we need to reserve 100 sections to do cleaning at
> the worse case. That's why you cannot see the reserved area as just 1% over
> total space.

Ok, I tried with -o1, -o5, and no -o switch at all:

   switch df -h "Used"
   -o1    126GiB
   -o5    384GiB
   ""     126GiB

So indeed, the manpage (which says -o5 is the default) doesn't match the behaviour.

With -s1 instead of -s128, I get:

   75GiB

100 sections at -s128 would be 25G, so I wonder what the remaining 101GiB
are (or the remaining 75GiB).

Don't get me wrong, a "default" ext4 gives me a lot less initial space,
but that's why I don't use ext4. XFS (which has a lot more on-disk data
structures) gives me a 100GB more space, which is not something to be
trifled with. If f2fs absolutely needs this space, it has to be, but at
the moment, it feels excessive.

I'm also ok with having to wait for gc when the disk is almost completely
full. The issue I have at this point is that f2fs reserves a LOT of space,
and long before the disk even near getting full, it basically stops
working. That's the point where I would have to wait for the GC, but f2fs
just seems to sit idle.

> >    F2FS-fs (dm-18): Failed to initialize F2FS segment manager
> >    (http://data.plan9.de/f2fs-mount-failure.txt)
> 
> I think the below patch should resolve this issue.

Sounds cool!

> > After this, df showed 185GB in use, which is more like 3%, not 1% - again
> > overprovisioning seems to be out of bounds.
> 
> Actually, 185GB should include FS metadata as well as reserved or overprovision
> space. It would be good to check the on-disk layout by fsck.f2fs.

That's a lot of metadata for an empty filesystem.

> >    [ASSERT] (get_current_sit_page: 803) ret >= 0
> >    [Exit 255] 
> 
> Actually, this doesn't report f2fs inconsistency.
> Instead, these two errors are from lseek64() and read() failures in dev_read():
> lib/libf2fs_io.c.
> 
> Maybe ENOMEM? Can you check the errno of this function?

That's very strange, if the kernel fails, I would expect some dmesg
output, but the fs was mountable before and after.

Unfortunately, I already went onwards with the next test.

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
