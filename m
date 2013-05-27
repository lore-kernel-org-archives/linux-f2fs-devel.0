From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [GIT PULL v2] f2fs updates for v3.10
Date: Mon, 27 May 2013 12:37:03 +0900
Message-ID: <1369625823.10521.29.camel@kjgkr>
References: <1367989951.16581.50.camel@kjgkr> <1368011413.16581.67.camel@kjgkr>
	<CAJL_dMtUfX-_3-4xb51HWPk54NyMU_frw84XdJc3OZWv52Dwcg@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8093507894660877857=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UgoGN-0002eG-SX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 May 2013 03:38:23 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UgoGK-00057b-Mu for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 May 2013 03:38:23 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNF00BZWU19U2J0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 May 2013 12:38:14 +0900 (KST)
In-reply-to: <CAJL_dMtUfX-_3-4xb51HWPk54NyMU_frw84XdJc3OZWv52Dwcg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Anca Emanuel <anca.emanuel@gmail.com>
Cc: "Linux FS DEV, Mailing List" <linux-fsdevel@vger.kernel.org>, "Linux Kernel,
	Mailing List" <linux-kernel@vger.kernel.org>, "Linux F2FS DEV,
	Mailing List" <linux-f2fs-devel@lists.sourceforge.net>


--===============8093507894660877857==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-Z0vOO6DGg0aBIm2mTt19"


--=-Z0vOO6DGg0aBIm2mTt19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thank you for the report.

I'm not able to reproduce this at all.
In my runs, there was no regression.
Can you do that?
Thanks,

2013-05-15 (=EC=88=98), 12:09 +0300, Anca Emanuel:
> Regresions: http://www.phoronix.com/scan.php?page=3Darticle&item=3Dlinux_=
310_f2fs&num=3D3
>=20
> The most notable one is PostgreSQL pgbench v8.4.11
> Transactions per second: 3032 in kernel 3.9
> down to 832 in kernel 3.10-rc1
>=20
> On Wed, May 8, 2013 at 2:10 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com> wro=
te:
> > Hi Linus,
> >
> > I've rebased one of patches, so could you consider the following pull
> > request?
> > Sorry for the noise.
> >
> > The following changes since commit
> > 47b3bc907328db968bc9b43c41f48f8d1e140750:
> >
> >   Merge branch 'x86-urgent-for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-03-07
> > 15:57:38 -0800)
> >
> > are available in the git repository at:
> >
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
> > tags/f2fs-for-v3.10
> >
> > for you to fetch changes up to 59bbd474abb9dd6a0c1a74df758ec29c7a8b150f=
:
> >
> >   f2fs: cover free_nid management with spin_lock (2013-05-08 19:54:22
> > +0900)
> >
> > ----------------------------------------------------------------
> > f2fs updates for v3.10
> >
> > This patch-set includes the following major enhancement patches.
> > o introduce a new gloabl lock scheme
> > o add tracepoints on several major functions
> > o fix the overall cleaning process focused on victim selection
> > o apply the block plugging to merge IOs as much as possible
> > o enhance management of free nids and its list
> > o enhance the readahead mode for node pages
> > o address several cretical deadlock conditions
> > o reduce lock_page calls
> >
> > The other minor bug fixes and enhancements are as follows.
> > o calculation mistakes: overflow
> > o bio types: READ, READA, and READ_SYNC
> > o fix the recovery flow, data races, and null pointer errors
> >
> > ----------------------------------------------------------------
> > Alexandru Gheorghiu (1):
> >       f2fs: use kmemdup
> >
> > Changman Lee (3):
> >       f2fs: fix overflow when calculating utilization on 32-bit
> >       f2fs: check the level before calling get_nid function
> >       f2fs: update f2fs.txt related with discard at mkfs
> >
> > Chris Fries (2):
> >       f2fs: continue to mount after failing recovery
> >       f2fs: recover when journal contains deleted files
> >
> > Haicheng Li (5):
> >       f2fs: fix inconsistent using of NM_WOUT_THRESHOLD
> >       f2fs: remove useless #include <linux/proc_fs.h> as we're now usin=
g
> > sysfs as debug entry.
> >       f2fs: bugfix for alloc_nid_failed()
> >       f2fs: code cleanup for scan_nat_page() and build_free_nids()
> >       f2fs: optimize scan_nat_page()
> >
> > Jaegeuk Kim (35):
> >       f2fs: fix to unlock node page when it was truncated
> >       f2fs: read with READ_SYNC when getting dnode page
> >       f2fs: introduce readahead mode of node pages
> >       f2fs: align f2fs maximum name length to linux based filesystem
> >       f2fs: reduce unncessary locking pages during read
> >       f2fs: should check the node page was truncated first
> >       f2fs: scan next nat page to reuse free nids in there
> >       f2fs: fix return value of releasepage for node and data
> >       f2fs: fix not to allocate max_nid
> >       f2fs: fix to call WRITE_FLUSH at the end of fsync
> >       f2fs: fix the recovery flow to handle errors correctly
> >       f2fs: do not skip writing file meta during fsync
> >       f2fs: remain nat cache entries for further free nid allocation
> >       f2fs: fix to give correct parent inode number for roll forward
> >       f2fs: do not use duplicate names in a macro
> >       f2fs: introduce TOTAL_SECS macro
> >       f2fs: remove redundant lock_page calls
> >       f2fs: allocate new segment aligned with sections
> >       f2fs: change GC bitmaps to apply the section granularity
> >       f2fs: check completion of foreground GC
> >       f2fs: allocate remained free segments in the LFS mode
> >       f2fs: avoid race for summary information
> >       f2fs: fix the bitmap consistency of dirty segments
> >       f2fs: reduce redundant spin_lock operations
> >       f2fs: introduce a new global lock scheme
> >       f2fs: write checkpoint before starting FG_GC
> >       f2fs: avoid frequent background GC
> >       f2fs: give a chance to merge IOs by IO scheduler
> >       f2fs: check nid =3D=3D 0 in add_free_nid
> >       f2fs: add a tracepoint on f2fs_new_inode
> >       f2fs: enhance alloc_nid and build_free_nids flows
> >       f2fs: check truncation of mapping after lock_page
> >       f2fs: modify the number of issued pages to merge IOs
> >       f2fs: avoid deadlock during evict after f2fs_gc
> >       f2fs: cover free_nid management with spin_lock
> >
> > Jason Hrycay (1):
> >       f2fs: move f2fs_balance_fs from truncate to punch_hole
> >
> > Masanari Iida (1):
> >       f2fs: fix typo in comments
> >
> > Namjae Jeon (17):
> >       f2fs: optimize get node page readahead part
> >       f2fs: optimize and change return path in lookup_free_nid_list
> >       f2fs: avoid extra ++ while returning from get_node_path
> >       f2fs: notify when discard is not supported
> >       f2fs: reorganize f2fs_setxattr
> >       f2fs: fix return values from validate superblock
> >       f2fs: avoid BUG_ON from check_nid_range and update return path in
> > do_read_inode
> >       f2fs: fix typo mistakes
> >       f2fs: make is_multimedia_file code align with its name
> >       f2fs: add tracepoints for sync & inode operations
> >       f2fs: add tracepoints for truncate operation
> >       f2fs: add tracepoint for tracing the page i/o
> >       f2fs: add tracepoints for GC threads
> >       f2fs: add tracepoints to debug the block allocation
> >       f2fs: add tracepoints for write page operations
> >       f2fs: add tracepoints to debug checkpoint request
> >       f2fs: add REQ_META about metadata requests for submit
> >
> > P J P (1):
> >       f2fs: add NULL pointer check
> >
> > Wei Yongjun (1):
> >       f2fs: fix error return code in f2fs_fill_super()
> >
> > Zhihui Zhang (1):
> >       f2fs: fix the logic of IS_DNODE()
> >
> >  Documentation/filesystems/f2fs.txt |   4 +-
> >  fs/f2fs/checkpoint.c               |  63 ++--
> >  fs/f2fs/data.c                     | 202 ++++++-----
> >  fs/f2fs/debug.c                    |  10 +-
> >  fs/f2fs/dir.c                      | 110 +++---
> >  fs/f2fs/f2fs.h                     |  95 ++++--
> >  fs/f2fs/file.c                     | 116 +++----
> >  fs/f2fs/gc.c                       | 125 ++++---
> >  fs/f2fs/gc.h                       |  12 +-
> >  fs/f2fs/inode.c                    |  68 ++--
> >  fs/f2fs/namei.c                    |  80 +++--
> >  fs/f2fs/node.c                     | 411 ++++++++++++----------
> >  fs/f2fs/node.h                     |  20 +-
> >  fs/f2fs/recovery.c                 |  83 +++--
> >  fs/f2fs/segment.c                  | 137 +++++---
> >  fs/f2fs/segment.h                  |  41 ++-
> >  fs/f2fs/super.c                    |  69 +++-
> >  fs/f2fs/xattr.c                    |  28 +-
> >  include/linux/f2fs_fs.h            |  17 +-
> >  include/trace/events/f2fs.h        | 682
> > +++++++++++++++++++++++++++++++++++++
> >  20 files changed, 1679 insertions(+), 694 deletions(-)
> >  create mode 100644 include/trace/events/f2fs.h
> >
> >
> > --
> > Jaegeuk Kim
> > Samsung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Jaegeuk Kim
Samsung

