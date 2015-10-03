From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: 100% system time hang with git f2fs
Date: Sat, 3 Oct 2015 08:29:09 +0200
Message-ID: <20151003062909.GA2318@schmorp.de>
References: <20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
	<20151001121120.GA7340@schmorp.de>
	<20151001185124.GA9803@schmorp.de>
	<20151002085340.GA3105@schmorp.de>
	<20151002165124.GA2586@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZiGJq-0005Ge-TD
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 03 Oct 2015 06:29:18 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZiGJp-0006JF-6m
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 03 Oct 2015 06:29:18 +0000
Content-Disposition: inline
In-Reply-To: <20151002165124.GA2586@jaegeuk-mac02>
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

On Fri, Oct 02, 2015 at 09:51:24AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > However, I have a freeze. When I mount the volume, start a du on it, and after
> > a while do:
> 
> How was your scenario?
> Did you delete device before, or just plain mount and umount?

After writing >2TB to it, I let it idle/gc for a while, then unmounted. Then
did a fsck and mount, and let it idle for the night. On the next day, I did a
du for a speed test, relaised I hadn't dropped the caches, interrupted the
du, and then trie drop_caches with the result.

> This should be shrinker is stuck on mutex. I suspect a deadlock.
> Can you do this, if you meet this again?

Will do. Btw, I already mentioned that /proc/*/stack didn't give a useful
backtrace. Since it was apparently running, I thought maybe run cat
/.../stack in a loop, and indeed, after a minute, I got one backtrace out
of it (the process doing the echo):

http://ue.tst.eu/2562aec1c51d4bad3d7b8b83380956a7.txt

Maybe that is already useful? It indeed mentions the shrinker.

(I did this after my mail, so didn't include it).

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
