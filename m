From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [RFC 0/5] Enable f2fs support inline data
Date: Mon, 10 Jun 2013 07:55:54 +0900
Message-ID: <1370818554.3600.73.camel@kjgkr>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
	<1370312366.3600.3.camel@kjgkr>
	<CAKYAXd-87rGatnEC8wbocR_wt6Qdpec3HzZaH9ukpzmst6DK=A@mail.gmail.com>
	<20130604060119.GA3265@hli22-desktop> <1370416414.3600.36.camel@kjgkr>
	<CA+v9cxZVvW+puuSWOYPJ-QnMPq-=vSi3xbb79s1u8i43XN2Wxw@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0608964091234018017=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UloY5-0004A9-Gh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Jun 2013 22:57:21 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UloY2-0006ZB-SI for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Jun 2013 22:57:21 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MO500MBQEFB4070@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Jun 2013 07:57:11 +0900 (KST)
In-reply-to: <CA+v9cxZVvW+puuSWOYPJ-QnMPq-=vSi3xbb79s1u8i43XN2Wxw@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, namjae.jeon@samsung.com, Huajun Li <huajun.li@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>


--===============0608964091234018017==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-bpg0MrU5CDt2VgwooYZF"


--=-bpg0MrU5CDt2VgwooYZF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2013-06-08 (=ED=86=A0), 15:25 +0800, Huajun Li:
>=20
> Hi Jaegeuk,=20
> Thanks for your suggestion.
> On Wed, Jun 5, 2013 at 3:13 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com>
> wrote:
>         Hi Haicheng,
>         2013-06-04 (=ED=99=94), 14:01 +0800, Haicheng Li:
>         > Hi Jaegeuk & Namjae,
>         >
>         > Sure, we'll address your comments. And this version is RFC,
>         just wanna to
>         > make sure this feature is meaningful for f2fs project, and
>         there is no obvious
>         > mistake, e.g. missing some critical path.
>         IMO, it is worth to design and implement the inline feature
>         though, I'd
>         like to review the total design before looking at trivial
>         mistakes.
>         Since if the initial design is changed frequently, we need to
>         review
>         again and again.
>        =20
> Agree. So let's understand/clarify your following proposal firstly.

>         So, we need to decide the overall inline design.
>         Currently we have to consider three data structures at a same
>         time for
>         the on-disk *inline* inode block structure, which are data,
>         dentry, and
>         xattr as well.
>        =20
>         IMO, we can give three inode flags: F2FS_INLINE_DATA,
>         F2FS_INLINE_DENT,
>         and F2FS_INLINE_XATTR.
>        =20
> Small data and dentries can be inline.  And xattr (such as XATTR_USER,
> XATTR_TRUSTED, eg. ) can be inline too, right ?

Right.

> Or inline xattr is just working for inline data/dentries?
> =20
>         < on-disk inode block >
>          - metadata
>          - if F2FS_INLINE_XATTR is set,
>           : use fixed 2*255 bytes to *cache* two xattrs for simplicity
>=20
> These 2 xattrs are working for the ones storing in xattr_nid block
> before, or just providing info for inline data/dent ?=20

I meant that we can store a fixed number of xattrs in the inode block
like *inline* data. The number, 2, is just for example.
If users give only one or two xattrs, we can store them in the inode
block instead of using extra node blocks.

If a system enables SELinux, it is able to set security labels to all
the files according to the policy, so that we need to consider inline
xattr seriously.
>=20
>=20
>          `- if F2FS_INLINE_DATA is set,
>            : use the remained space varied by F2FS_INLINE_XATTR.
>          `- if F2FS_INLINE_DENT is set,
>            : use variable number of dentries determined by
>         F2FS_INLINE_XATTR.
> Do you mean inline dent depends on inline xattr, that is, we need a
> dedicated xattr entry providing info for inline denteries, right?

What I meant was the size of inline dentry space. We need to calculate
the size for inline dentries on-the-fly as the F2FS_INLINE_XATTR is set
or not.

