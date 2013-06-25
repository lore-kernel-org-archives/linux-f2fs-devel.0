From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs tests
Date: Tue, 25 Jun 2013 14:13:23 +0900
Message-ID: <1372137203.28480.45.camel@kjgkr>
References: <20130621193600.GA12712@amd.pavel.ucw.cz>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20130621193600.GA12712@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-f2fs-devel@lists.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

Thank you for the interest.

2013-06-21 (=EA=B8=88), 21:36 +0200, Pavel Machek:
> Hi!
>=20
> I played a bit with f2fs...
>=20
> First, I had to compile the f2fstools... Unfortunately they require
> never autoconf than available on debian. I tried to hack it, but then
> I decided that compiling it by hand is just simpler.
>=20
> gcc -I include/ -I . lib/*.c mkfs/*.c /usr/lib/libuuid.so
>=20
> does the trick.
>=20
> I was quite surprised there's no fsck in the repository... Do you hav=
e
> fsck somewhere?

It'll be available soon via f2fs-tools.git. We've almost done to clean
up the codes.=20

>=20
> I tested with copy of kernel and 4GB stick (with RedHat logo, thanks
> :-)... copying it from hdd took 46 minutes for VFAT and 19 minutes fo=
r
> F2FS. Good.
>=20
> VFAT: time find . -name "not-here" took 26 seconds.
> F2F:  time find . -name "not-here" took 22-24 seconds.
>=20
> Faster copy, same speed find, good. (Find is even slightly faster tha=
n
> HDD, with 27-30 seconds).
>=20
> But now the strange stuff: the same data takes 861MB on ext3 and 1.3G=
B
> on f2fs. (It was even bigger than that on VFAT). I guess I should tes=
t
> the patch for inlining small files into inodes?

It is just caused by the different policy to show the file system
utilization.

When you request "df",
1. F2FS shows all the consumed space including its file system metadata=
=2E
Instead it tries to show file system size close to the device partiton
size as much as possbile.

2. EXT4 shows the amount of used-made data excluding the reserved space=
=2E
Therefore, it shows that its total size is smaller than the underlying
partition size.

So, you need to compare each entries from the results of "df" at a same
time.

When I tested 8GB partition,

=462FS shows:  [Size]   [Used]    [Avail]
 1. empty:    8.0G     497M       7.5G
 2. cp   :    8.0G     594M       7.4G
 3. untar:    8.0G     1.3G       6.7G

EXT4 shows:
 1. empty:    7.8G     18M        7.4G
 2. cp   :    7.8G    116M        7.3G
 3. untar:    7.8G    794M        6.6G=20

So, after untar the kernel source, you're able to discover that the
available sizes are not much different between F2FS and EXT4.

Thanks,

>=20
> 									Pavel

--=20
Jaegeuk Kim
Samsung
