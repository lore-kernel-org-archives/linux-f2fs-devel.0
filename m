From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/4.2.1
Date: Fri, 25 Sep 2015 01:27:20 +0200
Message-ID: <20150924232720.GA2892@schmorp.de>
References: <20150923215850.GC2360@schmorp.de>
	<20150923231103.GA3463@schmorp.de>
	<20150924182836.GD40291@jaegeuk-mac02>
	<20150924232025.GA2242@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfFvE-0007kD-KB
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 23:27:28 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfFvC-0006pc-Mc
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 23:27:28 +0000
Content-Disposition: inline
In-Reply-To: <20150924232025.GA2242@schmorp.de>
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

On Fri, Sep 25, 2015 at 01:20:25AM +0200, Marc Lehmann <schmorp@schmorp.de>=
 wrote:
> On Thu, Sep 24, 2015 at 11:28:36AM -0700, Jaegeuk Kim <jaegeuk@kernel.org=
> wrote:
> > > The log starts after only 20GB had been written. Here is the status o=
utput
> > > at 25GB:
> > > =

> > > http://ue.tst.eu/734f7883107ee4dabff77602db92310b.txt
> > =

> > It seems about 700MB were moved by background GC.

And before rebooting I did another sync, which took 130s, using 100% system
time. This is the status output afterward:

http://ue.tst.eu/6d0398c4184fdbef059e90a6bf454241.txt

Is it normal that f2fs takes this long for a sync? What happens when,
during shutdown, there is a timeout during umount and systemd shuts down
anyway, or the fs doesn't get unmounted, will there be data loss because
of rolling back?

I am a bit concerned, because the filesystem was sitting idle for hours,
and I expect a crash at that point to not lose any data due to reverting
to a=A0checkpoint.

-- =

                The choice of a       Deliantra, the free code+content MORPG
      -----=3D=3D-     _GNU_              http://www.deliantra.net
      ----=3D=3D-- _       generation
      ---=3D=3D---(_)__  __ ____  __      Marc Lehmann
      --=3D=3D---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=3D=3D=3D=3D=3D/_/_//_/\_,_/ /_/\_\

---------------------------------------------------------------------------=
---
