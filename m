From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [GIT PULL] f2fs updates for v3.11
Date: Tue, 02 Jul 2013 09:47:22 +0900
Message-ID: <1372726042.736.21.camel@kjgkr>
References: <1367989951.16581.50.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-E1a8Yma48swheAqccse8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1367989951.16581.50.camel@kjgkr>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Linux Kernel, Mailing List" <linux-kernel@vger.kernel.org>, "Linux FS DEV, Mailing List" <linux-fsdevel@vger.kernel.org>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-E1a8Yma48swheAqccse8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull request on f2fs updates for v3.11.
Most of patches in this patch-set have been proposed to fix the
roll-forward mechanism significantly.

One of major fixes is related to little and big endian conversion, and
its errorneous symptom on powerpc was initially reported by Oded Gabbay.

Another one is that it has been revealed the pgbench regression reported
by phoronix was caused by one of fsync bug fixes in 3.10-rc1. In order
to restore the performance, one enhancement patch was introduced in this
patch-set, which is f2fs: recover wrong pino after checkpoint during
fsync.

One of new features is *xattr security labels* which is essential to the
SEandroid system.

Please consider pulling the following tag.
Thank you,

The following changes since commit
e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
tags/for-f2fs-3.11

for you to fetch changes up to a1dd3c13ce65b726fddfe72b9d2f1009db983ce6:

  f2fs: fix to recover i_size from roll-forward (2013-07-02 08:48:16
+0900)

----------------------------------------------------------------
This patch-set includes the following major enhancement patches.
 o remount_fs callback function
 o restore parent inode number to enhance the fsync performance
 o xattr security labels
 o reduce the number of redundant lock/unlock data pages
 o avoid frequent write_inode calls

The other minor bug fixes are as follows.
 o endian conversion bugs
 o various bugs in the roll-forward recovery routine

----------------------------------------------------------------
Dan Carpenter (1):
      f2fs: dereferencing an ERR_PTR

Gu Zheng (3):
      f2fs: set sb->s_fs_info before calling parse_options()
      f2fs: code cleanup and simplify in func {find/add}_gc_inode
      f2fs: remove the unused argument "sbi" of func
destroy_fsync_dnodes()

Haicheng Li (4):
      f2fs: remove unecessary variable and code
      f2fs: remove unnecessary parameter "offset" from __add_sum_entry()
      f2fs: make locate_dirty_segment() as static
      f2fs: optimize do_write_data_page()

Jaegeuk Kim (35):
      f2fs: fix inconsistency of block count during recovery
      f2fs: fix the inconsistent state of data pages
      f2fs: remove redundant assignment
      f2fs: fix por_doing variable coverage
      f2fs: fix BUG_ON during f2fs_evict_inode(dir)
      f2fs: remove unnecessary por_doing check
      f2fs: skip get_node_page if locked node page is passed
      f2fs: change get_new_data_page to pass a locked node page
      f2fs: update inode page after creation
      f2fs: add debug msgs in the recovery routine
      f2fs: remove unnecessary kmap/kunmap operations
      f2fs: fix to unlock page before exit
      f2fs: don't do checkpoint if error is occurred
      f2fs: avoid RECLAIM_FS-ON-W: deadlock
      f2fs: add f2fs_readonly()
      f2fs: fix wrong condition check
      f2fs: reuse the locked dnode page and its inode
      f2fs: fix to handle do_recover_data errors
      f2fs: should not make_bad_inode on f2fs_link failure
      f2fs: use ihold
      f2fs: align data types between on-disk and in-memory block
addresses
      f2fs: iput only if whole data blocks are flushed
      f2fs: fix dentry recovery routine
      f2fs: fix incorrect iputs during the dentry recovery
      f2fs: cover cp_file information with ilock
      f2fs: fix iget/iput of dir during recovery
      f2fs: support xattr security labels
      f2fs: fix i_blocks translation on various types of files
      f2fs: sync dir->i_size with its block allocation
      f2fs: avoid freqeunt write_inode calls
      f2fs: recover wrong pino after checkpoint during fsync
      f2fs: fix crc endian conversion
      f2fs: fix an endian conversion bug detected by sparse
      f2fs: remove reusing any prefree segments
      f2fs: fix to recover i_size from roll-forward

