From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: Re: [f2fs-dev] [2.02] Re: [PATCH v8] F2FS support
Date: Fri, 5 Aug 2016 21:17:25 +0200
Message-ID: <CAN9vWD+QjoNoZ6rjcdURHhd-DvvPGbRygEHMmkDPZq-9jr95Kg@mail.gmail.com>
References: <20151119212824.GA11666@jaegeuk.local> <566E7DAA.4010202@gmail.com>
	<20151215003421.GD48918@jaegeuk.local>
	<20151215181439.GA60773@jaegeuk.local>
	<20160108194132.GA17464@jaegeuk.aosp>
	<20160222182525.GD10875@jaegeuk.gateway>
	<56D5F2E9.1070501@gmail.com>
	<20160303213653.GB15612@jaegeuk.hsd1.ca.comcast.net>
	<20160804170605.GA12013@jaegeuk>
	<CAA91j0VX88Zege4Y09jQdb6i3ZRb_Fodq69U+W-c0GgL7H85AA@mail.gmail.com>
	<20160805180737.GA21860@jaegeuk>
Reply-To: The development of GNU GRUB <grub-devel@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1069813164386512170=="
Return-path: <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>
In-Reply-To: <20160805180737.GA21860@jaegeuk>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/grub-devel/>
List-Post: <mailto:grub-devel@gnu.org>
List-Help: <mailto:grub-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=subscribe>
Errors-To: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org
Sender: "Grub-devel" <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>
To: The development of GNU GRUB <grub-devel@gnu.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

--===============1069813164386512170==
Content-Type: multipart/alternative; boundary=001a114b2fe8b25004053957ea81

--001a114b2fe8b25004053957ea81
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> BTW, I've heard that openmandriva adopted this patch to support F2FS in
their
installer.

And I've ported it to clover's GrubFSPkg which I'm using for EFIDroid :)
Your timing was really perfect. The day I needed f2fs support I found your
V1 in the mailing list :D
https://github.com/efidroid/uefi_edk2packages_GrubFSPkg/blob/master/grub/gr=
ub-core/fs/f2fs.c

Thanks
Michael

On Fri, Aug 5, 2016 at 8:07 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:

