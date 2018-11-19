From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 0/7] Remove fs specific fscrypt and fsverity
 build config options
Date: Mon, 19 Nov 2018 10:53:17 +0530
Message-ID: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gOc2B-0002UC-Ns
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 05:23:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOc2A-00Dfok-5m
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 05:23:43 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJ5ENec069422
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 19 Nov 2018 00:23:35 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2num1w6f00-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 19 Nov 2018 00:23:34 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Mon, 19 Nov 2018 05:23:34 -0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ebiggers@kernel.org, tytso@mit.edu

As a first step to avoid copy-pasting common code across filesystems
which implement fscrypt/fsverity, this commit removes filesystem
specific build config option (CONFIG_EXT4_FS_ENCRYPTION,
CONFIG_EXT4_FS_VERITY, CONFIG_F2FS_FS_ENCRYPTION and
CONFIG_F2FS_FS_VERITY) and replaces it with build options
(CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY) whose values affect all
the filesystems making use of fscrypt and fsverity. This is done in
order to have a common code base for implementing "post read"
processing across filesystems.

Changelog:
RFC -> V1:
1. Add a new patch to implement S_VERITY/IS_VERITY().
2. Split code that replaces filesystem specific routines with generic
   IS_ENCRYPTED() and IS_VERITY() calls into separate patches.

Chandan Rajendra (7):
  ext4: use IS_ENCRYPTED() to check encryption status
  f2fs: use IS_ENCRYPTED() to check encryption status
  fscrypt: Remove filesystem specific build config option
  Add S_VERITY and IS_VERITY()
  ext4: use IS_VERITY() to check inode's fsverity status
  f2fs: use IS_VERITY() to check inode's fsverity status
  fsverity: Remove filesystem specific build config option

 fs/crypto/Kconfig               |   2 +-
 fs/ext4/Kconfig                 |  35 ---
 fs/ext4/dir.c                   |  10 +-
 fs/ext4/ext4.h                  |  23 +-
 fs/ext4/ext4_jbd2.h             |   2 +-
 fs/ext4/extents.c               |   4 +-
 fs/ext4/file.c                  |   2 +-
 fs/ext4/ialloc.c                |   2 +-
 fs/ext4/inode.c                 |  32 +--
 fs/ext4/ioctl.c                 |   4 +-
 fs/ext4/move_extent.c           |   3 +-
 fs/ext4/namei.c                 |  18 +-
 fs/ext4/page-io.c               |   8 +-
 fs/ext4/readpage.c              |  10 +-
 fs/ext4/super.c                 |  12 +-
 fs/ext4/sysfs.c                 |   8 +-
 fs/f2fs/Kconfig                 |  31 ---
 fs/f2fs/data.c                  |   6 +-
 fs/f2fs/dir.c                   |  10 +-
 fs/f2fs/f2fs.h                  |   9 +-
 fs/f2fs/file.c                  |  16 +-
 fs/f2fs/inode.c                 |   4 +-
 fs/f2fs/namei.c                 |   6 +-
 fs/f2fs/super.c                 |  14 +-
 fs/f2fs/sysfs.c                 |   8 +-
 fs/verity/Kconfig               |   2 +-
 include/linux/fs.h              |   2 +
 include/linux/fscrypt.h         | 416 +++++++++++++++++++++++++++++++-
 include/linux/fscrypt_notsupp.h | 231 ------------------
 include/linux/fscrypt_supp.h    | 204 ----------------
 include/linux/fsverity.h        |   3 +-
 31 files changed, 509 insertions(+), 628 deletions(-)
 delete mode 100644 include/linux/fscrypt_notsupp.h
 delete mode 100644 include/linux/fscrypt_supp.h

-- 
2.19.1
