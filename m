From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: Re: [2.02] Re: [f2fs-dev] [PATCH v7] F2FS support
Date: Thu, 3 Mar 2016 00:20:30 +0100
Message-ID: <CAN9vWDJLxCm4Mr69XzhOnZMd32QJRg0+ussoA5TQbC1LbfeAAQ@mail.gmail.com>
References: <1427185140-41120-1-git-send-email-jaegeuk@kernel.org>
	<20150403224908.GB25673@jaegeuk-mac02.mot.com>
	<20151119212824.GA11666@jaegeuk.local> <566E7DAA.4010202@gmail.com>
	<20151215003421.GD48918@jaegeuk.local>
	<20151215181439.GA60773@jaegeuk.local>
	<20160108194132.GA17464@jaegeuk.aosp>
	<20160222182525.GD10875@jaegeuk.gateway>
	<56D5F2E9.1070501@gmail.com>
Reply-To: The development of GNU GRUB <grub-devel@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1558410000343847532=="
Return-path: <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>
In-Reply-To: <56D5F2E9.1070501@gmail.com>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/grub-devel>
List-Post: <mailto:grub-devel@gnu.org>
List-Help: <mailto:grub-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=subscribe>
Errors-To: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org
Sender: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org
To: The development of GNU GRUB <grub-devel@gnu.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

--===============1558410000343847532==
Content-Type: multipart/alternative; boundary=047d7b86dcb4c4a9e9052d1920ed

--047d7b86dcb4c4a9e9052d1920ed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I found a bug in the 'grub_f2fs_read_file' function.
It fails when the file position is not 0. to fix it:
-      grub_memcpy (buf + pos, inline_addr + pos, len);
+      grub_memcpy (buf, inline_addr + pos, len);


Michael

On Tue, Mar 1, 2016 at 8:52 PM, Andrei Borzenkov <arvidjaar@gmail.com>
wrote:

> ACK from my side. It is leaf code that does not affect anything so
> should not cause any regression.
>
> 22.02.2016 21:25, Jaegeuk Kim =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Chang log from v6:
> >  o remove redundant filesize check in ->read
> >  o check consistency in ->open regarding to inline_data
> >
> > -- >8 --
> > From 51c120612fdbc4bc315e9c4c6e91ca888c3f3596 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 17 Nov 2015 12:45:13 -0800
> > Subject: [PATCH] F2FS support
> >
> > "F2FS (Flash-Friendly File System) is flash-friendly file system which
> was merged
> > into Linux kernel v3.8 in 2013.
> >
> > The motive for F2FS was to build a file system that from the start,
> takes into
> > account the characteristics of NAND flash memory-based storage devices
> (such as
> > solid-state disks, eMMC, and SD cards).
> >
> > F2FS was designed on a basis of a log-structured file system approach,
> which
> > remedies some known issues of the older log structured file systems,
> such as
> > the snowball effect of wandering trees and high cleaning overhead. In
> addition,
> > since a NAND-based storage device shows different characteristics
> according to
> > its internal geometry or flash memory management scheme (such as the
> Flash
> > Translation Layer or FTL), it supports various parameters not only for
> > configuring on-disk layout, but also for selecting allocation and
> cleaning
> > algorithm.", quote by https://en.wikipedia.org/wiki/F2FS.
> >
> > The source codes for F2FS are available from:
> >
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  Makefile.util.def            |    7 +
> >  docs/grub.texi               |    5 +-
> >  grub-core/Makefile.core.def  |    5 +
> >  grub-core/fs/f2fs.c          | 1289
> ++++++++++++++++++++++++++++++++++++++++++
> >  po/exclude.pot               |    1 +
> >  tests/f2fs_test.in           |   19 +
> >  tests/util/grub-fs-tester.in |   10 +-
> >  7 files changed, 1332 insertions(+), 4 deletions(-)
> >  create mode 100644 grub-core/fs/f2fs.c
> >  create mode 100644 tests/f2fs_test.in
> >
> > diff --git a/Makefile.util.def b/Makefile.util.def
> > index db7e8ec..84627bb 100644
> > --- a/Makefile.util.def
> > +++ b/Makefile.util.def
> > @@ -99,6 +99,7 @@ library =3D {
> >    common =3D grub-core/fs/ext2.c;
> >    common =3D grub-core/fs/fat.c;
> >    common =3D grub-core/fs/exfat.c;
> > +  common =3D grub-core/fs/f2fs.c;
> >    common =3D grub-core/fs/fshelp.c;
> >    common =3D grub-core/fs/hfs.c;
> >    common =3D grub-core/fs/hfsplus.c;
> > @@ -766,6 +767,12 @@ script =3D {
> >
> >  script =3D {
> >    testcase;
> > +  name =3D f2fs_test;
> > +  common =3D tests/f2fs_test.in;
> > +};
> > +
> > +script =3D {
> > +  testcase;
> >    name =3D nilfs2_test;
> >    common =3D tests/nilfs2_test.in;
> >  };
> > diff --git a/docs/grub.texi b/docs/grub.texi
> > index 1df3db2..e5a80f3 100644
> > --- a/docs/grub.texi
> > +++ b/docs/grub.texi
> > @@ -360,7 +360,8 @@ blocklist notation. The currently supported
> filesystem types are @dfn{Amiga
> >  Fast FileSystem (AFFS)}, @dfn{AtheOS fs}, @dfn{BeFS},
> >  @dfn{BtrFS} (including raid0, raid1, raid10, gzip and lzo),
> >  @dfn{cpio} (little- and big-endian bin, odc and newc variants),
> > -@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @dfn{exFAT},
> @dfn{HFS},
> > +@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @dfn{exFAT},
> > +@dfn{f2fs}, @dfn{HFS},
> >  @dfn{HFS+}, @dfn{ISO9660} (including Joliet, Rock-ridge and multi-chun=
k
> files),
> >  @dfn{JFS}, @dfn{Minix fs} (versions 1, 2 and 3), @dfn{nilfs2},
> >  @dfn{NTFS} (including compression), @dfn{ReiserFS}, @dfn{ROMFS},
> > @@ -5347,7 +5348,7 @@ NTFS, JFS, UDF, HFS+, exFAT, long filenames in
> FAT, Joliet part of
> >  ISO9660 are treated as UTF-16 as per specification. AFS and BFS are re=
ad
> >  as UTF-8, again according to specification. BtrFS, cpio, tar, squash4,
> minix,
> >  minix2, minix3, ROMFS, ReiserFS, XFS, ext2, ext3, ext4, FAT (short
> names),
> > -RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are assumed
> > +f2fs, RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are assume=
d
> >  to be UTF-8. This might be false on systems configured with legacy
> charset
> >  but as long as the charset used is superset of ASCII you should be abl=
e
> to
> >  access ASCII-named files. And it's recommended to configure your syste=
m
> to use
> > diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.def
> > index d9fa0e3..b585ade 100644
> > --- a/grub-core/Makefile.core.def
> > +++ b/grub-core/Makefile.core.def
> > @@ -1278,6 +1278,11 @@ module =3D {
> >  };
> >
> >  module =3D {
> > +  name =3D f2fs;
> > +  common =3D fs/f2fs.c;
> > +};
> > +
> > +module =3D {
> >    name =3D fshelp;
> >    common =3D fs/fshelp.c;
> >  };
> > diff --git a/grub-core/fs/f2fs.c b/grub-core/fs/f2fs.c
> > new file mode 100644
> > index 0000000..cb312b3
> > --- /dev/null
> > +++ b/grub-core/fs/f2fs.c
> > @@ -0,0 +1,1289 @@
> > +/*
> > + *  f2fs.c - Flash-Friendly File System
> > + *
> > + *  Written by Jaegeuk Kim <jaegeuk@kernel.org>
> > + *
> > + *  Copyright (C) 2015  Free Software Foundation, Inc.
> > + *
> > + *  GRUB is free software: you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation, either version 3 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  GRUB is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#include <grub/err.h>
> > +#include <grub/file.h>
> > +#include <grub/mm.h>
> > +#include <grub/misc.h>
> > +#include <grub/disk.h>
> > +#include <grub/dl.h>
> > +#include <grub/types.h>
> > +#include <grub/charset.h>
> > +#include <grub/fshelp.h>
> > +
> > +GRUB_MOD_LICENSE ("GPLv3+");
> > +
> > +/* F2FS Magic Number */
> > +#define F2FS_SUPER_MAGIC     0xF2F52010
> > +#define CHECKSUM_OFFSET              4092            /* must be aligne=
d
> 4 bytes */
> > +#define U32_CHECKSUM_OFFSET  (CHECKSUM_OFFSET >> 2)
> > +
> > +/* byte-size offset */
> > +#define F2FS_SUPER_OFFSET    ((grub_disk_addr_t)1024)
> > +#define F2FS_SUPER_OFFSET0   (F2FS_SUPER_OFFSET >>
> GRUB_DISK_SECTOR_BITS)
> > +#define F2FS_SUPER_OFFSET1   ((F2FS_SUPER_OFFSET + F2FS_BLKSIZE) >>  \
> > +                                             GRUB_DISK_SECTOR_BITS)
> > +
> > +/* 9 bits for 512 bytes */
> > +#define F2FS_MIN_LOG_SECTOR_SIZE     9
> > +
> > +/* support only 4KB block */
> > +#define F2FS_BLK_BITS        12
> > +#define F2FS_BLKSIZE (1 << F2FS_BLK_BITS)
> > +#define F2FS_BLK_SEC_BITS    (F2FS_BLK_BITS - GRUB_DISK_SECTOR_BITS)
> > +
> > +#define VERSION_LEN  256
> > +#define F2FS_MAX_EXTENSION   64
> > +
> > +#define CP_COMPACT_SUM_FLAG  0x00000004
> > +#define CP_UMOUNT_FLAG       0x00000001
> > +
> > +#define MAX_ACTIVE_LOGS      16
> > +#define MAX_ACTIVE_NODE_LOGS 8
> > +#define MAX_ACTIVE_DATA_LOGS 8
> > +#define      NR_CURSEG_DATA_TYPE     3
> > +#define NR_CURSEG_NODE_TYPE  3
> > +#define NR_CURSEG_TYPE       (NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYP=
E)
> > +
> > +#define ENTRIES_IN_SUM       512
> > +#define      SUMMARY_SIZE    7
> > +#define      SUM_FOOTER_SIZE 5
> > +#define JENTRY_SIZE  (sizeof(struct grub_f2fs_nat_jent))
> > +#define SUM_ENTRIES_SIZE     (SUMMARY_SIZE * ENTRIES_IN_SUM)
> > +#define SUM_JOURNAL_SIZE     (F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> > +                             SUM_ENTRIES_SIZE)
> > +#define NAT_JOURNAL_ENTRIES  ((SUM_JOURNAL_SIZE - 2) / JENTRY_SIZE)
> > +#define NAT_JOURNAL_RESERVED ((SUM_JOURNAL_SIZE - 2) % JENTRY_SIZE)
> > +
> > +#define NAT_ENTRY_SIZE (sizeof(struct grub_f2fs_nat_entry))
> > +#define NAT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / NAT_ENTRY_SIZE)
> > +
> > +#define F2FS_NAME_LEN        255
> > +#define F2FS_SLOT_LEN        8
> > +#define NR_DENTRY_IN_BLOCK   214
> > +#define SIZE_OF_DIR_ENTRY    11      /* by byte */
> > +#define BITS_PER_BYTE        8
> > +#define SIZE_OF_DENTRY_BITMAP        ((NR_DENTRY_IN_BLOCK +
> BITS_PER_BYTE - 1) / \
> > +                             BITS_PER_BYTE)
> > +#define SIZE_OF_RESERVED     (F2FS_BLKSIZE - ((SIZE_OF_DIR_ENTRY + \
> > +                             F2FS_SLOT_LEN) * \
> > +                             NR_DENTRY_IN_BLOCK +
> SIZE_OF_DENTRY_BITMAP))
> > +
> > +#define F2FS_INLINE_XATTR_ADDRS      50      /* 200 bytes for inline
> xattrs */
> > +#define DEF_ADDRS_PER_INODE  923     /* Address Pointers in an Inode *=
/
> > +
> > +#define ADDRS_PER_BLOCK      1018    /* Address Pointers in a Direct
> Block */
> > +#define NIDS_PER_BLOCK       1018    /* Node IDs in an Indirect Block =
*/
> > +#define      NODE_DIR1_BLOCK (DEF_ADDRS_PER_INODE + 1)
> > +#define      NODE_DIR2_BLOCK (DEF_ADDRS_PER_INODE + 2)
> > +#define      NODE_IND1_BLOCK (DEF_ADDRS_PER_INODE + 3)
> > +#define      NODE_IND2_BLOCK (DEF_ADDRS_PER_INODE + 4)
> > +#define      NODE_DIND_BLOCK (DEF_ADDRS_PER_INODE + 5)
> > +
> > +#define MAX_INLINE_DATA      (4 * (DEF_ADDRS_PER_INODE - \
> > +                     F2FS_INLINE_XATTR_ADDRS - 1))
> > +#define NR_INLINE_DENTRY     (MAX_INLINE_DATA * BITS_PER_BYTE / \
> > +                     ((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
> > +                      BITS_PER_BYTE + 1))
> > +#define INLINE_DENTRY_BITMAP_SIZE    ((NR_INLINE_DENTRY + \
> > +                     BITS_PER_BYTE - 1) / BITS_PER_BYTE)
> > +#define INLINE_RESERVED_SIZE (MAX_INLINE_DATA - \
> > +                     ((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
> > +                      NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE))
> > +#define CURSEG_HOT_DATA      0
> > +
> > +#define CKPT_FLAG_SET(ckpt, f)       \
> > +             (ckpt)->ckpt_flags & grub_cpu_to_le32_compile_time (f)
> > +
> > +#define F2FS_INLINE_XATTR    0x01    /* file inline xattr flag */
> > +#define F2FS_INLINE_DATA     0x02    /* file inline data flag */
> > +#define F2FS_INLINE_DENTRY   0x04    /* file inline dentry flag */
> > +#define F2FS_DATA_EXIST              0x08    /* file inline data exist
> flag */
> > +#define F2FS_INLINE_DOTS     0x10    /* file having implicit dot
> dentries */
> > +
> > +enum FILE_TYPE
> > +{
> > +  F2FS_FT_UNKNOWN,
> > +  F2FS_FT_REG_FILE =3D 1,
> > +  F2FS_FT_DIR =3D 2,
> > +  F2FS_FT_SYMLINK =3D 7,
> > +};
> > +
> > +#define MAX_VOLUME_NAME              512
> > +
> > +struct grub_f2fs_superblock
> > +{
> > +  grub_uint32_t magic;
> > +  grub_uint16_t dummy1[2];
> > +  grub_uint32_t log_sectorsize;
> > +  grub_uint32_t log_sectors_per_block;
> > +  grub_uint32_t log_blocksize;
> > +  grub_uint32_t log_blocks_per_seg;
> > +  grub_uint32_t segs_per_sec;
> > +  grub_uint32_t secs_per_zone;
> > +  grub_uint32_t checksum_offset;
> > +  grub_uint8_t dummy2[40];
> > +  grub_uint32_t cp_blkaddr;
> > +  grub_uint32_t sit_blkaddr;
> > +  grub_uint32_t nat_blkaddr;
> > +  grub_uint32_t ssa_blkaddr;
> > +  grub_uint32_t main_blkaddr;
> > +  grub_uint32_t root_ino;
> > +  grub_uint32_t node_ino;
> > +  grub_uint32_t meta_ino;
> > +  grub_uint8_t uuid[16];
> > +  grub_uint16_t volume_name[MAX_VOLUME_NAME];
> > +  grub_uint32_t extension_count;
> > +  grub_uint8_t extension_list[F2FS_MAX_EXTENSION][8];
> > +  grub_uint32_t cp_payload;
> > +  grub_uint8_t version[VERSION_LEN];
> > +  grub_uint8_t init_version[VERSION_LEN];
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_checkpoint
> > +{
> > +  grub_uint64_t checkpoint_ver;
> > +  grub_uint64_t user_block_count;
> > +  grub_uint64_t valid_block_count;
> > +  grub_uint32_t rsvd_segment_count;
> > +  grub_uint32_t overprov_segment_count;
> > +  grub_uint32_t free_segment_count;
> > +  grub_uint32_t cur_node_segno[MAX_ACTIVE_NODE_LOGS];
> > +  grub_uint16_t cur_node_blkoff[MAX_ACTIVE_NODE_LOGS];
> > +  grub_uint32_t cur_data_segno[MAX_ACTIVE_DATA_LOGS];
> > +  grub_uint16_t cur_data_blkoff[MAX_ACTIVE_DATA_LOGS];
> > +  grub_uint32_t ckpt_flags;
> > +  grub_uint32_t cp_pack_total_block_count;
> > +  grub_uint32_t cp_pack_start_sum;
> > +  grub_uint32_t valid_node_count;
> > +  grub_uint32_t valid_inode_count;
> > +  grub_uint32_t next_free_nid;
> > +  grub_uint32_t sit_ver_bitmap_bytesize;
> > +  grub_uint32_t nat_ver_bitmap_bytesize;
> > +  grub_uint32_t checksum_offset;
> > +  grub_uint64_t elapsed_time;
> > +  grub_uint8_t alloc_type[MAX_ACTIVE_LOGS];
> > +  grub_uint8_t sit_nat_version_bitmap[3900];
> > +  grub_uint32_t checksum;
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_nat_entry {
> > +  grub_uint8_t version;
> > +  grub_uint32_t ino;
> > +  grub_uint32_t block_addr;
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_nat_jent
> > +{
> > +  grub_uint32_t nid;
> > +  struct grub_f2fs_nat_entry ne;
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_nat_journal {
> > +  grub_uint16_t n_nats;
> > +  struct grub_f2fs_nat_jent entries[NAT_JOURNAL_ENTRIES];
> > +  grub_uint8_t reserved[NAT_JOURNAL_RESERVED];
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_nat_block {
> > +  struct grub_f2fs_nat_entry ne[NAT_ENTRY_PER_BLOCK];
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_dir_entry
> > +{
> > +  grub_uint32_t hash_code;
> > +  grub_uint32_t ino;
> > +  grub_uint16_t name_len;
> > +  grub_uint8_t file_type;
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_inline_dentry
> > +{
> > +  grub_uint8_t dentry_bitmap[INLINE_DENTRY_BITMAP_SIZE];
> > +  grub_uint8_t reserved[INLINE_RESERVED_SIZE];
> > +  struct grub_f2fs_dir_entry dentry[NR_INLINE_DENTRY];
> > +  grub_uint8_t filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_dentry_block {
> > +  grub_uint8_t dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
> > +  grub_uint8_t reserved[SIZE_OF_RESERVED];
> > +  struct grub_f2fs_dir_entry dentry[NR_DENTRY_IN_BLOCK];
> > +  grub_uint8_t filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_inode
> > +{
> > +  grub_uint16_t i_mode;
> > +  grub_uint8_t i_advise;
> > +  grub_uint8_t i_inline;
> > +  grub_uint32_t i_uid;
> > +  grub_uint32_t i_gid;
> > +  grub_uint32_t i_links;
> > +  grub_uint64_t i_size;
> > +  grub_uint64_t i_blocks;
> > +  grub_uint64_t i_atime;
> > +  grub_uint64_t i_ctime;
> > +  grub_uint64_t i_mtime;
> > +  grub_uint32_t i_atime_nsec;
> > +  grub_uint32_t i_ctime_nsec;
> > +  grub_uint32_t i_mtime_nsec;
> > +  grub_uint32_t i_generation;
> > +  grub_uint32_t i_current_depth;
> > +  grub_uint32_t i_xattr_nid;
> > +  grub_uint32_t i_flags;
> > +  grub_uint32_t i_pino;
> > +  grub_uint32_t i_namelen;
> > +  grub_uint8_t i_name[F2FS_NAME_LEN];
> > +  grub_uint8_t i_dir_level;
> > +  grub_uint8_t i_ext[12];
> > +  grub_uint32_t i_addr[DEF_ADDRS_PER_INODE];
> > +  grub_uint32_t i_nid[5];
> > +} GRUB_PACKED;
> > +
> > +struct grub_direct_node {
> > +  grub_uint32_t addr[ADDRS_PER_BLOCK];
> > +} GRUB_PACKED;
> > +
> > +struct grub_indirect_node {
> > +  grub_uint32_t nid[NIDS_PER_BLOCK];
> > +} GRUB_PACKED;
> > +
> > +struct grub_f2fs_node
> > +{
> > +  union
> > +  {
> > +    struct grub_f2fs_inode i;
> > +    struct grub_direct_node dn;
> > +    struct grub_indirect_node in;
> > +    char buf[F2FS_BLKSIZE - 40];     /* Should occupy F2FS_BLKSIZE
> totally */
> > +  };
> > +  grub_uint8_t dummy[40];
> > +} GRUB_PACKED;
> > +
> > +struct grub_fshelp_node
> > +{
> > +  struct grub_f2fs_data *data;
> > +  struct grub_f2fs_node inode;
> > +  grub_uint32_t ino;
> > +  int inode_read;
> > +};
> > +
> > +struct grub_f2fs_data
> > +{
> > +  struct grub_f2fs_superblock sblock;
> > +  struct grub_f2fs_checkpoint ckpt;
> > +
> > +  grub_uint32_t root_ino;
> > +  grub_uint32_t blocks_per_seg;
> > +  grub_uint32_t cp_blkaddr;
> > +  grub_uint32_t nat_blkaddr;
> > +
> > +  struct grub_f2fs_nat_journal nat_j;
> > +  char *nat_bitmap;
> > +
> > +  grub_disk_t disk;
> > +  struct grub_f2fs_node *inode;
> > +  struct grub_fshelp_node diropen;
> > +};
> > +
> > +struct grub_f2fs_dir_iter_ctx
> > +{
> > +  struct grub_f2fs_data *data;
> > +  grub_fshelp_iterate_dir_hook_t hook;
> > +  void *hook_data;
> > +  grub_uint8_t *bitmap;
> > +  grub_uint8_t (*filename)[F2FS_SLOT_LEN];
> > +  struct grub_f2fs_dir_entry *dentry;
> > +  int max;
> > +};
> > +
> > +struct grub_f2fs_dir_ctx
> > +{
> > +  grub_fs_dir_hook_t hook;
> > +  void *hook_data;
> > +  struct grub_f2fs_data *data;
> > +};
> > +
> > +static grub_dl_t my_mod;
> > +
> > +static inline int
> > +grub_f2fs_test_bit_le (int nr, const grub_uint8_t *addr)
> > +{
> > +  return addr[nr >> 3] & (1 << (nr & 7));
> > +}
> > +
> > +static inline char *
> > +__inline_addr (struct grub_f2fs_inode *inode)
> > +{
> > +  return (char *)&inode->i_addr[1];
> > +}
> > +
> > +static inline grub_uint64_t
> > +grub_f2fs_file_size (struct grub_f2fs_inode *inode)
> > +{
> > +  return grub_le_to_cpu64 (inode->i_size);
> > +}
> > +
> > +static inline grub_uint32_t
> > +__start_cp_addr (struct grub_f2fs_data *data)
> > +{
> > +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > +  grub_uint32_t start_addr =3D data->cp_blkaddr;
> > +
> > +  if (!(ckpt->checkpoint_ver & grub_cpu_to_le64_compile_time(1)))
> > +    return start_addr + data->blocks_per_seg;
> > +  return start_addr;
> > +}
> > +
> > +static inline grub_uint32_t
> > +__start_sum_block (struct grub_f2fs_data *data)
> > +{
> > +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > +
> > +  return __start_cp_addr (data) + grub_le_to_cpu32
> (ckpt->cp_pack_start_sum);
> > +}
> > +
> > +static inline grub_uint32_t
> > +__sum_blk_addr (struct grub_f2fs_data *data, int base, int type)
> > +{
> > +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > +
> > +  return __start_cp_addr (data) +
> > +     grub_le_to_cpu32 (ckpt->cp_pack_total_block_count)
> > +     - (base + 1) + type;
> > +}
> > +
> > +static inline void *
> > +__nat_bitmap_ptr (struct grub_f2fs_data *data)
> > +{
> > +  struct grub_f2fs_checkpoint *ckpt =3D &data->ckpt;
> > +  grub_uint32_t offset;
> > +
> > +  if (grub_le_to_cpu32 (data->sblock.cp_payload) > 0)
> > +    return ckpt->sit_nat_version_bitmap;
> > +
> > +  offset =3D grub_le_to_cpu32 (ckpt->sit_ver_bitmap_bytesize);
> > +  return ckpt->sit_nat_version_bitmap + offset;
> > +}
> > +
> > +static inline grub_uint32_t
> > +__get_node_id (struct grub_f2fs_node *rn, int off, int inode_block)
> > +{
> > +  if (inode_block)
> > +    return grub_le_to_cpu32 (rn->i.i_nid[off - NODE_DIR1_BLOCK]);
> > +  return grub_le_to_cpu32 (rn->in.nid[off]);
> > +}
> > +
> > +static inline grub_err_t
> > +grub_f2fs_block_read (struct grub_f2fs_data *data, grub_uint32_t
> blkaddr, void *buf)
> > +{
> > +  return grub_disk_read (data->disk,
> > +             ((grub_disk_addr_t)blkaddr) << F2FS_BLK_SEC_BITS,
> > +             0, F2FS_BLKSIZE, buf);
> > +}
> > +
> > +/*
> > + * CRC32
> > +*/
> > +#define CRCPOLY_LE 0xedb88320
> > +
> > +static inline grub_uint32_t
> > +grub_f2fs_cal_crc32 (const void *buf, const grub_uint32_t len)
> > +{
> > +  grub_uint32_t crc =3D F2FS_SUPER_MAGIC;
> > +  unsigned char *p =3D (unsigned char *)buf;
> > +  grub_uint32_t tmp =3D len;
> > +  int i;
> > +
> > +  while (tmp--)
> > +    {
> > +      crc ^=3D *p++;
> > +      for (i =3D 0; i < 8; i++)
> > +        crc =3D (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
> > +    }
> > +  return crc;
> > +}
> > +
> > +static inline int
> > +grub_f2fs_crc_valid (grub_uint32_t blk_crc, void *buf, const
> grub_uint32_t len)
> > +{
> > +  grub_uint32_t cal_crc =3D 0;
> > +
> > +  cal_crc =3D grub_f2fs_cal_crc32 (buf, len);
> > +
> > +  return (cal_crc =3D=3D blk_crc) ? 1 : 0;
> > +}
> > +
> > +static inline int
> > +grub_f2fs_test_bit (grub_uint32_t nr, const char *p)
> > +{
> > +  int mask;
> > +
> > +  p +=3D (nr >> 3);
> > +  mask =3D 1 << (7 - (nr & 0x07));
> > +  return mask & *p;
> > +}
> > +
> > +static int
> > +grub_f2fs_sanity_check_sb (struct grub_f2fs_superblock *sb)
> > +{
> > +  grub_uint32_t log_sectorsize, log_sectors_per_block;
> > +
> > +  if (sb->magic !=3D grub_cpu_to_le32_compile_time (F2FS_SUPER_MAGIC))
> > +    return -1;
> > +
> > +  if (sb->log_blocksize !=3D grub_cpu_to_le32_compile_time
> (F2FS_BLK_BITS))
> > +    return -1;
> > +
> > +  log_sectorsize =3D grub_le_to_cpu32 (sb->log_sectorsize);
> > +  log_sectors_per_block =3D grub_le_to_cpu32 (sb->log_sectors_per_bloc=
k);
> > +
> > +  if (log_sectorsize > F2FS_BLK_BITS)
> > +    return -1;
> > +
> > +  if (log_sectorsize < F2FS_MIN_LOG_SECTOR_SIZE)
> > +    return -1;
> > +
> > +  if (log_sectors_per_block + log_sectorsize !=3D F2FS_BLK_BITS)
> > +    return -1;
> > +
> > +  return 0;
> > +}
> > +
> > +static int
> > +grub_f2fs_read_sb (struct grub_f2fs_data *data, grub_disk_addr_t offse=
t)
> > +{
> > +  grub_disk_t disk =3D data->disk;
> > +  grub_err_t err;
> > +
> > +  /* Read first super block. */
> > +  err =3D grub_disk_read (disk, offset, 0, sizeof (data->sblock),
> &data->sblock);
> > +  if (err)
> > +    return -1;
> > +
> > +  return grub_f2fs_sanity_check_sb (&data->sblock);
> > +}
> > +
> > +static void *
> > +validate_checkpoint (struct grub_f2fs_data *data, grub_uint32_t cp_add=
r,
> > +     grub_uint64_t *version)
> > +{
> > +  grub_uint32_t *cp_page_1, *cp_page_2;
> > +  struct grub_f2fs_checkpoint *cp_block;
> > +  grub_uint64_t cur_version =3D 0, pre_version =3D 0;
> > +  grub_uint32_t crc =3D 0;
> > +  grub_uint32_t crc_offset;
> > +  grub_err_t err;
> > +
> > +  /* Read the 1st cp block in this CP pack */
> > +  cp_page_1 =3D grub_malloc (F2FS_BLKSIZE);
> > +  if (!cp_page_1)
> > +    return NULL;
> > +
> > +  err =3D grub_f2fs_block_read (data, cp_addr, cp_page_1);
> > +  if (err)
> > +    goto invalid_cp1;
> > +
> > +  cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_1;
> > +  crc_offset =3D grub_le_to_cpu32 (cp_block->checksum_offset);
> > +  if (crc_offset !=3D CHECKSUM_OFFSET)
> > +    goto invalid_cp1;
> > +
> > +  crc =3D grub_le_to_cpu32 (*(cp_page_1 + U32_CHECKSUM_OFFSET));
> > +  if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))
> > +    goto invalid_cp1;
> > +
> > +  pre_version =3D grub_le_to_cpu64 (cp_block->checkpoint_ver);
> > +
> > +  /* Read the 2nd cp block in this CP pack */
> > +  cp_page_2 =3D grub_malloc (F2FS_BLKSIZE);
> > +  if (!cp_page_2)
> > +    goto invalid_cp1;
> > +
> > +  cp_addr +=3D grub_le_to_cpu32 (cp_block->cp_pack_total_block_count) =
- 1;
> > +
> > +  err =3D grub_f2fs_block_read (data, cp_addr, cp_page_2);
> > +  if (err)
> > +    goto invalid_cp2;
> > +
> > +  cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_2;
> > +  crc_offset =3D grub_le_to_cpu32 (cp_block->checksum_offset);
> > +  if (crc_offset !=3D CHECKSUM_OFFSET)
> > +    goto invalid_cp2;
> > +
> > +  crc =3D grub_le_to_cpu32 (*(cp_page_2 + U32_CHECKSUM_OFFSET));
> > +  if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))
> > +    goto invalid_cp2;
> > +
> > +  cur_version =3D grub_le_to_cpu64 (cp_block->checkpoint_ver);
> > +  if (cur_version =3D=3D pre_version)
> > +    {
> > +      *version =3D cur_version;
> > +      grub_free (cp_page_2);
> > +      return cp_page_1;
> > +    }
> > +
> > +invalid_cp2:
> > +  grub_free (cp_page_2);
> > +invalid_cp1:
> > +  grub_free (cp_page_1);
> > +  return NULL;
> > +}
> > +
> > +static grub_err_t
> > +grub_f2fs_read_cp (struct grub_f2fs_data *data)
> > +{
> > +  void *cp1, *cp2, *cur_page;
> > +  grub_uint64_t cp1_version =3D 0, cp2_version =3D 0;
> > +  grub_uint64_t cp_start_blk_no;
> > +
> > +  /*
> > +   * Finding out valid cp block involves read both
> > +   * sets (cp pack1 and cp pack 2)
> > +   */
> > +  cp_start_blk_no =3D data->cp_blkaddr;
> > +  cp1 =3D validate_checkpoint (data, cp_start_blk_no, &cp1_version);
> > +  if (!cp1 && grub_errno)
> > +    return grub_errno;
> > +
> > +  /* The second checkpoint pack should start at the next segment */
> > +  cp_start_blk_no +=3D data->blocks_per_seg;
> > +  cp2 =3D validate_checkpoint (data, cp_start_blk_no, &cp2_version);
> > +  if (!cp2 && grub_errno)
> > +    {
> > +      grub_free (cp1);
> > +      return grub_errno;
> > +    }
> > +
> > +  if (cp1 && cp2)
> > +    cur_page =3D (cp2_version > cp1_version) ? cp2 : cp1;
> > +  else if (cp1)
> > +    cur_page =3D cp1;
> > +  else if (cp2)
> > +    cur_page =3D cp2;
> > +  else
> > +    return grub_error (GRUB_ERR_BAD_FS, "no checkpoints");
> > +
> > +  grub_memcpy (&data->ckpt, cur_page, F2FS_BLKSIZE);
> > +
> > +  grub_free (cp1);
> > +  grub_free (cp2);
> > +  return 0;
> > +}
> > +
> > +static grub_err_t
> > +get_nat_journal (struct grub_f2fs_data *data)
> > +{
> > +  grub_uint32_t block;
> > +  char *buf;
> > +  grub_err_t err;
> > +
> > +  buf =3D grub_malloc (F2FS_BLKSIZE);
> > +  if (!buf)
> > +    return grub_errno;
> > +
> > +  if (CKPT_FLAG_SET(&data->ckpt, CP_COMPACT_SUM_FLAG))
> > +    block =3D __start_sum_block (data);
> > +  else if (CKPT_FLAG_SET (&data->ckpt, CP_UMOUNT_FLAG))
> > +    block =3D __sum_blk_addr (data, NR_CURSEG_TYPE, CURSEG_HOT_DATA);
> > +  else
> > +    block =3D __sum_blk_addr (data, NR_CURSEG_DATA_TYPE, CURSEG_HOT_DA=
TA);
> > +
> > +  err =3D grub_f2fs_block_read (data, block, buf);
> > +  if (err)
> > +    goto fail;
> > +
> > +  if (CKPT_FLAG_SET (&data->ckpt, CP_COMPACT_SUM_FLAG))
> > +    grub_memcpy (&data->nat_j, buf, SUM_JOURNAL_SIZE);
> > +  else
> > +    grub_memcpy (&data->nat_j, buf + SUM_ENTRIES_SIZE,
> SUM_JOURNAL_SIZE);
> > +
> > +fail:
> > +  grub_free (buf);
> > +  return err;
> > +}
> > +
> > +static grub_uint32_t
> > +get_blkaddr_from_nat_journal (struct grub_f2fs_data *data,
> grub_uint32_t nid)
> > +{
> > +  grub_uint16_t n =3D grub_le_to_cpu16 (data->nat_j.n_nats);
> > +  grub_uint32_t blkaddr =3D 0;
> > +  grub_uint16_t i;
> > +
> > +  for (i =3D 0; i < n; i++)
> > +    {
> > +      if (grub_le_to_cpu32 (data->nat_j.entries[i].nid) =3D=3D nid)
> > +        {
> > +          blkaddr =3D grub_le_to_cpu32
> (data->nat_j.entries[i].ne.block_addr);
> > +          break;
> > +        }
> > +    }
> > +  return blkaddr;
> > +}
> > +
> > +static grub_uint32_t
> > +get_node_blkaddr (struct grub_f2fs_data *data, grub_uint32_t nid)
> > +{
> > +  struct grub_f2fs_nat_block *nat_block;
> > +  grub_uint32_t seg_off, block_off, entry_off, block_addr;
> > +  grub_uint32_t blkaddr;
> > +  grub_err_t err;
> > +
> > +  blkaddr =3D get_blkaddr_from_nat_journal (data, nid);
> > +  if (blkaddr)
> > +    return blkaddr;
> > +
> > +  nat_block =3D grub_malloc (F2FS_BLKSIZE);
> > +  if (!nat_block)
> > +    return 0;
> > +
> > +  block_off =3D nid / NAT_ENTRY_PER_BLOCK;
> > +  entry_off =3D nid % NAT_ENTRY_PER_BLOCK;
> > +
> > +  seg_off =3D block_off / data->blocks_per_seg;
> > +  block_addr =3D data->nat_blkaddr +
> > +     ((seg_off * data->blocks_per_seg) << 1) +
> > +     (block_off & (data->blocks_per_seg - 1));
> > +
> > +  if (grub_f2fs_test_bit (block_off, data->nat_bitmap))
> > +    block_addr +=3D data->blocks_per_seg;
> > +
> > +  err =3D grub_f2fs_block_read (data, block_addr, nat_block);
> > +  if (err)
> > +    {
> > +      grub_free (nat_block);
> > +      return 0;
> > +    }
> > +
> > +  blkaddr =3D grub_le_to_cpu32 (nat_block->ne[entry_off].block_addr);
> > +
> > +  grub_free (nat_block);
> > +
> > +  return blkaddr;
> > +}
> > +
> > +static int
> > +grub_get_node_path (struct grub_f2fs_inode *inode, grub_uint32_t block=
,
> > +     grub_uint32_t offset[4], grub_uint32_t noffset[4])
> > +{
> > +  grub_uint32_t direct_blks =3D ADDRS_PER_BLOCK;
> > +  grub_uint32_t dptrs_per_blk =3D NIDS_PER_BLOCK;
> > +  grub_uint32_t indirect_blks =3D ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
> > +  grub_uint32_t dindirect_blks =3D indirect_blks * NIDS_PER_BLOCK;
> > +  grub_uint32_t direct_index =3D DEF_ADDRS_PER_INODE;
> > +  int n =3D 0;
> > +  int level =3D 0;
> > +
> > +  if (inode->i_inline & F2FS_INLINE_XATTR)
> > +    direct_index -=3D F2FS_INLINE_XATTR_ADDRS;
> > +
> > +  noffset[0] =3D 0;
> > +
> > +  if (block < direct_index)
> > +    {
> > +      offset[n] =3D block;
> > +      goto got;
> > +    }
> > +
> > +  block -=3D direct_index;
> > +  if (block < direct_blks)
> > +    {
> > +      offset[n++] =3D NODE_DIR1_BLOCK;
> > +      noffset[n] =3D 1;
> > +      offset[n] =3D block;
> > +      level =3D 1;
> > +      goto got;
> > +    }
> > +
> > +  block -=3D direct_blks;
> > +  if (block < direct_blks)
> > +    {
> > +      offset[n++] =3D NODE_DIR2_BLOCK;
> > +      noffset[n] =3D 2;
> > +      offset[n] =3D block;
> > +      level =3D 1;
> > +      goto got;
> > +    }
> > +
> > +  block -=3D direct_blks;
> > +  if (block < indirect_blks)
> > +    {
> > +      offset[n++] =3D NODE_IND1_BLOCK;
> > +      noffset[n] =3D 3;
> > +      offset[n++] =3D block / direct_blks;
> > +      noffset[n] =3D 4 + offset[n - 1];
> > +      offset[n] =3D block % direct_blks;
> > +      level =3D 2;
> > +      goto got;
> > +    }
> > +
> > +  block -=3D indirect_blks;
> > +  if (block < indirect_blks)
> > +    {
> > +      offset[n++] =3D NODE_IND2_BLOCK;
> > +      noffset[n] =3D 4 + dptrs_per_blk;
> > +      offset[n++] =3D block / direct_blks;
> > +      noffset[n] =3D 5 + dptrs_per_blk + offset[n - 1];
> > +      offset[n] =3D block % direct_blks;
> > +      level =3D 2;
> > +      goto got;
> > +    }
> > +
> > +  block -=3D indirect_blks;
> > +  if (block < dindirect_blks)
> > +    {
> > +      offset[n++] =3D NODE_DIND_BLOCK;
> > +      noffset[n] =3D 5 + (dptrs_per_blk * 2);
> > +      offset[n++] =3D block / indirect_blks;
> > +      noffset[n] =3D 6 + (dptrs_per_blk * 2) +
> > +      offset[n - 1] * (dptrs_per_blk + 1);
> > +      offset[n++] =3D (block / direct_blks) % dptrs_per_blk;
> > +      noffset[n] =3D 7 + (dptrs_per_blk * 2) +
> > +             offset[n - 2] * (dptrs_per_blk + 1) + offset[n - 1];
> > +      offset[n] =3D block % direct_blks;
> > +      level =3D 3;
> > +      goto got;
> > +    }
> > +got:
> > +  return level;
> > +}
> > +
> > +static grub_err_t
> > +grub_f2fs_read_node (struct grub_f2fs_data *data,
> > +     grub_uint32_t nid, struct grub_f2fs_node *np)
> > +{
> > +  grub_uint32_t blkaddr;
> > +
> > +  blkaddr =3D get_node_blkaddr (data, nid);
> > +  if (!blkaddr)
> > +    return grub_errno;
> > +
> > +  return grub_f2fs_block_read (data, blkaddr, np);
> > +}
> > +
> > +static struct grub_f2fs_data *
> > +grub_f2fs_mount (grub_disk_t disk)
> > +{
> > +  struct grub_f2fs_data *data;
> > +  grub_err_t err;
> > +
> > +  data =3D grub_malloc (sizeof (*data));
> > +  if (!data)
> > +    return NULL;
> > +
> > +  data->disk =3D disk;
> > +
> > +  if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET0))
> > +    {
> > +      if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET1))
> > +        {
> > +          if (grub_errno =3D=3D GRUB_ERR_NONE)
> > +            grub_error (GRUB_ERR_BAD_FS,
> > +                     "not a F2FS filesystem (no superblock)");
> > +          goto fail;
> > +        }
> > +    }
> > +
> > +  data->root_ino =3D grub_le_to_cpu32 (data->sblock.root_ino);
> > +  data->cp_blkaddr =3D grub_le_to_cpu32 (data->sblock.cp_blkaddr);
> > +  data->nat_blkaddr =3D grub_le_to_cpu32 (data->sblock.nat_blkaddr);
> > +  data->blocks_per_seg =3D 1 <<
> > +     grub_le_to_cpu32 (data->sblock.log_blocks_per_seg);
> > +
> > +  err =3D grub_f2fs_read_cp (data);
> > +  if (err)
> > +    goto fail;
> > +
> > +  data->nat_bitmap =3D __nat_bitmap_ptr (data);
> > +
> > +  err =3D get_nat_journal (data);
> > +  if (err)
> > +    goto fail;
> > +
> > +  data->diropen.data =3D data;
> > +  data->diropen.ino =3D data->root_ino;
> > +  data->diropen.inode_read =3D 1;
> > +  data->inode =3D &data->diropen.inode;
> > +
> > +  err =3D grub_f2fs_read_node (data, data->root_ino, data->inode);
> > +  if (err)
> > +    goto fail;
> > +
> > +  return data;
> > +
> > +fail:
> > +  grub_free (data);
> > +  return NULL;
> > +}
> > +
> > +/* guarantee inline_data was handled by caller */
> > +static grub_disk_addr_t
> > +grub_f2fs_get_block (grub_fshelp_node_t node, grub_disk_addr_t
> block_ofs)
> > +{
> > +  struct grub_f2fs_data *data =3D node->data;
> > +  struct grub_f2fs_inode *inode =3D &node->inode.i;
> > +  grub_uint32_t offset[4], noffset[4], nids[4];
> > +  struct grub_f2fs_node *node_block;
> > +  grub_uint32_t block_addr =3D -1;
> > +  int level, i;
> > +
> > +  level =3D grub_get_node_path (inode, block_ofs, offset, noffset);
> > +  if (level =3D=3D 0)
> > +    return grub_le_to_cpu32 (inode->i_addr[offset[0]]);
> > +
> > +  node_block =3D grub_malloc (F2FS_BLKSIZE);
> > +  if (!node_block)
> > +    return -1;
> > +
> > +  nids[1] =3D __get_node_id (&node->inode, offset[0], 1);
> > +
> > +  /* get indirect or direct nodes */
> > +  for (i =3D 1; i <=3D level; i++)
> > +    {
> > +      grub_f2fs_read_node (data, nids[i], node_block);
> > +      if (grub_errno)
> > +        goto fail;
> > +
> > +      if (i < level)
> > +        nids[i + 1] =3D __get_node_id (node_block, offset[i], 0);
> > +    }
> > +
> > +  block_addr =3D grub_le_to_cpu32 (node_block->dn.addr[offset[level]])=
;
> > +fail:
> > +  grub_free (node_block);
> > +  return block_addr;
> > +}
> > +
> > +static grub_ssize_t
> > +grub_f2fs_read_file (grub_fshelp_node_t node,
> > +             grub_disk_read_hook_t read_hook, void *read_hook_data,
> > +             grub_off_t pos, grub_size_t len, char *buf)
> > +{
> > +  struct grub_f2fs_inode *inode =3D &node->inode.i;
> > +  grub_off_t filesize =3D grub_f2fs_file_size (inode);
> > +  char *inline_addr =3D __inline_addr (inode);
> > +
> > +  if (inode->i_inline & F2FS_INLINE_DATA)
> > +    {
> > +      if (filesize > MAX_INLINE_DATA)
> > +        return -1;
> > +      if (len > filesize - pos)
> > +        len =3D filesize - pos;
> > +
> > +      grub_memcpy (buf + pos, inline_addr + pos, len);
> > +      return len;
> > +    }
> > +
> > +  return grub_fshelp_read_file (node->data->disk, node,
> > +                     read_hook, read_hook_data,
> > +                     pos, len, buf, grub_f2fs_get_block,
> > +                     filesize,
> > +                     F2FS_BLK_SEC_BITS, 0);
> > +}
> > +
> > +static char *
> > +grub_f2fs_read_symlink (grub_fshelp_node_t node)
> > +{
> > +  char *symlink;
> > +  struct grub_fshelp_node *diro =3D node;
> > +  grub_uint64_t filesize;
> > +
> > +  if (!diro->inode_read)
> > +    {
> > +      grub_f2fs_read_node (diro->data, diro->ino, &diro->inode);
> > +      if (grub_errno)
> > +        return 0;
> > +    }
> > +
> > +  filesize =3D grub_f2fs_file_size(&diro->inode.i);
> > +
> > +  symlink =3D grub_malloc (filesize + 1);
> > +  if (!symlink)
> > +    return 0;
> > +
> > +  grub_f2fs_read_file (diro, 0, 0, 0, filesize, symlink);
> > +  if (grub_errno)
> > +    {
> > +      grub_free (symlink);
> > +      return 0;
> > +    }
> > +
> > +  symlink[filesize] =3D '\0';
> > +  return symlink;
> > +}
> > +
> > +static int
> > +grub_f2fs_check_dentries (struct grub_f2fs_dir_iter_ctx *ctx)
> > +{
> > +  struct grub_fshelp_node *fdiro;
> > +  int i;
> > +
> > +  for (i =3D 0; i < ctx->max;)
> > +    {
> > +      char *filename;
> > +      enum grub_fshelp_filetype type =3D GRUB_FSHELP_UNKNOWN;
> > +      enum FILE_TYPE ftype;
> > +      int name_len;
> > +      int ret;
> > +
> > +      if (grub_f2fs_test_bit_le (i, ctx->bitmap) =3D=3D 0)
> > +        {
> > +          i++;
> > +          continue;
> > +        }
> > +
> > +      ftype =3D ctx->dentry[i].file_type;
> > +      name_len =3D grub_le_to_cpu16 (ctx->dentry[i].name_len);
> > +      filename =3D grub_malloc (name_len + 1);
> > +      if (!filename)
> > +        return 0;
> > +
> > +      grub_memcpy (filename, ctx->filename[i], name_len);
> > +      filename[name_len] =3D 0;
> > +
> > +      fdiro =3D grub_malloc (sizeof (struct grub_fshelp_node));
> > +      if (!fdiro)
> > +        {
> > +          grub_free(filename);
> > +          return 0;
> > +        }
> > +
> > +      if (ftype =3D=3D F2FS_FT_DIR)
> > +        type =3D GRUB_FSHELP_DIR;
> > +      else if (ftype =3D=3D F2FS_FT_SYMLINK)
> > +        type =3D GRUB_FSHELP_SYMLINK;
> > +      else if (ftype =3D=3D F2FS_FT_REG_FILE)
> > +        type =3D GRUB_FSHELP_REG;
> > +
> > +      fdiro->data =3D ctx->data;
> > +      fdiro->ino =3D grub_le_to_cpu32 (ctx->dentry[i].ino);
> > +      fdiro->inode_read =3D 0;
> > +
> > +      ret =3D ctx->hook (filename, type, fdiro, ctx->hook_data);
> > +      grub_free(filename);
> > +      if (ret)
> > +        return 1;
> > +
> > +      i +=3D (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int
> > +grub_f2fs_iterate_inline_dir (struct grub_f2fs_inode *dir,
> > +     struct grub_f2fs_dir_iter_ctx *ctx)
> > +{
> > +  struct grub_f2fs_inline_dentry *de_blk;
> > +
> > +  de_blk =3D (struct grub_f2fs_inline_dentry *) __inline_addr (dir);
> > +
> > +  ctx->bitmap =3D de_blk->dentry_bitmap;
> > +  ctx->dentry =3D de_blk->dentry;
> > +  ctx->filename =3D de_blk->filename;
> > +  ctx->max =3D NR_INLINE_DENTRY;
> > +
> > +  return grub_f2fs_check_dentries (ctx);
> > +}
> > +
> > +static int
> > +grub_f2fs_iterate_dir (grub_fshelp_node_t dir,
> > +     grub_fshelp_iterate_dir_hook_t hook, void *hook_data)
> > +{
> > +  struct grub_fshelp_node *diro =3D (struct grub_fshelp_node *) dir;
> > +  struct grub_f2fs_inode *inode;
> > +  struct grub_f2fs_dir_iter_ctx ctx =3D {
> > +    .data =3D diro->data,
> > +    .hook =3D hook,
> > +    .hook_data =3D hook_data
> > +  };
> > +  grub_off_t fpos =3D 0;
> > +
> > +  if (!diro->inode_read)
> > +    {
> > +      grub_f2fs_read_node (diro->data, diro->ino, &diro->inode);
> > +      if (grub_errno)
> > +     return 0;
> > +    }
> > +
> > +  inode =3D &diro->inode.i;
> > +
> > +  if (inode->i_inline & F2FS_INLINE_DENTRY)
> > +    return grub_f2fs_iterate_inline_dir (inode, &ctx);
> > +
> > +  while (fpos < grub_f2fs_file_size (inode))
> > +    {
> > +      struct grub_f2fs_dentry_block *de_blk;
> > +      char *buf;
> > +      int ret;
> > +
> > +      buf =3D grub_zalloc (F2FS_BLKSIZE);
> > +      if (!buf)
> > +        return 0;
> > +
> > +      grub_f2fs_read_file (diro, 0, 0, fpos, F2FS_BLKSIZE, buf);
> > +      if (grub_errno)
> > +        {
> > +          grub_free (buf);
> > +          return 0;
> > +        }
> > +
> > +      de_blk =3D (struct grub_f2fs_dentry_block *) buf;
> > +
> > +      ctx.bitmap =3D de_blk->dentry_bitmap;
> > +      ctx.dentry =3D de_blk->dentry;
> > +      ctx.filename =3D de_blk->filename;
> > +      ctx.max =3D NR_DENTRY_IN_BLOCK;
> > +
> > +      ret =3D grub_f2fs_check_dentries (&ctx);
> > +      grub_free (buf);
> > +      if (ret)
> > +        return 1;
> > +
> > +      fpos +=3D F2FS_BLKSIZE;
> > +    }
> > +  return 0;
> > +}
> > +
> > +static int
> > +grub_f2fs_dir_iter (const char *filename, enum grub_fshelp_filetype
> filetype,
> > +           grub_fshelp_node_t node, void *data)
> > +{
> > +  struct grub_f2fs_dir_ctx *ctx =3D data;
> > +  struct grub_dirhook_info info;
> > +
> > +  grub_memset (&info, 0, sizeof (info));
> > +  if (!node->inode_read)
> > +    {
> > +      grub_f2fs_read_node (ctx->data, node->ino, &node->inode);
> > +      if (!grub_errno)
> > +        node->inode_read =3D 1;
> > +      grub_errno =3D GRUB_ERR_NONE;
> > +    }
> > +  if (node->inode_read)
> > +    {
> > +      info.mtimeset =3D 1;
> > +      info.mtime =3D grub_le_to_cpu64 (node->inode.i.i_mtime);
> > +    }
> > +
> > +  info.dir =3D ((filetype & GRUB_FSHELP_TYPE_MASK) =3D=3D GRUB_FSHELP_=
DIR);
> > +  grub_free (node);
> > +  return ctx->hook (filename, &info, ctx->hook_data);
> > +}
> > +
> > +static grub_err_t
> > +grub_f2fs_dir (grub_device_t device, const char *path,
> > +     grub_fs_dir_hook_t hook, void *hook_data)
> > +{
> > +  struct grub_f2fs_dir_ctx ctx =3D {
> > +    .hook =3D hook,
> > +    .hook_data =3D hook_data
> > +  };
> > +  struct grub_fshelp_node *fdiro =3D 0;
> > +
> > +  grub_dl_ref (my_mod);
> > +
> > +  ctx.data =3D grub_f2fs_mount (device->disk);
> > +  if (!ctx.data)
> > +    goto fail;
> > +
> > +  grub_fshelp_find_file (path, &ctx.data->diropen, &fdiro,
> > +             grub_f2fs_iterate_dir, grub_f2fs_read_symlink,
> > +             GRUB_FSHELP_DIR);
> > +  if (grub_errno)
> > +    goto fail;
> > +
> > +  grub_f2fs_iterate_dir (fdiro, grub_f2fs_dir_iter, &ctx);
> > +
> > +fail:
> > +  if (fdiro !=3D &ctx.data->diropen)
> > +    grub_free (fdiro);
> > + grub_free (ctx.data);
> > + grub_dl_unref (my_mod);
> > + return grub_errno;
> > +}
> > +
> > +
> > +/* Open a file named NAME and initialize FILE.  */
> > +static grub_err_t
> > +grub_f2fs_open (struct grub_file *file, const char *name)
> > +{
> > +  struct grub_f2fs_data *data =3D NULL;
> > +  struct grub_fshelp_node *fdiro =3D 0;
> > +  struct grub_f2fs_inode *inode;
> > +
> > +  grub_dl_ref (my_mod);
> > +
> > +  data =3D grub_f2fs_mount (file->device->disk);
> > +  if (!data)
> > +    goto fail;
> > +
> > +  grub_fshelp_find_file (name, &data->diropen, &fdiro,
> > +                     grub_f2fs_iterate_dir, grub_f2fs_read_symlink,
> > +                     GRUB_FSHELP_REG);
> > +  if (grub_errno)
> > +    goto fail;
> > +
> > +  if (!fdiro->inode_read)
> > +    {
> > +      grub_f2fs_read_node (data, fdiro->ino, &fdiro->inode);
> > +      if (grub_errno)
> > +     goto fail;
> > +    }
> > +
> > +  grub_memcpy (data->inode, &fdiro->inode, sizeof (*data->inode));
> > +  grub_free (fdiro);
> > +
> > +  inode =3D &(data->inode->i);
> > +  file->size =3D grub_f2fs_file_size (inode);
> > +  file->data =3D data;
> > +  file->offset =3D 0;
> > +
> > +  if (inode->i_inline & F2FS_INLINE_DATA && file->size >
> MAX_INLINE_DATA)
> > +    grub_error (GRUB_ERR_BAD_FS, "corrupted inline_data: need fsck");
> > +  return 0;
> > +
> > +fail:
> > +  if (fdiro !=3D &data->diropen)
> > +    grub_free (fdiro);
> > +  grub_free (data);
> > +
> > +  grub_dl_unref (my_mod);
> > +
> > +  return grub_errno;
> > +}
> > +
> > +static grub_ssize_t
> > +grub_f2fs_read (grub_file_t file, char *buf, grub_size_t len)
> > +{
> > +  struct grub_f2fs_data *data =3D (struct grub_f2fs_data *) file->data=
;
> > +
> > +  return grub_f2fs_read_file (&data->diropen,
> > +             file->read_hook, file->read_hook_data,
> > +             file->offset, len, buf);
> > +}
> > +
> > +static grub_err_t
> > +grub_f2fs_close (grub_file_t file)
> > +{
> > +  struct grub_f2fs_data *data =3D (struct grub_f2fs_data *) file->data=
;
> > +
> > +  grub_free (data);
> > +
> > +  grub_dl_unref (my_mod);
> > +
> > +  return GRUB_ERR_NONE;
> > +}
> > +
> > +static grub_uint8_t *
> > +grub_f2fs_utf16_to_utf8 (grub_uint16_t *in_buf_le)
> > +{
> > +  grub_uint16_t in_buf[MAX_VOLUME_NAME];
> > +  grub_uint8_t *out_buf;
> > +  int len =3D 0;
> > +
> > +  out_buf =3D grub_malloc (MAX_VOLUME_NAME * GRUB_MAX_UTF8_PER_UTF16 +=
 1);
> > +  if (!out_buf)
> > +    return NULL;
> > +
> > +  while (*in_buf_le !=3D 0 && len < MAX_VOLUME_NAME) {
> > +    in_buf[len] =3D grub_le_to_cpu16 (in_buf_le[len]);
> > +    len++;
> > +  }
> > +
> > +  *grub_utf16_to_utf8 (out_buf, in_buf, len) =3D '\0';
> > +  return out_buf;
> > +}
> > +
> > +static grub_err_t
> > +grub_f2fs_label (grub_device_t device, char **label)
> > +{
> > +  struct grub_f2fs_data *data;
> > +  grub_disk_t disk =3D device->disk;
> > +
> > +  grub_dl_ref (my_mod);
> > +
> > +  data =3D grub_f2fs_mount (disk);
> > +  if (data)
> > +    *label =3D (char *) grub_f2fs_utf16_to_utf8
> (data->sblock.volume_name);
> > +  else
> > +    *label =3D NULL;
> > +
> > +  grub_free (data);
> > +  grub_dl_unref (my_mod);
> > +  return grub_errno;
> > +}
> > +
> > +static grub_err_t
> > +grub_f2fs_uuid (grub_device_t device, char **uuid)
> > +{
> > +  struct grub_f2fs_data *data;
> > +  grub_disk_t disk =3D device->disk;
> > +
> > +  grub_dl_ref (my_mod);
> > +
> > +  data =3D grub_f2fs_mount (disk);
> > +  if (data)
> > +    {
> > +      *uuid =3D
> > +     grub_xasprintf
> > +
>  ("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
> > +             data->sblock.uuid[0], data->sblock.uuid[1],
> > +             data->sblock.uuid[2], data->sblock.uuid[3],
> > +             data->sblock.uuid[4], data->sblock.uuid[5],
> > +             data->sblock.uuid[6], data->sblock.uuid[7],
> > +             data->sblock.uuid[8], data->sblock.uuid[9],
> > +             data->sblock.uuid[10], data->sblock.uuid[11],
> > +             data->sblock.uuid[12], data->sblock.uuid[13],
> > +             data->sblock.uuid[14], data->sblock.uuid[15]);
> > +    }
> > +  else
> > +    *uuid =3D NULL;
> > +
> > +  grub_free (data);
> > +  grub_dl_unref (my_mod);
> > +  return grub_errno;
> > +}
> > +
> > +static struct grub_fs grub_f2fs_fs =3D {
> > +  .name =3D "f2fs",
> > +  .dir =3D grub_f2fs_dir,
> > +  .open =3D grub_f2fs_open,
> > +  .read =3D grub_f2fs_read,
> > +  .close =3D grub_f2fs_close,
> > +  .label =3D grub_f2fs_label,
> > +  .uuid =3D grub_f2fs_uuid,
> > +#ifdef GRUB_UTIL
> > +  .reserved_first_sector =3D 1,
> > +  .blocklist_install =3D 0,
> > +#endif
> > +  .next =3D 0
> > +};
> > +
> > +GRUB_MOD_INIT (f2fs)
> > +{
> > +  grub_fs_register (&grub_f2fs_fs);
> > +  my_mod =3D mod;
> > +}
> > +
> > +GRUB_MOD_FINI (f2fs)
> > +{
> > +  grub_fs_unregister (&grub_f2fs_fs);
> > +}
> > diff --git a/po/exclude.pot b/po/exclude.pot
> > index 0a9b215..816089c 100644
> > --- a/po/exclude.pot
> > +++ b/po/exclude.pot
> > @@ -1214,6 +1214,7 @@ msgstr ""
> >
> >  #: grub-core/commands/xnu_uuid.c:75 grub-core/fs/jfs.c:924
> >  #: grub-core/fs/nilfs2.c:1135
> > +#: grub-core/fs/f2fs.c:1259
> >  #, c-format
> >  msgid
> "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
> >  msgstr ""
> > diff --git a/tests/f2fs_test.in b/tests/f2fs_test.in
> > new file mode 100644
> > index 0000000..1ea77c8
> > --- /dev/null
> > +++ b/tests/f2fs_test.in
> > @@ -0,0 +1,19 @@
> > +#!/bin/sh
> > +
> > +set -e
> > +
> > +if [ "x$EUID" =3D "x" ] ; then
> > + EUID=3D`id -u`
> > +fi
> > +
> > +if [ "$EUID" !=3D 0 ] ; then
> > + exit 77
> > +fi
> > +
> > +if ! which mkfs.f2fs >/dev/null 2>&1; then
> > + echo "mkfs.f2fs not installed; cannot test f2fs."
> > + exit 77
> > +fi
> > +
> > +
> > +"@builddir@/grub-fs-tester" f2fs
> > diff --git a/tests/util/grub-fs-tester.in b/tests/util/grub-fs-tester.i=
n
> > index 424de22..e3e4109 100644
> > --- a/tests/util/grub-fs-tester.in
> > +++ b/tests/util/grub-fs-tester.in
> > @@ -142,7 +142,7 @@ for
> ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOG=
SECSIZE +
> >       xsquash*)
> >           MINBLKSIZE=3D4096
> >           MAXBLKSIZE=3D1048576;;
> > -     xxfs)
> > +     xxfs|xf2fs)
> >           MINBLKSIZE=3D$SECSIZE
> >               # OS Limitation: GNU/Linux doesn't accept > 4096
> >           MAXBLKSIZE=3D4096;;
> > @@ -265,6 +265,10 @@ for
> ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOG=
SECSIZE +
> >               x"btrfs"*)
> >                   FSLABEL=3D"grub_;/test=C3=A9=F0=AF=A6=9B=F0=AF=A6=9D=
=F0=9F=98=81=D0=BA=D0=B8=D1=80=D0=B8=D1=82i
> urewfceniuewruevrewnuuireurevueurnievrewfnerfcnevirivinrewvnirewnivrewiuv=
crewvnuewvrrrewniuerwreiuviurewiuviurewnuvewnvrenurnunuvrevuurerejiremvreij=
nvcreivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoireoif";;
> >
> > +         # FS LIMITATION: f2fs label is at most 512 UTF-16 chars
> > +             x"f2fs")
> > +
>  FSLABEL=3D"grub_;/test=C3=A9=E4=8F=8C=E4=90=93=E4=8F=95=D0=BA=D0=B8=D1=
=80=D0=B8=D1=82iurewfceniuewruewnuuireurevueurnievrewfnerfcnevirivinrewvnir=
ewnivrewiuvcrewvnuewvrrrewniuerwreiuviurewiuviurewnuvewnvrenurnunuvrevuurer=
ejiremvreijnvvcreivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoirvcreivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoircreivire
> nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoireoifoiq";;
> > +
> >           # FS LIMITATION: exfat is at most 15 UTF-16 chars
> >               x"exfat")
> >                   FSLABEL=3D"g=C3=A9=D1=82 ;/=F0=AF=A6=9B=F0=AF=A6=9D=
=F0=9F=98=81=D0=BA=D0=B8=D1=80";;
> > @@ -474,7 +478,7 @@ for
> ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOG=
SECSIZE +
> >           # FIXME: Not sure about BtrFS, NTFS, JFS, AFS, UDF and SFS.
> Check it.
> >       # FS LIMITATION: as far as I know those FS don't store their last
> modification date.
> >               x"jfs_caseins" | x"jfs" | x"xfs" | x"xfs_crc" | x"btrfs"*
> | x"reiserfs_old" | x"reiserfs" \
> > -                 | x"bfs" | x"afs" \
> > +                 | x"bfs" | x"afs" | x"f2fs" \
> >                   | x"tarfs" | x"cpio_"* | x"minix" | x"minix2" \
> >                   | x"minix3" | x"ntfs"* | x"udf" | x"sfs"*)
> >                   NOFSTIME=3Dy;;
> > @@ -753,6 +757,8 @@ for
> ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE<=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOG=
SECSIZE +
> >                   MOUNTDEVICE=3D"/dev/mapper/grub_test-testvol"
> >                   MOUNTFS=3Dext2
> >                   "mkfs.ext2" -L "$FSLABEL" -q "${MOUNTDEVICE}"  ;;
> > +             xf2fs)
> > +                 "mkfs.f2fs" -l "$FSLABEL" -q "${LODEVICES[0]}" ;;
> >               xnilfs2)
> >                   "mkfs.nilfs2" -L "$FSLABEL" -b $BLKSIZE  -q
> "${LODEVICES[0]}" ;;
> >               xext2_old)
> >
>
>
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel
>