> On Fri, Aug 05, 2016 at 01:57:37PM +0300, Andrei Borzenkov wrote:
> > Vladimir prefers to postpone new features until 2.02 is out. From my
> > side I think it is isolated enough and new code so low regression
> > risk. Vladimir has the final word as maintainer :)
>
> Okay, I can wait for 2.02. ;)
> BTW, I've heard that openmandriva adopted this patch to support F2FS in
> their
> installer.
>
> Thanks,
>
> >
> > On Thu, Aug 4, 2016 at 8:06 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > Hi Andrei,
> > >
> > > It's been sitting for a long long time.
> > > May I ask whether or not there is any merging plan of this?
> > >
> > > Thanks,
> > >
> > > On Thu, Mar 03, 2016 at 01:36:53PM -0800, Jaegeuk Kim wrote:
> > >> Change log from v7:
> > >>  - fix an offset bug in read_file
> > >>
> > >> -- >8 --
> > >> From d774cdecc2fee18ed44098c88d2a54d358bc04d3 Mon Sep 17 00:00:00
> 2001
> > >> From: Jaegeuk Kim <jaegeuk@kernel.org>
> > >> Date: Tue, 17 Nov 2015 12:45:13 -0800
> > >> Subject: [PATCH] F2FS support
> > >>
> > >> "F2FS (Flash-Friendly File System) is flash-friendly file system
> which was merged
> > >> into Linux kernel v3.8 in 2013.
> > >>
> > >> The motive for F2FS was to build a file system that from the start,
> takes into
> > >> account the characteristics of NAND flash memory-based storage
> devices (such as
> > >> solid-state disks, eMMC, and SD cards).
> > >>
> > >> F2FS was designed on a basis of a log-structured file system
> approach, which
> > >> remedies some known issues of the older log structured file systems,
> such as
> > >> the snowball effect of wandering trees and high cleaning overhead. I=
n
> addition,
> > >> since a NAND-based storage device shows different characteristics
> according to
> > >> its internal geometry or flash memory management scheme (such as the
> Flash
> > >> Translation Layer or FTL), it supports various parameters not only f=
or
> > >> configuring on-disk layout, but also for selecting allocation and
> cleaning
> > >> algorithm.", quote by https://en.wikipedia.org/wiki/F2FS.
> > >>
> > >> The source codes for F2FS are available from:
> > >>
> > >> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git
> > >> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git
> > >>
> > >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > >> ---
> > >>  Makefile.util.def            |    7 +
> > >>  docs/grub.texi               |    5 +-
> > >>  grub-core/Makefile.core.def  |    5 +
> > >>  grub-core/fs/f2fs.c          | 1289 ++++++++++++++++++++++++++++++
> ++++++++++++
> > >>  po/exclude.pot               |    1 +
> > >>  tests/f2fs_test.in           |   19 +
> > >>  tests/util/grub-fs-tester.in |   10 +-
> > >>  7 files changed, 1332 insertions(+), 4 deletions(-)
> > >>  create mode 100644 grub-core/fs/f2fs.c
> > >>  create mode 100644 tests/f2fs_test.in
> > >>
> > >> diff --git a/Makefile.util.def b/Makefile.util.def
> > >> index db7e8ec..84627bb 100644
> > >> --- a/Makefile.util.def
> > >> +++ b/Makefile.util.def
> > >> @@ -99,6 +99,7 @@ library =3D {
> > >>    common =3D grub-core/fs/ext2.c;
> > >>    common =3D grub-core/fs/fat.c;
> > >>    common =3D grub-core/fs/exfat.c;
> > >> +  common =3D grub-core/fs/f2fs.c;
> > >>    common =3D grub-core/fs/fshelp.c;
> > >>    common =3D grub-core/fs/hfs.c;
> > >>    common =3D grub-core/fs/hfsplus.c;
> > >> @@ -766,6 +767,12 @@ script =3D {
> > >>
> > >>  script =3D {
> > >>    testcase;
> > >> +  name =3D f2fs_test;
> > >> +  common =3D tests/f2fs_test.in;
> > >> +};
> > >> +
> > >> +script =3D {
> > >> +  testcase;
> > >>    name =3D nilfs2_test;
> > >>    common =3D tests/nilfs2_test.in;
> > >>  };
> > >> diff --git a/docs/grub.texi b/docs/grub.texi
> > >> index 1df3db2..e5a80f3 100644
> > >> --- a/docs/grub.texi
> > >> +++ b/docs/grub.texi
> > >> @@ -360,7 +360,8 @@ blocklist notation. The currently supported
> filesystem types are @dfn{Amiga
> > >>  Fast FileSystem (AFFS)}, @dfn{AtheOS fs}, @dfn{BeFS},
> > >>  @dfn{BtrFS} (including raid0, raid1, raid10, gzip and lzo),
> > >>  @dfn{cpio} (little- and big-endian bin, odc and newc variants),
> > >> -@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32},
> @dfn{exFAT}, @dfn{HFS},
> > >> +@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @dfn{exFAT=
},
> > >> +@dfn{f2fs}, @dfn{HFS},
> > >>  @dfn{HFS+}, @dfn{ISO9660} (including Joliet, Rock-ridge and
> multi-chunk files),
> > >>  @dfn{JFS}, @dfn{Minix fs} (versions 1, 2 and 3), @dfn{nilfs2},
> > >>  @dfn{NTFS} (including compression), @dfn{ReiserFS}, @dfn{ROMFS},
> > >> @@ -5347,7 +5348,7 @@ NTFS, JFS, UDF, HFS+, exFAT, long filenames in
> FAT, Joliet part of
> > >>  ISO9660 are treated as UTF-16 as per specification. AFS and BFS are
> read
> > >>  as UTF-8, again according to specification. BtrFS, cpio, tar,
> squash4, minix,
> > >>  minix2, minix3, ROMFS, ReiserFS, XFS, ext2, ext3, ext4, FAT (short
> names),
> > >> -RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are assumed
> > >> +f2fs, RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are
> assumed
> > >>  to be UTF-8. This might be false on systems configured with legacy
> charset
> > >>  but as long as the charset used is superset of ASCII you should be
> able to
> > >>  access ASCII-named files. And it's recommended to configure your
> system to use
> > >> diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.d=
ef
> > >> index d9fa0e3..b585ade 100644
> > >> --- a/grub-core/Makefile.core.def
> > >> +++ b/grub-core/Makefile.core.def
> > >> @@ -1278,6 +1278,11 @@ module =3D {
> > >>  };
> > >>
> > >>  module =3D {
> > >> +  name =3D f2fs;
> > >> +  common =3D fs/f2fs.c;
> > >> +};
> > >> +
> > >> +module =3D {
> > >>    name =3D fshelp;
> > >>    common =3D fs/fshelp.c;
> > >>  };
> > >> diff --git a/grub-core/fs/f2fs.c b/grub-core/fs/f2fs.c
> > >> new file mode 100644
> > >> index 0000000..7fb256f
> > >> --- /dev/null
> > >> +++ b/grub-core/fs/f2fs.c
> > >> @@ -0,0 +1,1289 @@
> > >> +/*
> > >> + *  f2fs.c - Flash-Friendly File System
> > >> + *
> > >> + *  Written by Jaegeuk Kim <jaegeuk@kernel.org>
> > >> + *
> > >> + *  Copyright (C) 2015  Free Software Foundation, Inc.
> > >> + *
> > >> + *  GRUB is free software: you can redistribute it and/or modify
> > >> + *  it under the terms of the GNU General Public License as
> published by
> > >> + *  the Free Software Foundation, either version 3 of the License, =
or
> > >> + *  (at your option) any later version.
> > >> + *
> > >> + *  GRUB is distributed in the hope that it will be useful,
> > >> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > >> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > >> + *  GNU General Public License for more details.
> > >> + *
> > >> + *  You should have received a copy of the GNU General Public Licen=
se
> > >> + *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
> > >> + */
> > >> +#include <grub/err.h>
> > >> +#include <grub/file.h>
> > >> +#include <grub/mm.h>
> > >> +#include <grub/misc.h>
> > >> +#include <grub/disk.h>
> > >> +#include <grub/dl.h>
> > >> +#include <grub/types.h>
> > >> +#include <grub/charset.h>
> > >> +#include <grub/fshelp.h>
> > >> +
> > >> +GRUB_MOD_LICENSE ("GPLv3+");
> > >> +
> > >> +/* F2FS Magic Number */
> > >> +#define F2FS_SUPER_MAGIC     0xF2F52010
> > >> +#define CHECKSUM_OFFSET              4092            /* must be
> aligned 4 bytes */
> > >> +#define U32_CHECKSUM_OFFSET  (CHECKSUM_OFFSET >> 2)
> > >> +
> > >> +/* byte-size offset */
> > >> +#define F2FS_SUPER_OFFSET    ((grub_disk_addr_t)1024)
> > >> +#define F2FS_SUPER_OFFSET0   (F2FS_SUPER_OFFSET >>
> GRUB_DISK_SECTOR_BITS)
> > >> +#define F2FS_SUPER_OFFSET1   ((F2FS_SUPER_OFFSET + F2FS_BLKSIZE) >>
> \
> > >> +                                             GRUB_DISK_SECTOR_BITS)
> > >> +
> > >> +/* 9 bits for 512 bytes */
> > >> +#define F2FS_MIN_LOG_SECTOR_SIZE     9
> > >> +
> > >> +/* support only 4KB block */
> > >> +#define F2FS_BLK_BITS        12
> > >> +#define F2FS_BLKSIZE (1 << F2FS_BLK_BITS)
> > >> +#define F2FS_BLK_SEC_BITS    (F2FS_BLK_BITS - GRUB_DISK_SECTOR_BITS=
)
> > >> +
> > >> +#define VERSION_LEN  256
> > >> +#define F2FS_MAX_EXTENSION   64
> > >> +
> > >> +#define CP_COMPACT_SUM_FLAG  0x00000004
> > >> +#define CP_UMOUNT_FLAG       0x00000001
> > >> +
> > >> +#define MAX_ACTIVE_LOGS      16
> > >> +#define MAX_ACTIVE_NODE_LOGS 8
> > >> +#define MAX_ACTIVE_DATA_LOGS 8
> > >> +#define      NR_CURSEG_DATA_TYPE     3
> > >> +#define NR_CURSEG_NODE_TYPE  3
> > >> +#define NR_CURSEG_TYPE       (NR_CURSEG_DATA_TYPE +
> NR_CURSEG_NODE_TYPE)
> > >> +
> > >> +#define ENTRIES_IN_SUM       512
> > >> +#define      SUMMARY_SIZE    7
> > >> +#define      SUM_FOOTER_SIZE 5
> > >> +#define JENTRY_SIZE  (sizeof(struct grub_f2fs_nat_jent))
> > >> +#define SUM_ENTRIES_SIZE     (SUMMARY_SIZE * ENTRIES_IN_SUM)
> > >> +#define SUM_JOURNAL_SIZE     (F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> > >> +                             SUM_ENTRIES_SIZE)
> > >> +#define NAT_JOURNAL_ENTRIES  ((SUM_JOURNAL_SIZE - 2) / JENTRY_SIZE)
> > >> +#define NAT_JOURNAL_RESERVED ((SUM_JOURNAL_SIZE - 2) % JENTRY_SIZE)
> > >> +
> > >> +#define NAT_ENTRY_SIZE (sizeof(struct grub_f2fs_nat_entry))
> > >> +#define NAT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / NAT_ENTRY_SIZE)
> > >> +
> > >> +#define F2FS_NAME_LEN        255
> > >> +#define F2FS_SLOT_LEN        8
> > >> +#define NR_DENTRY_IN_BLOCK   214
> > >> +#define SIZE_OF_DIR_ENTRY    11      /* by byte */
> > >> +#define BITS_PER_BYTE        8
> > >> +#define SIZE_OF_DENTRY_BITMAP        ((NR_DENTRY_IN_BLOCK +
> BITS_PER_BYTE - 1) / \
> > >> +                             BITS_PER_BYTE)
> > >> +#define SIZE_OF_RESERVED     (F2FS_BLKSIZE - ((SIZE_OF_DIR_ENTRY + =
\
> > >> +                             F2FS_SLOT_LEN) * \
> > >> +                             NR_DENTRY_IN_BLOCK +
> SIZE_OF_DENTRY_BITMAP))
> > >> +
> > >> +#define F2FS_INLINE_XATTR_ADDRS      50      /* 200 bytes for inlin=
e
> xattrs */
> > >> +#define DEF_ADDRS_PER_INODE  923     /* Address Pointers in an Inod=
e
> */
> > >> +
> > >> +#define ADDRS_PER_BLOCK      1018    /* Address Pointers in a Direc=
t
> Block */
> > >> +#define NIDS_PER_BLOCK       1018    /* Node IDs in an Indirect
> Block */
> > >> +#define      NODE_DIR1_BLOCK (DEF_ADDRS_PER_INODE + 1)
> > >> +#define      NODE_DIR2_BLOCK (DEF_ADDRS_PER_INODE + 2)
> > >> +#define      NODE_IND1_BLOCK (DEF_ADDRS_PER_INODE + 3)
> > >> +#define      NODE_IND2_BLOCK (DEF_ADDRS_PER_INODE + 4)
> > >> +#define      NODE_DIND_BLOCK (DEF_ADDRS_PER_INODE + 5)
> > >> +
> > >> +#define MAX_INLINE_DATA      (4 * (DEF_ADDRS_PER_INODE - \
> > >> +                     F2FS_INLINE_XATTR_ADDRS - 1))
> > >> +#define NR_INLINE_DENTRY     (MAX_INLINE_DATA * BITS_PER_BYTE / \
> > >> +                     ((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
> > >> +                      BITS_PER_BYTE + 1))
> > >> +#define INLINE_DENTRY_BITMAP_SIZE    ((NR_INLINE_DENTRY + \
> > >> +                     BITS_PER_BYTE - 1) / BITS_PER_BYTE)
> > >> +#define INLINE_RESERVED_SIZE (MAX_INLINE_DATA - \
> > >> +                     ((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
> > >> +                      NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE)=
)
> > >> +#define CURSEG_HOT_DATA      0
> > >> +
> > >> +#define CKPT_FLAG_SET(ckpt, f)       \
> > >> +             (ckpt)->ckpt_flags & grub_cpu_to_le32_compile_time (f)
> > >> +
> > >> +#define F2FS_INLINE_XATTR    0x01    /* file inline xattr flag */
> > >> +#define F2FS_INLINE_DATA     0x02    /* file inline data flag */
> > >> +#define F2FS_INLINE_DENTRY   0x04    /* file inline dentry flag */
> > >> +#define F2FS_DATA_EXIST              0x08    /* file inline data
> exist flag */
> > >> +#define F2FS_INLINE_DOTS     0x10    /* file having implicit dot
> dentries */
> > >> +
> > >> +enum FILE_TYPE
> > >> +{
> > >> +  F2FS_FT_UNKNOWN,
> > >> +  F2FS_FT_REG_FILE =3D 1,
> > >> +  F2FS_FT_DIR =3D 2,
> > >> +  F2FS_FT_SYMLINK =3D 7,
> > >> +};
> > >> +
> > >> +#define MAX_VOLUME_NAME              512
> > >> +
> > >> +struct grub_f2fs_superblock
> > >> +{
> > >> +  grub_uint32_t magic;
> > >> +  grub_uint16_t dummy1[2];
> > >> +  grub_uint32_t log_sectorsize;
> > >> +  grub_uint32_t log_sectors_per_block;
> > >> +  grub_uint32_t log_blocksize;
> > >> +  grub_uint32_t log_blocks_per_seg;
> > >> +  grub_uint32_t segs_per_sec;
> > >> +  grub_uint32_t secs_per_zone;
> > >> +  grub_uint32_t checksum_offset;
> > >> +  grub_uint8_t dummy2[40];
> > >> +  grub_uint32_t cp_blkaddr;
> > >> +  grub_uint32_t sit_blkaddr;
> > >> +  grub_uint32_t nat_blkaddr;
> > >> +  grub_uint32_t ssa_blkaddr;
> > >> +  grub_uint32_t main_blkaddr;
> > >> +  grub_uint32_t root_ino;
> > >> +  grub_uint32_t node_ino;
> > >> +  grub_uint32_t meta_ino;
> > >> +  grub_uint8_t uuid[16];
> > >> +  grub_uint16_t volume_name[MAX_VOLUME_NAME];
> > >> +  grub_uint32_t extension_count;
> > >> +  grub_uint8_t extension_list[F2FS_MAX_EXTENSION][8];
> > >> +  grub_uint32_t cp_payload;
> > >> +  grub_uint8_t version[VERSION_LEN];
> > >> +  grub_uint8_t init_version[VERSION_LEN];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_checkpoint
> > >> +{
> > >> +  grub_uint64_t checkpoint_ver;
> > >> +  grub_uint64_t user_block_count;
> > >> +  grub_uint64_t valid_block_count;
> > >> +  grub_uint32_t rsvd_segment_count;
> > >> +  grub_uint32_t overprov_segment_count;
> > >> +  grub_uint32_t free_segment_count;
> > >> +  grub_uint32_t cur_node_segno[MAX_ACTIVE_NODE_LOGS];
> > >> +  grub_uint16_t cur_node_blkoff[MAX_ACTIVE_NODE_LOGS];
> > >> +  grub_uint32_t cur_data_segno[MAX_ACTIVE_DATA_LOGS];
> > >> +  grub_uint16_t cur_data_blkoff[MAX_ACTIVE_DATA_LOGS];
> > >> +  grub_uint32_t ckpt_flags;
> > >> +  grub_uint32_t cp_pack_total_block_count;
> > >> +  grub_uint32_t cp_pack_start_sum;
> > >> +  grub_uint32_t valid_node_count;
> > >> +  grub_uint32_t valid_inode_count;
> > >> +  grub_uint32_t next_free_nid;
> > >> +  grub_uint32_t sit_ver_bitmap_bytesize;
> > >> +  grub_uint32_t nat_ver_bitmap_bytesize;
> > >> +  grub_uint32_t checksum_offset;
> > >> +  grub_uint64_t elapsed_time;
> > >> +  grub_uint8_t alloc_type[MAX_ACTIVE_LOGS];
> > >> +  grub_uint8_t sit_nat_version_bitmap[3900];
> > >> +  grub_uint32_t checksum;
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_nat_entry {
> > >> +  grub_uint8_t version;
> > >> +  grub_uint32_t ino;
> > >> +  grub_uint32_t block_addr;
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_nat_jent
> > >> +{
> > >> +  grub_uint32_t nid;
> > >> +  struct grub_f2fs_nat_entry ne;
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_nat_journal {
> > >> +  grub_uint16_t n_nats;
> > >> +  struct grub_f2fs_nat_jent entries[NAT_JOURNAL_ENTRIES];
> > >> +  grub_uint8_t reserved[NAT_JOURNAL_RESERVED];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_nat_block {
> > >> +  struct grub_f2fs_nat_entry ne[NAT_ENTRY_PER_BLOCK];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_dir_entry
> > >> +{
> > >> +  grub_uint32_t hash_code;
> > >> +  grub_uint32_t ino;
> > >> +  grub_uint16_t name_len;
> > >> +  grub_uint8_t file_type;
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_inline_dentry
> > >> +{
> > >> +  grub_uint8_t dentry_bitmap[INLINE_DENTRY_BITMAP_SIZE];
> > >> +  grub_uint8_t reserved[INLINE_RESERVED_SIZE];
> > >> +  struct grub_f2fs_dir_entry dentry[NR_INLINE_DENTRY];
> > >> +  grub_uint8_t filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_dentry_block {
> > >> +  grub_uint8_t dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
> > >> +  grub_uint8_t reserved[SIZE_OF_RESERVED];
> > >> +  struct grub_f2fs_dir_entry dentry[NR_DENTRY_IN_BLOCK];
> > >> +  grub_uint8_t filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_inode
> > >> +{
> > >> +  grub_uint16_t i_mode;
> > >> +  grub_uint8_t i_advise;
> > >> +  grub_uint8_t i_inline;
> > >> +  grub_uint32_t i_uid;
> > >> +  grub_uint32_t i_gid;
> > >> +  grub_uint32_t i_links;
> > >> +  grub_uint64_t i_size;
> > >> +  grub_uint64_t i_blocks;
> > >> +  grub_uint64_t i_atime;
> > >> +  grub_uint64_t i_ctime;
> > >> +  grub_uint64_t i_mtime;
> > >> +  grub_uint32_t i_atime_nsec;
> > >> +  grub_uint32_t i_ctime_nsec;
> > >> +  grub_uint32_t i_mtime_nsec;
> > >> +  grub_uint32_t i_generation;
> > >> +  grub_uint32_t i_current_depth;
> > >> +  grub_uint32_t i_xattr_nid;
> > >> +  grub_uint32_t i_flags;
> > >> +  grub_uint32_t i_pino;
> > >> +  grub_uint32_t i_namelen;
> > >> +  grub_uint8_t i_name[F2FS_NAME_LEN];
> > >> +  grub_uint8_t i_dir_level;
> > >> +  grub_uint8_t i_ext[12];
> > >> +  grub_uint32_t i_addr[DEF_ADDRS_PER_INODE];
> > >> +  grub_uint32_t i_nid[5];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_direct_node {
> > >> +  grub_uint32_t addr[ADDRS_PER_BLOCK];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_indirect_node {
> > >> +  grub_uint32_t nid[NIDS_PER_BLOCK];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_f2fs_node
> > >> +{
> > >> +  union
> > >> +  {
> > >> +    struct grub_f2fs_inode i;
> > >> +    struct grub_direct_node dn;
> > >> +    struct grub_indirect_node in;
> > >> +    char buf[F2FS_BLKSIZE - 40];     /* Should occupy F2FS_BLKSIZE
> totally */
> > >> +  };
> > >> +  grub_uint8_t dummy[40];
> > >> +} GRUB_PACKED;
> > >> +
> > >> +struct grub_fshelp_node
> > >> +{
> > >> +  struct grub_f2fs_data *data;
> > >> +  struct grub_f2fs_node inode;
> > >> +  grub_uint32_t ino;
> > >> +  int inode_read;
> > >> +};
> > >> +
> > >> +struct grub_f2fs_data
> > >> +{
> > >> +  struct grub_f2fs_superblock sblock;
> > >> +  struct grub_f2fs_checkpoint ckpt;
> > >> +
> > >> +  grub_uint32_t root_ino;
> > >> +  grub_uint32_t blocks_per_seg;
> > >> +  grub_uint32_t cp_blkaddr;
> > >> +  grub_uint32_t nat_blkaddr;
> > >> +
> > >> +  struct grub_f2fs_nat_journal nat_j;
> > >> +  char *nat_bitmap;
> > >> +
> > >> +  grub_disk_t disk;
> > >> +  struct grub_f2fs_node *inode;
> > >> +  struct grub_fshelp_node diropen;
> > >> +};
> > >> +
> > >> +struct grub_f2fs_dir_iter_ctx
> > >> +{
> > >> +  struct grub_f2fs_data *data;
> > >> +  grub_fshelp_iterate_dir_hook_t hook;
> > >> +  void *hook_data;
> > >> +  grub_uint8_t *bitmap;
> > >> +  grub_uint8_t (*filename)[F2FS_SLOT_LEN];
> > >> +  struct grub_f2fs_dir_entry *dentry;
> > >> +  int max;
> > >> +};
> > >> +
> > >> +struct grub_f2fs_dir_ctx
> > >> +{
> > >> +  grub_fs_dir_hook_t hook;
> > >> +  void *hook_data;
> > >> +  struct grub_f2fs_data *data;
> > >> +};
> > >> +
> > >> +static grub_dl_t my_mod;
> > >> +
> > >> +static inline int
> > >> +grub_f2fs_test_bit_le (int nr, const grub_uint8_t *addr)
> > >> +{
> > >> +  return addr[nr >> 3] & (1 << (nr & 7));
> > >> +}
> > >> +
> > >> +static inline char *
> > >> +__inline_addr (struct grub_f2fs_inode *inode)
> > >> +{
> > >> +  return (char *)&inode->i_addr[1];
> > >> +}
> > >> +
> > >> +static inline grub_uint64_t
> > >> +grub_f2fs_file_size (struct grub_f2fs_inode *inode)
> > >> +{
> > >> +  return grub_le_to_cpu64 (inode->i_size);
> > >> +}
> > >> +
> > >> +static inline grub_uint32_t
> > >> +__start_cp_addr (struct grub_f2fs_data *data)
> > >> +{
> > >> +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > >> +  grub_uint32_t start_addr =3D data->cp_blkaddr;
> > >> +
> > >> +  if (!(ckpt->checkpoint_ver & grub_cpu_to_le64_compile_time(1)))
> > >> +    return start_addr + data->blocks_per_seg;
> > >> +  return start_addr;
> > >> +}
> > >> +
> > >> +static inline grub_uint32_t
> > >> +__start_sum_block (struct grub_f2fs_data *data)
> > >> +{
> > >> +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > >> +
> > >> +  return __start_cp_addr (data) + grub_le_to_cpu32
> (ckpt->cp_pack_start_sum);
> > >> +}
> > >> +
> > >> +static inline grub_uint32_t
> > >> +__sum_blk_addr (struct grub_f2fs_data *data, int base, int type)
> > >> +{
> > >> +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > >> +
> > >> +  return __start_cp_addr (data) +
> > >> +     grub_le_to_cpu32 (ckpt->cp_pack_total_block_count)
> > >> +     - (base + 1) + type;
> > >> +}
> > >> +
> > >> +static inline void *
> > >> +__nat_bitmap_ptr (struct grub_f2fs_data *data)
> > >> +{
> > >> +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > >> +  grub_uint32_t offset;
> > >> +
> > >> +  if (grub_le_to_cpu32 (data->sblock.cp_payload) > 0)
> > >> +    return ckpt->sit_nat_version_bitmap;
> > >> +
> > >> +  offset =3D grub_le_to_cpu32 (ckpt->sit_ver_bitmap_bytesize);
> > >> +  return ckpt->sit_nat_version_bitmap + offset;
> > >> +}
> > >> +
> > >> +static inline grub_uint32_t
> > >> +__get_node_id (struct grub_f2fs_node *rn, int off, int inode_block)
> > >> +{
> > >> +  if (inode_block)
> > >> +    return grub_le_to_cpu32 (rn->i.i_nid[off - NODE_DIR1_BLOCK]);
> > >> +  return grub_le_to_cpu32 (rn->in.nid[off]);
> > >> +}
> > >> +
> > >> +static inline grub_err_t
> > >> +grub_f2fs_block_read (struct grub_f2fs_data *data, grub_uint32_t
> blkaddr, void *buf)
> > >> +{
> > >> +  return grub_disk_read (data->disk,
> > >> +             ((grub_disk_addr_t)blkaddr) << F2FS_BLK_SEC_BITS,
> > >> +             0, F2FS_BLKSIZE, buf);
> > >> +}
> > >> +
> > >> +/*
> > >> + * CRC32
> > >> +*/
> > >> +#define CRCPOLY_LE 0xedb88320
> > >> +
> > >> +static inline grub_uint32_t
> > >> +grub_f2fs_cal_crc32 (const void *buf, const grub_uint32_t len)
> > >> +{
> > >> +  grub_uint32_t crc =3D F2FS_SUPER_MAGIC;
> > >> +  unsigned char *p =3D (unsigned char *)buf;
> > >> +  grub_uint32_t tmp =3D len;
> > >> +  int i;
> > >> +
> > >> +  while (tmp--)
> > >> +    {
> > >> +      crc ^=3D *p++;
> > >> +      for (i =3D 0; i < 8; i++)
> > >> +        crc =3D (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
> > >> +    }
> > >> +  return crc;
> > >> +}
> > >> +
> > >> +static inline int
> > >> +grub_f2fs_crc_valid (grub_uint32_t blk_crc, void *buf, const
> grub_uint32_t len)
> > >> +{
> > >> +  grub_uint32_t cal_crc =3D 0;
> > >> +
> > >> +  cal_crc =3D grub_f2fs_cal_crc32 (buf, len);
> > >> +
> > >> +  return (cal_crc =3D=3D blk_crc) ? 1 : 0;
> > >> +}
> > >> +
> > >> +static inline int
> > >> +grub_f2fs_test_bit (grub_uint32_t nr, const char *p)
> > >> +{
> > >> +  int mask;
> > >> +
> > >> +  p +=3D (nr >> 3);
> > >> +  mask =3D 1 << (7 - (nr & 0x07));
> > >> +  return mask & *p;
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_f2fs_sanity_check_sb (struct grub_f2fs_superblock *sb)
> > >> +{
> > >> +  grub_uint32_t log_sectorsize, log_sectors_per_block;
> > >> +
> > >> +  if (sb->magic !=3D grub_cpu_to_le32_compile_time (F2FS_SUPER_MAGI=
C))
> > >> +    return -1;
> > >> +
> > >> +  if (sb->log_blocksize !=3D grub_cpu_to_le32_compile_time
> (F2FS_BLK_BITS))
> > >> +    return -1;
> > >> +
> > >> +  log_sectorsize =3D grub_le_to_cpu32 (sb->log_sectorsize);
> > >> +  log_sectors_per_block =3D grub_le_to_cpu32
> (sb->log_sectors_per_block);
> > >> +
> > >> +  if (log_sectorsize > F2FS_BLK_BITS)
> > >> +    return -1;
> > >> +
> > >> +  if (log_sectorsize < F2FS_MIN_LOG_SECTOR_SIZE)
> > >> +    return -1;
> > >> +
> > >> +  if (log_sectors_per_block + log_sectorsize !=3D F2FS_BLK_BITS)
> > >> +    return -1;
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_f2fs_read_sb (struct grub_f2fs_data *data, grub_disk_addr_t
> offset)
> > >> +{
> > >> +  grub_disk_t disk =3D data->disk;
> > >> +  grub_err_t err;
> > >> +
> > >> +  /* Read first super block. */
> > >> +  err =3D grub_disk_read (disk, offset, 0, sizeof (data->sblock),
> &data->sblock);
> > >> +  if (err)
> > >> +    return -1;
> > >> +
> > >> +  return grub_f2fs_sanity_check_sb (&data->sblock);
> > >> +}
> > >> +
> > >> +static void *
> > >> +validate_checkpoint (struct grub_f2fs_data *data, grub_uint32_t
> cp_addr,
> > >> +     grub_uint64_t *version)
> > >> +{
> > >> +  grub_uint32_t *cp_page_1, *cp_page_2;
> > >> +  struct grub_f2fs_checkpoint *cp_block;
> > >> +  grub_uint64_t cur_version =3D 0, pre_version =3D 0;
> > >> +  grub_uint32_t crc =3D 0;
> > >> +  grub_uint32_t crc_offset;
> > >> +  grub_err_t err;
> > >> +
> > >> +  /* Read the 1st cp block in this CP pack */
> > >> +  cp_page_1 =3D grub_malloc (F2FS_BLKSIZE);
> > >> +  if (!cp_page_1)
> > >> +    return NULL;
> > >> +
> > >> +  err =3D grub_f2fs_block_read (data, cp_addr, cp_page_1);
> > >> +  if (err)
> > >> +    goto invalid_cp1;
> > >> +
> > >> +  cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_1;
> > >> +  crc_offset =3D grub_le_to_cpu32 (cp_block->checksum_offset);
> > >> +  if (crc_offset !=3D CHECKSUM_OFFSET)
> > >> +    goto invalid_cp1;
> > >> +
> > >> +  crc =3D grub_le_to_cpu32 (*(cp_page_1 + U32_CHECKSUM_OFFSET));
> > >> +  if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))
> > >> +    goto invalid_cp1;
> > >> +
> > >> +  pre_version =3D grub_le_to_cpu64 (cp_block->checkpoint_ver);
> > >> +
> > >> +  /* Read the 2nd cp block in this CP pack */
> > >> +  cp_page_2 =3D grub_malloc (F2FS_BLKSIZE);
> > >> +  if (!cp_page_2)
> > >> +    goto invalid_cp1;
> > >> +
> > >> +  cp_addr +=3D grub_le_to_cpu32 (cp_block->cp_pack_total_block_coun=
t)
> - 1;
> > >> +
> > >> +  err =3D grub_f2fs_block_read (data, cp_addr, cp_page_2);
> > >> +  if (err)
> > >> +    goto invalid_cp2;
> > >> +
> > >> +  cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_2;
> > >> +  crc_offset =3D grub_le_to_cpu32 (cp_block->checksum_offset);
> > >> +  if (crc_offset !=3D CHECKSUM_OFFSET)
> > >> +    goto invalid_cp2;
> > >> +
> > >> +  crc =3D grub_le_to_cpu32 (*(cp_page_2 + U32_CHECKSUM_OFFSET));
> > >> +  if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))
> > >> +    goto invalid_cp2;
> > >> +
> > >> +  cur_version =3D grub_le_to_cpu64 (cp_block->checkpoint_ver);
> > >> +  if (cur_version =3D=3D pre_version)
> > >> +    {
> > >> +      *version =3D cur_version;
> > >> +      grub_free (cp_page_2);
> > >> +      return cp_page_1;
> > >> +    }
> > >> +
> > >> +invalid_cp2:
> > >> +  grub_free (cp_page_2);
> > >> +invalid_cp1:
> > >> +  grub_free (cp_page_1);
> > >> +  return NULL;
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +grub_f2fs_read_cp (struct grub_f2fs_data *data)
> > >> +{
> > >> +  void *cp1, *cp2, *cur_page;
> > >> +  grub_uint64_t cp1_version =3D 0, cp2_version =3D 0;
> > >> +  grub_uint64_t cp_start_blk_no;
> > >> +
> > >> +  /*
> > >> +   * Finding out valid cp block involves read both
> > >> +   * sets (cp pack1 and cp pack 2)
> > >> +   */
> > >> +  cp_start_blk_no =3D data->cp_blkaddr;
> > >> +  cp1 =3D validate_checkpoint (data, cp_start_blk_no, &cp1_version)=
;
> > >> +  if (!cp1 && grub_errno)
> > >> +    return grub_errno;
> > >> +
> > >> +  /* The second checkpoint pack should start at the next segment */
> > >> +  cp_start_blk_no +=3D data->blocks_per_seg;
> > >> +  cp2 =3D validate_checkpoint (data, cp_start_blk_no, &cp2_version)=
;
> > >> +  if (!cp2 && grub_errno)
> > >> +    {
> > >> +      grub_free (cp1);
> > >> +      return grub_errno;
> > >> +    }
> > >> +
> > >> +  if (cp1 && cp2)
> > >> +    cur_page =3D (cp2_version > cp1_version) ? cp2 : cp1;
> > >> +  else if (cp1)
> > >> +    cur_page =3D cp1;
> > >> +  else if (cp2)
> > >> +    cur_page =3D cp2;
> > >> +  else
> > >> +    return grub_error (GRUB_ERR_BAD_FS, "no checkpoints");
> > >> +
> > >> +  grub_memcpy (&data->ckpt, cur_page, F2FS_BLKSIZE);
> > >> +
> > >> +  grub_free (cp1);
> > >> +  grub_free (cp2);
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +get_nat_journal (struct grub_f2fs_data *data)
> > >> +{
> > >> +  grub_uint32_t block;
> > >> +  char *buf;
> > >> +  grub_err_t err;
> > >> +
> > >> +  buf =3D grub_malloc (F2FS_BLKSIZE);
> > >> +  if (!buf)
> > >> +    return grub_errno;
> > >> +
> > >> +  if (CKPT_FLAG_SET(&data->ckpt, CP_COMPACT_SUM_FLAG))
> > >> +    block =3D __start_sum_block (data);
> > >> +  else if (CKPT_FLAG_SET (&data->ckpt, CP_UMOUNT_FLAG))
> > >> +    block =3D __sum_blk_addr (data, NR_CURSEG_TYPE, CURSEG_HOT_DATA=
);
> > >> +  else
> > >> +    block =3D __sum_blk_addr (data, NR_CURSEG_DATA_TYPE,
> CURSEG_HOT_DATA);
> > >> +
> > >> +  err =3D grub_f2fs_block_read (data, block, buf);
> > >> +  if (err)
> > >> +    goto fail;
> > >> +
> > >> +  if (CKPT_FLAG_SET (&data->ckpt, CP_COMPACT_SUM_FLAG))
> > >> +    grub_memcpy (&data->nat_j, buf, SUM_JOURNAL_SIZE);
> > >> +  else
> > >> +    grub_memcpy (&data->nat_j, buf + SUM_ENTRIES_SIZE,
> SUM_JOURNAL_SIZE);
> > >> +
> > >> +fail:
> > >> +  grub_free (buf);
> > >> +  return err;
> > >> +}
> > >> +
> > >> +static grub_uint32_t
> > >> +get_blkaddr_from_nat_journal (struct grub_f2fs_data *data,
> grub_uint32_t nid)
> > >> +{
> > >> +  grub_uint16_t n =3D grub_le_to_cpu16 (data->nat_j.n_nats);
> > >> +  grub_uint32_t blkaddr =3D 0;
> > >> +  grub_uint16_t i;
> > >> +
> > >> +  for (i =3D 0; i < n; i++)
> > >> +    {
> > >> +      if (grub_le_to_cpu32 (data->nat_j.entries[i].nid) =3D=3D nid)
> > >> +        {
> > >> +          blkaddr =3D grub_le_to_cpu32 (data->nat_j.entries[i].ne.
> block_addr);
> > >> +          break;
> > >> +        }
> > >> +    }
> > >> +  return blkaddr;
> > >> +}
> > >> +
> > >> +static grub_uint32_t
> > >> +get_node_blkaddr (struct grub_f2fs_data *data, grub_uint32_t nid)
> > >> +{
> > >> +  struct grub_f2fs_nat_block *nat_block;
> > >> +  grub_uint32_t seg_off, block_off, entry_off, block_addr;
> > >> +  grub_uint32_t blkaddr;
> > >> +  grub_err_t err;
> > >> +
> > >> +  blkaddr =3D get_blkaddr_from_nat_journal (data, nid);
> > >> +  if (blkaddr)
> > >> +    return blkaddr;
> > >> +
> > >> +  nat_block =3D grub_malloc (F2FS_BLKSIZE);
> > >> +  if (!nat_block)
> > >> +    return 0;
> > >> +
> > >> +  block_off =3D nid / NAT_ENTRY_PER_BLOCK;
> > >> +  entry_off =3D nid % NAT_ENTRY_PER_BLOCK;
> > >> +
> > >> +  seg_off =3D block_off / data->blocks_per_seg;
> > >> +  block_addr =3D data->nat_blkaddr +
> > >> +     ((seg_off * data->blocks_per_seg) << 1) +
> > >> +     (block_off & (data->blocks_per_seg - 1));
> > >> +
> > >> +  if (grub_f2fs_test_bit (block_off, data->nat_bitmap))
> > >> +    block_addr +=3D data->blocks_per_seg;
> > >> +
> > >> +  err =3D grub_f2fs_block_read (data, block_addr, nat_block);
> > >> +  if (err)
> > >> +    {
> > >> +      grub_free (nat_block);
> > >> +      return 0;
> > >> +    }
> > >> +
> > >> +  blkaddr =3D grub_le_to_cpu32 (nat_block->ne[entry_off].block_addr=
);
> > >> +
> > >> +  grub_free (nat_block);
> > >> +
> > >> +  return blkaddr;
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_get_node_path (struct grub_f2fs_inode *inode, grub_uint32_t
> block,
> > >> +     grub_uint32_t offset[4], grub_uint32_t noffset[4])
> > >> +{
> > >> +  grub_uint32_t direct_blks =3D ADDRS_PER_BLOCK;
> > >> +  grub_uint32_t dptrs_per_blk =3D NIDS_PER_BLOCK;
> > >> +  grub_uint32_t indirect_blks =3D ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
> > >> +  grub_uint32_t dindirect_blks =3D indirect_blks * NIDS_PER_BLOCK;
> > >> +  grub_uint32_t direct_index =3D DEF_ADDRS_PER_INODE;
> > >> +  int n =3D 0;
> > >> +  int level =3D 0;
> > >> +
> > >> +  if (inode->i_inline & F2FS_INLINE_XATTR)
> > >> +    direct_index -=3D F2FS_INLINE_XATTR_ADDRS;
> > >> +
> > >> +  noffset[0] =3D 0;
> > >> +
> > >> +  if (block < direct_index)
> > >> +    {
> > >> +      offset[n] =3D block;
> > >> +      goto got;
> > >> +    }
> > >> +
> > >> +  block -=3D direct_index;
> > >> +  if (block < direct_blks)
> > >> +    {
> > >> +      offset[n++] =3D NODE_DIR1_BLOCK;
> > >> +      noffset[n] =3D 1;
> > >> +      offset[n] =3D block;
> > >> +      level =3D 1;
> > >> +      goto got;
> > >> +    }
> > >> +
> > >> +  block -=3D direct_blks;
> > >> +  if (block < direct_blks)
> > >> +    {
> > >> +      offset[n++] =3D NODE_DIR2_BLOCK;
> > >> +      noffset[n] =3D 2;
> > >> +      offset[n] =3D block;
> > >> +      level =3D 1;
> > >> +      goto got;
> > >> +    }
> > >> +
> > >> +  block -=3D direct_blks;
> > >> +  if (block < indirect_blks)
> > >> +    {
> > >> +      offset[n++] =3D NODE_IND1_BLOCK;
> > >> +      noffset[n] =3D 3;
> > >> +      offset[n++] =3D block / direct_blks;
> > >> +      noffset[n] =3D 4 + offset[n - 1];
> > >> +      offset[n] =3D block % direct_blks;
> > >> +      level =3D 2;
> > >> +      goto got;
> > >> +    }
> > >> +
> > >> +  block -=3D indirect_blks;
> > >> +  if (block < indirect_blks)
> > >> +    {
> > >> +      offset[n++] =3D NODE_IND2_BLOCK;
> > >> +      noffset[n] =3D 4 + dptrs_per_blk;
> > >> +      offset[n++] =3D block / direct_blks;
> > >> +      noffset[n] =3D 5 + dptrs_per_blk + offset[n - 1];
> > >> +      offset[n] =3D block % direct_blks;
> > >> +      level =3D 2;
> > >> +      goto got;
> > >> +    }
> > >> +
> > >> +  block -=3D indirect_blks;
> > >> +  if (block < dindirect_blks)
> > >> +    {
> > >> +      offset[n++] =3D NODE_DIND_BLOCK;
> > >> +      noffset[n] =3D 5 + (dptrs_per_blk * 2);
> > >> +      offset[n++] =3D block / indirect_blks;
> > >> +      noffset[n] =3D 6 + (dptrs_per_blk * 2) +
> > >> +      offset[n - 1] * (dptrs_per_blk + 1);
> > >> +      offset[n++] =3D (block / direct_blks) % dptrs_per_blk;
> > >> +      noffset[n] =3D 7 + (dptrs_per_blk * 2) +
> > >> +             offset[n - 2] * (dptrs_per_blk + 1) + offset[n - 1];
> > >> +      offset[n] =3D block % direct_blks;
> > >> +      level =3D 3;
> > >> +      goto got;
> > >> +    }
> > >> +got:
> > >> +  return level;
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +grub_f2fs_read_node (struct grub_f2fs_data *data,
> > >> +     grub_uint32_t nid, struct grub_f2fs_node *np)
> > >> +{
> > >> +  grub_uint32_t blkaddr;
> > >> +
> > >> +  blkaddr =3D get_node_blkaddr (data, nid);
> > >> +  if (!blkaddr)
> > >> +    return grub_errno;
> > >> +
> > >> +  return grub_f2fs_block_read (data, blkaddr, np);
> > >> +}
> > >> +
> > >> +static struct grub_f2fs_data *
> > >> +grub_f2fs_mount (grub_disk_t disk)
> > >> +{
> > >> +  struct grub_f2fs_data *data;
> > >> +  grub_err_t err;
> > >> +
> > >> +  data =3D grub_malloc (sizeof (*data));
> > >> +  if (!data)
> > >> +    return NULL;
> > >> +
> > >> +  data->disk =3D disk;
> > >> +
> > >> +  if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET0))
> > >> +    {
> > >> +      if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET1))
> > >> +        {
> > >> +          if (grub_errno =3D=3D GRUB_ERR_NONE)
> > >> +            grub_error (GRUB_ERR_BAD_FS,
> > >> +                     "not a F2FS filesystem (no superblock)");
> > >> +          goto fail;
> > >> +        }
> > >> +    }
> > >> +
> > >> +  data->root_ino =3D grub_le_to_cpu32 (data->sblock.root_ino);
> > >> +  data->cp_blkaddr =3D grub_le_to_cpu32 (data->sblock.cp_blkaddr);
> > >> +  data->nat_blkaddr =3D grub_le_to_cpu32 (data->sblock.nat_blkaddr)=
;
> > >> +  data->blocks_per_seg =3D 1 <<
> > >> +     grub_le_to_cpu32 (data->sblock.log_blocks_per_seg);
> > >> +
> > >> +  err =3D grub_f2fs_read_cp (data);
> > >> +  if (err)
> > >> +    goto fail;
> > >> +
> > >> +  data->nat_bitmap =3D __nat_bitmap_ptr (data);
> > >> +
> > >> +  err =3D get_nat_journal (data);
> > >> +  if (err)
> > >> +    goto fail;
> > >> +
> > >> +  data->diropen.data =3D data;
> > >> +  data->diropen.ino =3D data->root_ino;
> > >> +  data->diropen.inode_read =3D 1;
> > >> +  data->inode =3D &data->diropen.inode;
> > >> +
> > >> +  err =3D grub_f2fs_read_node (data, data->root_ino, data->inode);
> > >> +  if (err)
> > >> +    goto fail;
> > >> +
> > >> +  return data;
> > >> +
> > >> +fail:
> > >> +  grub_free (data);
> > >> +  return NULL;
> > >> +}
> > >> +
> > >> +/* guarantee inline_data was handled by caller */
> > >> +static grub_disk_addr_t
> > >> +grub_f2fs_get_block (grub_fshelp_node_t node, grub_disk_addr_t
> block_ofs)
> > >> +{
> > >> +  struct grub_f2fs_data *data =3D node->data;
> > >> +  struct grub_f2fs_inode *inode =3D &node->inode.i;
> > >> +  grub_uint32_t offset[4], noffset[4], nids[4];
> > >> +  struct grub_f2fs_node *node_block;
> > >> +  grub_uint32_t block_addr =3D -1;
> > >> +  int level, i;
> > >> +
> > >> +  level =3D grub_get_node_path (inode, block_ofs, offset, noffset);
> > >> +  if (level =3D=3D 0)
> > >> +    return grub_le_to_cpu32 (inode->i_addr[offset[0]]);
> > >> +
> > >> +  node_block =3D grub_malloc (F2FS_BLKSIZE);
> > >> +  if (!node_block)
> > >> +    return -1;
> > >> +
> > >> +  nids[1] =3D __get_node_id (&node->inode, offset[0], 1);
> > >> +
> > >> +  /* get indirect or direct nodes */
> > >> +  for (i =3D 1; i <=3D level; i++)
> > >> +    {
> > >> +      grub_f2fs_read_node (data, nids[i], node_block);
> > >> +      if (grub_errno)
> > >> +        goto fail;
> > >> +
> > >> +      if (i < level)
> > >> +        nids[i + 1] =3D __get_node_id (node_block, offset[i], 0);
> > >> +    }
> > >> +
> > >> +  block_addr =3D grub_le_to_cpu32 (node_block->dn.addr[offset[
> level]]);
> > >> +fail:
> > >> +  grub_free (node_block);
> > >> +  return block_addr;
> > >> +}
> > >> +
> > >> +static grub_ssize_t
> > >> +grub_f2fs_read_file (grub_fshelp_node_t node,
> > >> +             grub_disk_read_hook_t read_hook, void *read_hook_data,
> > >> +             grub_off_t pos, grub_size_t len, char *buf)
> > >> +{
> > >> +  struct grub_f2fs_inode *inode =3D &node->inode.i;
> > >> +  grub_off_t filesize =3D grub_f2fs_file_size (inode);
> > >> +  char *inline_addr =3D __inline_addr (inode);
> > >> +
> > >> +  if (inode->i_inline & F2FS_INLINE_DATA)
> > >> +    {
> > >> +      if (filesize > MAX_INLINE_DATA)
> > >> +        return -1;
> > >> +      if (len > filesize - pos)
> > >> +        len =3D filesize - pos;
> > >> +
> > >> +      grub_memcpy (buf, inline_addr + pos, len);
> > >> +      return len;
> > >> +    }
> > >> +
> > >> +  return grub_fshelp_read_file (node->data->disk, node,
> > >> +                     read_hook, read_hook_data,
> > >> +                     pos, len, buf, grub_f2fs_get_block,
> > >> +                     filesize,
> > >> +                     F2FS_BLK_SEC_BITS, 0);
> > >> +}
> > >> +
> > >> +static char *
> > >> +grub_f2fs_read_symlink (grub_fshelp_node_t node)
> > >> +{
> > >> +  char *symlink;
> > >> +  struct grub_fshelp_node *diro =3D node;
> > >> +  grub_uint64_t filesize;
> > >> +
> > >> +  if (!diro->inode_read)
> > >> +    {
> > >> +      grub_f2fs_read_node (diro->data, diro->ino, &diro->inode);
> > >> +      if (grub_errno)
> > >> +        return 0;
> > >> +    }
> > >> +
> > >> +  filesize =3D grub_f2fs_file_size(&diro->inode.i);
> > >> +
> > >> +  symlink =3D grub_malloc (filesize + 1);
> > >> +  if (!symlink)
> > >> +    return 0;
> > >> +
> > >> +  grub_f2fs_read_file (diro, 0, 0, 0, filesize, symlink);
> > >> +  if (grub_errno)
> > >> +    {
> > >> +      grub_free (symlink);
> > >> +      return 0;
> > >> +    }
> > >> +
> > >> +  symlink[filesize] =3D '\0';
> > >> +  return symlink;
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_f2fs_check_dentries (struct grub_f2fs_dir_iter_ctx *ctx)
> > >> +{
> > >> +  struct grub_fshelp_node *fdiro;
> > >> +  int i;
> > >> +
> > >> +  for (i =3D 0; i < ctx->max;)
> > >> +    {
> > >> +      char *filename;
> > >> +      enum grub_fshelp_filetype type =3D GRUB_FSHELP_UNKNOWN;
> > >> +      enum FILE_TYPE ftype;
> > >> +      int name_len;
> > >> +      int ret;
> > >> +
> > >> +      if (grub_f2fs_test_bit_le (i, ctx->bitmap) =3D=3D 0)
> > >> +        {
> > >> +          i++;
> > >> +          continue;
> > >> +        }
> > >> +
> > >> +      ftype =3D ctx->dentry[i].file_type;
> > >> +      name_len =3D grub_le_to_cpu16 (ctx->dentry[i].name_len);
> > >> +      filename =3D grub_malloc (name_len + 1);
> > >> +      if (!filename)
> > >> +        return 0;
> > >> +
> > >> +      grub_memcpy (filename, ctx->filename[i], name_len);
> > >> +      filename[name_len] =3D 0;
> > >> +
> > >> +      fdiro =3D grub_malloc (sizeof (struct grub_fshelp_node));
> > >> +      if (!fdiro)
> > >> +        {
> > >> +          grub_free(filename);
> > >> +          return 0;
> > >> +        }
> > >> +
> > >> +      if (ftype =3D=3D F2FS_FT_DIR)
> > >> +        type =3D GRUB_FSHELP_DIR;
> > >> +      else if (ftype =3D=3D F2FS_FT_SYMLINK)
> > >> +        type =3D GRUB_FSHELP_SYMLINK;
> > >> +      else if (ftype =3D=3D F2FS_FT_REG_FILE)
> > >> +        type =3D GRUB_FSHELP_REG;
> > >> +
> > >> +      fdiro->data =3D ctx->data;
> > >> +      fdiro->ino =3D grub_le_to_cpu32 (ctx->dentry[i].ino);
> > >> +      fdiro->inode_read =3D 0;
> > >> +
> > >> +      ret =3D ctx->hook (filename, type, fdiro, ctx->hook_data);
> > >> +      grub_free(filename);
> > >> +      if (ret)
> > >> +        return 1;
> > >> +
> > >> +      i +=3D (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
> > >> +    }
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_f2fs_iterate_inline_dir (struct grub_f2fs_inode *dir,
> > >> +     struct grub_f2fs_dir_iter_ctx *ctx)
> > >> +{
> > >> +  struct grub_f2fs_inline_dentry *de_blk;
> > >> +
> > >> +  de_blk =3D (struct grub_f2fs_inline_dentry *) __inline_addr (dir)=
;
> > >> +
> > >> +  ctx->bitmap =3D de_blk->dentry_bitmap;
> > >> +  ctx->dentry =3D de_blk->dentry;
> > >> +  ctx->filename =3D de_blk->filename;
> > >> +  ctx->max =3D NR_INLINE_DENTRY;
> > >> +
> > >> +  return grub_f2fs_check_dentries (ctx);
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_f2fs_iterate_dir (grub_fshelp_node_t dir,
> > >> +     grub_fshelp_iterate_dir_hook_t hook, void *hook_data)
> > >> +{
> > >> +  struct grub_fshelp_node *diro =3D (struct grub_fshelp_node *) dir=
;
> > >> +  struct grub_f2fs_inode *inode;
> > >> +  struct grub_f2fs_dir_iter_ctx ctx =3D {
> > >> +    .data =3D diro->data,
> > >> +    .hook =3D hook,
> > >> +    .hook_data =3D hook_data
> > >> +  };
> > >> +  grub_off_t fpos =3D 0;
> > >> +
> > >> +  if (!diro->inode_read)
> > >> +    {
> > >> +      grub_f2fs_read_node (diro->data, diro->ino, &diro->inode);
> > >> +      if (grub_errno)
> > >> +     return 0;
> > >> +    }
> > >> +
> > >> +  inode =3D &diro->inode.i;
> > >> +
> > >> +  if (inode->i_inline & F2FS_INLINE_DENTRY)
> > >> +    return grub_f2fs_iterate_inline_dir (inode, &ctx);
> > >> +
> > >> +  while (fpos < grub_f2fs_file_size (inode))
> > >> +    {
> > >> +      struct grub_f2fs_dentry_block *de_blk;
> > >> +      char *buf;
> > >> +      int ret;
> > >> +
> > >> +      buf =3D grub_zalloc (F2FS_BLKSIZE);
> > >> +      if (!buf)
> > >> +        return 0;
> > >> +
> > >> +      grub_f2fs_read_file (diro, 0, 0, fpos, F2FS_BLKSIZE, buf);
> > >> +      if (grub_errno)
> > >> +        {
> > >> +          grub_free (buf);
> > >> +          return 0;
> > >> +        }
> > >> +
> > >> +      de_blk =3D (struct grub_f2fs_dentry_block *) buf;
> > >> +
> > >> +      ctx.bitmap =3D de_blk->dentry_bitmap;
> > >> +      ctx.dentry =3D de_blk->dentry;
> > >> +      ctx.filename =3D de_blk->filename;
> > >> +      ctx.max =3D NR_DENTRY_IN_BLOCK;
> > >> +
> > >> +      ret =3D grub_f2fs_check_dentries (&ctx);
> > >> +      grub_free (buf);
> > >> +      if (ret)
> > >> +        return 1;
> > >> +
> > >> +      fpos +=3D F2FS_BLKSIZE;
> > >> +    }
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int
> > >> +grub_f2fs_dir_iter (const char *filename, enum grub_fshelp_filetype
> filetype,
> > >> +           grub_fshelp_node_t node, void *data)
> > >> +{
> > >> +  struct grub_f2fs_dir_ctx *ctx =3D data;
> > >> +  struct grub_dirhook_info info;
> > >> +
> > >> +  grub_memset (&info, 0, sizeof (info));
> > >> +  if (!node->inode_read)
> > >> +    {
> > >> +      grub_f2fs_read_node (ctx->data, node->ino, &node->inode);
> > >> +      if (!grub_errno)
> > >> +        node->inode_read =3D 1;
> > >> +      grub_errno =3D GRUB_ERR_NONE;
> > >> +    }
> > >> +  if (node->inode_read)
> > >> +    {
> > >> +      info.mtimeset =3D 1;
> > >> +      info.mtime =3D grub_le_to_cpu64 (node->inode.i.i_mtime);
> > >> +    }
> > >> +
> > >> +  info.dir =3D ((filetype & GRUB_FSHELP_TYPE_MASK) =3D=3D GRUB_FSHE=
LP_DIR);
> > >> +  grub_free (node);
> > >> +  return ctx->hook (filename, &info, ctx->hook_data);
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +grub_f2fs_dir (grub_device_t device, const char *path,
> > >> +     grub_fs_dir_hook_t hook, void *hook_data)
> > >> +{
> > >> +  struct grub_f2fs_dir_ctx ctx =3D {
> > >> +    .hook =3D hook,
> > >> +    .hook_data =3D hook_data
> > >> +  };
> > >> +  struct grub_fshelp_node *fdiro =3D 0;
> > >> +
> > >> +  grub_dl_ref (my_mod);
> > >> +
> > >> +  ctx.data =3D grub_f2fs_mount (device->disk);
> > >> +  if (!ctx.data)
> > >> +    goto fail;
> > >> +
> > >> +  grub_fshelp_find_file (path, &ctx.data->diropen, &fdiro,
> > >> +             grub_f2fs_iterate_dir, grub_f2fs_read_symlink,
> > >> +             GRUB_FSHELP_DIR);
> > >> +  if (grub_errno)
> > >> +    goto fail;
> > >> +
> > >> +  grub_f2fs_iterate_dir (fdiro, grub_f2fs_dir_iter, &ctx);
> > >> +
> > >> +fail:
> > >> +  if (fdiro !=3D &ctx.data->diropen)
> > >> +    grub_free (fdiro);
> > >> + grub_free (ctx.data);
> > >> + grub_dl_unref (my_mod);
> > >> + return grub_errno;
> > >> +}
> > >> +
> > >> +
> > >> +/* Open a file named NAME and initialize FILE.  */
> > >> +static grub_err_t
> > >> +grub_f2fs_open (struct grub_file *file, const char *name)
> > >> +{
> > >> +  struct grub_f2fs_data *data =3D NULL;
> > >> +  struct grub_fshelp_node *fdiro =3D 0;
> > >> +  struct grub_f2fs_inode *inode;
> > >> +
> > >> +  grub_dl_ref (my_mod);
> > >> +
> > >> +  data =3D grub_f2fs_mount (file->device->disk);
> > >> +  if (!data)
> > >> +    goto fail;
> > >> +
> > >> +  grub_fshelp_find_file (name, &data->diropen, &fdiro,
> > >> +                     grub_f2fs_iterate_dir, grub_f2fs_read_symlink,
> > >> +                     GRUB_FSHELP_REG);
> > >> +  if (grub_errno)
> > >> +    goto fail;
> > >> +
> > >> +  if (!fdiro->inode_read)
> > >> +    {
> > >> +      grub_f2fs_read_node (data, fdiro->ino, &fdiro->inode);
> > >> +      if (grub_errno)
> > >> +     goto fail;
> > >> +    }
> > >> +
> > >> +  grub_memcpy (data->inode, &fdiro->inode, sizeof (*data->inode));
> > >> +  grub_free (fdiro);
> > >> +
> > >> +  inode =3D &(data->inode->i);
> > >> +  file->size =3D grub_f2fs_file_size (inode);
> > >> +  file->data =3D data;
> > >> +  file->offset =3D 0;
> > >> +
> > >> +  if (inode->i_inline & F2FS_INLINE_DATA && file->size >
> MAX_INLINE_DATA)
> > >> +    grub_error (GRUB_ERR_BAD_FS, "corrupted inline_data: need fsck"=
);
> > >> +  return 0;
> > >> +
> > >> +fail:
> > >> +  if (fdiro !=3D &data->diropen)
> > >> +    grub_free (fdiro);
> > >> +  grub_free (data);
> > >> +
> > >> +  grub_dl_unref (my_mod);
> > >> +
> > >> +  return grub_errno;
> > >> +}
> > >> +
> > >> +static grub_ssize_t
> > >> +grub_f2fs_read (grub_file_t file, char *buf, grub_size_t len)
> > >> +{
> > >> +  struct grub_f2fs_data *data =3D (struct grub_f2fs_data *) file->d=
ata;
> > >> +
> > >> +  return grub_f2fs_read_file (&data->diropen,
> > >> +             file->read_hook, file->read_hook_data,
> > >> +             file->offset, len, buf);
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +grub_f2fs_close (grub_file_t file)
> > >> +{
> > >> +  struct grub_f2fs_data *data =3D (struct grub_f2fs_data *) file->d=
ata;
> > >> +
> > >> +  grub_free (data);
> > >> +
> > >> +  grub_dl_unref (my_mod);
> > >> +
> > >> +  return GRUB_ERR_NONE;
> > >> +}
> > >> +
> > >> +static grub_uint8_t *
> > >> +grub_f2fs_utf16_to_utf8 (grub_uint16_t *in_buf_le)
> > >> +{
> > >> +  grub_uint16_t in_buf[MAX_VOLUME_NAME];
> > >> +  grub_uint8_t *out_buf;
> > >> +  int len =3D 0;
> > >> +
> > >> +  out_buf =3D grub_malloc (MAX_VOLUME_NAME * GRUB_MAX_UTF8_PER_UTF1=
6 +
> 1);
> > >> +  if (!out_buf)
> > >> +    return NULL;
> > >> +
> > >> +  while (*in_buf_le !=3D 0 && len < MAX_VOLUME_NAME) {
> > >> +    in_buf[len] =3D grub_le_to_cpu16 (in_buf_le[len]);
> > >> +    len++;
> > >> +  }
> > >> +
> > >> +  *grub_utf16_to_utf8 (out_buf, in_buf, len) =3D '\0';
> > >> +  return out_buf;
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +grub_f2fs_label (grub_device_t device, char **label)
> > >> +{
> > >> +  struct grub_f2fs_data *data;
> > >> +  grub_disk_t disk =3D device->disk;
> > >> +
> > >> +  grub_dl_ref (my_mod);
> > >> +
> > >> +  data =3D grub_f2fs_mount (disk);
> > >> +  if (data)
> > >> +    *label =3D (char *) grub_f2fs_utf16_to_utf8
> (data->sblock.volume_name);
> > >> +  else
> > >> +    *label =3D NULL;
> > >> +
> > >> +  grub_free (data);
> > >> +  grub_dl_unref (my_mod);
> > >> +  return grub_errno;
> > >> +}
> > >> +
> > >> +static grub_err_t
> > >> +grub_f2fs_uuid (grub_device_t device, char **uuid)
> > >> +{
> > >> +  struct grub_f2fs_data *data;
> > >> +  grub_disk_t disk =3D device->disk;
> > >> +
> > >> +  grub_dl_ref (my_mod);
> > >> +
> > >> +  data =3D grub_f2fs_mount (disk);
> > >> +  if (data)
> > >> +    {
> > >> +      *uuid =3D
> > >> +     grub_xasprintf
> > >> +     ("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%
> 02x%02x%02x",
> > >> +             data->sblock.uuid[0], data->sblock.uuid[1],
> > >> +             data->sblock.uuid[2], data->sblock.uuid[3],
> > >> +             data->sblock.uuid[4], data->sblock.uuid[5],
> > >> +             data->sblock.uuid[6], data->sblock.uuid[7],
> > >> +             data->sblock.uuid[8], data->sblock.uuid[9],
> > >> +             data->sblock.uuid[10], data->sblock.uuid[11],
> > >> +             data->sblock.uuid[12], data->sblock.uuid[13],
> > >> +             data->sblock.uuid[14], data->sblock.uuid[15]);
> > >> +    }
> > >> +  else
> > >> +    *uuid =3D NULL;
> > >> +
> > >> +  grub_free (data);
> > >> +  grub_dl_unref (my_mod);
> > >> +  return grub_errno;
> > >> +}
> > >> +
> > >> +static struct grub_fs grub_f2fs_fs =3D {
> > >> +  .name =3D "f2fs",
> > >> +  .dir =3D grub_f2fs_dir,
> > >> +  .open =3D grub_f2fs_open,
> > >> +  .read =3D grub_f2fs_read,
> > >> +  .close =3D grub_f2fs_close,
> > >> +  .label =3D grub_f2fs_label,
> > >> +  .uuid =3D grub_f2fs_uuid,
> > >> +#ifdef GRUB_UTIL
> > >> +  .reserved_first_sector =3D 1,
> > >> +  .blocklist_install =3D 0,
> > >> +#endif
> > >> +  .next =3D 0
> > >> +};
> > >> +
> > >> +GRUB_MOD_INIT (f2fs)
> > >> +{
> > >> +  grub_fs_register (&grub_f2fs_fs);
> > >> +  my_mod =3D mod;
> > >> +}
> > >> +
> > >> +GRUB_MOD_FINI (f2fs)
> > >> +{
> > >> +  grub_fs_unregister (&grub_f2fs_fs);
> > >> +}
> > >> diff --git a/po/exclude.pot b/po/exclude.pot
> > >> index 0a9b215..816089c 100644
> > >> --- a/po/exclude.pot
> > >> +++ b/po/exclude.pot
> > >> @@ -1214,6 +1214,7 @@ msgstr ""
> > >>
> > >>  #: grub-core/commands/xnu_uuid.c:75 grub-core/fs/jfs.c:924
> > >>  #: grub-core/fs/nilfs2.c:1135
> > >> +#: grub-core/fs/f2fs.c:1259
> > >>  #, c-format
> > >>  msgid "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%
> 02x%02x%02x"
> > >>  msgstr ""
> > >> diff --git a/tests/f2fs_test.in b/tests/f2fs_test.in
> > >> new file mode 100644
> > >> index 0000000..1ea77c8
> > >> --- /dev/null
> > >> +++ b/tests/f2fs_test.in
> > >> @@ -0,0 +1,19 @@
> > >> +#!/bin/sh
> > >> +
> > >> +set -e
> > >> +
> > >> +if [ "x$EUID" =3D "x" ] ; then
> > >> + EUID=3D`id -u`
> > >> +fi
> > >> +
> > >> +if [ "$EUID" !=3D 0 ] ; then
> > >> + exit 77
> > >> +fi
> > >> +
> > >> +if ! which mkfs.f2fs >/dev/null 2>&1; then
> > >> + echo "mkfs.f2fs not installed; cannot test f2fs."
> > >> + exit 77
> > >> +fi
> > >> +
> > >> +
> > >> +"@builddir@/grub-fs-tester" f2fs
> > >> diff --git a/tests/util/grub-fs-tester.in b/tests/util/
> grub-fs-tester.in
> > >> index 424de22..e3e4109 100644
> > >> --- a/tests/util/grub-fs-tester.in
> > >> +++ b/tests/util/grub-fs-tester.in
> > >> @@ -142,7 +142,7 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;
> LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +
> > >>       xsquash*)
> > >>           MINBLKSIZE=3D4096
> > >>           MAXBLKSIZE=3D1048576;;
> > >> -     xxfs)
> > >> +     xxfs|xf2fs)
> > >>           MINBLKSIZE=3D$SECSIZE
> > >>               # OS Limitation: GNU/Linux doesn't accept > 4096
> > >>           MAXBLKSIZE=3D4096;;
> > >> @@ -265,6 +265,10 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;
> LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +
> > >>               x"btrfs"*)
> > >>                   FSLABEL=3D"grub_;/test=C3=A9=F0=AF=A6=9B=F0=AF=A6=
=9D=F0=9F=98=81=D0=BA=D0=B8=D1=80=D0=B8=D1=82i
> urewfceniuewruevrewnuuireurevueurnievrewfnerfcnevirivinrewvn
> irewnivrewiuvcrewvnuewvrrrewniuerwreiuviurewiuviurewnuvewnvr
> enurnunuvrevuurerejiremvreijnvcreivire nverivnreivrevnureiorfnfrvoeoi
> roireoireoifrefoieroifoireoif";;
> > >>
> > >> +         # FS LIMITATION: f2fs label is at most 512 UTF-16 chars
> > >> +             x"f2fs")
> > >> +                 FSLABEL=3D"grub_;/test=C3=A9=E4=8F=8C=E4=90=93=E4=
=8F=95=D0=BA=D0=B8=D1=80=D0=B8=D1=82iurewfceniuewruew
> nuuireurevueurnievrewfnerfcnevirivinrewvnirewnivrewiuvcrewvn
> uewvrrrewniuerwreiuviurewiuviurewnuvewnvrenurnunuvrevuurerejiremvreijnvvc=
reivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoirvcreivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoircreivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoireoifoiq";;
> > >> +
> > >>           # FS LIMITATION: exfat is at most 15 UTF-16 chars
> > >>               x"exfat")
> > >>                   FSLABEL=3D"g=C3=A9=D1=82 ;/=F0=AF=A6=9B=F0=AF=A6=
=9D=F0=9F=98=81=D0=BA=D0=B8=D1=80";;
> > >> @@ -474,7 +478,7 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;
> LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +
> > >>           # FIXME: Not sure about BtrFS, NTFS, JFS, AFS, UDF and SFS=
.
> Check it.
> > >>       # FS LIMITATION: as far as I know those FS don't store their
> last modification date.
> > >>               x"jfs_caseins" | x"jfs" | x"xfs" | x"xfs_crc" |
> x"btrfs"* | x"reiserfs_old" | x"reiserfs" \
> > >> -                 | x"bfs" | x"afs" \
> > >> +                 | x"bfs" | x"afs" | x"f2fs" \
> > >>                   | x"tarfs" | x"cpio_"* | x"minix" | x"minix2" \
> > >>                   | x"minix3" | x"ntfs"* | x"udf" | x"sfs"*)
> > >>                   NOFSTIME=3Dy;;
> > >> @@ -753,6 +757,8 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;
> LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +
> > >>                   MOUNTDEVICE=3D"/dev/mapper/grub_test-testvol"
> > >>                   MOUNTFS=3Dext2
> > >>                   "mkfs.ext2" -L "$FSLABEL" -q "${MOUNTDEVICE}"  ;;
> > >> +             xf2fs)
> > >> +                 "mkfs.f2fs" -l "$FSLABEL" -q "${LODEVICES[0]}" ;;
> > >>               xnilfs2)
> > >>                   "mkfs.nilfs2" -L "$FSLABEL" -b $BLKSIZE  -q
> "${LODEVICES[0]}" ;;
> > >>               xext2_old)
> > >> --
> > >> 2.6.3
> > >>
> > >>
> > >> ------------------------------------------------------------
> ------------------
> > >> Site24x7 APM Insight: Get Deep Visibility into Application Performan=
ce
> > >> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> > >> Monitor end-to-end web transactions and take corrective actions now
> > >> Troubleshoot faster and improve end-user experience. Signup Now!
> > >> http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&iu=3D/4140
> > >> _______________________________________________
> > >> Linux-f2fs-devel mailing list
> > >> Linux-f2fs-devel@lists.sourceforge.net
> > >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel
>

--001a114b2fe8b25004053957ea81
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;=C2=A0<span style=3D"font-size:12.8px">BTW, I&#39;ve h=
eard that openmandriva adopted this patch to support F2FS in their</span><b=
r style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">installer.</s=
pan><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=
=3D"font-size:12.8px">And I&#39;ve ported it to clover&#39;s GrubFSPkg whic=
h I&#39;m using for EFIDroid :)</span></div><div><span style=3D"font-size:1=
2.8px">Your timing was really perfect. The day I needed f2fs support I foun=
d your V1 in the mailing list :D</span></div><div><span style=3D"font-size:=
12.8px"><a href=3D"https://github.com/efidroid/uefi_edk2packages_GrubFSPkg/=
blob/master/grub/grub-core/fs/f2fs.c">https://github.com/efidroid/uefi_edk2=
packages_GrubFSPkg/blob/master/grub/grub-core/fs/f2fs.c</a></span><br></div=
><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D=
"font-size:12.8px">Thanks</span></div><div><span style=3D"font-size:12.8px"=
>Michael</span></div></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Fri, Aug 5, 2016 at 8:07 PM, Jaegeuk Kim <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jaegeuk@kernel.org" target=3D"_blank">jaegeuk@kernel.org=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">O=
n Fri, Aug 05, 2016 at 01:57:37PM +0300, Andrei Borzenkov wrote:<br>
&gt; Vladimir prefers to postpone new features until 2.02 is out. From my<b=
r>
&gt; side I think it is isolated enough and new code so low regression<br>
&gt; risk. Vladimir has the final word as maintainer :)<br>
<br>
</span>Okay, I can wait for 2.02. ;)<br>
BTW, I&#39;ve heard that openmandriva adopted this patch to support F2FS in=
 their<br>
installer.<br>
<br>
Thanks,<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Thu, Aug 4, 2016 at 8:06 PM, Jaegeuk Kim &lt;<a href=3D"mailto:jaeg=
euk@kernel.org">jaegeuk@kernel.org</a>&gt; wrote:<br>
&gt; &gt; Hi Andrei,<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s been sitting for a long long time.<br>
&gt; &gt; May I ask whether or not there is any merging plan of this?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Mar 03, 2016 at 01:36:53PM -0800, Jaegeuk Kim wrote:<br>
&gt; &gt;&gt; Change log from v7:<br>
&gt; &gt;&gt;=C2=A0 - fix an offset bug in read_file<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -- &gt;8 --<br>
&gt; &gt;&gt; From d774cdecc2fee18ed44098c88d2a54<wbr>d358bc04d3 Mon Sep 17=
 00:00:00 2001<br>
&gt; &gt;&gt; From: Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk@kernel.org">j=
aegeuk@kernel.org</a>&gt;<br>
&gt; &gt;&gt; Date: Tue, 17 Nov 2015 12:45:13 -0800<br>
&gt; &gt;&gt; Subject: [PATCH] F2FS support<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &quot;F2FS (Flash-Friendly File System) is flash-friendly fil=
e system which was merged<br>
&gt; &gt;&gt; into Linux kernel v3.8 in 2013.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The motive for F2FS was to build a file system that from the =
start, takes into<br>
&gt; &gt;&gt; account the characteristics of NAND flash memory-based storag=
e devices (such as<br>
&gt; &gt;&gt; solid-state disks, eMMC, and SD cards).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; F2FS was designed on a basis of a log-structured file system =
approach, which<br>
&gt; &gt;&gt; remedies some known issues of the older log structured file s=
ystems, such as<br>
&gt; &gt;&gt; the snowball effect of wandering trees and high cleaning over=
head. In addition,<br>
&gt; &gt;&gt; since a NAND-based storage device shows different characteris=
tics according to<br>
&gt; &gt;&gt; its internal geometry or flash memory management scheme (such=
 as the Flash<br>
&gt; &gt;&gt; Translation Layer or FTL), it supports various parameters not=
 only for<br>
&gt; &gt;&gt; configuring on-disk layout, but also for selecting allocation=
 and cleaning<br>
&gt; &gt;&gt; algorithm.&quot;, quote by <a href=3D"https://en.wikipedia.or=
g/wiki/F2FS" rel=3D"noreferrer" target=3D"_blank">https://en.wikipedia.org/=
wiki/<wbr>F2FS</a>.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The source codes for F2FS are available from:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; <a href=3D"http://git.kernel.org/cgit/linux/kernel/git/jaegeu=
k/f2fs.git" rel=3D"noreferrer" target=3D"_blank">http://git.kernel.org/cgit=
/<wbr>linux/kernel/git/jaegeuk/f2fs.<wbr>git</a><br>
&gt; &gt;&gt; <a href=3D"http://git.kernel.org/cgit/linux/kernel/git/jaegeu=
k/f2fs-tools.git" rel=3D"noreferrer" target=3D"_blank">http://git.kernel.or=
g/cgit/<wbr>linux/kernel/git/jaegeuk/f2fs-<wbr>tools.git</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk@kern=
el.org">jaegeuk@kernel.org</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 Makefile.util.def=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 7 +<br>
&gt; &gt;&gt;=C2=A0 docs/grub.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 5 +-<br>
&gt; &gt;&gt;=C2=A0 grub-core/Makefile.core.def=C2=A0 |=C2=A0 =C2=A0 5 +<br=
>
&gt; &gt;&gt;=C2=A0 grub-core/fs/f2fs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 1289 ++++++++++++++++++++++++++++++<wbr>++++++++++++<br>
&gt; &gt;&gt;=C2=A0 po/exclude.pot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt; &gt;&gt;=C2=A0 tests/<a href=3D"http://f2fs_test.in" rel=3D"noreferrer=
" target=3D"_blank">f2fs_test.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A019 +<br>
&gt; &gt;&gt;=C2=A0 tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"=
noreferrer" target=3D"_blank">grub-fs-tester.in</a> |=C2=A0 =C2=A010 +-<br>
&gt; &gt;&gt;=C2=A0 7 files changed, 1332 insertions(+), 4 deletions(-)<br>
&gt; &gt;&gt;=C2=A0 create mode 100644 grub-core/fs/f2fs.c<br>
&gt; &gt;&gt;=C2=A0 create mode 100644 tests/<a href=3D"http://f2fs_test.in=
" rel=3D"noreferrer" target=3D"_blank">f2fs_test.in</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/Makefile.util.def b/Makefile.util.def<br>
&gt; &gt;&gt; index db7e8ec..84627bb 100644<br>
&gt; &gt;&gt; --- a/Makefile.util.def<br>
&gt; &gt;&gt; +++ b/Makefile.util.def<br>
&gt; &gt;&gt; @@ -99,6 +99,7 @@ library =3D {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/ext2.c;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/fat.c;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/exfat.c;<br>
&gt; &gt;&gt; +=C2=A0 common =3D grub-core/fs/f2fs.c;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/fshelp.c;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/hfs.c;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/hfsplus.c;<br>
&gt; &gt;&gt; @@ -766,6 +767,12 @@ script =3D {<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 script =3D {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 testcase;<br>
&gt; &gt;&gt; +=C2=A0 name =3D f2fs_test;<br>
&gt; &gt;&gt; +=C2=A0 common =3D tests/<a href=3D"http://f2fs_test.in" rel=
=3D"noreferrer" target=3D"_blank">f2fs_test.in</a>;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +script =3D {<br>
&gt; &gt;&gt; +=C2=A0 testcase;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 name =3D nilfs2_test;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D tests/<a href=3D"http://nilfs2_test.i=
n" rel=3D"noreferrer" target=3D"_blank">nilfs2_test.in</a>;<br>
&gt; &gt;&gt;=C2=A0 };<br>
&gt; &gt;&gt; diff --git a/docs/grub.texi b/docs/grub.texi<br>
&gt; &gt;&gt; index 1df3db2..e5a80f3 100644<br>
&gt; &gt;&gt; --- a/docs/grub.texi<br>
&gt; &gt;&gt; +++ b/docs/grub.texi<br>
&gt; &gt;&gt; @@ -360,7 +360,8 @@ blocklist notation. The currently support=
ed filesystem types are @dfn{Amiga<br>
&gt; &gt;&gt;=C2=A0 Fast FileSystem (AFFS)}, @dfn{AtheOS fs}, @dfn{BeFS},<b=
r>
&gt; &gt;&gt;=C2=A0 @dfn{BtrFS} (including raid0, raid1, raid10, gzip and l=
zo),<br>
&gt; &gt;&gt;=C2=A0 @dfn{cpio} (little- and big-endian bin, odc and newc va=
riants),<br>
&gt; &gt;&gt; -@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @df=
n{exFAT}, @dfn{HFS},<br>
&gt; &gt;&gt; +@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @df=
n{exFAT},<br>
&gt; &gt;&gt; +@dfn{f2fs}, @dfn{HFS},<br>
&gt; &gt;&gt;=C2=A0 @dfn{HFS+}, @dfn{ISO9660} (including Joliet, Rock-ridge=
 and multi-chunk files),<br>
&gt; &gt;&gt;=C2=A0 @dfn{JFS}, @dfn{Minix fs} (versions 1, 2 and 3), @dfn{n=
ilfs2},<br>
&gt; &gt;&gt;=C2=A0 @dfn{NTFS} (including compression), @dfn{ReiserFS}, @df=
n{ROMFS},<br>
&gt; &gt;&gt; @@ -5347,7 +5348,7 @@ NTFS, JFS, UDF, HFS+, exFAT, long filen=
ames in FAT, Joliet part of<br>
&gt; &gt;&gt;=C2=A0 ISO9660 are treated as UTF-16 as per specification. AFS=
 and BFS are read<br>
&gt; &gt;&gt;=C2=A0 as UTF-8, again according to specification. BtrFS, cpio=
, tar, squash4, minix,<br>
&gt; &gt;&gt;=C2=A0 minix2, minix3, ROMFS, ReiserFS, XFS, ext2, ext3, ext4,=
 FAT (short names),<br>
&gt; &gt;&gt; -RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are as=
sumed<br>
&gt; &gt;&gt; +f2fs, RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS =
are assumed<br>
&gt; &gt;&gt;=C2=A0 to be UTF-8. This might be false on systems configured =
with legacy charset<br>
&gt; &gt;&gt;=C2=A0 but as long as the charset used is superset of ASCII yo=
u should be able to<br>
&gt; &gt;&gt;=C2=A0 access ASCII-named files. And it&#39;s recommended to c=
onfigure your system to use<br>
&gt; &gt;&gt; diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile=
.core.def<br>
&gt; &gt;&gt; index d9fa0e3..b585ade 100644<br>
&gt; &gt;&gt; --- a/grub-core/Makefile.core.def<br>
&gt; &gt;&gt; +++ b/grub-core/Makefile.core.def<br>
&gt; &gt;&gt; @@ -1278,6 +1278,11 @@ module =3D {<br>
&gt; &gt;&gt;=C2=A0 };<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 module =3D {<br>
&gt; &gt;&gt; +=C2=A0 name =3D f2fs;<br>
&gt; &gt;&gt; +=C2=A0 common =3D fs/f2fs.c;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +module =3D {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 name =3D fshelp;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 common =3D fs/fshelp.c;<br>
&gt; &gt;&gt;=C2=A0 };<br>
&gt; &gt;&gt; diff --git a/grub-core/fs/f2fs.c b/grub-core/fs/f2fs.c<br>
&gt; &gt;&gt; new file mode 100644<br>
&gt; &gt;&gt; index 0000000..7fb256f<br>
&gt; &gt;&gt; --- /dev/null<br>
&gt; &gt;&gt; +++ b/grub-core/fs/f2fs.c<br>
&gt; &gt;&gt; @@ -0,0 +1,1289 @@<br>
&gt; &gt;&gt; +/*<br>
&gt; &gt;&gt; + *=C2=A0 f2fs.c - Flash-Friendly File System<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + *=C2=A0 Written by Jaegeuk Kim &lt;<a href=3D"mailto:jaegeu=
k@kernel.org">jaegeuk@kernel.org</a>&gt;<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + *=C2=A0 Copyright (C) 2015=C2=A0 Free Software Foundation, =
Inc.<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + *=C2=A0 GRUB is free software: you can redistribute it and/=
or modify<br>
&gt; &gt;&gt; + *=C2=A0 it under the terms of the GNU General Public Licens=
e as published by<br>
&gt; &gt;&gt; + *=C2=A0 the Free Software Foundation, either version 3 of t=
he License, or<br>
&gt; &gt;&gt; + *=C2=A0 (at your option) any later version.<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + *=C2=A0 GRUB is distributed in the hope that it will be use=
ful,<br>
&gt; &gt;&gt; + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied =
warranty of<br>
&gt; &gt;&gt; + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
.=C2=A0 See the<br>
&gt; &gt;&gt; + *=C2=A0 GNU General Public License for more details.<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + *=C2=A0 You should have received a copy of the GNU General =
Public License<br>
&gt; &gt;&gt; + *=C2=A0 along with GRUB.=C2=A0 If not, see &lt;<a href=3D"h=
ttp://www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://ww=
w.gnu.org/licenses/</a>&gt;<wbr>.<br>
&gt; &gt;&gt; + */<br>
&gt; &gt;&gt; +#include &lt;grub/err.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/file.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/mm.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/misc.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/disk.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/dl.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/types.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/charset.h&gt;<br>
&gt; &gt;&gt; +#include &lt;grub/fshelp.h&gt;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +GRUB_MOD_LICENSE (&quot;GPLv3+&quot;);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/* F2FS Magic Number */<br>
&gt; &gt;&gt; +#define F2FS_SUPER_MAGIC=C2=A0 =C2=A0 =C2=A00xF2F52010<br>
&gt; &gt;&gt; +#define CHECKSUM_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 4092=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* must be alig=
ned 4 bytes */<br>
&gt; &gt;&gt; +#define U32_CHECKSUM_OFFSET=C2=A0 (CHECKSUM_OFFSET &gt;&gt; =
2)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/* byte-size offset */<br>
&gt; &gt;&gt; +#define F2FS_SUPER_OFFSET=C2=A0 =C2=A0 ((grub_disk_addr_t)10=
24)<br>
&gt; &gt;&gt; +#define F2FS_SUPER_OFFSET0=C2=A0 =C2=A0(F2FS_SUPER_OFFSET &g=
t;&gt; GRUB_DISK_SECTOR_BITS)<br>
&gt; &gt;&gt; +#define F2FS_SUPER_OFFSET1=C2=A0 =C2=A0((F2FS_SUPER_OFFSET +=
 F2FS_BLKSIZE) &gt;&gt;=C2=A0 \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0GRUB_DISK_SECTOR_BITS)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/* 9 bits for 512 bytes */<br>
&gt; &gt;&gt; +#define F2FS_MIN_LOG_SECTOR_SIZE=C2=A0 =C2=A0 =C2=A09<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/* support only 4KB block */<br>
&gt; &gt;&gt; +#define F2FS_BLK_BITS=C2=A0 =C2=A0 =C2=A0 =C2=A0 12<br>
&gt; &gt;&gt; +#define F2FS_BLKSIZE (1 &lt;&lt; F2FS_BLK_BITS)<br>
&gt; &gt;&gt; +#define F2FS_BLK_SEC_BITS=C2=A0 =C2=A0 (F2FS_BLK_BITS - GRUB=
_DISK_SECTOR_BITS)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define VERSION_LEN=C2=A0 256<br>
&gt; &gt;&gt; +#define F2FS_MAX_EXTENSION=C2=A0 =C2=A064<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define CP_COMPACT_SUM_FLAG=C2=A0 0x00000004<br>
&gt; &gt;&gt; +#define CP_UMOUNT_FLAG=C2=A0 =C2=A0 =C2=A0 =C2=A00x00000001<=
br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define MAX_ACTIVE_LOGS=C2=A0 =C2=A0 =C2=A0 16<br>
&gt; &gt;&gt; +#define MAX_ACTIVE_NODE_LOGS 8<br>
&gt; &gt;&gt; +#define MAX_ACTIVE_DATA_LOGS 8<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 NR_CURSEG_DATA_TYPE=C2=A0 =C2=A0=
 =C2=A03<br>
&gt; &gt;&gt; +#define NR_CURSEG_NODE_TYPE=C2=A0 3<br>
&gt; &gt;&gt; +#define NR_CURSEG_TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0(NR_CURSEG_=
DATA_TYPE + NR_CURSEG_NODE_TYPE)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define ENTRIES_IN_SUM=C2=A0 =C2=A0 =C2=A0 =C2=A0512<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 SUMMARY_SIZE=C2=A0 =C2=A0 7<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 SUM_FOOTER_SIZE 5<br>
&gt; &gt;&gt; +#define JENTRY_SIZE=C2=A0 (sizeof(struct grub_f2fs_nat_jent)=
)<br>
&gt; &gt;&gt; +#define SUM_ENTRIES_SIZE=C2=A0 =C2=A0 =C2=A0(SUMMARY_SIZE * =
ENTRIES_IN_SUM)<br>
&gt; &gt;&gt; +#define SUM_JOURNAL_SIZE=C2=A0 =C2=A0 =C2=A0(F2FS_BLKSIZE - =
SUM_FOOTER_SIZE -\<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUM_ENTRIES_SIZE)<br>
&gt; &gt;&gt; +#define NAT_JOURNAL_ENTRIES=C2=A0 ((SUM_JOURNAL_SIZE - 2) / =
JENTRY_SIZE)<br>
&gt; &gt;&gt; +#define NAT_JOURNAL_RESERVED ((SUM_JOURNAL_SIZE - 2) % JENTR=
Y_SIZE)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define NAT_ENTRY_SIZE (sizeof(struct grub_f2fs_nat_entry))<=
br>
&gt; &gt;&gt; +#define NAT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / NAT_ENTRY_SIZE)<=
br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define F2FS_NAME_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 255<br>
&gt; &gt;&gt; +#define F2FS_SLOT_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; &gt;&gt; +#define NR_DENTRY_IN_BLOCK=C2=A0 =C2=A0214<br>
&gt; &gt;&gt; +#define SIZE_OF_DIR_ENTRY=C2=A0 =C2=A0 11=C2=A0 =C2=A0 =C2=
=A0 /* by byte */<br>
&gt; &gt;&gt; +#define BITS_PER_BYTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; &gt;&gt; +#define SIZE_OF_DENTRY_BITMAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((N=
R_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BITS_PER_BYTE)<br>
&gt; &gt;&gt; +#define SIZE_OF_RESERVED=C2=A0 =C2=A0 =C2=A0(F2FS_BLKSIZE - =
((SIZE_OF_DIR_ENTRY + \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0F2FS_SLOT_LEN) * \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NR_DENTRY_IN_BLOCK + SIZE_OF_D=
ENTRY_BITMAP))<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define F2FS_INLINE_XATTR_ADDRS=C2=A0 =C2=A0 =C2=A0 50=C2=A0=
 =C2=A0 =C2=A0 /* 200 bytes for inline xattrs */<br>