> =20
>=20
>          `- Otherwise, use as pointers
>        =20
>         And then, we need to define how to deal with their
>         combinations.
>        =20
>         Operational conditions
>         ----------------------
>          - use inline xattr or not, by checking other inline flags and
>         inline
>         data size.
>          - calculate inline data size and its offset according to the
>         use of
>         inline xattrs.
>          - the places of inline operaions wrt the lock consistency and
>         coverage
>          - Power-off-recovery routine should care about the on-disk
>         inode
>         structure.
>          - unset F2FS_INLINE_DATA if i_size =3D 0
>          - unset F2FS_INLINE_XATTR if xattr entries =3D 0
>          - unset F2FS_INLINE_DENT if dentries =3D 0
>        =20
>          - what else?
> - clear these flags after the inline data/dent is moved to normal data
> block
> - maybe we need store xattr_header while making xattr inline.=20

It seems that there is nothing to store any header information.

Thanks,

>        =20
>         Once we design the whole thing, we can make general functions
>         to deal
>         with them gracefully.
>        =20
>         > And if you team has some special opensource test suites used
>         in your daily
>         > f2fs test cycle, pls. kindly share the info with us, then we
>         can make sure our
>         > patchset can pass these cases before we send out next
>         version.
>        =20
>        =20
>         1. xfstests for functionality
>         2. fsstress for deadlock/consistency check
>         3. power-off with fsstress
>        =20
>         Thanks,
>        =20
>         > BTW, test the kernel source tree or kernel build is a good
>         suggestion. thanks.
>         >
>         > On Tue, Jun 04, 2013 at 01:23:57PM +0900, Namjae Jeon wrote:
>         > > Hi. Huajun.
>         > >
>         > > I agree jaegeuk's opinion.
>         > > Additionally, It is better that you describe the effect in
>         change-log
>         > > when this feature is added to f2fs.
>         > > e.g.
>         > >     1. how much space is saved when storing
>         kernel-tree(small files) ?
>         > >     2. small files creation performance test.
>         > >     3. file look-up performance test.
>         > >     4. other performance tools 's result.
>         > >
>         > > Thanks.
>         > >
>         > > 2013/6/4 Jaegeuk Kim <jaegeuk.kim@samsung.com>:
>         > > > Hi,
>         > > >
>         > > > This feature is one of my todo items. ;)
>         > > > Thank you for the contribution.
>         > > >
>         > > > Before reviewing the below code intensively, we need to
>         check the
>         > > > following issues.
>         > > >
>         > > > - deadlock conditions
>         > > > - FS consistency
>         > > > - recovery routine
>         > > >
>         > > > Could you check one more time?
>         > > > Thanks again,
>         > > >
>         > > > 2013-06-03 (=EC=9B=94), 18:04 +0800, Huajun Li:
>         > > >> f2fs inode is so large, small files can be stored
>         directly in the inode,
>         > > >> rather than just storing a single block address and
>         storing the data elsewhere.
>         > > >>
>         > > >> This RFC patch set is just to enable f2fs support
>         inline data: files less than
>         > > >> about 3.6K can be stored directly in inode block.
>         > > >>
>         > > >> TODO: make small dirs inline too.
>         > > >>
>         > > >>
>         > > >> Haicheng Li (3):
>         > > >>   f2fs: Add helper functions and flag to support inline
>         data
>         > > >>   f2fs: Add interface for inline data support
>         > > >>   f2fs: add tracepoints to debug inline data operations
>         > > >>
>         > > >> Huajun Li (2):
>         > > >>   f2fs: Handle inline data read and write
>         > > >>   f2fs: Key functions to handle inline data
>         > > >>
>         > > >>  fs/f2fs/Kconfig             |   10 +++
>         > > >>  fs/f2fs/Makefile            |    1 +
>         > > >>  fs/f2fs/data.c              |   78
>         +++++++++++++++++++++-
>         > > >>  fs/f2fs/f2fs.h              |   70 +++++++++++++++++++
>         > > >>  fs/f2fs/file.c              |    9 ++-
>         > > >>  fs/f2fs/inline.c            |  156
>         +++++++++++++++++++++++++++++++++++++++++++
>         > > >>  fs/f2fs/inode.c             |    8 +++
>         > > >>  include/linux/f2fs_fs.h     |    5 ++
>         > > >>  include/trace/events/f2fs.h |   69 +++++++++++++++++++
>         > > >>  9 files changed, 402 insertions(+), 4 deletions(-)
>         > > >>  create mode 100644 fs/f2fs/inline.c
>         > > >>
>         > > >
>         > > > --
>         > > > Jaegeuk Kim
>         > > > Samsung
>         > > --
>         > > To unsubscribe from this list: send the line "unsubscribe
>         linux-fsdevel" in
>         > > the body of a message to majordomo@vger.kernel.org
>         > > More majordomo info at
>          http://vger.kernel.org/majordomo-info.html
>        =20
>        =20
>         --
>         Jaegeuk Kim
>         Samsung
>=20
>=20

--=20
Jaegeuk Kim
Samsung

--=-bpg0MrU5CDt2VgwooYZF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRtQf6AAoJEEAUqH6CSFDSu7EP/jBIPHME4manwiGt6PDABdQN
MuK6XM+9QirDvYbJiZ/h1nqHRBi/dOpxIo9WVHty258b1FxNEdtj87eCcMTxL6Mb
rqnv/gRpmM1Icyw+Aada1yC1FpRAzxEAg0nw+iOjB0sonjv992mD+PAb7AP8vCP5
JkU6qFSuLl3x9ZViC9CbWpEDQrlsNOsg6Zkfz/UG4pLUUitycwuXAM2ugpuOBPeR
Erh5pbND6qNgPulcCWYeEMNZKv6D9OfrIR6liLE2ozm4l3ZvFwHoQi1c22sbzSgK
AW8mKEioSGU0wgRSr7JZzAiUteAoDvFJtjCbhc+5c2eXBHqmtAERmp1wVyyaUS/Q
gU0q/JLaGdOAzym/2204hRcbtDTk43xcd9PHwlqh8HjhX9UT5zFBhrdxF3IFhuQS
SEGISwACmzirDubu3npP6Y0y1G0lADrWEmxgp1wkuTrKkPjI3TtSU1uDNEFCkfSW
nA8OawwHPAkwe6d8ENp/s973cv1gWsAI+NTpfvVGbh7OEIUfM2C4zaTv35+MB3WX
0Ol9AKFL82l23Kqh4u/VjsuimNHzyyVyn+4BJpIQmrfcmoPElCKhM2dqlGdxDfAt
JW/c+a35OTSeHR1GoIfPxhw4+zWtSj1o8obdmCaFpZ9XxjfdtZufOJ9B1RYMzTKd
5klQagUgqUCJAvQaIcxr
=tMS9
-----END PGP SIGNATURE-----

--=-bpg0MrU5CDt2VgwooYZF--



--===============0608964091234018017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
--===============0608964091234018017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============0608964091234018017==--
