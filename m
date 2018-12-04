From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V2 0/7] Remove fs specific fscrypt and fsverity
 build config options
Date: Tue,  4 Dec 2018 15:26:43 +0530
Message-ID: <20181204095650.12562-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gU7S8-0002nb-T0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Dec 2018 09:57:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gU7S5-003bvd-V4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Dec 2018 09:57:15 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB49ru2o077871
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 4 Dec 2018 04:57:06 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p5pmssynh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 04 Dec 2018 04:57:06 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Tue, 4 Dec 2018 09:57:05 -0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: dedekind1@gmail.com, tytso@mit.edu, corbet@lwn.net, jhogan@kernel.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ralf@linux-mips.org, ebiggers@kernel.org, paul.burton@mips.com, adilger.kernel@dilger.ca, green.hu@gmail.com, richard@nod.at, schwidefsky@de.ibm.com, jaegeuk@kernel.org, deanbo422@gmail.com, viro@zeniv.linux.org.uk

In order to have a common code base for fscrypt & fsverity "post read"
processing across filesystems which implement fscrypt/fsverity, this
commit removes filesystem specific build config option
(CONFIG_EXT4_FS_ENCRYPTION, CONFIG_EXT4_FS_VERITY,
CONFIG_F2FS_FS_ENCRYPTION, CONFIG_F2FS_FS_VERITY and
CONFIG_UBIFS_FS_ENCRYPTION) and replaces it with build options
(CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY) whose values affect all
the filesystems making use of fscrypt and fsverity.

PS: Since I have access to only to x86 and ppc64le machines, I haven't tested the
defconfig files for other architectures.

Changelog:
V1 -> V2:
1. Address the following review comments provided by Eric Biggers,
   - In ext4_should_use_dax(), Use ext4_test_inode_flag() to check for
     fscrypt/fsverity status of an inode.
   - Update documentation associated with fscrypt & fsverity to refer to
     CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY build flags.
   - Remove filesystem specific fscrypt build configuration from defconfig
     files.
   - Provide a list of supported filesystems for CONFIG_FS_ENCRYPTION and
     CONFIG_FS_VERITY build flags.
   - Update comment describing S_VERITY flag.
2. Remove UBIFS specific encryption build option and make use of the generic
   CONFIG_FS_ENCRYPTION flag.

RFC -> V1:
1. Add a new patch to implement S_VERITY/IS_VERITY().
2. Split code that replaces filesystem specific routines with generic
   IS_ENCRYPTED() and IS_VERITY() calls into separate patches.

Chandan Rajendra (7):
  ext4: use IS_ENCRYPTED() to check encryption status
  f2fs: use IS_ENCRYPTED() to check encryption status
  fscrypt: remove filesystem specific build config option
  Add S_VERITY and IS_VERITY()
  ext4: use IS_VERITY() to check inode's fsverity status
  f2fs: use IS_VERITY() to check inode's fsverity status
  fsverity: Remove filesystem specific build config option

 Documentation/filesystems/fscrypt.rst   |   4 +-
 Documentation/filesystems/fsverity.rst  |   4 +-
 arch/mips/configs/generic_defconfig     |   2 +-
 arch/nds32/configs/defconfig            |   2 +-
 arch/s390/configs/debug_defconfig       |   2 +-
 arch/s390/configs/performance_defconfig |   2 +-
 fs/crypto/Kconfig                       |   5 +-
 fs/ext4/Kconfig                         |  35 --
 fs/ext4/dir.c                           |  10 +-
 fs/ext4/ext4.h                          |  23 +-
 fs/ext4/ext4_jbd2.h                     |   2 +-
 fs/ext4/extents.c                       |   4 +-
 fs/ext4/file.c                          |   2 +-
 fs/ext4/ialloc.c                        |   2 +-
 fs/ext4/inode.c                         |  32 +-
 fs/ext4/ioctl.c                         |   4 +-
 fs/ext4/move_extent.c                   |   3 +-
 fs/ext4/namei.c                         |  18 +-
 fs/ext4/page-io.c                       |   8 +-
 fs/ext4/readpage.c                      |  10 +-
 fs/ext4/super.c                         |  13 +-
 fs/ext4/sysfs.c                         |   8 +-
 fs/f2fs/Kconfig                         |  31 --
 fs/f2fs/data.c                          |   6 +-
 fs/f2fs/dir.c                           |  10 +-
 fs/f2fs/f2fs.h                          |   9 +-
 fs/f2fs/file.c                          |  16 +-
 fs/f2fs/inode.c                         |   4 +-
 fs/f2fs/namei.c                         |   6 +-
 fs/f2fs/super.c                         |  14 +-
 fs/f2fs/sysfs.c                         |   8 +-
 fs/ubifs/Kconfig                        |  11 -
 fs/ubifs/Makefile                       |   2 +-
 fs/ubifs/ioctl.c                        |   4 +-
 fs/ubifs/sb.c                           |   2 +-
 fs/ubifs/super.c                        |   2 +-
 fs/ubifs/ubifs.h                        |   5 +-
 fs/verity/Kconfig                       |   3 +-
 include/linux/fs.h                      |  10 +-
 include/linux/fscrypt.h                 | 416 +++++++++++++++++++++++-
 include/linux/fscrypt_notsupp.h         | 231 -------------
 include/linux/fscrypt_supp.h            | 204 ------------
 include/linux/fsverity.h                |   3 +-
 43 files changed, 532 insertions(+), 660 deletions(-)
 delete mode 100644 include/linux/fscrypt_notsupp.h
 delete mode 100644 include/linux/fscrypt_supp.h

-- 
2.19.1