&gt; &gt;&gt; +#define DEF_ADDRS_PER_INODE=C2=A0 923=C2=A0 =C2=A0 =C2=A0/* =
Address Pointers in an Inode */<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define ADDRS_PER_BLOCK=C2=A0 =C2=A0 =C2=A0 1018=C2=A0 =C2=
=A0 /* Address Pointers in a Direct Block */<br>
&gt; &gt;&gt; +#define NIDS_PER_BLOCK=C2=A0 =C2=A0 =C2=A0 =C2=A01018=C2=A0 =
=C2=A0 /* Node IDs in an Indirect Block */<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_DIR1_BLOCK (DEF_ADDRS_PER_I=
NODE + 1)<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_DIR2_BLOCK (DEF_ADDRS_PER_I=
NODE + 2)<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_IND1_BLOCK (DEF_ADDRS_PER_I=
NODE + 3)<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_IND2_BLOCK (DEF_ADDRS_PER_I=
NODE + 4)<br>
&gt; &gt;&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_DIND_BLOCK (DEF_ADDRS_PER_I=
NODE + 5)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define MAX_INLINE_DATA=C2=A0 =C2=A0 =C2=A0 (4 * (DEF_ADDRS_=
PER_INODE - \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0F2FS_INLINE_XATTR_ADDRS - 1))<br>
&gt; &gt;&gt; +#define NR_INLINE_DENTRY=C2=A0 =C2=A0 =C2=A0(MAX_INLINE_DATA=
 * BITS_PER_BYTE / \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 BITS_PER_BYTE + 1))<br>
