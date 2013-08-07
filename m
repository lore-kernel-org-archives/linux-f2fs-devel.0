From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [RFC 0/5] Enable f2fs support inline data
Date: Wed, 07 Aug 2013 20:36:56 +0900
Message-ID: <1375875416.22638.51.camel@kjgkr>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
 <1370312366.3600.3.camel@kjgkr>
 <CAKYAXd-87rGatnEC8wbocR_wt6Qdpec3HzZaH9ukpzmst6DK=A@mail.gmail.com>
 <20130604060119.GA3265@hli22-desktop> <1370416414.3600.36.camel@kjgkr>
 <CA+v9cxZVvW+puuSWOYPJ-QnMPq-=vSi3xbb79s1u8i43XN2Wxw@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CA+v9cxZVvW+puuSWOYPJ-QnMPq-=vSi3xbb79s1u8i43XN2Wxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: Haicheng Li <haicheng.li@linux.intel.com>, Namjae Jeon <linkinjeon@gmail.com>, Huajun Li <huajun.li@intel.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, namjae.jeon@samsung.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

Sorry for the long delay.
I've been too busy to catch up this new big feature.

Anyway, do you guys still design or focus on this issue?
Nowadays, I can afford to dive into this issue.
So, if you have done any progress so far, can you share it with me?
Otherwise, I'd like to start to design it from the scatch.

Thanks,

2013-06-08, 15:25 +0800, Huajun Li:
>=20
> Hi Jaegeuk,=20
> Thanks for your suggestion.
>=20
>=20
> On Wed, Jun 5, 2013 at 3:13 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com>
> wrote:
>         Hi Haicheng,
>        =20
>         2013-06-04 (=ED=99=94), 14:01 +0800, Haicheng Li:
>         > Hi Jaegeuk & Namjae,
>         >
>         > Sure, we'll address your comments. And this version is RFC,
>         just wanna to
>         > make sure this feature is meaningful for f2fs project, and
>         there is no obvious
>         > mistake, e.g. missing some critical path.
>        =20
>        =20
>         IMO, it is worth to design and implement the inline feature
>         though, I'd
>         like to review the total design before looking at trivial
>         mistakes.
>         Since if the initial design is changed frequently, we need to
>         review
>         again and again.
>        =20
> Agree. So let's understand/clarify your following proposal firstly.
>=20
>=20
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
> Small data and dentries can be inline.  And xattr (such as XATTR_USER=
,
> XATTR_TRUSTED, eg. ) can be inline too, right ?
> Or inline xattr is just working for inline data/dentries?
> =20
>         < on-disk inode block >
>          - metadata
>          - if F2FS_INLINE_XATTR is set,
>           : use fixed 2*255 bytes to *cache* two xattrs for simplicit=
y
>=20
> These 2 xattrs are working for the ones storing in xattr_nid block
> before, or just providing info for inline data/dent ?=20
>=20
>=20
>          `- if F2FS_INLINE_DATA is set,
>            : use the remained space varied by F2FS_INLINE_XATTR.
>          `- if F2FS_INLINE_DENT is set,
>            : use variable number of dentries determined by
>         F2FS_INLINE_XATTR.
> Do you mean inline dent depends on inline xattr, that is, we need a
> dedicated xattr entry providing info for inline denteries, right?
> =20
>=20
>          `- Otherwise, use as pointers
>        =20
>         And then, we need to define how to deal with their
>         combinations.
>        =20
>         Operational conditions
>         ----------------------
>          - use inline xattr or not, by checking other inline flags an=
d
>         inline
>         data size.
>          - calculate inline data size and its offset according to the
>         use of
>         inline xattrs.
>          - the places of inline operaions wrt the lock consistency an=
d
>         coverage
>          - Power-off-recovery routine should care about the on-disk
>         inode
>         structure.
>          - unset F2FS_INLINE_DATA if i_size =3D 0
>          - unset F2FS_INLINE_XATTR if xattr entries =3D 0
>          - unset F2FS_INLINE_DENT if dentries =3D 0
>        =20
>          - what else?
> - clear these flags after the inline data/dent is moved to normal dat=
a
> block
> - maybe we need store xattr_header while making xattr inline.=20
>=20
>=20
>        =20
>         Once we design the whole thing, we can make general functions
>         to deal
>         with them gracefully.
>        =20
>         > And if you team has some special opensource test suites use=
d
>         in your daily
>         > f2fs test cycle, pls. kindly share the info with us, then w=
e
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
>         > On Tue, Jun 04, 2013 at 01:23:57PM +0900, Namjae Jeon wrote=
:
>         > > Hi. Huajun.
>         > >
>         > > I agree jaegeuk's opinion.
>         > > Additionally, It is better that you describe the effect i=
n
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
>         > > >>   f2fs: Add helper functions and flag to support inlin=
e
>         data
>         > > >>   f2fs: Add interface for inline data support
>         > > >>   f2fs: add tracepoints to debug inline data operation=
s
>         > > >>
>         > > >> Huajun Li (2):
>         > > >>   f2fs: Handle inline data read and write
>         > > >>   f2fs: Key functions to handle inline data
>         > > >>
>         > > >>  fs/f2fs/Kconfig             |   10 +++
>         > > >>  fs/f2fs/Makefile            |    1 +
>         > > >>  fs/f2fs/data.c              |   78
>         +++++++++++++++++++++-
>         > > >>  fs/f2fs/f2fs.h              |   70 ++++++++++++++++++=
+
>         > > >>  fs/f2fs/file.c              |    9 ++-
>         > > >>  fs/f2fs/inline.c            |  156
>         +++++++++++++++++++++++++++++++++++++++++++
>         > > >>  fs/f2fs/inode.c             |    8 +++
>         > > >>  include/linux/f2fs_fs.h     |    5 ++
>         > > >>  include/trace/events/f2fs.h |   69 ++++++++++++++++++=
+
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
