From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: add sysfs support for controlling the gc_thread
Date: Tue, 28 May 2013 10:34:27 +0900
Message-ID: <1369704867.10521.46.camel@kjgkr>
References: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
 <1369619214.10521.25.camel@kjgkr>
 <CAKYAXd_QZronHD536LOfeFWLmtCoweRq3gbH94R4_7oKC7hv3w@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-+QrFJcKhcSoQM45hooja"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd_QZronHD536LOfeFWLmtCoweRq3gbH94R4_7oKC7hv3w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-+QrFJcKhcSoQM45hooja
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2013-05-27 (=EC=9B=94), 13:45 +0900, Namjae Jeon:
> 2013/5/27, Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> > Hi Namjae,
> Hi Jaegeuk.
>=20
> First, Thanks for your interest.
> >
> > This is an interesting functionality.
> > Could you describe why and when we need to do this?
> > What are pros and cons?
> > How can we use this?
> As the default size of the F2FS parameter can vary as per the storage
> size, so we can figure out the default values for Garbage collection
> on each device.
> It will be good if we can provide an interface which helps in tunning
> these timing parameters to optimize the behavior of GC thread.

Agreed.

>=20
> As you know, we can see performance dropping suddenly by GC thread. GC
> thread is working more roughly for big size disk. And on other hand,
> it is more work hard for very small partition.
>=20
> And If App didn't access f2fs partition for a while. We can use this
> time to make possible valid blocks using foregound gc thread working.
> So we should need gc thread fg start and stop functionality.
> We will describe how to use it and more detail in patch changelog(v2).
> >
> > IMO, when users try to control IO latencies, it seems that they can
> > trigger such the explicit GCs, but in order to do that, they also need
> > to know the status of current f2fs in more precisely. Does the debugfs
> > show it enoughly?
> First important thing before running the GC thread forecefully from
> the user level =E2=80=98sysfs=E2=80=99 is to have diagnostic values of th=
e FLASH
> partition. So, we are trying to figure out how we can check the stats
> regarding running the GC thread.
>=20
> I have thought more after getting your reply.
> f2fs_cleaner(a tentative name) is that provide the following several
> options to control gc thread.
> 1. start forground gc thread to clean all invalid blocks.
> 2. stop number 1(fg) working.
> 3. set new tunning parameter (min/max/no_gc).
> 4. get status of current f2fs.
> We will provide user level util in f2fs tools and sysfs at the same time.
> It is useful if the console level user/App user can change them easily.
>=20
> >
> > Afterwards, it is worth to add some information to
> > Document/filesystems/f2fs.txt.
> Yes, It will be included in next series patches.
> How do you think ? If you agree my suggestion, I will start to work
> the above jobs.

As I described, basically I agreed that this kind of interfaces and user
apps are definitely beneficial to the f2fs users.

But wrt design and implementation of new interfaces, we'd better discuss
how to use them in more detail and what information should be needed for
user-made cleaner.
After then, we'd better start to design the interfaces as well as user
scenarios clearly.

IMO, the following issues should be addressed.
- how to know system idle time by users?
- any priority scheme for cleaning?
- what status of current f2fs?
- how about supporting that f2fs controls gc times dynamically instead
of the user decision?

Thanks,

>=20
> Let me know your opinion.
>=20
> Thanks.
> >
> > Thanks,
> >

--=20
Jaegeuk Kim
Samsung

--=-+QrFJcKhcSoQM45hooja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRpAmjAAoJEEAUqH6CSFDSWUwP/2DbVKxhzQysNexbNgrYp6xK
VvAq8TEj05nSHyQlmhFtr+9ytXwJ0e5StkuQ1SCKZ2wKCeMAnbt76wFRZo2lHiQB
SiopzSO/p8BcEHikOcinqL2FRNFDRu/uyXtzWKa63lFBZnb2GOjx3HAcb1zNzPiy
1iJd0NSNfO4d75H7LJXFaMGxS+eGHzVR6YFpFazD3ccy1dEgUbAxs2EMfzpPrU+1
0xZdgx7puu4vmzaI6XelFDPUu0KxKSdn/4NrFX3BTT0zD3WG4dd2XfhmLUNqnlQz
7SlAfFP6NCneQMdtWpXAkErMky4+zmyZhbM9ATm2oBSazDP/B2EJS/hwR/NQV++d
WEu3MLWY4oAVy7vS5DTJIXI9cmhd0ttWrQPr6WpdhdPznCoEVQ+g99pLM3gDCdgc
fBDo6MxHvA19AOR8akSBp0K+MIdHldOe3MK4rqYFBApehl8/QDyFkrVEnQut8KrZ
0m5Xt6z2K2DWayCJwcINwTZsraMkllj5mEPMqx+zBCg7Qw0VEg9JD/qk60EsxYYe
gZ8Y9sQgwOeGQoyMchIvPp7M6KJLG0vg4DuNl2lQbFscjwwJmqHQ3RNKeuQ10gQf
lBZvC/ggEuiy8Lfmpx6ToiLqRhTBCHCu5LdWbup58BL1dAqGsejImhe8tU4/mOa9
Z6oP2NR4cJnG57/IPs8X
=hyi9
-----END PGP SIGNATURE-----

--=-+QrFJcKhcSoQM45hooja--

