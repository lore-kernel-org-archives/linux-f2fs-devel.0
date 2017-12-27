From: "Marcelo \"Marc\" Ranolfi" <marc.2377@gmail.com>
Subject: Re: Bug report - f2fs corruption with 4.14 kernel
Date: Tue, 26 Dec 2017 22:02:41 -0200
Message-ID: <CAETC-g9c0ajz+hkXY+d7qPan-fcVcFmDbGCEiBm8fY940Ps9Sw@mail.gmail.com>
References: <CAETC-g8XJTuuCOhg-8RLQhEwpyLCHPcWtBnN7Uxxsabh=LyS=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <marc.2377@gmail.com>) id 1eTzBJ-0003Rm-Mh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Dec 2017 00:02:49 +0000
Received: from mail-lf0-f42.google.com ([209.85.215.42])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eTzBI-0005yx-Ng
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Dec 2017 00:02:49 +0000
Received: by mail-lf0-f42.google.com with SMTP id y78so35174377lfd.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 26 Dec 2017 16:02:48 -0800 (PST)
In-Reply-To: <CAETC-g8XJTuuCOhg-8RLQhEwpyLCHPcWtBnN7Uxxsabh=LyS=Q@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@gmail.com>

Hi all,

confirmed it's not device-mapper.

Also happening with kernel 4.14.8 and 4.15rc5.

The bug only happens after some 2-3 hours of uptime or more.

Yesterday it got me pretty bad; corrupted /var/lib/pacman (I use Arch;
this dir is the package manager library) so I had to restore
everything from the logs via script.


Regards
Marc

On Sun, Dec 24, 2017 at 3:35 AM, Marcelo "Marc" Ranolfi
<marc.2377@gmail.com> wrote:
> Dear developers,
>
>
> I've been using f2fs for my root fs since the 4.9 kernel. The
> partition is encrypted with dm-crypt (LUKS).
>
> A few weeks back, after upgrading to kernel 4.14.2, I began to
> experience corruption of many files, revealed by boot-time fsck. Most
> of the corrupted files were temporary, but not all.
>
> I never got to successfully restore them, since fsck.f2fs attempts to
> restore files to /.lost_found (instead of lost+found, as it'd normally
> be expected), and the folder did not exist in my system.
>
> After isolating the problem to the kernel version, and after it
> affected some important system files, I simply reverted to 4.13.9 and
> stood by it for a while.
>
> Two days ago I wanted to give it another try. Even though nothing from
> the changelogs seemed to give me hope, I upgraded from 4.13.9 to
> 4.14.7 and rebooted. And rebooted again. No apparent issue, at that
> moment.
>
> But then, after a few hours of work, my applications started to
> malfunction. First qemu/libvirt (not sure which); I restarted my VM
> but it crashed again after a couple minutes.
> Then the music player crashed, followed by my text editor, with a
> delay of about 5-10 minutes in between.
>
> This is where I noticed something was seriously wrong.
>
> I attempted to close my browser (Firefox) in order to restart the
> computer, but it was impossible. Firefox would not close due to some
> missing persistent state file(s) that should be stored in
> $HOME/.mozilla, but was missing.
>
> I proceeded to shutdown the system nevertheless, but my DE (Cinnamon)
> was not accepting commands due to missing or invalid system libraries.
>
> Hard reset. On power on, fsck once again "recovered" many lost files -
> only it actually did not recover a thing, for I still hadn't created
> lost_found.
>
> After struggling for a while to get my system to a usable state, I had
> to reinstall 1146 packages from the package manager. It seems I'm
> alright by now.
>
> I'm sure this is a kernel issue. Could be device mapper, I suppose,
> but... I use encryption, in the same fashion, on two other volumes
> formatted with ext4. I also have ext2 and ntfs filesystems without
> encryption. My hardware is alright. The problem is gone by downgrading
> to kernel 4.13.x.
>
> For these reasons I'm quite sure this is an f2fs issue.
>
>
> Let me know if I can provide something more useful to help in sorting this out.
>
>
> Regards
> Marc

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
