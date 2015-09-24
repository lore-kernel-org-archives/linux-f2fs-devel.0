From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/4.2.1
Date: Fri, 25 Sep 2015 01:20:25 +0200
Message-ID: <20150924232025.GA2242@schmorp.de>
References: <20150923215850.GC2360@schmorp.de>
	<20150923231103.GA3463@schmorp.de>
	<20150924182836.GD40291@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfFoZ-0004Fg-0r
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 23:20:35 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfFoW-0006gA-Tp
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 23:20:35 +0000
Content-Disposition: inline
In-Reply-To: <20150924182836.GD40291@jaegeuk-mac02>
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

On Thu, Sep 24, 2015 at 11:28:36AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > The log starts after only 20GB had been written. Here is the status output
> > at 25GB:
> > 
> > http://ue.tst.eu/734f7883107ee4dabff77602db92310b.txt
> 
> It seems about 700MB were moved by background GC.

And to quantify "slower", copying 2.1TiB took 18h, at 35.6MB/s. "sync" was
routinely taking minutes to execute.

As a sidenote, a "du" on cold cache pulled in data from the drive at
~26MB/s, which is quite impressive. At the number of files, that means
it is pulling in ~4.4kb/stat. It also means it stat's at 5869 files/s,
which is very good! I hadn't expected this from a flash file system on
rotational media.

> > Any idea why 4.2.1 performs so much worse than 3.8.21?
> 
> One thing that we can try is to run the latest f2fs source in v3.18.
> This branch supports f2fs for v3.18.

Will do!

> And, if possible, could you share the status output of both of v3.18 and v4.2?

Will do, this is the output for 4.2.1, after copying and having it sit
idle for a few hours.

http://ue.tst.eu/90522477a480ae7a3b71647269b31ff7.txt

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