Jason Hrycay (1):
      f2fs: handle errors from get_node_page calls

Namjae Jeon (10):
      f2fs: reorganize f2fs_vm_page_mkwrite
      f2fs: push some variables to debug part
      f2fs: remove unneeded initializations in f2fs_parent_dir
      f2fs: optimize several routines in node.h
      f2fs: return proper error from start_gc_thread
      f2fs: reorganise the function get_victim_by_default
      f2fs: use the F2FS specific flags in f2fs_ioctl()
      f2fs: optimise the truncate_data_blocks_range() range
      f2fs: add remount_fs callback support
      f2fs: optimize the init_dirty_segmap function

Peter Zijlstra (1):
      f2fs, lockdep: annotate mutex_lock_all()

majianpeng (1):
      f2fs: use list_for_each_entry rather than list_for_each_entry_safe

 Documentation/filesystems/f2fs.txt |   9 +-
 fs/f2fs/Kconfig                    |  12 ++
 fs/f2fs/acl.c                      |   2 +-
 fs/f2fs/checkpoint.c               |  99 +++++++++++----
 fs/f2fs/data.c                     |  68 +++++++---
 fs/f2fs/debug.c                    |   4 +-
 fs/f2fs/dir.c                      | 109 +++++++++-------
 fs/f2fs/f2fs.h                     |  66 +++++++---
 fs/f2fs/file.c                     |  58 +++++++--
 fs/f2fs/gc.c                       |  42 +++---
 fs/f2fs/inode.c                    |  13 +-
 fs/f2fs/namei.c                    |  17 +--
 fs/f2fs/node.c                     |  34 ++---
 fs/f2fs/node.h                     |  68 ++++------
 fs/f2fs/recovery.c                 | 150 ++++++++++++++--------
 fs/f2fs/segment.c                  | 101 ++++-----------
 fs/f2fs/super.c                    | 253
++++++++++++++++++++++++-------------
 fs/f2fs/xattr.c                    |  68 +++++++++-
 fs/f2fs/xattr.h                    |  24 ++--
 include/linux/f2fs_fs.h            |   4 +-
 20 files changed, 750 insertions(+), 451 deletions(-)

--=20
Jaegeuk Kim
Samsung

--=-E1a8Yma48swheAqccse8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJR0iMbAAoJEEAUqH6CSFDSKYIP/2lcC9XMn9j44LSA40B/quC+
uSvynOLflZYhx3pf9GlfFQ8F4I9GFunyjxsaAGFoAsz3CNrmBERH+1zoUhPm8U5P
l9fvVOZZ2MXqHt5xDgufi1BV7KBmVdGngXogRBaXuyXd+KMYNv+BfxUE5pakbR/i
skdRhapZCHngT9KPWmL1Po1+ZWiLaIb0jCbIUwhJy6E6ZuUQ6zmv2O5mcEsH1pkI
w+8RW4N23ttKU3EKjmia/jN3PDoX/PwBgIszqE1W5mLRw5AAlScDsfqy4KuxuLux
fv+CaQ0c7XLWUfbJZUvzBxl1g1HdmQ18j1GDi5gh8V+gUME1VptFabd/hg0HY3jw
wKVZbdk0zetBazNuzr6rUgZPf5Ub9bn0YiJByZDlysML0yD2993OA0+B24/JPhCW
nTNox940WxzXxE42p2beXipfEQzXR+6iKrxTuHGO6L1qsemwFENGo3nNw0PmVWKh
n++yEaekmd10b9SUeKUG9EqCfEkuPt9pcRrqYpl6ZOiBcbUfoZtOsNbVNuQCce4d
X3gNBiLxzoCMJMuALLNe7lUUBAdsVBeahlw+GWi9NdJSwrawXFpYultbl5doYJrZ
IXinC164UWohccy0diUh+K+YByIm7uHKvZpiF/sGRTNTAMRIesEsSMaPgEIxNq0Y
q2Qn3hO3Gk/pqY8pkX/k
=VENO
-----END PGP SIGNATURE-----

--=-E1a8Yma48swheAqccse8--