&gt; &gt;&gt; +#define INLINE_DENTRY_BITMAP_SIZE=C2=A0 =C2=A0 ((NR_INLINE_D=
ENTRY + \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BITS_PER_BYTE - 1) / BITS_PER_BYTE)<br>
&gt; &gt;&gt; +#define INLINE_RESERVED_SIZE (MAX_INLINE_DATA - \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE))<br>
&gt; &gt;&gt; +#define CURSEG_HOT_DATA=C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define CKPT_FLAG_SET(ckpt, f)=C2=A0 =C2=A0 =C2=A0 =C2=A0\<b=
r>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ckpt)-&gt;c=
kpt_flags &amp; grub_cpu_to_le32_compile_time (f)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define F2FS_INLINE_XATTR=C2=A0 =C2=A0 0x01=C2=A0 =C2=A0 /* =
file inline xattr flag */<br>
&gt; &gt;&gt; +#define F2FS_INLINE_DATA=C2=A0 =C2=A0 =C2=A00x02=C2=A0 =C2=
=A0 /* file inline data flag */<br>
&gt; &gt;&gt; +#define F2FS_INLINE_DENTRY=C2=A0 =C2=A00x04=C2=A0 =C2=A0 /* =
file inline dentry flag */<br>
&gt; &gt;&gt; +#define F2FS_DATA_EXIST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x08=C2=A0 =C2=A0 /* file inline data exist flag */<br>
&gt; &gt;&gt; +#define F2FS_INLINE_DOTS=C2=A0 =C2=A0 =C2=A00x10=C2=A0 =C2=
=A0 /* file having implicit dot dentries */<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +enum FILE_TYPE<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 F2FS_FT_UNKNOWN,<br>
&gt; &gt;&gt; +=C2=A0 F2FS_FT_REG_FILE =3D 1,<br>
&gt; &gt;&gt; +=C2=A0 F2FS_FT_DIR =3D 2,<br>
&gt; &gt;&gt; +=C2=A0 F2FS_FT_SYMLINK =3D 7,<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define MAX_VOLUME_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 512<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_superblock<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t magic;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t dummy1[2];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t log_sectorsize;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t log_sectors_per_block;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t log_blocksize;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t log_blocks_per_seg;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t segs_per_sec;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t secs_per_zone;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t checksum_offset;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t dummy2[40];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cp_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t sit_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t nat_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t ssa_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t main_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t root_ino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t node_ino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t meta_ino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t uuid[16];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t volume_name[MAX_VOLUME_NAME];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t extension_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t extension_list[F2FS_MAX_<wbr>EXTENSION][=
8];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cp_payload;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t version[VERSION_LEN];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t init_version[VERSION_LEN];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_checkpoint<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t checkpoint_ver;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t user_block_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t valid_block_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t rsvd_segment_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t overprov_segment_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t free_segment_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cur_node_segno[MAX_ACTIVE_<wbr>NODE_LOG=
S];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t cur_node_blkoff[MAX_ACTIVE_<wbr>NODE_LO=
GS];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cur_data_segno[MAX_ACTIVE_<wbr>DATA_LOG=
S];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t cur_data_blkoff[MAX_ACTIVE_<wbr>DATA_LO=
GS];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t ckpt_flags;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cp_pack_total_block_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cp_pack_start_sum;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t valid_node_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t valid_inode_count;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t next_free_nid;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t sit_ver_bitmap_bytesize;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t nat_ver_bitmap_bytesize;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t checksum_offset;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t elapsed_time;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t alloc_type[MAX_ACTIVE_LOGS];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t sit_nat_version_bitmap[3900];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t checksum;<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_nat_entry {<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t version;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t ino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t block_addr;<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_nat_jent<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t nid;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_nat_entry ne;<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_nat_journal {<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t n_nats;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_nat_jent entries[NAT_JOURNAL_ENTRIES=
];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t reserved[NAT_JOURNAL_RESERVED]<wbr>;<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_nat_block {<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_nat_entry ne[NAT_ENTRY_PER_BLOCK];<b=
r>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_dir_entry<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t hash_code;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t ino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t name_len;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t file_type;<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_inline_dentry<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t dentry_bitmap[INLINE_DENTRY_<wbr>BITMAP_=
SIZE];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t reserved[INLINE_RESERVED_SIZE]<wbr>;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_dir_entry dentry[NR_INLINE_DENTRY];<=
br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t filename[NR_INLINE_DENTRY][<wbr>F2FS_SLO=
T_LEN];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_dentry_block {<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t dentry_bitmap[SIZE_OF_DENTRY_<wbr>BITMAP=
];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t reserved[SIZE_OF_RESERVED];<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_dir_entry dentry[NR_DENTRY_IN_BLOCK]=
;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t filename[NR_DENTRY_IN_BLOCK][<wbr>F2FS_S=
LOT_LEN];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_inode<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t i_mode;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t i_advise;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t i_inline;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_uid;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_gid;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_links;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t i_size;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t i_blocks;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t i_atime;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t i_ctime;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t i_mtime;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_atime_nsec;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_ctime_nsec;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_mtime_nsec;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_generation;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_current_depth;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_xattr_nid;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_flags;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_pino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_namelen;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t i_name[F2FS_NAME_LEN];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t i_dir_level;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t i_ext[12];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_addr[DEF_ADDRS_PER_INODE];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t i_nid[5];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_direct_node {<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t addr[ADDRS_PER_BLOCK];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_indirect_node {<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t nid[NIDS_PER_BLOCK];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_node<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 union<br>
&gt; &gt;&gt; +=C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 struct grub_f2fs_inode i;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 struct grub_direct_node dn;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 struct grub_indirect_node in;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 char buf[F2FS_BLKSIZE - 40];=C2=A0 =C2=A0 =C2=
=A0/* Should occupy F2FS_BLKSIZE totally */<br>
&gt; &gt;&gt; +=C2=A0 };<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t dummy[40];<br>
&gt; &gt;&gt; +} GRUB_PACKED;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_fshelp_node<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_node inode;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t ino;<br>
&gt; &gt;&gt; +=C2=A0 int inode_read;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_data<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_superblock sblock;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_checkpoint ckpt;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t root_ino;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t blocks_per_seg;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cp_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t nat_blkaddr;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_nat_journal nat_j;<br>
&gt; &gt;&gt; +=C2=A0 char *nat_bitmap;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_disk_t disk;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_node *inode;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_fshelp_node diropen;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_dir_iter_ctx<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; &gt;&gt; +=C2=A0 grub_fshelp_iterate_dir_hook_t hook;<br>
&gt; &gt;&gt; +=C2=A0 void *hook_data;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t *bitmap;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t (*filename)[F2FS_SLOT_LEN];<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_dir_entry *dentry;<br>
&gt; &gt;&gt; +=C2=A0 int max;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct grub_f2fs_dir_ctx<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_fs_dir_hook_t hook;<br>
&gt; &gt;&gt; +=C2=A0 void *hook_data;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_dl_t my_mod;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline int<br>
&gt; &gt;&gt; +grub_f2fs_test_bit_le (int nr, const grub_uint8_t *addr)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 return addr[nr &gt;&gt; 3] &amp; (1 &lt;&lt; (nr &amp=
; 7));<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline char *<br>
&gt; &gt;&gt; +__inline_addr (struct grub_f2fs_inode *inode)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 return (char *)&amp;inode-&gt;i_addr[1];<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_uint64_t<br>
&gt; &gt;&gt; +grub_f2fs_file_size (struct grub_f2fs_inode *inode)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 return grub_le_to_cpu64 (inode-&gt;i_size);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_uint32_t<br>
&gt; &gt;&gt; +__start_cp_addr (struct grub_f2fs_data *data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;c=
kpt;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t start_addr =3D data-&gt;cp_blkaddr;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (!(ckpt-&gt;checkpoint_ver &amp; grub_cpu_to_le64_=
compile_time(<wbr>1)))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return start_addr + data-&gt;blocks_per_seg;<b=
r>
&gt; &gt;&gt; +=C2=A0 return start_addr;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_uint32_t<br>
&gt; &gt;&gt; +__start_sum_block (struct grub_f2fs_data *data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;c=
kpt;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return __start_cp_addr (data) + grub_le_to_cpu32 (ckp=
t-&gt;cp_pack_start_sum);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_uint32_t<br>
&gt; &gt;&gt; +__sum_blk_addr (struct grub_f2fs_data *data, int base, int t=
ype)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;c=
kpt;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return __start_cp_addr (data) +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_le_to_cpu32 (ckpt-&gt;cp_pack_total=
_block_<wbr>count)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0- (base + 1) + type;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline void *<br>
&gt; &gt;&gt; +__nat_bitmap_ptr (struct grub_f2fs_data *data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;c=
kpt;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t offset;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (grub_le_to_cpu32 (data-&gt;sblock.cp_payload) &gt=
; 0)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return ckpt-&gt;sit_nat_version_bitmap;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 offset =3D grub_le_to_cpu32 (ckpt-&gt;sit_ver_bitmap_=
<wbr>bytesize);<br>
&gt; &gt;&gt; +=C2=A0 return ckpt-&gt;sit_nat_version_bitmap + offset;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_uint32_t<br>
&gt; &gt;&gt; +__get_node_id (struct grub_f2fs_node *rn, int off, int inode=
_block)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 if (inode_block)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_le_to_cpu32 (rn-&gt;i.i_nid[off - =
NODE_DIR1_BLOCK]);<br>
&gt; &gt;&gt; +=C2=A0 return grub_le_to_cpu32 (rn-&gt;in.nid[off]);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_block_read (struct grub_f2fs_data *data, grub_uint=
32_t blkaddr, void *buf)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 return grub_disk_read (data-&gt;disk,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((grub_disk_=
addr_t)blkaddr) &lt;&lt; F2FS_BLK_SEC_BITS,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, F2FS_BLKS=
IZE, buf);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/*<br>
&gt; &gt;&gt; + * CRC32<br>
&gt; &gt;&gt; +*/<br>
&gt; &gt;&gt; +#define CRCPOLY_LE 0xedb88320<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline grub_uint32_t<br>
&gt; &gt;&gt; +grub_f2fs_cal_crc32 (const void *buf, const grub_uint32_t le=
n)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t crc =3D F2FS_SUPER_MAGIC;<br>
&gt; &gt;&gt; +=C2=A0 unsigned char *p =3D (unsigned char *)buf;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t tmp =3D len;<br>
&gt; &gt;&gt; +=C2=A0 int i;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 while (tmp--)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 crc ^=3D *p++;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 8; i++)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crc =3D (crc &gt;&gt; 1) ^ ((crc=
 &amp; 1) ? CRCPOLY_LE : 0);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 return crc;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline int<br>
&gt; &gt;&gt; +grub_f2fs_crc_valid (grub_uint32_t blk_crc, void *buf, const=
 grub_uint32_t len)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t cal_crc =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 cal_crc =3D grub_f2fs_cal_crc32 (buf, len);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return (cal_crc =3D=3D blk_crc) ? 1 : 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static inline int<br>
&gt; &gt;&gt; +grub_f2fs_test_bit (grub_uint32_t nr, const char *p)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 int mask;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 p +=3D (nr &gt;&gt; 3);<br>
&gt; &gt;&gt; +=C2=A0 mask =3D 1 &lt;&lt; (7 - (nr &amp; 0x07));<br>
&gt; &gt;&gt; +=C2=A0 return mask &amp; *p;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_f2fs_sanity_check_sb (struct grub_f2fs_superblock *sb)<=
br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t log_sectorsize, log_sectors_per_block;<=
br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (sb-&gt;magic !=3D grub_cpu_to_le32_compile_time (=
F2FS_SUPER_MAGIC))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (sb-&gt;log_blocksize !=3D grub_cpu_to_le32_compil=
e_time (F2FS_BLK_BITS))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 log_sectorsize =3D grub_le_to_cpu32 (sb-&gt;log_secto=
rsize);<br>
&gt; &gt;&gt; +=C2=A0 log_sectors_per_block =3D grub_le_to_cpu32 (sb-&gt;lo=
g_sectors_per_block);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (log_sectorsize &gt; F2FS_BLK_BITS)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (log_sectorsize &lt; F2FS_MIN_LOG_SECTOR_SIZE)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (log_sectors_per_block + log_sectorsize !=3D F2FS_=
BLK_BITS)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_f2fs_read_sb (struct grub_f2fs_data *data, grub_disk_ad=
dr_t offset)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_disk_t disk =3D data-&gt;disk;<br>
&gt; &gt;&gt; +=C2=A0 grub_err_t err;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 /* Read first super block. */<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_disk_read (disk, offset, 0, sizeof (data=
-&gt;sblock), &amp;data-&gt;sblock);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return grub_f2fs_sanity_check_sb (&amp;data-&gt;sbloc=
k);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static void *<br>
&gt; &gt;&gt; +validate_checkpoint (struct grub_f2fs_data *data, grub_uint3=
2_t cp_addr,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_uint64_t *version)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t *cp_page_1, *cp_page_2;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_checkpoint *cp_block;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t cur_version =3D 0, pre_version =3D 0;<b=
r>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t crc =3D 0;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t crc_offset;<br>
&gt; &gt;&gt; +=C2=A0 grub_err_t err;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 /* Read the 1st cp block in this CP pack */<br>
&gt; &gt;&gt; +=C2=A0 cp_page_1 =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; &gt;&gt; +=C2=A0 if (!cp_page_1)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, cp_addr, cp_page_=
1);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_1=
;<br>
&gt; &gt;&gt; +=C2=A0 crc_offset =3D grub_le_to_cpu32 (cp_block-&gt;checksu=
m_offset);<br>
&gt; &gt;&gt; +=C2=A0 if (crc_offset !=3D CHECKSUM_OFFSET)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 crc =3D grub_le_to_cpu32 (*(cp_page_1 + U32_CHECKSUM_=
OFFSET));<br>
&gt; &gt;&gt; +=C2=A0 if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 pre_version =3D grub_le_to_cpu64 (cp_block-&gt;checkp=
oint_ver);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 /* Read the 2nd cp block in this CP pack */<br>
&gt; &gt;&gt; +=C2=A0 cp_page_2 =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; &gt;&gt; +=C2=A0 if (!cp_page_2)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 cp_addr +=3D grub_le_to_cpu32 (cp_block-&gt;cp_pack_t=
otal_<wbr>block_count) - 1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, cp_addr, cp_page_=
2);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp2;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_2=
;<br>
&gt; &gt;&gt; +=C2=A0 crc_offset =3D grub_le_to_cpu32 (cp_block-&gt;checksu=
m_offset);<br>
&gt; &gt;&gt; +=C2=A0 if (crc_offset !=3D CHECKSUM_OFFSET)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp2;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 crc =3D grub_le_to_cpu32 (*(cp_page_2 + U32_CHECKSUM_=
OFFSET));<br>
&gt; &gt;&gt; +=C2=A0 if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto invalid_cp2;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 cur_version =3D grub_le_to_cpu64 (cp_block-&gt;checkp=
oint_ver);<br>
&gt; &gt;&gt; +=C2=A0 if (cur_version =3D=3D pre_version)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 *version =3D cur_version;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (cp_page_2);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 return cp_page_1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +invalid_cp2:<br>
&gt; &gt;&gt; +=C2=A0 grub_free (cp_page_2);<br>
&gt; &gt;&gt; +invalid_cp1:<br>
&gt; &gt;&gt; +=C2=A0 grub_free (cp_page_1);<br>
&gt; &gt;&gt; +=C2=A0 return NULL;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_read_cp (struct grub_f2fs_data *data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 void *cp1, *cp2, *cur_page;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t cp1_version =3D 0, cp2_version =3D 0;<b=
r>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t cp_start_blk_no;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 /*<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0* Finding out valid cp block involves read both=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0* sets (cp pack1 and cp pack 2)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; +=C2=A0 cp_start_blk_no =3D data-&gt;cp_blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 cp1 =3D validate_checkpoint (data, cp_start_blk_no, &=
amp;cp1_version);<br>
&gt; &gt;&gt; +=C2=A0 if (!cp1 &amp;&amp; grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 /* The second checkpoint pack should start at the nex=
t segment */<br>
&gt; &gt;&gt; +=C2=A0 cp_start_blk_no +=3D data-&gt;blocks_per_seg;<br>
&gt; &gt;&gt; +=C2=A0 cp2 =3D validate_checkpoint (data, cp_start_blk_no, &=
amp;cp2_version);<br>
&gt; &gt;&gt; +=C2=A0 if (!cp2 &amp;&amp; grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (cp1);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (cp1 &amp;&amp; cp2)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 cur_page =3D (cp2_version &gt; cp1_version) ? =
cp2 : cp1;<br>
&gt; &gt;&gt; +=C2=A0 else if (cp1)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 cur_page =3D cp1;<br>
&gt; &gt;&gt; +=C2=A0 else if (cp2)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 cur_page =3D cp2;<br>
&gt; &gt;&gt; +=C2=A0 else<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_error (GRUB_ERR_BAD_FS, &quot;no c=
heckpoints&quot;);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_memcpy (&amp;data-&gt;ckpt, cur_page, F2FS_BLKSI=
ZE);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_free (cp1);<br>
&gt; &gt;&gt; +=C2=A0 grub_free (cp2);<br>
&gt; &gt;&gt; +=C2=A0 return 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +get_nat_journal (struct grub_f2fs_data *data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t block;<br>
&gt; &gt;&gt; +=C2=A0 char *buf;<br>
&gt; &gt;&gt; +=C2=A0 grub_err_t err;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 buf =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; &gt;&gt; +=C2=A0 if (!buf)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (CKPT_FLAG_SET(&amp;data-&gt;ckpt, CP_COMPACT_SUM_=
FLAG))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 block =3D __start_sum_block (data);<br>
&gt; &gt;&gt; +=C2=A0 else if (CKPT_FLAG_SET (&amp;data-&gt;ckpt, CP_UMOUNT=
_FLAG))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 block =3D __sum_blk_addr (data, NR_CURSEG_TYPE=
, CURSEG_HOT_DATA);<br>
&gt; &gt;&gt; +=C2=A0 else<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 block =3D __sum_blk_addr (data, NR_CURSEG_DATA=
_TYPE, CURSEG_HOT_DATA);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, block, buf);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (CKPT_FLAG_SET (&amp;data-&gt;ckpt, CP_COMPACT_SUM=
_FLAG))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 grub_memcpy (&amp;data-&gt;nat_j, buf, SUM_JOU=
RNAL_SIZE);<br>
&gt; &gt;&gt; +=C2=A0 else<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 grub_memcpy (&amp;data-&gt;nat_j, buf + SUM_EN=
TRIES_SIZE, SUM_JOURNAL_SIZE);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +fail:<br>
&gt; &gt;&gt; +=C2=A0 grub_free (buf);<br>
&gt; &gt;&gt; +=C2=A0 return err;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_uint32_t<br>
&gt; &gt;&gt; +get_blkaddr_from_nat_journal (struct grub_f2fs_data *data, g=
rub_uint32_t nid)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t n =3D grub_le_to_cpu16 (data-&gt;nat_j.=
n_nats);<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t blkaddr =3D 0;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t i;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 for (i =3D 0; i &lt; n; i++)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_le_to_cpu32 (data-&gt;nat_j.en=
tries[i].nid) =3D=3D nid)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blkaddr =3D grub_le_to_cp=
u32 (data-&gt;nat_j.entries[i].ne.<wbr>block_addr);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 return blkaddr;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_uint32_t<br>
&gt; &gt;&gt; +get_node_blkaddr (struct grub_f2fs_data *data, grub_uint32_t=
 nid)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_nat_block *nat_block;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t seg_off, block_off, entry_off, block_ad=
dr;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t blkaddr;<br>
&gt; &gt;&gt; +=C2=A0 grub_err_t err;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 blkaddr =3D get_blkaddr_from_nat_journal (data, nid);=
<br>
&gt; &gt;&gt; +=C2=A0 if (blkaddr)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return blkaddr;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 nat_block =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; &gt;&gt; +=C2=A0 if (!nat_block)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block_off =3D nid / NAT_ENTRY_PER_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 entry_off =3D nid % NAT_ENTRY_PER_BLOCK;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 seg_off =3D block_off / data-&gt;blocks_per_seg;<br>
&gt; &gt;&gt; +=C2=A0 block_addr =3D data-&gt;nat_blkaddr +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0((seg_off * data-&gt;blocks_per_seg) &lt=
;&lt; 1) +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0(block_off &amp; (data-&gt;blocks_per_se=
g - 1));<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (grub_f2fs_test_bit (block_off, data-&gt;nat_bitma=
p))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 block_addr +=3D data-&gt;blocks_per_seg;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, block_addr, nat_b=
lock);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (nat_block);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 blkaddr =3D grub_le_to_cpu32 (nat_block-&gt;ne[entry_=
off].<wbr>block_addr);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_free (nat_block);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return blkaddr;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_get_node_path (struct grub_f2fs_inode *inode, grub_uint=
32_t block,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_uint32_t offset[4], grub_uint32_t n=
offset[4])<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t direct_blks =3D ADDRS_PER_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t dptrs_per_blk =3D NIDS_PER_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t indirect_blks =3D ADDRS_PER_BLOCK * NID=
S_PER_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t dindirect_blks =3D indirect_blks * NIDS=
_PER_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t direct_index =3D DEF_ADDRS_PER_INODE;<b=
r>
&gt; &gt;&gt; +=C2=A0 int n =3D 0;<br>
&gt; &gt;&gt; +=C2=A0 int level =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_XATTR)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 direct_index -=3D F2FS_INLINE_XATTR_ADDRS;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 noffset[0] =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (block &lt; direct_index)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block -=3D direct_index;<br>
&gt; &gt;&gt; +=C2=A0 if (block &lt; direct_blks)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_DIR1_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block -=3D direct_blks;<br>
&gt; &gt;&gt; +=C2=A0 if (block &lt; direct_blks)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_DIR2_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 2;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block -=3D direct_blks;<br>
&gt; &gt;&gt; +=C2=A0 if (block &lt; indirect_blks)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_IND1_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 3;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D block / direct_blks;<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 4 + offset[n - 1];<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block % direct_blks;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 2;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block -=3D indirect_blks;<br>
&gt; &gt;&gt; +=C2=A0 if (block &lt; indirect_blks)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_IND2_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 4 + dptrs_per_blk;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D block / direct_blks;<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 5 + dptrs_per_blk + offs=
et[n - 1];<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block % direct_blks;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 2;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block -=3D indirect_blks;<br>
&gt; &gt;&gt; +=C2=A0 if (block &lt; dindirect_blks)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_DIND_BLOCK;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 5 + (dptrs_per_blk * 2);=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D block / indirect_blks;<=
br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 6 + (dptrs_per_blk * 2) =
+<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n - 1] * (dptrs_per_blk + 1);<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D (block / direct_blks) %=
 dptrs_per_blk;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 7 + (dptrs_per_blk * 2) =
+<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset[n - 2=
] * (dptrs_per_blk + 1) + offset[n - 1];<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block % direct_blks;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 3;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +got:<br>
&gt; &gt;&gt; +=C2=A0 return level;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_read_node (struct grub_f2fs_data *data,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_uint32_t nid, struct grub_f2fs_node=
 *np)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t blkaddr;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 blkaddr =3D get_node_blkaddr (data, nid);<br>
&gt; &gt;&gt; +=C2=A0 if (!blkaddr)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return grub_f2fs_block_read (data, blkaddr, np);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static struct grub_f2fs_data *<br>
&gt; &gt;&gt; +grub_f2fs_mount (grub_disk_t disk)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; &gt;&gt; +=C2=A0 grub_err_t err;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data =3D grub_malloc (sizeof (*data));<br>
&gt; &gt;&gt; +=C2=A0 if (!data)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;disk =3D disk;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET0))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_f2fs_read_sb (data, F2FS_SUPER=
_OFFSET1))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (grub_errno =3D=3D GRU=
B_ERR_NONE)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grub_error (GRUB_E=
RR_BAD_FS,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;not a F2FS filesystem (no superblock)&quot;);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;root_ino =3D grub_le_to_cpu32 (data-&gt;sblo=
ck.root_ino);<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;cp_blkaddr =3D grub_le_to_cpu32 (data-&gt;sb=
lock.cp_blkaddr);<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;nat_blkaddr =3D grub_le_to_cpu32 (data-&gt;s=
block.nat_blkaddr);<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;blocks_per_seg =3D 1 &lt;&lt;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_le_to_cpu32 (data-&gt;sblock.log_bl=
ocks_per_<wbr>seg);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_f2fs_read_cp (data);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;nat_bitmap =3D __nat_bitmap_ptr (data);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D get_nat_journal (data);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;diropen.data =3D data;<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;diropen.ino =3D data-&gt;root_ino;<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;diropen.inode_read =3D 1;<br>
&gt; &gt;&gt; +=C2=A0 data-&gt;inode =3D &amp;data-&gt;diropen.inode;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 err =3D grub_f2fs_read_node (data, data-&gt;root_ino,=
 data-&gt;inode);<br>