--=-Z0vOO6DGg0aBIm2mTt19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRotTfAAoJEEAUqH6CSFDSKwcP/iQ2622yy7mbvf6MSZ+d2LWC
oZxaLe5EuLfRZv2Z+GHD92OAyUQ+KNwx8J6xLtUNYK1yx1B8mN6XnMvwhqFJ+0YC
lBTXyNYTZqHoevgxq5oPWlJTgc/cghj4YhQ6J8QhcZAXjwGg77y8h7DxA2X6eEm/
X+WF0+BG+D4A29jin9sLD2cPOOXYNsFORAanMLRGJ5shKO7BLXqezn68V6naIuYf
zwBUrrKOAcOrvCwpfhG57+DYX7KxhSS/SZhsx5Hq44YEo87bCEbaXDW6hYBvB4CX
VQiyH7yUXBpDpUtCU0rZjUEU1+C5kuR4bY/oU2nWo/MkB0fo92D20eU1ZeYkdIiz
Izy+FaKVrI0oFfZvwfE6SGcN2nOIUchxjroFie23rs5IRpVo6maw7eGRJ5o5PTSs
7m67YXaq2hfxETLg8x8Lpp0fsbiPkXlBBQBA5jS5d8T4f6whr4a4hLoePwMUit8B
K5z/OFRqu3sxLj3eX3Wc2Q2JuWwT1+mkdgl/c042dKi+flgF5hWNa2fbMw5S1XdQ
xrMF4747AvxO0p7mc7FApC1gx+NVR7ErJBqQ0Ooj+Uz6AoD+WbzF0DNh1H/bqPEk
LfQiuL1cY0FONhEjgl1IReJ8U6UjFLJbUNO71bJsbHcpk7YRKZuxtPtpe+ZwR6Pm
FCQFFZcgj5ySoQXtoNT4
=rM3j
-----END PGP SIGNATURE-----

--=-Z0vOO6DGg0aBIm2mTt19--



--===============8093507894660877857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--===============8093507894660877857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============8093507894660877857==--
