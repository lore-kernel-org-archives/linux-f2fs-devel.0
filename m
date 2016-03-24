From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Wed, 23 Mar 2016 18:29:23 -0700
Message-ID: <20160324012923.GA24644@jaegeuk.gateway>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
	<56F06067.2060404@davizone.at> <56F07C02.2020106@matthiasprager.de>
	<20160322203613.GA14498@jaegeuk.gateway>
	<56F29214.9040001@davizone.at> <56F2C755.5060402@matthiasprager.de>
	<20160323205204.GB4443@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aiu5d-0005Zn-7t
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Mar 2016 01:29:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aiu5b-00030Y-Ql
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Mar 2016 01:29:33 +0000
Content-Disposition: inline
In-Reply-To: <20160323205204.GB4443@schmorp.de>
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
Cc: David Gnedt <david.gnedt@davizone.at>, Matthias Prager <linux@matthiasprager.de>, linux-f2fs-devel@lists.sourceforge.net

On Wed, Mar 23, 2016 at 10:00:10PM +0100, Marc Lehmann wrote:
> On Wed, Mar 23, 2016 at 05:41:57PM +0100, Matthias Prager <linux@matthiasprager.de> wrote:
> > detail. Writing on a read-only fs is a no go! There usually is a reason
> > why someone mounts an filesystem read-only and f2fs should not simply
> > ignore such a flag.
> 
> Hmm, no.
> 
> Even an unusual case is enough, such as mounting it read-only for data
> recovery because the underlying device dies on writes (quite likely for
> ssds, the primary target for f2fs).
> 
> However, other linux filesystems either replay their journal on readonly
> mounts, or even *require* a replay (most have a flag to prevent that,
> but that might not help data recovery). In fact, my example above can
> relatively easily worked around using device mapper and a temporary
> snapshot volume for writes.
> 
> So, the "ro" mount flag in linux does not mean "do not write to the
> backing store", and did not have that meaning for a long time, so it's
> fine for f2fs to write even for ro mounts.
> 
> That means the correct behaviour for f2fs is to write unless "norecovery"
> has been specified, which already exists for this purpose on f2fs.

Well. IMO, we have to deal with fixing inconsistency and doing recovery
separately.

In terms of recovery, I agree that we must do it no matter how fs is mounted.
The only missing part in f2fs is that, we need to throw an error, if there is
something to recover under read-write and norecovery mount likewise ext4.

Regarding to fixing inconsistency dynamically, it seems depending on filesystems
according to how severely it can corrupt the underlying on-disk layout.
For example, I could see that btrfs conducts btrfs_recover_relocation only
when read-write mount, while doing btrfs_replay_log all the time.

Back to our cases, I think fixing superblock just depends on our policy.
Initially, I added f2fs_commit_super to recover the broken superblock
optionally, since we have no problem to mount with the alternate valid
superblock.

In the case of misaligned end address, it also doesn't need to fix it at
read-only mount, since it has nothing to do with read operations.
That is only used to check the boundary bug when writing blocks.

Lastly, when considerting RO to RW case as you pointed out, I think we need to
handle that in f2fs_remount by adding a superblock flag likewise ext4.

Let me submit some patches for them.

Thanks,

> Different behaviour would put f2fs at odds with other existing
> filesystems, which write on "ro" mounts to gain integrity.
> 
> Even better would be if there was a "force" or similar option which would
> allow me to mount filesystems with possibly bad superblock data. This
> could even be rolled into the existing "norecovery" switch, which, when
> given, could try to mount even if the superblock has (some amount of) bad
> data.
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