&gt; &gt;&gt; +=C2=A0 if (err)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return data;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +fail:<br>
&gt; &gt;&gt; +=C2=A0 grub_free (data);<br>
&gt; &gt;&gt; +=C2=A0 return NULL;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/* guarantee inline_data was handled by caller */<br>
&gt; &gt;&gt; +static grub_disk_addr_t<br>
&gt; &gt;&gt; +grub_f2fs_get_block (grub_fshelp_node_t node, grub_disk_addr=
_t block_ofs)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data =3D node-&gt;data;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_inode *inode =3D &amp;node-&gt;inode=
.i;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t offset[4], noffset[4], nids[4];<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_node *node_block;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint32_t block_addr =3D -1;<br>
&gt; &gt;&gt; +=C2=A0 int level, i;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 level =3D grub_get_node_path (inode, block_ofs, offse=
t, noffset);<br>
&gt; &gt;&gt; +=C2=A0 if (level =3D=3D 0)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_le_to_cpu32 (inode-&gt;i_addr[offs=
et[0]]);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 node_block =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; &gt;&gt; +=C2=A0 if (!node_block)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 nids[1] =3D __get_node_id (&amp;node-&gt;inode, offse=
t[0], 1);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 /* get indirect or direct nodes */<br>
&gt; &gt;&gt; +=C2=A0 for (i =3D 1; i &lt;=3D level; i++)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (data, nids[i], nod=
e_block);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (i &lt; level)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nids[i + 1] =3D __get_node_id (n=
ode_block, offset[i], 0);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 block_addr =3D grub_le_to_cpu32 (node_block-&gt;dn.ad=
dr[offset[<wbr>level]]);<br>
&gt; &gt;&gt; +fail:<br>
&gt; &gt;&gt; +=C2=A0 grub_free (node_block);<br>
&gt; &gt;&gt; +=C2=A0 return block_addr;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_ssize_t<br>
&gt; &gt;&gt; +grub_f2fs_read_file (grub_fshelp_node_t node,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_disk_re=
ad_hook_t read_hook, void *read_hook_data,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_off_t p=
os, grub_size_t len, char *buf)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_inode *inode =3D &amp;node-&gt;inode=
.i;<br>
&gt; &gt;&gt; +=C2=A0 grub_off_t filesize =3D grub_f2fs_file_size (inode);<=
br>
&gt; &gt;&gt; +=C2=A0 char *inline_addr =3D __inline_addr (inode);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_DATA)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (filesize &gt; MAX_INLINE_DATA)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (len &gt; filesize - pos)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D filesize - pos;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_memcpy (buf, inline_addr + pos, le=
n);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return grub_fshelp_read_file (node-&gt;data-&gt;disk,=
 node,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0read_hook, read_hook_data,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pos, len, buf, grub_f2fs_get_block,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0filesize,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0F2FS_BLK_SEC_BITS, 0);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static char *<br>
