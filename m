From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Fwd: fsck.f2fs fails with "can't find valid
 checkpoint"
Date: Tue, 4 Jul 2017 20:53:59 -0700
Message-ID: <20170705035359.GE15448@jaegeuk-macbookpro.roam.corp.google.com>
References: <CAETC-g8rBb53ibGYPciFjgN-uKK7xahPJZVGs8NsR+=0Qpu+oQ@mail.gmail.com>
	<CAOtxgydToHmRwgWa1mc13wB9tuZPREokNCE4qo83As_LgeU9-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dSbOA-0000Vt-CF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 03:54:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSbO9-00080H-Ez
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 03:54:06 +0000
Content-Disposition: inline
In-Reply-To: <CAOtxgydToHmRwgWa1mc13wB9tuZPREokNCE4qo83As_LgeU9-Q@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@gmail.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 07/04, Jaegeuk Kim wrote:
> + f2fs mailing list
> 
> ---------- Forwarded message ----------
> From: Marcelo "Marc" Ranolfi <marc.2377@gmail.com>
> Date: 2017-07-04 18:52 GMT-07:00
> Subject: Fwd: fsck.f2fs fails with "can't find valid checkpoint"
> To: Jaegeuk Kim <jaegeuk.kim@gmail.com>
> 
> 
> 
> ---------- Forwarded message ----------
> From: Marcelo "Marc" Ranolfi <marc.2377@gmail.com>
> Date: Tue, Jul 4, 2017 at 3:54 PM
> Subject: fsck.f2fs fails with "can't find valid checkpoint"
> To: linux-f2fs-devel@lists.sourceforge.net
> 
> 
> (reposting because yesterday's email didn't work)
> 
> Gentlemen,
> 
> I was using F2FS in my system when it crashed, and since then, I can't boot
> it, nor mount the root partition, and fsck doesn't help. I'm typing this
> from a live CD.
> 
> The system is Arch Linux with the 4.12-rc7 kernel (I was compiling the
> stable kernel when it crashed). I posted about it here (
> https://unix.stackexchange.com/questions/375114/f2fs-lost-d
> ata-wont-mount-and-fsck-doesnt-work) but that probably won't help much.
> The gist of the story is that I'm trying these commands, from the arch iso
> image:
> 
> cryptsetup open /dev/sda3 csystem

So, you did encrypt the disk, and then got sudden power-off.

> fsck.f2fs -f /dev/mapper/csystem

After then, fsck.f2fs can't find checkpoint, which means your encrypted disk is
severely damaged. Once such the encrypted disk has been crashed, it's very
difficult to recover there-in files from filesystem level, since checkpoint in
f2fs is not recoverable. Because, we don't expect two checkpoint copies were
crashed at the same time.

How's your fsck.f2fs -d 3 result? And, can you share your image? If it's not
easy to recover checkpoint manually, I think it needs to write a tool to scan
whole disk to find recoverable files. But, it'll take time.

Thanks,

> 
> and instead of repairing, it reports:
> 
> [f2fs_do_mount:2018] Can't find valid checkpoint
> 
> The documentation available in the Kernel tree (
> https://github.com/torvalds/linux/blob/master/Documentation
> /filesystems/f2fs.txt) says under fsck.f2fs:
> "Note that, initial version of the tool does not fix any inconsistency."
> 
> However that's not mentioned in the following sources:
> https://www.mankier.com/8/fsck.f2fs
> https://lkml.org/lkml/2014/9/20/104
> 
> I suppose the Kernel doc is outdated, since from inspecting the fsck source
> code, I think it should work.
> 
> 
> So, I'd like to know whether I'm facing a bug in the tool, or if something
> specific to my case is preventing the tool to work. And of course, I'm
> really in need of having my files back.
> 
> I'm a programmer so please let me know if I can be of any help, if need be.
> 
> 
> Yours faithfully
> Marcelo "Marc" Ranolfi

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
