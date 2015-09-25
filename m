From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/4.2.1
Date: Fri, 25 Sep 2015 08:50:57 +0200
Message-ID: <20150925065057.GA2638@schmorp.de>
References: <20150924175131.GC40291@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfMqY-0007yr-KS
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 06:51:06 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfMqX-0002XB-DO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 06:51:06 +0000
Content-Disposition: inline
In-Reply-To: <20150924175131.GC40291@jaegeuk-mac02>
	<20150924182836.GD40291@jaegeuk-mac02>
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
> One thing that we can try is to run the latest f2fs source in v3.18.
> This branch supports f2fs for v3.18.

Ok, please bear with me, the last time I built my own kernel was during
the 2.4 timeframe, and this is a ubuntu kernel. What I did is this:

   git clone -b linux-3.18 git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
   cd f2fs/fs/f2fs
   rsync -avPR include/linux/f2fs_fs.h include/trace/events/f2fs.h /usr/src/linux-headers-3.18.21-031821/.
   make -C /lib/modules/3.18.21-031821-generic/build/ M=$PWD modules modules_install

I then rmmod f2fs/insmod the resulting module, and tried to mount my
existing f2fs fs for a quick test, but got a null ptr exception on "mount":

http://ue.tst.eu/e4628dcee97324e580da1bafad938052.txt

Probably caused me not building a full kernel, but recreating how ubuntu
build their kernels on a debian system isn't something I look forward to.

> For example, if I can represent blocks like:
[number of logs discussion]

Thanks for this explanation - two logs doesn't look so bad, from a
locality viewpoint (not a big issue for flash, but a big issue for
rotational devices - I also realised I can't use dmcache as dmcache, even
in writethrough mode, writes back all data after an unclean shutdown,
which would positively kill the disk).

Since whatever speed difference I saw with two logs wasn't big, you
completely sold me on 6 logs, or 4 (especially if it seepds up the gc,
which I haven't much tested yet). Two logs was merely a test anyway (the
same with no_heap, I don't know what it does, but I thought it is worth
a try, as metadata + data nearer together is better than having them at
opposite ends of the log or so).

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