&gt; &gt;&gt; +grub_f2fs_read_symlink (grub_fshelp_node_t node)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 char *symlink;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_fshelp_node *diro =3D node;<br>
&gt; &gt;&gt; +=C2=A0 grub_uint64_t filesize;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (!diro-&gt;inode_read)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (diro-&gt;data, dir=
o-&gt;ino, &amp;diro-&gt;inode);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 filesize =3D grub_f2fs_file_size(&amp;diro-&gt;<wbr>i=
node.i);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 symlink =3D grub_malloc (filesize + 1);<br>
&gt; &gt;&gt; +=C2=A0 if (!symlink)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_f2fs_read_file (diro, 0, 0, 0, filesize, symlink=
);<br>
&gt; &gt;&gt; +=C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (symlink);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 symlink[filesize] =3D &#39;\0&#39;;<br>
&gt; &gt;&gt; +=C2=A0 return symlink;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_f2fs_check_dentries (struct grub_f2fs_dir_iter_ctx *ctx=
)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_fshelp_node *fdiro;<br>
&gt; &gt;&gt; +=C2=A0 int i;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 for (i =3D 0; i &lt; ctx-&gt;max;)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 char *filename;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 enum grub_fshelp_filetype type =3D GRUB=
_FSHELP_UNKNOWN;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 enum FILE_TYPE ftype;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 int name_len;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_f2fs_test_bit_le (i, ctx-&gt;b=
itmap) =3D=3D 0)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ftype =3D ctx-&gt;dentry[i].file_type;<=
br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 name_len =3D grub_le_to_cpu16 (ctx-&gt;=
dentry[i].name_len);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 filename =3D grub_malloc (name_len + 1)=
;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (!filename)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_memcpy (filename, ctx-&gt;filename=
[i], name_len);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 filename[name_len] =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro =3D grub_malloc (sizeof (struct g=
rub_fshelp_node));<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (!fdiro)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grub_free(filename);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (ftype =3D=3D F2FS_FT_DIR)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GRUB_FSHELP_DIR;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 else if (ftype =3D=3D F2FS_FT_SYMLINK)<=
br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GRUB_FSHELP_SYMLINK;<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 else if (ftype =3D=3D F2FS_FT_REG_FILE)=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GRUB_FSHELP_REG;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro-&gt;data =3D ctx-&gt;data;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro-&gt;ino =3D grub_le_to_cpu32 (ctx=
-&gt;dentry[i].ino);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro-&gt;inode_read =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ret =3D ctx-&gt;hook (filename, type, f=
diro, ctx-&gt;hook_data);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free(filename);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (ret)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 i +=3D (name_len + F2FS_SLOT_LEN - 1) /=
 F2FS_SLOT_LEN;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_f2fs_iterate_inline_dir (struct grub_f2fs_inode *dir,<b=
r>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct grub_f2fs_dir_iter_ctx *ctx)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_inline_dentry *de_blk;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 de_blk =3D (struct grub_f2fs_inline_dentry *) __inlin=
e_addr (dir);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 ctx-&gt;bitmap =3D de_blk-&gt;dentry_bitmap;<br>
&gt; &gt;&gt; +=C2=A0 ctx-&gt;dentry =3D de_blk-&gt;dentry;<br>
&gt; &gt;&gt; +=C2=A0 ctx-&gt;filename =3D de_blk-&gt;filename;<br>
&gt; &gt;&gt; +=C2=A0 ctx-&gt;max =3D NR_INLINE_DENTRY;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return grub_f2fs_check_dentries (ctx);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_f2fs_iterate_dir (grub_fshelp_node_t dir,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_fshelp_iterate_dir_hook_t hook, voi=
d *hook_data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_fshelp_node *diro =3D (struct grub_fshelp=
_node *) dir;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_inode *inode;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_dir_iter_ctx ctx =3D {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 .data =3D diro-&gt;data,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 .hook =3D hook,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 .hook_data =3D hook_data<br>
&gt; &gt;&gt; +=C2=A0 };<br>
&gt; &gt;&gt; +=C2=A0 grub_off_t fpos =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (!diro-&gt;inode_read)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (diro-&gt;data, dir=
o-&gt;ino, &amp;diro-&gt;inode);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 inode =3D &amp;diro-&gt;inode.i;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_DENTRY)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return grub_f2fs_iterate_inline_dir (inode, &a=
mp;ctx);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 while (fpos &lt; grub_f2fs_file_size (inode))<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 struct grub_f2fs_dentry_block *de_blk;<=
br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 char *buf;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 buf =3D grub_zalloc (F2FS_BLKSIZE);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (!buf)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_file (diro, 0, 0, fpos, =
F2FS_BLKSIZE, buf);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grub_free (buf);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 de_blk =3D (struct grub_f2fs_dentry_blo=
ck *) buf;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.bitmap =3D de_blk-&gt;dentry_bitmap=
;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.dentry =3D de_blk-&gt;dentry;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.filename =3D de_blk-&gt;filename;<b=
r>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.max =3D NR_DENTRY_IN_BLOCK;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 ret =3D grub_f2fs_check_dentries (&amp;=
ctx);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (buf);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (ret)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 fpos +=3D F2FS_BLKSIZE;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 return 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int<br>
&gt; &gt;&gt; +grub_f2fs_dir_iter (const char *filename, enum grub_fshelp_f=
iletype filetype,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_fshelp_node_t =
node, void *data)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_dir_ctx *ctx =3D data;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_dirhook_info info;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_memset (&amp;info, 0, sizeof (info));<br>
&gt; &gt;&gt; +=C2=A0 if (!node-&gt;inode_read)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (ctx-&gt;data, node=
-&gt;ino, &amp;node-&gt;inode);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (!grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 node-&gt;inode_read =3D 1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_errno =3D GRUB_ERR_NONE;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 if (node-&gt;inode_read)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 info.mtimeset =3D 1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 info.mtime =3D grub_le_to_cpu64 (node-&=
gt;inode.i.i_mtime);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 info.dir =3D ((filetype &amp; GRUB_FSHELP_TYPE_MASK) =
=3D=3D GRUB_FSHELP_DIR);<br>
&gt; &gt;&gt; +=C2=A0 grub_free (node);<br>
&gt; &gt;&gt; +=C2=A0 return ctx-&gt;hook (filename, &amp;info, ctx-&gt;hoo=
k_data);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_dir (grub_device_t device, const char *path,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_fs_dir_hook_t hook, void *hook_data=
)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_dir_ctx ctx =3D {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 .hook =3D hook,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 .hook_data =3D hook_data<br>
&gt; &gt;&gt; +=C2=A0 };<br>
&gt; &gt;&gt; +=C2=A0 struct grub_fshelp_node *fdiro =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 ctx.data =3D grub_f2fs_mount (device-&gt;disk);<br>
&gt; &gt;&gt; +=C2=A0 if (!ctx.data)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_fshelp_find_file (path, &amp;ctx.data-&gt;dirope=
n, &amp;fdiro,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_f2fs_it=
erate_dir, grub_f2fs_read_symlink,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GRUB_FSHELP_=
DIR);<br>
&gt; &gt;&gt; +=C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_f2fs_iterate_dir (fdiro, grub_f2fs_dir_iter, &am=
p;ctx);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +fail:<br>
&gt; &gt;&gt; +=C2=A0 if (fdiro !=3D &amp;ctx.data-&gt;diropen)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 grub_free (fdiro);<br>
&gt; &gt;&gt; + grub_free (ctx.data);<br>
&gt; &gt;&gt; + grub_dl_unref (my_mod);<br>
&gt; &gt;&gt; + return grub_errno;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +/* Open a file named NAME and initialize FILE.=C2=A0 */<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_open (struct grub_file *file, const char *name)<br=
>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data =3D NULL;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_fshelp_node *fdiro =3D 0;<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_inode *inode;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data =3D grub_f2fs_mount (file-&gt;device-&gt;disk);<=
br>
&gt; &gt;&gt; +=C2=A0 if (!data)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_fshelp_find_file (name, &amp;data-&gt;diropen, &=
amp;fdiro,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0grub_f2fs_iterate_dir, grub_f2fs_read_symlink,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0GRUB_FSHELP_REG);<br>
&gt; &gt;&gt; +=C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (!fdiro-&gt;inode_read)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (data, fdiro-&gt;in=
o, &amp;fdiro-&gt;inode);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_memcpy (data-&gt;inode, &amp;fdiro-&gt;inode, si=
zeof (*data-&gt;inode));<br>
&gt; &gt;&gt; +=C2=A0 grub_free (fdiro);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 inode =3D &amp;(data-&gt;inode-&gt;i);<br>
&gt; &gt;&gt; +=C2=A0 file-&gt;size =3D grub_f2fs_file_size (inode);<br>
&gt; &gt;&gt; +=C2=A0 file-&gt;data =3D data;<br>
&gt; &gt;&gt; +=C2=A0 file-&gt;offset =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_DATA &amp;&a=
mp; file-&gt;size &gt; MAX_INLINE_DATA)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 grub_error (GRUB_ERR_BAD_FS, &quot;corrupted i=
nline_data: need fsck&quot;);<br>
&gt; &gt;&gt; +=C2=A0 return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +fail:<br>
&gt; &gt;&gt; +=C2=A0 if (fdiro !=3D &amp;data-&gt;diropen)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 grub_free (fdiro);<br>
&gt; &gt;&gt; +=C2=A0 grub_free (data);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_ssize_t<br>
&gt; &gt;&gt; +grub_f2fs_read (grub_file_t file, char *buf, grub_size_t len=
)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data =3D (struct grub_f2fs_dat=
a *) file-&gt;data;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return grub_f2fs_read_file (&amp;data-&gt;diropen,<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file-&gt;rea=
d_hook, file-&gt;read_hook_data,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file-&gt;off=
set, len, buf);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_close (grub_file_t file)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data =3D (struct grub_f2fs_dat=
a *) file-&gt;data;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_free (data);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 return GRUB_ERR_NONE;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_uint8_t *<br>
&gt; &gt;&gt; +grub_f2fs_utf16_to_utf8 (grub_uint16_t *in_buf_le)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_uint16_t in_buf[MAX_VOLUME_NAME];<br>
&gt; &gt;&gt; +=C2=A0 grub_uint8_t *out_buf;<br>
&gt; &gt;&gt; +=C2=A0 int len =3D 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 out_buf =3D grub_malloc (MAX_VOLUME_NAME * GRUB_MAX_U=
TF8_PER_UTF16 + 1);<br>
&gt; &gt;&gt; +=C2=A0 if (!out_buf)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 while (*in_buf_le !=3D 0 &amp;&amp; len &lt; MAX_VOLU=
ME_NAME) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 in_buf[len] =3D grub_le_to_cpu16 (in_buf_le[le=
n]);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 len++;<br>
&gt; &gt;&gt; +=C2=A0 }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 *grub_utf16_to_utf8 (out_buf, in_buf, len) =3D &#39;\=
0&#39;;<br>
&gt; &gt;&gt; +=C2=A0 return out_buf;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_label (grub_device_t device, char **label)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; &gt;&gt; +=C2=A0 grub_disk_t disk =3D device-&gt;disk;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data =3D grub_f2fs_mount (disk);<br>
&gt; &gt;&gt; +=C2=A0 if (data)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 *label =3D (char *) grub_f2fs_utf16_to_utf8 (d=
ata-&gt;sblock.volume_name);<br>
&gt; &gt;&gt; +=C2=A0 else<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 *label =3D NULL;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_free (data);<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; &gt;&gt; +=C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static grub_err_t<br>
&gt; &gt;&gt; +grub_f2fs_uuid (grub_device_t device, char **uuid)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; &gt;&gt; +=C2=A0 grub_disk_t disk =3D device-&gt;disk;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 data =3D grub_f2fs_mount (disk);<br>
&gt; &gt;&gt; +=C2=A0 if (data)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 *uuid =3D<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0grub_xasprintf<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0(&quot;%02x%02x%02x%02x-%02x%02x-%<wbr>0=
2x%02x-%02x%02x-%02x%02x%02x%<wbr>02x%02x%02x&quot;,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[0], data-&gt;sblock.uuid[1],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[2], data-&gt;sblock.uuid[3],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[4], data-&gt;sblock.uuid[5],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[6], data-&gt;sblock.uuid[7],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[8], data-&gt;sblock.uuid[9],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[10], data-&gt;sblock.uuid[11],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[12], data-&gt;sblock.uuid[13],<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sbl=
ock.uuid[14], data-&gt;sblock.uuid[15]);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; +=C2=A0 else<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 *uuid =3D NULL;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 grub_free (data);<br>
&gt; &gt;&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; &gt;&gt; +=C2=A0 return grub_errno;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static struct grub_fs grub_f2fs_fs =3D {<br>
&gt; &gt;&gt; +=C2=A0 .name =3D &quot;f2fs&quot;,<br>
&gt; &gt;&gt; +=C2=A0 .dir =3D grub_f2fs_dir,<br>
&gt; &gt;&gt; +=C2=A0 .open =3D grub_f2fs_open,<br>
&gt; &gt;&gt; +=C2=A0 .read =3D grub_f2fs_read,<br>
&gt; &gt;&gt; +=C2=A0 .close =3D grub_f2fs_close,<br>
&gt; &gt;&gt; +=C2=A0 .label =3D grub_f2fs_label,<br>
&gt; &gt;&gt; +=C2=A0 .uuid =3D grub_f2fs_uuid,<br>
&gt; &gt;&gt; +#ifdef GRUB_UTIL<br>
&gt; &gt;&gt; +=C2=A0 .reserved_first_sector =3D 1,<br>
&gt; &gt;&gt; +=C2=A0 .blocklist_install =3D 0,<br>
&gt; &gt;&gt; +#endif<br>
&gt; &gt;&gt; +=C2=A0 .next =3D 0<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +GRUB_MOD_INIT (f2fs)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_fs_register (&amp;grub_f2fs_fs);<br>
&gt; &gt;&gt; +=C2=A0 my_mod =3D mod;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +GRUB_MOD_FINI (f2fs)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 grub_fs_unregister (&amp;grub_f2fs_fs);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; diff --git a/po/exclude.pot b/po/exclude.pot<br>
&gt; &gt;&gt; index 0a9b215..816089c 100644<br>
&gt; &gt;&gt; --- a/po/exclude.pot<br>
&gt; &gt;&gt; +++ b/po/exclude.pot<br>
&gt; &gt;&gt; @@ -1214,6 +1214,7 @@ msgstr &quot;&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 #: grub-core/commands/xnu_uuid.c:<wbr>75 grub-core/fs/j=
fs.c:924<br>
&gt; &gt;&gt;=C2=A0 #: grub-core/fs/nilfs2.c:1135<br>
&gt; &gt;&gt; +#: grub-core/fs/f2fs.c:1259<br>
&gt; &gt;&gt;=C2=A0 #, c-format<br>
&gt; &gt;&gt;=C2=A0 msgid &quot;%02x%02x%02x%02x-%02x%02x-%<wbr>02x%02x-%02=
x%02x-%02x%02x%02x%<wbr>02x%02x%02x&quot;<br>
&gt; &gt;&gt;=C2=A0 msgstr &quot;&quot;<br>
&gt; &gt;&gt; diff --git a/tests/<a href=3D"http://f2fs_test.in" rel=3D"nor=
eferrer" target=3D"_blank">f2fs_test.in</a> b/tests/<a href=3D"http://f2fs_=
test.in" rel=3D"noreferrer" target=3D"_blank">f2fs_test.in</a><br>
&gt; &gt;&gt; new file mode 100644<br>
&gt; &gt;&gt; index 0000000..1ea77c8<br>
&gt; &gt;&gt; --- /dev/null<br>
&gt; &gt;&gt; +++ b/tests/<a href=3D"http://f2fs_test.in" rel=3D"noreferrer=
" target=3D"_blank">f2fs_test.in</a><br>
&gt; &gt;&gt; @@ -0,0 +1,19 @@<br>
&gt; &gt;&gt; +#!/bin/sh<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +set -e<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +if [ &quot;x$EUID&quot; =3D &quot;x&quot; ] ; then<br>
&gt; &gt;&gt; + EUID=3D`id -u`<br>
&gt; &gt;&gt; +fi<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +if [ &quot;$EUID&quot; !=3D 0 ] ; then<br>
&gt; &gt;&gt; + exit 77<br>
&gt; &gt;&gt; +fi<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +if ! which mkfs.f2fs &gt;/dev/null 2&gt;&amp;1; then<br>
&gt; &gt;&gt; + echo &quot;mkfs.f2fs not installed; cannot test f2fs.&quot;=
<br>
&gt; &gt;&gt; + exit 77<br>
&gt; &gt;&gt; +fi<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +&quot;@builddir@/grub-fs-tester&quot; f2fs<br>
&gt; &gt;&gt; diff --git a/tests/util/<a href=3D"http://grub-fs-tester.in" =
rel=3D"noreferrer" target=3D"_blank">grub-fs-tester.in</a> b/tests/util/<a =
href=3D"http://grub-fs-tester.in" rel=3D"noreferrer" target=3D"_blank">grub=
-fs-tester.in</a><br>
&gt; &gt;&gt; index 424de22..e3e4109 100644<br>
&gt; &gt;&gt; --- a/tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"=
noreferrer" target=3D"_blank">grub-fs-tester.in</a><br>
&gt; &gt;&gt; +++ b/tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"=
noreferrer" target=3D"_blank">grub-fs-tester.in</a><br>
&gt; &gt;&gt; @@ -142,7 +142,7 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;<wbr>LOG=
SECSIZE&lt;=3DMAXLOGSECSIZE;<wbr>LOGSECSIZE=3DLOGSECSIZE +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0xsquash*)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MINBLKSIZE=3D4096<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAXBLKSIZE=3D1048576;=
;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0xxfs)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0xxfs|xf2fs)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MINBLKSIZE=3D$SECSIZE=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# OS Li=
mitation: GNU/Linux doesn&#39;t accept &gt; 4096<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAXBLKSIZE=3D4096;;<b=
r>
&gt; &gt;&gt; @@ -265,6 +265,10 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;<wbr>LO=
GSECSIZE&lt;=3DMAXLOGSECSIZE;<wbr>LOGSECSIZE=3DLOGSECSIZE +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;=
btrfs&quot;*)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0FSLABEL=3D&quot;grub_;/test=C3=A9=F0=AF=A6=9B=F0=AF=A6=9D=F0=9F=98=
=81<wbr>=D0=BA=D0=B8=D1=80=D0=B8=D1=82i urewfceniuewruevrewnuuireurevu<wbr>=
eurnievrewfnerfcnevirivinrewvn<wbr>irewnivrewiuvcrewvnuewvrrrewni<wbr>uerwr=
eiuviurewiuviurewnuvewnvr<wbr>enurnunuvrevuurerejiremvreijnv<wbr>creivire n=
verivnreivrevnureiorfnfrvoeoi<wbr>roireoireoifrefoieroifoireoif&quot;<wbr>;=
;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# FS LIMITATION: f2fs labe=
l is at most 512 UTF-16 chars<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;f2fs&=
quot;)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FSLABEL=3D&quot;grub_;/<wbr>test=C3=A9=E4=8F=8C=E4=90=93=E4=8F=95=D0=BA=
=D0=B8=D1=80=D0=B8=D1=82iurewfceniuewruew<wbr>nuuireurevueurnievrewfnerfcne=
v<wbr>irivinrewvnirewnivrewiuvcrewvn<wbr>uewvrrrewniuerwreiuviurewiuviu<wbr=
>rewnuvewnvrenurnunuvrevuurerej<wbr>iremvreijnvvcreivire nverivnreivrevnure=
iorfnfrvoeoi<wbr>roireoireoifrefoieroifoirvcrei<wbr>vire nverivnreivrevnure=
iorfnfrvoeoi<wbr>roireoireoifrefoieroifoircreiv<wbr>ire nverivnreivrevnurei=
orfnfrvoeoi<wbr>roireoireoifrefoieroifoireoifo<wbr>iq&quot;;;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# FS LIMITATION: exfa=
t is at most 15 UTF-16 chars<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;=
exfat&quot;)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0FSLABEL=3D&quot;g=C3=A9=D1=82 ;/=F0=AF=A6=9B=F0=AF=A6=9D=F0=9F=98=81=
=D0=BA=D0=B8=D1=80&quot;;;<br>
&gt; &gt;&gt; @@ -474,7 +478,7 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;<wbr>LOG=
SECSIZE&lt;=3DMAXLOGSECSIZE;<wbr>LOGSECSIZE=3DLOGSECSIZE +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# FIXME: Not sure abo=
ut BtrFS, NTFS, JFS, AFS, UDF and SFS. Check it.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# FS LIMITATION: as far as I know t=
hose FS don&#39;t store their last modification date.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;=
jfs_caseins&quot; | x&quot;jfs&quot; | x&quot;xfs&quot; | x&quot;xfs_crc&qu=
ot; | x&quot;btrfs&quot;* | x&quot;reiserfs_old&quot; | x&quot;reiserfs&quo=
t; \<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| x&quot;bfs&quot; | x&quot;afs&quot; \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| x&quot;bfs&quot; | x&quot;afs&quot; | x&quot;f2fs&quot; \<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| x&quot;tarfs&quot; | x&quot;cpio_&quot;* | x&quot;minix&quot; | x&=
quot;minix2&quot; \<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| x&quot;minix3&quot; | x&quot;ntfs&quot;* | x&quot;udf&quot; | x&qu=
ot;sfs&quot;*)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NOFSTIME=3Dy;;<br>
&gt; &gt;&gt; @@ -753,6 +757,8 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;<wbr>LOG=
SECSIZE&lt;=3DMAXLOGSECSIZE;<wbr>LOGSECSIZE=3DLOGSECSIZE +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0MOUNTDEVICE=3D&quot;/dev/mapper/grub_<wbr>test-testvol&quot;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0MOUNTFS=3Dext2<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;mkfs.ext2&quot; -L &quot;$FSLABEL&quot; -q &quot;${MOUNTDEVICE=
}&quot;=C2=A0 ;;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xf2fs)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;mkfs.f2fs&quot; -l &quot;$FSLABEL&quot; -q &quot;${LODEVICES[0]}&q=
uot; ;;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xnilfs2=
)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;mkfs.nilfs2&quot; -L &quot;$FSLABEL&quot; -b $BLKSIZE=C2=A0 -q=
 &quot;${LODEVICES[0]}&quot; ;;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xext2_o=