--047d7b86dcb4c4a9e9052d1920ed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I found a bug in the &#39;grub_f2fs_read_file&#39; functio=
n.<div>It fails when the file position is not 0. to fix it:</div><div><div>=
- =C2=A0 =C2=A0 =C2=A0grub_memcpy (buf + pos, inline_addr + pos, len);</div=
><div>+ =C2=A0 =C2=A0 =C2=A0grub_memcpy (buf, inline_addr + pos, len);</div=
></div><div><br></div><div><br></div><div>Michael</div></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Tue, Mar 1, 2016 at 8:52 PM,=
 Andrei Borzenkov <span dir=3D"ltr">&lt;<a href=3D"mailto:arvidjaar@gmail.c=
om" target=3D"_blank">arvidjaar@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">ACK from my side. It is leaf code that does not affe=
ct anything so<br>
should not cause any regression.<br>
<br>
<a href=3D"tel:22.02.2016%2021" value=3D"+12202201621">22.02.2016 21</a>:25=
, Jaegeuk Kim =D0=BF=D0=B8=D1=88=D0=B5=D1=82:<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; Chang log from v6:<br>
&gt;=C2=A0 o remove redundant filesize check in -&gt;read<br>
&gt;=C2=A0 o check consistency in -&gt;open regarding to inline_data<br>
&gt;<br>
&gt; -- &gt;8 --<br>
&gt; From 51c120612fdbc4bc315e9c4c6e91ca888c3f3596 Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk@kernel.org">jaegeuk@ke=
rnel.org</a>&gt;<br>
&gt; Date: Tue, 17 Nov 2015 12:45:13 -0800<br>
&gt; Subject: [PATCH] F2FS support<br>
&gt;<br>
&gt; &quot;F2FS (Flash-Friendly File System) is flash-friendly file system =
which was merged<br>
&gt; into Linux kernel v3.8 in 2013.<br>
&gt;<br>
&gt; The motive for F2FS was to build a file system that from the start, ta=
kes into<br>
&gt; account the characteristics of NAND flash memory-based storage devices=
 (such as<br>
&gt; solid-state disks, eMMC, and SD cards).<br>
&gt;<br>
&gt; F2FS was designed on a basis of a log-structured file system approach,=
 which<br>
