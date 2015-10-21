From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: next-20151021 - compile error in  fs/f2fs/checkpoint.c
Date: Wed, 21 Oct 2015 14:05:35 -0400
Message-ID: <37662.1445450735@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1445450735_28315P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

--==_Exmh_1445450735_28315P
Content-Type: text/plain; charset=us-ascii

Building next-20151021 dies with this error:

  CC [M]  fs/f2fs/checkpoint.o
fs/f2fs/checkpoint.c: In function 'get_valid_checkpoint':
fs/f2fs/checkpoint.c:707:3: error: too few arguments to function 'ra_meta_pages'
   ra_meta_pages(sbi, cp_blk_no + 1, cp_blks - 1, META_CP);
   ^
fs/f2fs/checkpoint.c:143:5: note: declared here
 int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
     ^
scripts/Makefile.build:258: recipe for target 'fs/f2fs/checkpoint.o' failed
make[2]: *** [fs/f2fs/checkpoint.o] Error 1

Looks like this commit:

commit 26879fb101f28c554294eaf25ac7817a2825b180
Author: Chao Yu <chao2.yu@samsung.com>
Date:   Mon Oct 12 17:05:59 2015 +0800

    f2fs: support lower priority asynchronous readahead in ra_meta_pages

missed updating one call.  Apparently this wasn't compile-tested before
being pushed upstream?

--==_Exmh_1445450735_28315P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVifT7wdmEQWDXROgAQIoiw/9FrkfwQJhDG/3jyuIeD40/SGJ1RojrnGW
DDNdfs+PHiRI/+RsBAg3cTM3yfPp8NLrwp5TVOXgaJN7+mt9lsWalE1tVrYiMzrW
OFk2PrrL+s4o1bn0+jbZ1cH66+lHHe0Yyvf4vrHtr9raI9JMqxam66w6QQNikij5
s9/NjqwVvArKFkgx5y6WIZryE6sTkS768cM0FjF31lg2IsWGLgogn2GPuMNjUPgW
KzIZk6wZDawjYSlSr6G7uFZH9VmYyEhDESHR/SLxAZiqaoIKDHI5TgQqgPop4hTF
rcLhmXOWPTcXixzcY69NZCU7h8QyhTKQy+LrM5iYT/M608xaoYtSJrRHV9XuZkR5
QHDZgT99nBWu8nFzvJJv8553+VGJSVUUUdRnGoTukTRcKEqNMpR+NhPLTAf0pT72
RYnCY3HZHoUgR2hNbSXKwrETEmeVhOXScFORqIt7YWd+fP2HW3MLHdfeNi3Ju0/y
0EPVtcz+vnPzGG/ZXl6Mp/cCpWJ4FuSzajwC+fqT7UxNocAkIwZYLbXtR5E+vBM6
8UPVfaADEm6GVwwNcFRSTkl9VmJ9djeYMarRsgvTB2bDra9M49kBtukj7CrmaK+5
EvM2RYGI1QyaKkBKzTM/cxzFZGTx6sSlCTcqVoqodLfwU/LJEsSnvGBIyM48TFIM
fDi6gBGaOIQ=
=V4Nm
-----END PGP SIGNATURE-----

--==_Exmh_1445450735_28315P--
