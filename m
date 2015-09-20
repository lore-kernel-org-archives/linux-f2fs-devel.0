From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: finally testing with SMR drives
Date: Mon, 21 Sep 2015 01:59:01 +0200
Message-ID: <20150920235901.GA7017@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zdokz-0003f8-I2
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 00:14:57 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zdokx-0000Gm-Ic
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 00:14:57 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZdoVZ-0007O1-JA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Sep 2015 23:59:01 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZdoVZ-00071u-EU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Sep 2015 23:59:01 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZdoVZ-0000Ir-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 01:59:01 +0200
Content-Disposition: inline
In-Reply-To: <20150810203106.GA4575@jaegeuk-mac02>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On Mon, Aug 10, 2015 at 01:31:06PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> I'm very interested in trying f2fs on SMR drives too.

Sorry that it took me so long, I am currently conducting initial tests, and
will hopefully be able tpo report soon, for real this time.

The kernel bug regarding SMR drives has multiplied (the gory details
are in https://bugzilla.kernel.org/show_bug.cgi?id=93581, apparently, a
silent data corruption error has emerged, although I don't think I was
affected by it), in short, I will test with "stock" 3.18.20 and/or 4.2.0
(with max_sectors_kb=512). I also have the current git f2fs tools up and
running.

I'll do small test with 4.2.0 and hopefully also the big ones (depending on
when I can reboot the boxes).

In the meantime, can you answer me one question?

How can I effectively disable IPU?

I currently try this:

   echo 8 >ipu_policy
   echo 100 >min_ipu_util

Can you verify that this would suppress at least "most" IPU updates? If
not, is there a better way to suppress them? Thanks!

I really want to see the garbage collector freeing big chunks on its own,
and rather wait for it to do its work than to risk IPU writes, as the
latter will effectively trigger a similar garbage collect on the drive
(less efficient, but with more cache).

> - over 4TB storage space case

I currently do tests with 512GB, will do full device size later.

> - inline_dentry mount option; I'm still working on extent_cache for v4.3 too

While inline_dentry will be nice to have, I can live with them being
disabled, but will test anyways. Likewise the extent_cache.

> - various sizes of section and zone
> - tmpfile, and rename2 interfaces

I wasn'*t even aware of the renameat2 syscall, thanks for indirectly
pointing this out to me :)

>  http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git

Up and running, thanks for pointing the URL out to me, I overlooked it in
the manpage :/

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