&gt; remedies some known issues of the older log structured file systems, s=
uch as<br>
&gt; the snowball effect of wandering trees and high cleaning overhead. In =
addition,<br>
&gt; since a NAND-based storage device shows different characteristics acco=
rding to<br>
&gt; its internal geometry or flash memory management scheme (such as the F=
lash<br>
&gt; Translation Layer or FTL), it supports various parameters not only for=
<br>
&gt; configuring on-disk layout, but also for selecting allocation and clea=
ning<br>
&gt; algorithm.&quot;, quote by <a href=3D"https://en.wikipedia.org/wiki/F2=
FS" rel=3D"noreferrer" target=3D"_blank">https://en.wikipedia.org/wiki/F2FS=
</a>.<br>
&gt;<br>
&gt; The source codes for F2FS are available from:<br>
&gt;<br>
&gt; <a href=3D"http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.gi=
t" rel=3D"noreferrer" target=3D"_blank">http://git.kernel.org/cgit/linux/ke=
rnel/git/jaegeuk/f2fs.git</a><br>
&gt; <a href=3D"http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-to=
ols.git" rel=3D"noreferrer" target=3D"_blank">http://git.kernel.org/cgit/li=
nux/kernel/git/jaegeuk/f2fs-tools.git</a><br>
&gt;<br>
&gt; Signed-off-by: Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk@kernel.org">j=
aegeuk@kernel.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 Makefile.util.def=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 7 +<br>
&gt;=C2=A0 docs/grub.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 5 +-<br>
&gt;=C2=A0 grub-core/Makefile.core.def=C2=A0 |=C2=A0 =C2=A0 5 +<br>
&gt;=C2=A0 grub-core/fs/f2fs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1289 +++=
+++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 po/exclude.pot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 tests/<a href=3D"http://f2fs_test.in" rel=3D"noreferrer" target=
=3D"_blank">f2fs_test.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A019 +<br>
&gt;=C2=A0 tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"noreferre=
r" target=3D"_blank">grub-fs-tester.in</a> |=C2=A0 =C2=A010 +-<br>
&gt;=C2=A0 7 files changed, 1332 insertions(+), 4 deletions(-)<br>
&gt;=C2=A0 create mode 100644 grub-core/fs/f2fs.c<br>
&gt;=C2=A0 create mode 100644 tests/<a href=3D"http://f2fs_test.in" rel=3D"=
noreferrer" target=3D"_blank">f2fs_test.in</a><br>
&gt;<br>
&gt; diff --git a/Makefile.util.def b/Makefile.util.def<br>
&gt; index db7e8ec..84627bb 100644<br>
&gt; --- a/Makefile.util.def<br>
&gt; +++ b/Makefile.util.def<br>
&gt; @@ -99,6 +99,7 @@ library =3D {<br>
&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/ext2.c;<br>
&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/fat.c;<br>
&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/exfat.c;<br>
&gt; +=C2=A0 common =3D grub-core/fs/f2fs.c;<br>
&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/fshelp.c;<br>
&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/hfs.c;<br>
&gt;=C2=A0 =C2=A0 common =3D grub-core/fs/hfsplus.c;<br>
&gt; @@ -766,6 +767,12 @@ script =3D {<br>
&gt;<br>
&gt;=C2=A0 script =3D {<br>
&gt;=C2=A0 =C2=A0 testcase;<br>
&gt; +=C2=A0 name =3D f2fs_test;<br>
&gt; +=C2=A0 common =3D tests/<a href=3D"http://f2fs_test.in" rel=3D"norefe=
rrer" target=3D"_blank">f2fs_test.in</a>;<br>
&gt; +};<br>
&gt; +<br>
&gt; +script =3D {<br>
&gt; +=C2=A0 testcase;<br>
&gt;=C2=A0 =C2=A0 name =3D nilfs2_test;<br>
&gt;=C2=A0 =C2=A0 common =3D tests/<a href=3D"http://nilfs2_test.in" rel=3D=
"noreferrer" target=3D"_blank">nilfs2_test.in</a>;<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/docs/grub.texi b/docs/grub.texi<br>
&gt; index 1df3db2..e5a80f3 100644<br>
&gt; --- a/docs/grub.texi<br>
&gt; +++ b/docs/grub.texi<br>
&gt; @@ -360,7 +360,8 @@ blocklist notation. The currently supported filesy=
stem types are @dfn{Amiga<br>
&gt;=C2=A0 Fast FileSystem (AFFS)}, @dfn{AtheOS fs}, @dfn{BeFS},<br>
&gt;=C2=A0 @dfn{BtrFS} (including raid0, raid1, raid10, gzip and lzo),<br>
&gt;=C2=A0 @dfn{cpio} (little- and big-endian bin, odc and newc variants),<=
br>
&gt; -@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @dfn{exFAT},=
 @dfn{HFS},<br>
&gt; +@dfn{Linux ext2/ext3/ext4}, @dfn{DOS FAT12/FAT16/FAT32}, @dfn{exFAT},=
<br>
&gt; +@dfn{f2fs}, @dfn{HFS},<br>
&gt;=C2=A0 @dfn{HFS+}, @dfn{ISO9660} (including Joliet, Rock-ridge and mult=
i-chunk files),<br>
&gt;=C2=A0 @dfn{JFS}, @dfn{Minix fs} (versions 1, 2 and 3), @dfn{nilfs2},<b=
r>
&gt;=C2=A0 @dfn{NTFS} (including compression), @dfn{ReiserFS}, @dfn{ROMFS},=
<br>
&gt; @@ -5347,7 +5348,7 @@ NTFS, JFS, UDF, HFS+, exFAT, long filenames in F=
AT, Joliet part of<br>
&gt;=C2=A0 ISO9660 are treated as UTF-16 as per specification. AFS and BFS =
are read<br>
&gt;=C2=A0 as UTF-8, again according to specification. BtrFS, cpio, tar, sq=
uash4, minix,<br>
&gt;=C2=A0 minix2, minix3, ROMFS, ReiserFS, XFS, ext2, ext3, ext4, FAT (sho=
rt names),<br>
&gt; -RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are assumed<br>
&gt; +f2fs, RockRidge part of ISO9660, nilfs2, UFS1, UFS2 and ZFS are assum=
ed<br>
&gt;=C2=A0 to be UTF-8. This might be false on systems configured with lega=
cy charset<br>
&gt;=C2=A0 but as long as the charset used is superset of ASCII you should =
be able to<br>
&gt;=C2=A0 access ASCII-named files. And it&#39;s recommended to configure =
your system to use<br>
&gt; diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.def=
<br>
&gt; index d9fa0e3..b585ade 100644<br>
&gt; --- a/grub-core/Makefile.core.def<br>
&gt; +++ b/grub-core/Makefile.core.def<br>
&gt; @@ -1278,6 +1278,11 @@ module =3D {<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 module =3D {<br>
&gt; +=C2=A0 name =3D f2fs;<br>
&gt; +=C2=A0 common =3D fs/f2fs.c;<br>
&gt; +};<br>
&gt; +<br>
&gt; +module =3D {<br>
&gt;=C2=A0 =C2=A0 name =3D fshelp;<br>
&gt;=C2=A0 =C2=A0 common =3D fs/fshelp.c;<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/grub-core/fs/f2fs.c b/grub-core/fs/f2fs.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..cb312b3<br>
&gt; --- /dev/null<br>
&gt; +++ b/grub-core/fs/f2fs.c<br>
&gt; @@ -0,0 +1,1289 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 f2fs.c - Flash-Friendly File System<br>
&gt; + *<br>
&gt; + *=C2=A0 Written by Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk@kernel.=
org">jaegeuk@kernel.org</a>&gt;<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright (C) 2015=C2=A0 Free Software Foundation, Inc.<br>
&gt; + *<br>
&gt; + *=C2=A0 GRUB is free software: you can redistribute it and/or modify=
<br>
&gt; + *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; + *=C2=A0 the Free Software Foundation, either version 3 of the Licens=
e, or<br>
&gt; + *=C2=A0 (at your option) any later version.<br>
&gt; + *<br>
&gt; + *=C2=A0 GRUB is distributed in the hope that it will be useful,<br>
&gt; + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; + *=C2=A0 GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; + *=C2=A0 along with GRUB.=C2=A0 If not, see &lt;<a href=3D"http://www=
.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org=
/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +#include &lt;grub/err.h&gt;<br>
&gt; +#include &lt;grub/file.h&gt;<br>
&gt; +#include &lt;grub/mm.h&gt;<br>
&gt; +#include &lt;grub/misc.h&gt;<br>
&gt; +#include &lt;grub/disk.h&gt;<br>
&gt; +#include &lt;grub/dl.h&gt;<br>
&gt; +#include &lt;grub/types.h&gt;<br>
&gt; +#include &lt;grub/charset.h&gt;<br>
&gt; +#include &lt;grub/fshelp.h&gt;<br>
&gt; +<br>
&gt; +GRUB_MOD_LICENSE (&quot;GPLv3+&quot;);<br>
&gt; +<br>
&gt; +/* F2FS Magic Number */<br>
&gt; +#define F2FS_SUPER_MAGIC=C2=A0 =C2=A0 =C2=A00xF2F52010<br>
&gt; +#define CHECKSUM_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 4092=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* must be aligned 4 byte=
s */<br>
&gt; +#define U32_CHECKSUM_OFFSET=C2=A0 (CHECKSUM_OFFSET &gt;&gt; 2)<br>
&gt; +<br>
&gt; +/* byte-size offset */<br>
&gt; +#define F2FS_SUPER_OFFSET=C2=A0 =C2=A0 ((grub_disk_addr_t)1024)<br>
&gt; +#define F2FS_SUPER_OFFSET0=C2=A0 =C2=A0(F2FS_SUPER_OFFSET &gt;&gt; GR=
UB_DISK_SECTOR_BITS)<br>
&gt; +#define F2FS_SUPER_OFFSET1=C2=A0 =C2=A0((F2FS_SUPER_OFFSET + F2FS_BLK=
SIZE) &gt;&gt;=C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0GRUB_DISK_SECTOR_BITS)<br>
&gt; +<br>
&gt; +/* 9 bits for 512 bytes */<br>
&gt; +#define F2FS_MIN_LOG_SECTOR_SIZE=C2=A0 =C2=A0 =C2=A09<br>
&gt; +<br>
&gt; +/* support only 4KB block */<br>
&gt; +#define F2FS_BLK_BITS=C2=A0 =C2=A0 =C2=A0 =C2=A0 12<br>
&gt; +#define F2FS_BLKSIZE (1 &lt;&lt; F2FS_BLK_BITS)<br>
&gt; +#define F2FS_BLK_SEC_BITS=C2=A0 =C2=A0 (F2FS_BLK_BITS - GRUB_DISK_SEC=
TOR_BITS)<br>
&gt; +<br>
&gt; +#define VERSION_LEN=C2=A0 256<br>
&gt; +#define F2FS_MAX_EXTENSION=C2=A0 =C2=A064<br>
&gt; +<br>
&gt; +#define CP_COMPACT_SUM_FLAG=C2=A0 0x00000004<br>
&gt; +#define CP_UMOUNT_FLAG=C2=A0 =C2=A0 =C2=A0 =C2=A00x00000001<br>
&gt; +<br>
&gt; +#define MAX_ACTIVE_LOGS=C2=A0 =C2=A0 =C2=A0 16<br>
&gt; +#define MAX_ACTIVE_NODE_LOGS 8<br>
&gt; +#define MAX_ACTIVE_DATA_LOGS 8<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 NR_CURSEG_DATA_TYPE=C2=A0 =C2=A0 =C2=A03<=
br>
&gt; +#define NR_CURSEG_NODE_TYPE=C2=A0 3<br>
&gt; +#define NR_CURSEG_TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0(NR_CURSEG_DATA_TYPE=
 + NR_CURSEG_NODE_TYPE)<br>