ld)<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; 2.6.3<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ------------------------------<wbr>--------------------------=
----<wbr>------------------<br>
&gt; &gt;&gt; Site24x7 APM Insight: Get Deep Visibility into Application Pe=
rformance<br>
&gt; &gt;&gt; APM + Mobile APM + RUM: Monitor 3 App instances at just $35/M=
onth<br>
&gt; &gt;&gt; Monitor end-to-end web transactions and take corrective actio=
ns now<br>
&gt; &gt;&gt; Troubleshoot faster and improve end-user experience. Signup N=
ow!<br>
&gt; &gt;&gt; <a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D27=
2487151&amp;iu=3D/4140" rel=3D"noreferrer" target=3D"_blank">http://pubads.=
g.doubleclick.<wbr>net/gampad/clk?id=3D272487151&amp;<wbr>iu=3D/4140</a><br=
>
&gt; &gt;&gt; ______________________________<wbr>_________________<br>
&gt; &gt;&gt; Linux-f2fs-devel mailing list<br>
&gt; &gt;&gt; <a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Lin=
ux-f2fs-devel@lists.<wbr>sourceforge.net</a><br>
&gt; &gt;&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/linux=
-f2fs-devel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge=
.net/<wbr>lists/listinfo/linux-f2fs-<wbr>devel</a><br>
<br>
______________________________<wbr>_________________<br>
Grub-devel mailing list<br>
<a href=3D"mailto:Grub-devel@gnu.org">Grub-devel@gnu.org</a><br>
<a href=3D"https://lists.gnu.org/mailman/listinfo/grub-devel" rel=3D"norefe=
rrer" target=3D"_blank">https://lists.gnu.org/mailman/<wbr>listinfo/grub-de=
vel</a><br>
</div></div></blockquote></div><br></div>

--001a114b2fe8b25004053957ea81--


--===============1069813164386512170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Grub-devel mailing list
Grub-devel@gnu.org
https://lists.gnu.org/mailman/listinfo/grub-devel

--===============1069813164386512170==--