&gt; +<br>
&gt; +#define ENTRIES_IN_SUM=C2=A0 =C2=A0 =C2=A0 =C2=A0512<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 SUMMARY_SIZE=C2=A0 =C2=A0 7<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 SUM_FOOTER_SIZE 5<br>
&gt; +#define JENTRY_SIZE=C2=A0 (sizeof(struct grub_f2fs_nat_jent))<br>
&gt; +#define SUM_ENTRIES_SIZE=C2=A0 =C2=A0 =C2=A0(SUMMARY_SIZE * ENTRIES_I=
N_SUM)<br>
&gt; +#define SUM_JOURNAL_SIZE=C2=A0 =C2=A0 =C2=A0(F2FS_BLKSIZE - SUM_FOOTE=
R_SIZE -\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUM_ENTRIES_SIZE)<br>
&gt; +#define NAT_JOURNAL_ENTRIES=C2=A0 ((SUM_JOURNAL_SIZE - 2) / JENTRY_SI=
ZE)<br>
&gt; +#define NAT_JOURNAL_RESERVED ((SUM_JOURNAL_SIZE - 2) % JENTRY_SIZE)<b=
r>
&gt; +<br>
&gt; +#define NAT_ENTRY_SIZE (sizeof(struct grub_f2fs_nat_entry))<br>
&gt; +#define NAT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / NAT_ENTRY_SIZE)<br>
&gt; +<br>
&gt; +#define F2FS_NAME_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 255<br>
&gt; +#define F2FS_SLOT_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +#define NR_DENTRY_IN_BLOCK=C2=A0 =C2=A0214<br>
&gt; +#define SIZE_OF_DIR_ENTRY=C2=A0 =C2=A0 11=C2=A0 =C2=A0 =C2=A0 /* by b=
yte */<br>
&gt; +#define BITS_PER_BYTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +#define SIZE_OF_DENTRY_BITMAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((NR_DENTRY_=
IN_BLOCK + BITS_PER_BYTE - 1) / \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BITS_PER_BYTE)<br>
&gt; +#define SIZE_OF_RESERVED=C2=A0 =C2=A0 =C2=A0(F2FS_BLKSIZE - ((SIZE_OF=
_DIR_ENTRY + \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0F2FS_SLOT_LEN) * \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITM=
AP))<br>
&gt; +<br>
&gt; +#define F2FS_INLINE_XATTR_ADDRS=C2=A0 =C2=A0 =C2=A0 50=C2=A0 =C2=A0 =
=C2=A0 /* 200 bytes for inline xattrs */<br>
&gt; +#define DEF_ADDRS_PER_INODE=C2=A0 923=C2=A0 =C2=A0 =C2=A0/* Address P=
ointers in an Inode */<br>
&gt; +<br>
&gt; +#define ADDRS_PER_BLOCK=C2=A0 =C2=A0 =C2=A0 1018=C2=A0 =C2=A0 /* Addr=
ess Pointers in a Direct Block */<br>
&gt; +#define NIDS_PER_BLOCK=C2=A0 =C2=A0 =C2=A0 =C2=A01018=C2=A0 =C2=A0 /*=
 Node IDs in an Indirect Block */<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_DIR1_BLOCK (DEF_ADDRS_PER_INODE + 1)=
<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_DIR2_BLOCK (DEF_ADDRS_PER_INODE + 2)=
<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_IND1_BLOCK (DEF_ADDRS_PER_INODE + 3)=
<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_IND2_BLOCK (DEF_ADDRS_PER_INODE + 4)=
<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 NODE_DIND_BLOCK (DEF_ADDRS_PER_INODE + 5)=
<br>
&gt; +<br>
&gt; +#define MAX_INLINE_DATA=C2=A0 =C2=A0 =C2=A0 (4 * (DEF_ADDRS_PER_INODE=
 - \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0F2FS_INLINE_XATTR_ADDRS - 1))<br>
&gt; +#define NR_INLINE_DENTRY=C2=A0 =C2=A0 =C2=A0(MAX_INLINE_DATA * BITS_P=
ER_BYTE / \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 BITS_PER_BYTE + 1))<br>
&gt; +#define INLINE_DENTRY_BITMAP_SIZE=C2=A0 =C2=A0 ((NR_INLINE_DENTRY + \=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BITS_PER_BYTE - 1) / BITS_PER_BYTE)<br>
&gt; +#define INLINE_RESERVED_SIZE (MAX_INLINE_DATA - \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE))<br>
&gt; +#define CURSEG_HOT_DATA=C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +<br>
&gt; +#define CKPT_FLAG_SET(ckpt, f)=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ckpt)-&gt;ckpt_flags=
 &amp; grub_cpu_to_le32_compile_time (f)<br>
&gt; +<br>
&gt; +#define F2FS_INLINE_XATTR=C2=A0 =C2=A0 0x01=C2=A0 =C2=A0 /* file inli=
ne xattr flag */<br>
&gt; +#define F2FS_INLINE_DATA=C2=A0 =C2=A0 =C2=A00x02=C2=A0 =C2=A0 /* file=
 inline data flag */<br>
&gt; +#define F2FS_INLINE_DENTRY=C2=A0 =C2=A00x04=C2=A0 =C2=A0 /* file inli=
ne dentry flag */<br>
&gt; +#define F2FS_DATA_EXIST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x08=C2=A0 =C2=A0 /* file inline data exist flag */<br>
&gt; +#define F2FS_INLINE_DOTS=C2=A0 =C2=A0 =C2=A00x10=C2=A0 =C2=A0 /* file=
 having implicit dot dentries */<br>
&gt; +<br>
&gt; +enum FILE_TYPE<br>
&gt; +{<br>
&gt; +=C2=A0 F2FS_FT_UNKNOWN,<br>
&gt; +=C2=A0 F2FS_FT_REG_FILE =3D 1,<br>
&gt; +=C2=A0 F2FS_FT_DIR =3D 2,<br>
&gt; +=C2=A0 F2FS_FT_SYMLINK =3D 7,<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define MAX_VOLUME_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 512<br>
&gt; +<br>
&gt; +struct grub_f2fs_superblock<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t magic;<br>
&gt; +=C2=A0 grub_uint16_t dummy1[2];<br>
&gt; +=C2=A0 grub_uint32_t log_sectorsize;<br>
&gt; +=C2=A0 grub_uint32_t log_sectors_per_block;<br>
&gt; +=C2=A0 grub_uint32_t log_blocksize;<br>
&gt; +=C2=A0 grub_uint32_t log_blocks_per_seg;<br>
&gt; +=C2=A0 grub_uint32_t segs_per_sec;<br>
&gt; +=C2=A0 grub_uint32_t secs_per_zone;<br>
&gt; +=C2=A0 grub_uint32_t checksum_offset;<br>
&gt; +=C2=A0 grub_uint8_t dummy2[40];<br>
&gt; +=C2=A0 grub_uint32_t cp_blkaddr;<br>
&gt; +=C2=A0 grub_uint32_t sit_blkaddr;<br>
&gt; +=C2=A0 grub_uint32_t nat_blkaddr;<br>
&gt; +=C2=A0 grub_uint32_t ssa_blkaddr;<br>
&gt; +=C2=A0 grub_uint32_t main_blkaddr;<br>
&gt; +=C2=A0 grub_uint32_t root_ino;<br>
&gt; +=C2=A0 grub_uint32_t node_ino;<br>
&gt; +=C2=A0 grub_uint32_t meta_ino;<br>
&gt; +=C2=A0 grub_uint8_t uuid[16];<br>
&gt; +=C2=A0 grub_uint16_t volume_name[MAX_VOLUME_NAME];<br>
&gt; +=C2=A0 grub_uint32_t extension_count;<br>
&gt; +=C2=A0 grub_uint8_t extension_list[F2FS_MAX_EXTENSION][8];<br>
&gt; +=C2=A0 grub_uint32_t cp_payload;<br>
&gt; +=C2=A0 grub_uint8_t version[VERSION_LEN];<br>
&gt; +=C2=A0 grub_uint8_t init_version[VERSION_LEN];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_checkpoint<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint64_t checkpoint_ver;<br>
&gt; +=C2=A0 grub_uint64_t user_block_count;<br>
&gt; +=C2=A0 grub_uint64_t valid_block_count;<br>
&gt; +=C2=A0 grub_uint32_t rsvd_segment_count;<br>
&gt; +=C2=A0 grub_uint32_t overprov_segment_count;<br>
&gt; +=C2=A0 grub_uint32_t free_segment_count;<br>
&gt; +=C2=A0 grub_uint32_t cur_node_segno[MAX_ACTIVE_NODE_LOGS];<br>
&gt; +=C2=A0 grub_uint16_t cur_node_blkoff[MAX_ACTIVE_NODE_LOGS];<br>
&gt; +=C2=A0 grub_uint32_t cur_data_segno[MAX_ACTIVE_DATA_LOGS];<br>
&gt; +=C2=A0 grub_uint16_t cur_data_blkoff[MAX_ACTIVE_DATA_LOGS];<br>
&gt; +=C2=A0 grub_uint32_t ckpt_flags;<br>
&gt; +=C2=A0 grub_uint32_t cp_pack_total_block_count;<br>
&gt; +=C2=A0 grub_uint32_t cp_pack_start_sum;<br>
&gt; +=C2=A0 grub_uint32_t valid_node_count;<br>
&gt; +=C2=A0 grub_uint32_t valid_inode_count;<br>
&gt; +=C2=A0 grub_uint32_t next_free_nid;<br>
&gt; +=C2=A0 grub_uint32_t sit_ver_bitmap_bytesize;<br>
&gt; +=C2=A0 grub_uint32_t nat_ver_bitmap_bytesize;<br>
&gt; +=C2=A0 grub_uint32_t checksum_offset;<br>
&gt; +=C2=A0 grub_uint64_t elapsed_time;<br>
&gt; +=C2=A0 grub_uint8_t alloc_type[MAX_ACTIVE_LOGS];<br>
&gt; +=C2=A0 grub_uint8_t sit_nat_version_bitmap[3900];<br>
&gt; +=C2=A0 grub_uint32_t checksum;<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_nat_entry {<br>
&gt; +=C2=A0 grub_uint8_t version;<br>
&gt; +=C2=A0 grub_uint32_t ino;<br>
&gt; +=C2=A0 grub_uint32_t block_addr;<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_nat_jent<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t nid;<br>
&gt; +=C2=A0 struct grub_f2fs_nat_entry ne;<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_nat_journal {<br>
&gt; +=C2=A0 grub_uint16_t n_nats;<br>
&gt; +=C2=A0 struct grub_f2fs_nat_jent entries[NAT_JOURNAL_ENTRIES];<br>
&gt; +=C2=A0 grub_uint8_t reserved[NAT_JOURNAL_RESERVED];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_nat_block {<br>
&gt; +=C2=A0 struct grub_f2fs_nat_entry ne[NAT_ENTRY_PER_BLOCK];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_dir_entry<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t hash_code;<br>
&gt; +=C2=A0 grub_uint32_t ino;<br>
&gt; +=C2=A0 grub_uint16_t name_len;<br>
&gt; +=C2=A0 grub_uint8_t file_type;<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_inline_dentry<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint8_t dentry_bitmap[INLINE_DENTRY_BITMAP_SIZE];<br>
&gt; +=C2=A0 grub_uint8_t reserved[INLINE_RESERVED_SIZE];<br>
&gt; +=C2=A0 struct grub_f2fs_dir_entry dentry[NR_INLINE_DENTRY];<br>
&gt; +=C2=A0 grub_uint8_t filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_dentry_block {<br>
&gt; +=C2=A0 grub_uint8_t dentry_bitmap[SIZE_OF_DENTRY_BITMAP];<br>
&gt; +=C2=A0 grub_uint8_t reserved[SIZE_OF_RESERVED];<br>
&gt; +=C2=A0 struct grub_f2fs_dir_entry dentry[NR_DENTRY_IN_BLOCK];<br>
&gt; +=C2=A0 grub_uint8_t filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_inode<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint16_t i_mode;<br>
&gt; +=C2=A0 grub_uint8_t i_advise;<br>
&gt; +=C2=A0 grub_uint8_t i_inline;<br>
&gt; +=C2=A0 grub_uint32_t i_uid;<br>
&gt; +=C2=A0 grub_uint32_t i_gid;<br>
&gt; +=C2=A0 grub_uint32_t i_links;<br>
&gt; +=C2=A0 grub_uint64_t i_size;<br>
&gt; +=C2=A0 grub_uint64_t i_blocks;<br>
&gt; +=C2=A0 grub_uint64_t i_atime;<br>
&gt; +=C2=A0 grub_uint64_t i_ctime;<br>
&gt; +=C2=A0 grub_uint64_t i_mtime;<br>
&gt; +=C2=A0 grub_uint32_t i_atime_nsec;<br>
&gt; +=C2=A0 grub_uint32_t i_ctime_nsec;<br>
&gt; +=C2=A0 grub_uint32_t i_mtime_nsec;<br>
&gt; +=C2=A0 grub_uint32_t i_generation;<br>
&gt; +=C2=A0 grub_uint32_t i_current_depth;<br>
&gt; +=C2=A0 grub_uint32_t i_xattr_nid;<br>
&gt; +=C2=A0 grub_uint32_t i_flags;<br>
&gt; +=C2=A0 grub_uint32_t i_pino;<br>
&gt; +=C2=A0 grub_uint32_t i_namelen;<br>
&gt; +=C2=A0 grub_uint8_t i_name[F2FS_NAME_LEN];<br>
&gt; +=C2=A0 grub_uint8_t i_dir_level;<br>
&gt; +=C2=A0 grub_uint8_t i_ext[12];<br>
&gt; +=C2=A0 grub_uint32_t i_addr[DEF_ADDRS_PER_INODE];<br>
&gt; +=C2=A0 grub_uint32_t i_nid[5];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_direct_node {<br>
&gt; +=C2=A0 grub_uint32_t addr[ADDRS_PER_BLOCK];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_indirect_node {<br>
&gt; +=C2=A0 grub_uint32_t nid[NIDS_PER_BLOCK];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_f2fs_node<br>
&gt; +{<br>
&gt; +=C2=A0 union<br>
&gt; +=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 struct grub_f2fs_inode i;<br>
&gt; +=C2=A0 =C2=A0 struct grub_direct_node dn;<br>
&gt; +=C2=A0 =C2=A0 struct grub_indirect_node in;<br>
&gt; +=C2=A0 =C2=A0 char buf[F2FS_BLKSIZE - 40];=C2=A0 =C2=A0 =C2=A0/* Shou=
ld occupy F2FS_BLKSIZE totally */<br>
&gt; +=C2=A0 };<br>
&gt; +=C2=A0 grub_uint8_t dummy[40];<br>
&gt; +} GRUB_PACKED;<br>
&gt; +<br>
&gt; +struct grub_fshelp_node<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; +=C2=A0 struct grub_f2fs_node inode;<br>
&gt; +=C2=A0 grub_uint32_t ino;<br>
&gt; +=C2=A0 int inode_read;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct grub_f2fs_data<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_superblock sblock;<br>
&gt; +=C2=A0 struct grub_f2fs_checkpoint ckpt;<br>
&gt; +<br>
&gt; +=C2=A0 grub_uint32_t root_ino;<br>
&gt; +=C2=A0 grub_uint32_t blocks_per_seg;<br>
&gt; +=C2=A0 grub_uint32_t cp_blkaddr;<br>
&gt; +=C2=A0 grub_uint32_t nat_blkaddr;<br>
&gt; +<br>
&gt; +=C2=A0 struct grub_f2fs_nat_journal nat_j;<br>
&gt; +=C2=A0 char *nat_bitmap;<br>
&gt; +<br>
&gt; +=C2=A0 grub_disk_t disk;<br>
&gt; +=C2=A0 struct grub_f2fs_node *inode;<br>
&gt; +=C2=A0 struct grub_fshelp_node diropen;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct grub_f2fs_dir_iter_ctx<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; +=C2=A0 grub_fshelp_iterate_dir_hook_t hook;<br>
&gt; +=C2=A0 void *hook_data;<br>
&gt; +=C2=A0 grub_uint8_t *bitmap;<br>
&gt; +=C2=A0 grub_uint8_t (*filename)[F2FS_SLOT_LEN];<br>
&gt; +=C2=A0 struct grub_f2fs_dir_entry *dentry;<br>
&gt; +=C2=A0 int max;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct grub_f2fs_dir_ctx<br>
&gt; +{<br>
&gt; +=C2=A0 grub_fs_dir_hook_t hook;<br>
&gt; +=C2=A0 void *hook_data;<br>
&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static grub_dl_t my_mod;<br>
&gt; +<br>
&gt; +static inline int<br>
&gt; +grub_f2fs_test_bit_le (int nr, const grub_uint8_t *addr)<br>
&gt; +{<br>
&gt; +=C2=A0 return addr[nr &gt;&gt; 3] &amp; (1 &lt;&lt; (nr &amp; 7));<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static inline char *<br>
&gt; +__inline_addr (struct grub_f2fs_inode *inode)<br>
&gt; +{<br>
&gt; +=C2=A0 return (char *)&amp;inode-&gt;i_addr[1];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline grub_uint64_t<br>
&gt; +grub_f2fs_file_size (struct grub_f2fs_inode *inode)<br>
&gt; +{<br>
&gt; +=C2=A0 return grub_le_to_cpu64 (inode-&gt;i_size);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline grub_uint32_t<br>
&gt; +__start_cp_addr (struct grub_f2fs_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;ckpt;<br>
&gt; +=C2=A0 grub_uint32_t start_addr =3D data-&gt;cp_blkaddr;<br>
&gt; +<br>
&gt; +=C2=A0 if (!(ckpt-&gt;checkpoint_ver &amp; grub_cpu_to_le64_compile_t=
ime(1)))<br>
&gt; +=C2=A0 =C2=A0 return start_addr + data-&gt;blocks_per_seg;<br>
&gt; +=C2=A0 return start_addr;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline grub_uint32_t<br>
&gt; +__start_sum_block (struct grub_f2fs_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;ckpt;<br>
&gt; +<br>
&gt; +=C2=A0 return __start_cp_addr (data) + grub_le_to_cpu32 (ckpt-&gt;cp_=
pack_start_sum);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline grub_uint32_t<br>
&gt; +__sum_blk_addr (struct grub_f2fs_data *data, int base, int type)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;ckpt;<br>
&gt; +<br>
&gt; +=C2=A0 return __start_cp_addr (data) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_le_to_cpu32 (ckpt-&gt;cp_pack_total_block_co=
unt)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0- (base + 1) + type;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void *<br>
&gt; +__nat_bitmap_ptr (struct grub_f2fs_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_checkpoint *ckpt =3D &amp;data-&gt;ckpt;<br>
&gt; +=C2=A0 grub_uint32_t offset;<br>
&gt; +<br>
&gt; +=C2=A0 if (grub_le_to_cpu32 (data-&gt;sblock.cp_payload) &gt; 0)<br>
&gt; +=C2=A0 =C2=A0 return ckpt-&gt;sit_nat_version_bitmap;<br>
&gt; +<br>
&gt; +=C2=A0 offset =3D grub_le_to_cpu32 (ckpt-&gt;sit_ver_bitmap_bytesize)=
;<br>
&gt; +=C2=A0 return ckpt-&gt;sit_nat_version_bitmap + offset;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline grub_uint32_t<br>
&gt; +__get_node_id (struct grub_f2fs_node *rn, int off, int inode_block)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 if (inode_block)<br>
&gt; +=C2=A0 =C2=A0 return grub_le_to_cpu32 (rn-&gt;i.i_nid[off - NODE_DIR1=
_BLOCK]);<br>
&gt; +=C2=A0 return grub_le_to_cpu32 (rn-&gt;in.nid[off]);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline grub_err_t<br>
&gt; +grub_f2fs_block_read (struct grub_f2fs_data *data, grub_uint32_t blka=
ddr, void *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 return grub_disk_read (data-&gt;disk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((grub_disk_addr_t)bl=
kaddr) &lt;&lt; F2FS_BLK_SEC_BITS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, F2FS_BLKSIZE, buf)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * CRC32<br>
&gt; +*/<br>
&gt; +#define CRCPOLY_LE 0xedb88320<br>
&gt; +<br>
&gt; +static inline grub_uint32_t<br>
&gt; +grub_f2fs_cal_crc32 (const void *buf, const grub_uint32_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t crc =3D F2FS_SUPER_MAGIC;<br>
&gt; +=C2=A0 unsigned char *p =3D (unsigned char *)buf;<br>
&gt; +=C2=A0 grub_uint32_t tmp =3D len;<br>
&gt; +=C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 while (tmp--)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 crc ^=3D *p++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 8; i++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crc =3D (crc &gt;&gt; 1) ^ ((crc &amp; 1)=
 ? CRCPOLY_LE : 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 return crc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int<br>
&gt; +grub_f2fs_crc_valid (grub_uint32_t blk_crc, void *buf, const grub_uin=
t32_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t cal_crc =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 cal_crc =3D grub_f2fs_cal_crc32 (buf, len);<br>
&gt; +<br>
&gt; +=C2=A0 return (cal_crc =3D=3D blk_crc) ? 1 : 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int<br>
&gt; +grub_f2fs_test_bit (grub_uint32_t nr, const char *p)<br>
&gt; +{<br>
&gt; +=C2=A0 int mask;<br>
&gt; +<br>
&gt; +=C2=A0 p +=3D (nr &gt;&gt; 3);<br>
&gt; +=C2=A0 mask =3D 1 &lt;&lt; (7 - (nr &amp; 0x07));<br>
&gt; +=C2=A0 return mask &amp; *p;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_f2fs_sanity_check_sb (struct grub_f2fs_superblock *sb)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t log_sectorsize, log_sectors_per_block;<br>
&gt; +<br>
&gt; +=C2=A0 if (sb-&gt;magic !=3D grub_cpu_to_le32_compile_time (F2FS_SUPE=
R_MAGIC))<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 if (sb-&gt;log_blocksize !=3D grub_cpu_to_le32_compile_time (F=
2FS_BLK_BITS))<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 log_sectorsize =3D grub_le_to_cpu32 (sb-&gt;log_sectorsize);<b=
r>
&gt; +=C2=A0 log_sectors_per_block =3D grub_le_to_cpu32 (sb-&gt;log_sectors=
_per_block);<br>
&gt; +<br>
&gt; +=C2=A0 if (log_sectorsize &gt; F2FS_BLK_BITS)<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 if (log_sectorsize &lt; F2FS_MIN_LOG_SECTOR_SIZE)<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 if (log_sectors_per_block + log_sectorsize !=3D F2FS_BLK_BITS)=
<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_f2fs_read_sb (struct grub_f2fs_data *data, grub_disk_addr_t offs=
et)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_disk_t disk =3D data-&gt;disk;<br>
&gt; +=C2=A0 grub_err_t err;<br>
&gt; +<br>
&gt; +=C2=A0 /* Read first super block. */<br>
&gt; +=C2=A0 err =3D grub_disk_read (disk, offset, 0, sizeof (data-&gt;sblo=
ck), &amp;data-&gt;sblock);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 return grub_f2fs_sanity_check_sb (&amp;data-&gt;sblock);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void *<br>
&gt; +validate_checkpoint (struct grub_f2fs_data *data, grub_uint32_t cp_ad=
dr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_uint64_t *version)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t *cp_page_1, *cp_page_2;<br>
&gt; +=C2=A0 struct grub_f2fs_checkpoint *cp_block;<br>
&gt; +=C2=A0 grub_uint64_t cur_version =3D 0, pre_version =3D 0;<br>
&gt; +=C2=A0 grub_uint32_t crc =3D 0;<br>
&gt; +=C2=A0 grub_uint32_t crc_offset;<br>
&gt; +=C2=A0 grub_err_t err;<br>
&gt; +<br>
&gt; +=C2=A0 /* Read the 1st cp block in this CP pack */<br>
&gt; +=C2=A0 cp_page_1 =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; +=C2=A0 if (!cp_page_1)<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +<br>
&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, cp_addr, cp_page_1);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; +<br>
&gt; +=C2=A0 cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_1;<br>
&gt; +=C2=A0 crc_offset =3D grub_le_to_cpu32 (cp_block-&gt;checksum_offset)=
;<br>
&gt; +=C2=A0 if (crc_offset !=3D CHECKSUM_OFFSET)<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; +<br>
&gt; +=C2=A0 crc =3D grub_le_to_cpu32 (*(cp_page_1 + U32_CHECKSUM_OFFSET));=
<br>
&gt; +=C2=A0 if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; +<br>
&gt; +=C2=A0 pre_version =3D grub_le_to_cpu64 (cp_block-&gt;checkpoint_ver)=
;<br>
&gt; +<br>
&gt; +=C2=A0 /* Read the 2nd cp block in this CP pack */<br>
&gt; +=C2=A0 cp_page_2 =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; +=C2=A0 if (!cp_page_2)<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp1;<br>
&gt; +<br>
&gt; +=C2=A0 cp_addr +=3D grub_le_to_cpu32 (cp_block-&gt;cp_pack_total_bloc=
k_count) - 1;<br>
&gt; +<br>
&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, cp_addr, cp_page_2);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp2;<br>
&gt; +<br>
&gt; +=C2=A0 cp_block =3D (struct grub_f2fs_checkpoint *)cp_page_2;<br>
&gt; +=C2=A0 crc_offset =3D grub_le_to_cpu32 (cp_block-&gt;checksum_offset)=
;<br>
&gt; +=C2=A0 if (crc_offset !=3D CHECKSUM_OFFSET)<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp2;<br>
&gt; +<br>
&gt; +=C2=A0 crc =3D grub_le_to_cpu32 (*(cp_page_2 + U32_CHECKSUM_OFFSET));=
<br>
&gt; +=C2=A0 if (!grub_f2fs_crc_valid (crc, cp_block, crc_offset))<br>
&gt; +=C2=A0 =C2=A0 goto invalid_cp2;<br>
&gt; +<br>
&gt; +=C2=A0 cur_version =3D grub_le_to_cpu64 (cp_block-&gt;checkpoint_ver)=
;<br>
&gt; +=C2=A0 if (cur_version =3D=3D pre_version)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *version =3D cur_version;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (cp_page_2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 return cp_page_1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +invalid_cp2:<br>
&gt; +=C2=A0 grub_free (cp_page_2);<br>
&gt; +invalid_cp1:<br>
&gt; +=C2=A0 grub_free (cp_page_1);<br>
&gt; +=C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_read_cp (struct grub_f2fs_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 void *cp1, *cp2, *cur_page;<br>
&gt; +=C2=A0 grub_uint64_t cp1_version =3D 0, cp2_version =3D 0;<br>
&gt; +=C2=A0 grub_uint64_t cp_start_blk_no;<br>
&gt; +<br>
&gt; +=C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0* Finding out valid cp block involves read both<br>
&gt; +=C2=A0 =C2=A0* sets (cp pack1 and cp pack 2)<br>
&gt; +=C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 cp_start_blk_no =3D data-&gt;cp_blkaddr;<br>
&gt; +=C2=A0 cp1 =3D validate_checkpoint (data, cp_start_blk_no, &amp;cp1_v=
ersion);<br>
&gt; +=C2=A0 if (!cp1 &amp;&amp; grub_errno)<br>
&gt; +=C2=A0 =C2=A0 return grub_errno;<br>
&gt; +<br>
&gt; +=C2=A0 /* The second checkpoint pack should start at the next segment=
 */<br>
&gt; +=C2=A0 cp_start_blk_no +=3D data-&gt;blocks_per_seg;<br>
&gt; +=C2=A0 cp2 =3D validate_checkpoint (data, cp_start_blk_no, &amp;cp2_v=
ersion);<br>
&gt; +=C2=A0 if (!cp2 &amp;&amp; grub_errno)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (cp1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 return grub_errno;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 if (cp1 &amp;&amp; cp2)<br>
&gt; +=C2=A0 =C2=A0 cur_page =3D (cp2_version &gt; cp1_version) ? cp2 : cp1=
;<br>
&gt; +=C2=A0 else if (cp1)<br>
&gt; +=C2=A0 =C2=A0 cur_page =3D cp1;<br>
&gt; +=C2=A0 else if (cp2)<br>
&gt; +=C2=A0 =C2=A0 cur_page =3D cp2;<br>
&gt; +=C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 return grub_error (GRUB_ERR_BAD_FS, &quot;no checkpoint=
s&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 grub_memcpy (&amp;data-&gt;ckpt, cur_page, F2FS_BLKSIZE);<br>
&gt; +<br>
&gt; +=C2=A0 grub_free (cp1);<br>
&gt; +=C2=A0 grub_free (cp2);<br>
&gt; +=C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +get_nat_journal (struct grub_f2fs_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t block;<br>
&gt; +=C2=A0 char *buf;<br>
&gt; +=C2=A0 grub_err_t err;<br>
&gt; +<br>
&gt; +=C2=A0 buf =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; +=C2=A0 if (!buf)<br>
&gt; +=C2=A0 =C2=A0 return grub_errno;<br>
&gt; +<br>
&gt; +=C2=A0 if (CKPT_FLAG_SET(&amp;data-&gt;ckpt, CP_COMPACT_SUM_FLAG))<br=
>
&gt; +=C2=A0 =C2=A0 block =3D __start_sum_block (data);<br>
&gt; +=C2=A0 else if (CKPT_FLAG_SET (&amp;data-&gt;ckpt, CP_UMOUNT_FLAG))<b=
r>
&gt; +=C2=A0 =C2=A0 block =3D __sum_blk_addr (data, NR_CURSEG_TYPE, CURSEG_=
HOT_DATA);<br>
&gt; +=C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 block =3D __sum_blk_addr (data, NR_CURSEG_DATA_TYPE, CU=
RSEG_HOT_DATA);<br>
&gt; +<br>
&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, block, buf);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 if (CKPT_FLAG_SET (&amp;data-&gt;ckpt, CP_COMPACT_SUM_FLAG))<b=
r>
&gt; +=C2=A0 =C2=A0 grub_memcpy (&amp;data-&gt;nat_j, buf, SUM_JOURNAL_SIZE=
);<br>
&gt; +=C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 grub_memcpy (&amp;data-&gt;nat_j, buf + SUM_ENTRIES_SIZ=
E, SUM_JOURNAL_SIZE);<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 grub_free (buf);<br>
&gt; +=C2=A0 return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_uint32_t<br>
&gt; +get_blkaddr_from_nat_journal (struct grub_f2fs_data *data, grub_uint3=
2_t nid)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint16_t n =3D grub_le_to_cpu16 (data-&gt;nat_j.n_nats);<=
br>
&gt; +=C2=A0 grub_uint32_t blkaddr =3D 0;<br>
&gt; +=C2=A0 grub_uint16_t i;<br>
&gt; +<br>
&gt; +=C2=A0 for (i =3D 0; i &lt; n; i++)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_le_to_cpu32 (data-&gt;nat_j.entries[i].=
nid) =3D=3D nid)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blkaddr =3D grub_le_to_cpu32 (data=
-&gt;nat_j.entries[i].ne.block_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 return blkaddr;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_uint32_t<br>
&gt; +get_node_blkaddr (struct grub_f2fs_data *data, grub_uint32_t nid)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_nat_block *nat_block;<br>
&gt; +=C2=A0 grub_uint32_t seg_off, block_off, entry_off, block_addr;<br>
&gt; +=C2=A0 grub_uint32_t blkaddr;<br>
&gt; +=C2=A0 grub_err_t err;<br>
&gt; +<br>
&gt; +=C2=A0 blkaddr =3D get_blkaddr_from_nat_journal (data, nid);<br>
&gt; +=C2=A0 if (blkaddr)<br>
&gt; +=C2=A0 =C2=A0 return blkaddr;<br>
&gt; +<br>
&gt; +=C2=A0 nat_block =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; +=C2=A0 if (!nat_block)<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +<br>
&gt; +=C2=A0 block_off =3D nid / NAT_ENTRY_PER_BLOCK;<br>
&gt; +=C2=A0 entry_off =3D nid % NAT_ENTRY_PER_BLOCK;<br>
&gt; +<br>
&gt; +=C2=A0 seg_off =3D block_off / data-&gt;blocks_per_seg;<br>
&gt; +=C2=A0 block_addr =3D data-&gt;nat_blkaddr +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((seg_off * data-&gt;blocks_per_seg) &lt;&lt; 1) =
+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(block_off &amp; (data-&gt;blocks_per_seg - 1));<=
br>
&gt; +<br>
&gt; +=C2=A0 if (grub_f2fs_test_bit (block_off, data-&gt;nat_bitmap))<br>
&gt; +=C2=A0 =C2=A0 block_addr +=3D data-&gt;blocks_per_seg;<br>
&gt; +<br>
&gt; +=C2=A0 err =3D grub_f2fs_block_read (data, block_addr, nat_block);<br=
>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (nat_block);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 blkaddr =3D grub_le_to_cpu32 (nat_block-&gt;ne[entry_off].bloc=
k_addr);<br>
&gt; +<br>
&gt; +=C2=A0 grub_free (nat_block);<br>
&gt; +<br>
&gt; +=C2=A0 return blkaddr;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_get_node_path (struct grub_f2fs_inode *inode, grub_uint32_t bloc=
k,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_uint32_t offset[4], grub_uint32_t noffset[4]=
)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t direct_blks =3D ADDRS_PER_BLOCK;<br>
&gt; +=C2=A0 grub_uint32_t dptrs_per_blk =3D NIDS_PER_BLOCK;<br>
&gt; +=C2=A0 grub_uint32_t indirect_blks =3D ADDRS_PER_BLOCK * NIDS_PER_BLO=
CK;<br>
&gt; +=C2=A0 grub_uint32_t dindirect_blks =3D indirect_blks * NIDS_PER_BLOC=
K;<br>
&gt; +=C2=A0 grub_uint32_t direct_index =3D DEF_ADDRS_PER_INODE;<br>
&gt; +=C2=A0 int n =3D 0;<br>
&gt; +=C2=A0 int level =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_XATTR)<br>
&gt; +=C2=A0 =C2=A0 direct_index -=3D F2FS_INLINE_XATTR_ADDRS;<br>
&gt; +<br>
&gt; +=C2=A0 noffset[0] =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 if (block &lt; direct_index)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 block -=3D direct_index;<br>
&gt; +=C2=A0 if (block &lt; direct_blks)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_DIR1_BLOCK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 block -=3D direct_blks;<br>
&gt; +=C2=A0 if (block &lt; direct_blks)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_DIR2_BLOCK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 block -=3D direct_blks;<br>
&gt; +=C2=A0 if (block &lt; indirect_blks)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_IND1_BLOCK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D block / direct_blks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 4 + offset[n - 1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block % direct_blks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 block -=3D indirect_blks;<br>
&gt; +=C2=A0 if (block &lt; indirect_blks)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_IND2_BLOCK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 4 + dptrs_per_blk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D block / direct_blks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 5 + dptrs_per_blk + offset[n - 1]=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block % direct_blks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 block -=3D indirect_blks;<br>
&gt; +=C2=A0 if (block &lt; dindirect_blks)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D NODE_DIND_BLOCK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 5 + (dptrs_per_blk * 2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D block / indirect_blks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 6 + (dptrs_per_blk * 2) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n - 1] * (dptrs_per_blk + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n++] =3D (block / direct_blks) % dptrs_pe=
r_blk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 noffset[n] =3D 7 + (dptrs_per_blk * 2) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset[n - 2] * (dptr=
s_per_blk + 1) + offset[n - 1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 offset[n] =3D block % direct_blks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 level =3D 3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 goto got;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +got:<br>
&gt; +=C2=A0 return level;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_read_node (struct grub_f2fs_data *data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_uint32_t nid, struct grub_f2fs_node *np)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint32_t blkaddr;<br>
&gt; +<br>
&gt; +=C2=A0 blkaddr =3D get_node_blkaddr (data, nid);<br>
&gt; +=C2=A0 if (!blkaddr)<br>
&gt; +=C2=A0 =C2=A0 return grub_errno;<br>
&gt; +<br>
&gt; +=C2=A0 return grub_f2fs_block_read (data, blkaddr, np);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct grub_f2fs_data *<br>
&gt; +grub_f2fs_mount (grub_disk_t disk)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; +=C2=A0 grub_err_t err;<br>
&gt; +<br>
&gt; +=C2=A0 data =3D grub_malloc (sizeof (*data));<br>
&gt; +=C2=A0 if (!data)<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +<br>
&gt; +=C2=A0 data-&gt;disk =3D disk;<br>
&gt; +<br>
&gt; +=C2=A0 if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET0))<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_f2fs_read_sb (data, F2FS_SUPER_OFFSET1)=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (grub_errno =3D=3D GRUB_ERR_NON=
E)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grub_error (GRUB_ERR_BAD_FS=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;not a F2FS filesystem (no superblock)&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 data-&gt;root_ino =3D grub_le_to_cpu32 (data-&gt;sblock.root_i=
no);<br>
&gt; +=C2=A0 data-&gt;cp_blkaddr =3D grub_le_to_cpu32 (data-&gt;sblock.cp_b=
lkaddr);<br>
&gt; +=C2=A0 data-&gt;nat_blkaddr =3D grub_le_to_cpu32 (data-&gt;sblock.nat=
_blkaddr);<br>
&gt; +=C2=A0 data-&gt;blocks_per_seg =3D 1 &lt;&lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_le_to_cpu32 (data-&gt;sblock.log_blocks_per_=
seg);<br>
&gt; +<br>
&gt; +=C2=A0 err =3D grub_f2fs_read_cp (data);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 data-&gt;nat_bitmap =3D __nat_bitmap_ptr (data);<br>
&gt; +<br>
&gt; +=C2=A0 err =3D get_nat_journal (data);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 data-&gt;diropen.data =3D data;<br>
&gt; +=C2=A0 data-&gt;diropen.ino =3D data-&gt;root_ino;<br>
&gt; +=C2=A0 data-&gt;diropen.inode_read =3D 1;<br>
&gt; +=C2=A0 data-&gt;inode =3D &amp;data-&gt;diropen.inode;<br>
&gt; +<br>
&gt; +=C2=A0 err =3D grub_f2fs_read_node (data, data-&gt;root_ino, data-&gt=
;inode);<br>
&gt; +=C2=A0 if (err)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 return data;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 grub_free (data);<br>
&gt; +=C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* guarantee inline_data was handled by caller */<br>
&gt; +static grub_disk_addr_t<br>
&gt; +grub_f2fs_get_block (grub_fshelp_node_t node, grub_disk_addr_t block_=
ofs)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data =3D node-&gt;data;<br>
&gt; +=C2=A0 struct grub_f2fs_inode *inode =3D &amp;node-&gt;inode.i;<br>
&gt; +=C2=A0 grub_uint32_t offset[4], noffset[4], nids[4];<br>
&gt; +=C2=A0 struct grub_f2fs_node *node_block;<br>
&gt; +=C2=A0 grub_uint32_t block_addr =3D -1;<br>
&gt; +=C2=A0 int level, i;<br>
&gt; +<br>
&gt; +=C2=A0 level =3D grub_get_node_path (inode, block_ofs, offset, noffse=
t);<br>
&gt; +=C2=A0 if (level =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 return grub_le_to_cpu32 (inode-&gt;i_addr[offset[0]]);<=
br>
&gt; +<br>
&gt; +=C2=A0 node_block =3D grub_malloc (F2FS_BLKSIZE);<br>
&gt; +=C2=A0 if (!node_block)<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
&gt; +=C2=A0 nids[1] =3D __get_node_id (&amp;node-&gt;inode, offset[0], 1);=
<br>
&gt; +<br>
&gt; +=C2=A0 /* get indirect or direct nodes */<br>
&gt; +=C2=A0 for (i =3D 1; i &lt;=3D level; i++)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (data, nids[i], node_block);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (i &lt; level)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nids[i + 1] =3D __get_node_id (node_block=
, offset[i], 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 block_addr =3D grub_le_to_cpu32 (node_block-&gt;dn.addr[offset=
[level]]);<br>
&gt; +fail:<br>
&gt; +=C2=A0 grub_free (node_block);<br>
&gt; +=C2=A0 return block_addr;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_ssize_t<br>
&gt; +grub_f2fs_read_file (grub_fshelp_node_t node,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_disk_read_hook_t=
 read_hook, void *read_hook_data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_off_t pos, grub_=
size_t len, char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_inode *inode =3D &amp;node-&gt;inode.i;<br>
&gt; +=C2=A0 grub_off_t filesize =3D grub_f2fs_file_size (inode);<br>
&gt; +=C2=A0 char *inline_addr =3D __inline_addr (inode);<br>
&gt; +<br>
&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_DATA)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (filesize &gt; MAX_INLINE_DATA)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (len &gt; filesize - pos)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D filesize - pos;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_memcpy (buf + pos, inline_addr + pos, len);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 return grub_fshelp_read_file (node-&gt;data-&gt;disk, node,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0read_hook, read_hook_data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pos, len, buf, grub_f2fs_get_block,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0filesize,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0F2FS_BLK_SEC_BITS, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static char *<br>
&gt; +grub_f2fs_read_symlink (grub_fshelp_node_t node)<br>
&gt; +{<br>
&gt; +=C2=A0 char *symlink;<br>
&gt; +=C2=A0 struct grub_fshelp_node *diro =3D node;<br>
&gt; +=C2=A0 grub_uint64_t filesize;<br>
&gt; +<br>
&gt; +=C2=A0 if (!diro-&gt;inode_read)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (diro-&gt;data, diro-&gt;ino=
, &amp;diro-&gt;inode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 filesize =3D grub_f2fs_file_size(&amp;diro-&gt;inode.i);<br>
&gt; +<br>
&gt; +=C2=A0 symlink =3D grub_malloc (filesize + 1);<br>
&gt; +=C2=A0 if (!symlink)<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +<br>
&gt; +=C2=A0 grub_f2fs_read_file (diro, 0, 0, 0, filesize, symlink);<br>
&gt; +=C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (symlink);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 symlink[filesize] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 return symlink;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_f2fs_check_dentries (struct grub_f2fs_dir_iter_ctx *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_fshelp_node *fdiro;<br>
&gt; +=C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 for (i =3D 0; i &lt; ctx-&gt;max;)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 char *filename;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 enum grub_fshelp_filetype type =3D GRUB_FSHELP_U=
NKNOWN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 enum FILE_TYPE ftype;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int name_len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_f2fs_test_bit_le (i, ctx-&gt;bitmap) =
=3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ftype =3D ctx-&gt;dentry[i].file_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 name_len =3D grub_le_to_cpu16 (ctx-&gt;dentry[i]=
.name_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 filename =3D grub_malloc (name_len + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (!filename)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_memcpy (filename, ctx-&gt;filename[i], name=
_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 filename[name_len] =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro =3D grub_malloc (sizeof (struct grub_fshel=
p_node));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (!fdiro)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grub_free(filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (ftype =3D=3D F2FS_FT_DIR)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GRUB_FSHELP_DIR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 else if (ftype =3D=3D F2FS_FT_SYMLINK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GRUB_FSHELP_SYMLINK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 else if (ftype =3D=3D F2FS_FT_REG_FILE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GRUB_FSHELP_REG;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro-&gt;data =3D ctx-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro-&gt;ino =3D grub_le_to_cpu32 (ctx-&gt;dent=
ry[i].ino);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fdiro-&gt;inode_read =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ret =3D ctx-&gt;hook (filename, type, fdiro, ctx=
-&gt;hook_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free(filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 i +=3D (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLO=
T_LEN;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_f2fs_iterate_inline_dir (struct grub_f2fs_inode *dir,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct grub_f2fs_dir_iter_ctx *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_inline_dentry *de_blk;<br>
&gt; +<br>
&gt; +=C2=A0 de_blk =3D (struct grub_f2fs_inline_dentry *) __inline_addr (d=
ir);<br>
&gt; +<br>
&gt; +=C2=A0 ctx-&gt;bitmap =3D de_blk-&gt;dentry_bitmap;<br>
&gt; +=C2=A0 ctx-&gt;dentry =3D de_blk-&gt;dentry;<br>
&gt; +=C2=A0 ctx-&gt;filename =3D de_blk-&gt;filename;<br>
&gt; +=C2=A0 ctx-&gt;max =3D NR_INLINE_DENTRY;<br>
&gt; +<br>
&gt; +=C2=A0 return grub_f2fs_check_dentries (ctx);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_f2fs_iterate_dir (grub_fshelp_node_t dir,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_fshelp_iterate_dir_hook_t hook, void *hook_d=
ata)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_fshelp_node *diro =3D (struct grub_fshelp_node *) =
dir;<br>
&gt; +=C2=A0 struct grub_f2fs_inode *inode;<br>
&gt; +=C2=A0 struct grub_f2fs_dir_iter_ctx ctx =3D {<br>
&gt; +=C2=A0 =C2=A0 .data =3D diro-&gt;data,<br>
&gt; +=C2=A0 =C2=A0 .hook =3D hook,<br>
&gt; +=C2=A0 =C2=A0 .hook_data =3D hook_data<br>
&gt; +=C2=A0 };<br>
&gt; +=C2=A0 grub_off_t fpos =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 if (!diro-&gt;inode_read)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (diro-&gt;data, diro-&gt;ino=
, &amp;diro-&gt;inode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 inode =3D &amp;diro-&gt;inode.i;<br>
&gt; +<br>
&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_DENTRY)<br>
&gt; +=C2=A0 =C2=A0 return grub_f2fs_iterate_inline_dir (inode, &amp;ctx);<=
br>
&gt; +<br>
&gt; +=C2=A0 while (fpos &lt; grub_f2fs_file_size (inode))<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 struct grub_f2fs_dentry_block *de_blk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 char *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 buf =3D grub_zalloc (F2FS_BLKSIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (!buf)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_file (diro, 0, 0, fpos, F2FS_BLKS=
IZE, buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grub_free (buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 de_blk =3D (struct grub_f2fs_dentry_block *) buf=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.bitmap =3D de_blk-&gt;dentry_bitmap;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.dentry =3D de_blk-&gt;dentry;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.filename =3D de_blk-&gt;filename;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ctx.max =3D NR_DENTRY_IN_BLOCK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ret =3D grub_f2fs_check_dentries (&amp;ctx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_free (buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fpos +=3D F2FS_BLKSIZE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +grub_f2fs_dir_iter (const char *filename, enum grub_fshelp_filetype f=
iletype,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_fshelp_node_t node, voi=
d *data)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_dir_ctx *ctx =3D data;<br>
&gt; +=C2=A0 struct grub_dirhook_info info;<br>
&gt; +<br>
&gt; +=C2=A0 grub_memset (&amp;info, 0, sizeof (info));<br>
&gt; +=C2=A0 if (!node-&gt;inode_read)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (ctx-&gt;data, node-&gt;ino,=
 &amp;node-&gt;inode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (!grub_errno)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 node-&gt;inode_read =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_errno =3D GRUB_ERR_NONE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 if (node-&gt;inode_read)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 info.mtimeset =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 info.mtime =3D grub_le_to_cpu64 (node-&gt;inode.=
i.i_mtime);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 info.dir =3D ((filetype &amp; GRUB_FSHELP_TYPE_MASK) =3D=3D GR=
UB_FSHELP_DIR);<br>
&gt; +=C2=A0 grub_free (node);<br>
&gt; +=C2=A0 return ctx-&gt;hook (filename, &amp;info, ctx-&gt;hook_data);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_dir (grub_device_t device, const char *path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_fs_dir_hook_t hook, void *hook_data)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_dir_ctx ctx =3D {<br>
&gt; +=C2=A0 =C2=A0 .hook =3D hook,<br>
&gt; +=C2=A0 =C2=A0 .hook_data =3D hook_data<br>
&gt; +=C2=A0 };<br>
&gt; +=C2=A0 struct grub_fshelp_node *fdiro =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; +<br>
&gt; +=C2=A0 ctx.data =3D grub_f2fs_mount (device-&gt;disk);<br>
&gt; +=C2=A0 if (!ctx.data)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 grub_fshelp_find_file (path, &amp;ctx.data-&gt;diropen, &amp;f=
diro,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grub_f2fs_iterate_dir=
, grub_f2fs_read_symlink,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GRUB_FSHELP_DIR);<br>
&gt; +=C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 grub_f2fs_iterate_dir (fdiro, grub_f2fs_dir_iter, &amp;ctx);<b=
r>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 if (fdiro !=3D &amp;ctx.data-&gt;diropen)<br>
&gt; +=C2=A0 =C2=A0 grub_free (fdiro);<br>
&gt; + grub_free (ctx.data);<br>
&gt; + grub_dl_unref (my_mod);<br>
&gt; + return grub_errno;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +/* Open a file named NAME and initialize FILE.=C2=A0 */<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_open (struct grub_file *file, const char *name)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data =3D NULL;<br>
&gt; +=C2=A0 struct grub_fshelp_node *fdiro =3D 0;<br>
&gt; +=C2=A0 struct grub_f2fs_inode *inode;<br>
&gt; +<br>
&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; +<br>
&gt; +=C2=A0 data =3D grub_f2fs_mount (file-&gt;device-&gt;disk);<br>
&gt; +=C2=A0 if (!data)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 grub_fshelp_find_file (name, &amp;data-&gt;diropen, &amp;fdiro=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0grub_f2fs_iterate_dir, grub_f2fs_read_symlink,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GRUB_FSHELP_REG);<br>
&gt; +=C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 if (!fdiro-&gt;inode_read)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 grub_f2fs_read_node (data, fdiro-&gt;ino, &amp;f=
diro-&gt;inode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if (grub_errno)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 grub_memcpy (data-&gt;inode, &amp;fdiro-&gt;inode, sizeof (*da=
ta-&gt;inode));<br>
&gt; +=C2=A0 grub_free (fdiro);<br>
&gt; +<br>
&gt; +=C2=A0 inode =3D &amp;(data-&gt;inode-&gt;i);<br>
&gt; +=C2=A0 file-&gt;size =3D grub_f2fs_file_size (inode);<br>
&gt; +=C2=A0 file-&gt;data =3D data;<br>
&gt; +=C2=A0 file-&gt;offset =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 if (inode-&gt;i_inline &amp; F2FS_INLINE_DATA &amp;&amp; file-=
&gt;size &gt; MAX_INLINE_DATA)<br>
&gt; +=C2=A0 =C2=A0 grub_error (GRUB_ERR_BAD_FS, &quot;corrupted inline_dat=
a: need fsck&quot;);<br>
&gt; +=C2=A0 return 0;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 if (fdiro !=3D &amp;data-&gt;diropen)<br>
&gt; +=C2=A0 =C2=A0 grub_free (fdiro);<br>
&gt; +=C2=A0 grub_free (data);<br>
&gt; +<br>
&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; +<br>
&gt; +=C2=A0 return grub_errno;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_ssize_t<br>
&gt; +grub_f2fs_read (grub_file_t file, char *buf, grub_size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data =3D (struct grub_f2fs_data *) file=
-&gt;data;<br>
&gt; +<br>
&gt; +=C2=A0 return grub_f2fs_read_file (&amp;data-&gt;diropen,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file-&gt;read_hook, f=
ile-&gt;read_hook_data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file-&gt;offset, len,=
 buf);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_close (grub_file_t file)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data =3D (struct grub_f2fs_data *) file=
-&gt;data;<br>
&gt; +<br>
&gt; +=C2=A0 grub_free (data);<br>
&gt; +<br>
&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; +<br>
&gt; +=C2=A0 return GRUB_ERR_NONE;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_uint8_t *<br>
&gt; +grub_f2fs_utf16_to_utf8 (grub_uint16_t *in_buf_le)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_uint16_t in_buf[MAX_VOLUME_NAME];<br>
&gt; +=C2=A0 grub_uint8_t *out_buf;<br>
&gt; +=C2=A0 int len =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 out_buf =3D grub_malloc (MAX_VOLUME_NAME * GRUB_MAX_UTF8_PER_U=
TF16 + 1);<br>
&gt; +=C2=A0 if (!out_buf)<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +<br>
&gt; +=C2=A0 while (*in_buf_le !=3D 0 &amp;&amp; len &lt; MAX_VOLUME_NAME) =
{<br>
&gt; +=C2=A0 =C2=A0 in_buf[len] =3D grub_le_to_cpu16 (in_buf_le[len]);<br>
&gt; +=C2=A0 =C2=A0 len++;<br>
&gt; +=C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 *grub_utf16_to_utf8 (out_buf, in_buf, len) =3D &#39;\0&#39;;<b=
r>
&gt; +=C2=A0 return out_buf;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_label (grub_device_t device, char **label)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; +=C2=A0 grub_disk_t disk =3D device-&gt;disk;<br>
&gt; +<br>
&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; +<br>
&gt; +=C2=A0 data =3D grub_f2fs_mount (disk);<br>
&gt; +=C2=A0 if (data)<br>
&gt; +=C2=A0 =C2=A0 *label =3D (char *) grub_f2fs_utf16_to_utf8 (data-&gt;s=
block.volume_name);<br>
&gt; +=C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 *label =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 grub_free (data);<br>
&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; +=C2=A0 return grub_errno;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static grub_err_t<br>
&gt; +grub_f2fs_uuid (grub_device_t device, char **uuid)<br>
&gt; +{<br>
&gt; +=C2=A0 struct grub_f2fs_data *data;<br>
&gt; +=C2=A0 grub_disk_t disk =3D device-&gt;disk;<br>
&gt; +<br>
&gt; +=C2=A0 grub_dl_ref (my_mod);<br>
&gt; +<br>
&gt; +=C2=A0 data =3D grub_f2fs_mount (disk);<br>
&gt; +=C2=A0 if (data)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *uuid =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0grub_xasprintf<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(&quot;%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02=
x-%02x%02x%02x%02x%02x%02x&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
0], data-&gt;sblock.uuid[1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
2], data-&gt;sblock.uuid[3],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
4], data-&gt;sblock.uuid[5],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
6], data-&gt;sblock.uuid[7],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
8], data-&gt;sblock.uuid[9],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
10], data-&gt;sblock.uuid[11],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
12], data-&gt;sblock.uuid[13],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sblock.uuid[=
14], data-&gt;sblock.uuid[15]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 *uuid =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 grub_free (data);<br>
&gt; +=C2=A0 grub_dl_unref (my_mod);<br>
&gt; +=C2=A0 return grub_errno;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct grub_fs grub_f2fs_fs =3D {<br>
&gt; +=C2=A0 .name =3D &quot;f2fs&quot;,<br>
&gt; +=C2=A0 .dir =3D grub_f2fs_dir,<br>
&gt; +=C2=A0 .open =3D grub_f2fs_open,<br>
&gt; +=C2=A0 .read =3D grub_f2fs_read,<br>
&gt; +=C2=A0 .close =3D grub_f2fs_close,<br>
&gt; +=C2=A0 .label =3D grub_f2fs_label,<br>
&gt; +=C2=A0 .uuid =3D grub_f2fs_uuid,<br>
&gt; +#ifdef GRUB_UTIL<br>
&gt; +=C2=A0 .reserved_first_sector =3D 1,<br>
&gt; +=C2=A0 .blocklist_install =3D 0,<br>
&gt; +#endif<br>
&gt; +=C2=A0 .next =3D 0<br>
&gt; +};<br>
&gt; +<br>
&gt; +GRUB_MOD_INIT (f2fs)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_fs_register (&amp;grub_f2fs_fs);<br>
&gt; +=C2=A0 my_mod =3D mod;<br>
&gt; +}<br>
&gt; +<br>
&gt; +GRUB_MOD_FINI (f2fs)<br>
&gt; +{<br>
&gt; +=C2=A0 grub_fs_unregister (&amp;grub_f2fs_fs);<br>
&gt; +}<br>
&gt; diff --git a/po/exclude.pot b/po/exclude.pot<br>
&gt; index 0a9b215..816089c 100644<br>
&gt; --- a/po/exclude.pot<br>
&gt; +++ b/po/exclude.pot<br>
&gt; @@ -1214,6 +1214,7 @@ msgstr &quot;&quot;<br>
&gt;<br>
&gt;=C2=A0 #: grub-core/commands/xnu_uuid.c:75 grub-core/fs/jfs.c:924<br>
&gt;=C2=A0 #: grub-core/fs/nilfs2.c:1135<br>
&gt; +#: grub-core/fs/f2fs.c:1259<br>
&gt;=C2=A0 #, c-format<br>
&gt;=C2=A0 msgid &quot;%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x=
%02x%02x%02x%02x&quot;<br>
&gt;=C2=A0 msgstr &quot;&quot;<br>
&gt; diff --git a/tests/<a href=3D"http://f2fs_test.in" rel=3D"noreferrer" =
target=3D"_blank">f2fs_test.in</a> b/tests/<a href=3D"http://f2fs_test.in" =
rel=3D"noreferrer" target=3D"_blank">f2fs_test.in</a><br>
&gt; new file mode 100644<br>
&gt; index 0000000..1ea77c8<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/<a href=3D"http://f2fs_test.in" rel=3D"noreferrer" target=
=3D"_blank">f2fs_test.in</a><br>
&gt; @@ -0,0 +1,19 @@<br>
&gt; +#!/bin/sh<br>
&gt; +<br>
&gt; +set -e<br>
&gt; +<br>
&gt; +if [ &quot;x$EUID&quot; =3D &quot;x&quot; ] ; then<br>
&gt; + EUID=3D`id -u`<br>
&gt; +fi<br>
&gt; +<br>
&gt; +if [ &quot;$EUID&quot; !=3D 0 ] ; then<br>
&gt; + exit 77<br>
&gt; +fi<br>
&gt; +<br>
&gt; +if ! which mkfs.f2fs &gt;/dev/null 2&gt;&amp;1; then<br>
&gt; + echo &quot;mkfs.f2fs not installed; cannot test f2fs.&quot;<br>
&gt; + exit 77<br>
&gt; +fi<br>
&gt; +<br>
&gt; +<br>
&gt; +&quot;@builddir@/grub-fs-tester&quot; f2fs<br>
&gt; diff --git a/tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"no=
referrer" target=3D"_blank">grub-fs-tester.in</a> b/tests/util/<a href=3D"h=
ttp://grub-fs-tester.in" rel=3D"noreferrer" target=3D"_blank">grub-fs-teste=
r.in</a><br>
&gt; index 424de22..e3e4109 100644<br>
&gt; --- a/tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"noreferre=
r" target=3D"_blank">grub-fs-tester.in</a><br>
&gt; +++ b/tests/util/<a href=3D"http://grub-fs-tester.in" rel=3D"noreferre=
r" target=3D"_blank">grub-fs-tester.in</a><br>
&gt; @@ -142,7 +142,7 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE&lt;=3D=
MAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0xsquash*)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MINBLKSIZE=3D4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAXBLKSIZE=3D1048576;;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0xxfs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0xxfs|xf2fs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MINBLKSIZE=3D$SECSIZE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# OS Limitation:=
 GNU/Linux doesn&#39;t accept &gt; 4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAXBLKSIZE=3D4096;;<br>
&gt; @@ -265,6 +265,10 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE&lt;=
=3DMAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;btrfs&quo=
t;*)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FS=
LABEL=3D&quot;grub_;/test=C3=A9=F0=AF=A6=9B=F0=AF=A6=9D=F0=9F=98=81=D0=BA=
=D0=B8=D1=80=D0=B8=D1=82i urewfceniuewruevrewnuuireurevueurnievrewfnerfcnev=
irivinrewvnirewnivrewiuvcrewvnuewvrrrewniuerwreiuviurewiuviurewnuvewnvrenur=
nunuvrevuurerejiremvreijnvcreivire nverivnreivrevnureiorfnfrvoeoiroireoireo=
ifrefoieroifoireoif&quot;;;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# FS LIMITATION: f2fs label is at m=
ost 512 UTF-16 chars<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;f2fs&quot;)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FSLABEL=
=3D&quot;grub_;/test=C3=A9=E4=8F=8C=E4=90=93=E4=8F=95=D0=BA=D0=B8=D1=80=D0=
=B8=D1=82iurewfceniuewruewnuuireurevueurnievrewfnerfcnevirivinrewvnirewnivr=
ewiuvcrewvnuewvrrrewniuerwreiuviurewiuviurewnuvewnvrenurnunuvrevuurerejirem=
vreijnvvcreivire nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoirvcr=
eivire nverivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoircreivire nver=
ivnreivrevnureiorfnfrvoeoiroireoireoifrefoieroifoireoifoiq&quot;;;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# FS LIMITATION: exfat is at m=
ost 15 UTF-16 chars<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;exfat&quo=
t;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FS=
LABEL=3D&quot;g=C3=A9=D1=82 ;/=F0=AF=A6=9B=F0=AF=A6=9D=F0=9F=98=81=D0=BA=D0=
=B8=D1=80&quot;;;<br>
&gt; @@ -474,7 +478,7 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE&lt;=3D=
MAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# FIXME: Not sure about BtrFS,=
 NTFS, JFS, AFS, UDF and SFS. Check it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# FS LIMITATION: as far as I know those FS d=
on&#39;t store their last modification date.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x&quot;jfs_casei=
ns&quot; | x&quot;jfs&quot; | x&quot;xfs&quot; | x&quot;xfs_crc&quot; | x&q=
uot;btrfs&quot;* | x&quot;reiserfs_old&quot; | x&quot;reiserfs&quot; \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| x&quo=
t;bfs&quot; | x&quot;afs&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| x&quo=
t;bfs&quot; | x&quot;afs&quot; | x&quot;f2fs&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
x&quot;tarfs&quot; | x&quot;cpio_&quot;* | x&quot;minix&quot; | x&quot;mini=
x2&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
x&quot;minix3&quot; | x&quot;ntfs&quot;* | x&quot;udf&quot; | x&quot;sfs&qu=
ot;*)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NO=
FSTIME=3Dy;;<br>
&gt; @@ -753,6 +757,8 @@ for ((LOGSECSIZE=3DMINLOGSECSIZE;LOGSECSIZE&lt;=3D=
MAXLOGSECSIZE;LOGSECSIZE=3DLOGSECSIZE +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MO=
UNTDEVICE=3D&quot;/dev/mapper/grub_test-testvol&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MO=
UNTFS=3Dext2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;mkfs.ext2&quot; -L &quot;$FSLABEL&quot; -q &quot;${MOUNTDEVICE}&quot;=
=C2=A0 ;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xf2fs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;m=
kfs.f2fs&quot; -l &quot;$FSLABEL&quot; -q &quot;${LODEVICES[0]}&quot; ;;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xnilfs2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;mkfs.nilfs2&quot; -L &quot;$FSLABEL&quot; -b $BLKSIZE=C2=A0 -q &quot;${=
LODEVICES[0]}&quot; ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xext2_old)<br>
&gt;<br>
<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">_______________________=
________________________<br>
Grub-devel mailing list<br>
<a href=3D"mailto:Grub-devel@gnu.org">Grub-devel@gnu.org</a><br>
<a href=3D"https://lists.gnu.org/mailman/listinfo/grub-devel" rel=3D"norefe=
rrer" target=3D"_blank">https://lists.gnu.org/mailman/listinfo/grub-devel</=
a><br>
</div></div></blockquote></div><br></div>

--047d7b86dcb4c4a9e9052d1920ed--


--===============1558410000343847532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Grub-devel mailing list
Grub-devel@gnu.org
https://lists.gnu.org/mailman/listinfo/grub-devel

--===============1558410000343847532==--
