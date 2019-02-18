From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [RFC PATCH 00/10] Consolidate Post read processing
 code
Date: Mon, 18 Feb 2019 15:49:13 +0530
Message-ID: <2149979.e1aSEps7Pq@localhost.localdomain>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1gvg0l-0002ul-Bc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:18:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gvg0c-00EWJ7-Ru
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:18:55 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1IABcDG093137
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:18:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qqrc5eshw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:18:40 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Mon, 18 Feb 2019 10:18:39 -0000
In-Reply-To: <20190218100433.20048-1-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org

On Monday, February 18, 2019 3:34:23 PM IST Chandan Rajendra wrote:
> This patchset moves the "post read processing" code into a file of its
> own and gets the generic do_mpage_readpge() to make use of the
> functionality provided. With these changes in place, the patchset
> changes Ext4 to use mpage_readpage[s] instead of its own custom
> ext4_readpages() function. This is done to reduce duplicity of code
> across filesystems. Based on the reviews provided for this patchset, I
> will change F2FS to use mpage_readpage[s] and post the next version of
> this patchset to linux-fsdevel mailing list.
> 
> The patchset also includes patches from previous postings i.e.
> patches to replace per-filesystem encryption config options with a
> single config option that affects all filesystems making use of
> fscrypt code.

The patchset is based on fsverity_2019-01-30 branch of Eric's git tree. It can
also be obtained from "https://github.com/chandanr/linux.git
use-mpage-readpage-rfc".

> 
> Chandan Rajendra (10):
>   ext4: use IS_ENCRYPTED() to check encryption status
>   f2fs: use IS_ENCRYPTED() to check encryption status
>   fscrypt: remove filesystem specific build config option
>   Consolidate "post read processing" into a new file
>   fsverity: Add call back to decide if verity check has to be performed
>   Introduce REQ_POST_READ_PROC bio flag
>   fsverity: Add call back to determine readpage limit
>   fsverity: Add call back to verify file holes
>   fs/mpage.c: Integrate post read processing
>   ext4: Wire up ext4_readpage[s] to use mpage_readpage[s]
> 
>  Documentation/filesystems/fscrypt.rst   |   4 +-
>  arch/mips/configs/generic_defconfig     |   2 +-
>  arch/nds32/configs/defconfig            |   2 +-
>  arch/s390/configs/debug_defconfig       |   2 +-
>  arch/s390/configs/performance_defconfig |   2 +-
>  fs/Makefile                             |   3 +-
>  fs/crypto/Kconfig                       |   5 +-
>  fs/crypto/bio.c                         |  21 +-
>  fs/crypto/crypto.c                      |   1 +
>  fs/crypto/fscrypt_private.h             |   4 +-
>  fs/ext4/Kconfig                         |  15 -
>  fs/ext4/Makefile                        |   2 +-
>  fs/ext4/dir.c                           |  10 +-
>  fs/ext4/ext4.h                          |  14 +-
>  fs/ext4/ext4_jbd2.h                     |   2 +-
>  fs/ext4/extents.c                       |   4 +-
>  fs/ext4/ialloc.c                        |   2 +-
>  fs/ext4/inode.c                         |  29 +-
>  fs/ext4/ioctl.c                         |   4 +-
>  fs/ext4/move_extent.c                   |   3 +-
>  fs/ext4/namei.c                         |  18 +-
>  fs/ext4/page-io.c                       |   9 +-
>  fs/ext4/readpage.c                      | 444 ------------------------
>  fs/ext4/super.c                         |  43 ++-
>  fs/ext4/sysfs.c                         |   4 +-
>  fs/f2fs/Kconfig                         |  12 +-
>  fs/f2fs/data.c                          |   4 +-
>  fs/f2fs/dir.c                           |  10 +-
>  fs/f2fs/f2fs.h                          |  14 +-
>  fs/f2fs/file.c                          |  10 +-
>  fs/f2fs/inode.c                         |   4 +-
>  fs/f2fs/namei.c                         |   6 +-
>  fs/f2fs/super.c                         |   8 +-
>  fs/f2fs/sysfs.c                         |   4 +-
>  fs/mpage.c                              |  77 +++-
>  fs/post_read_process.c                  | 128 +++++++
>  fs/ubifs/Kconfig                        |  12 +-
>  fs/ubifs/Makefile                       |   2 +-
>  fs/ubifs/ioctl.c                        |   4 +-
>  fs/ubifs/sb.c                           |   2 +-
>  fs/ubifs/super.c                        |   2 +-
>  fs/ubifs/ubifs.h                        |   5 +-
>  fs/verity/verify.c                      |  12 +
>  include/linux/blk_types.h               |   2 +
>  include/linux/fs.h                      |   4 +-
>  include/linux/fscrypt.h                 | 405 ++++++++++++++++++++-
>  include/linux/fscrypt_notsupp.h         | 231 ------------
>  include/linux/fscrypt_supp.h            | 204 -----------
>  include/linux/fsverity.h                |   3 +
>  include/linux/post_read_process.h       |  21 ++
>  50 files changed, 757 insertions(+), 1078 deletions(-)
>  delete mode 100644 fs/ext4/readpage.c
>  create mode 100644 fs/post_read_process.c
>  delete mode 100644 include/linux/fscrypt_notsupp.h
>  delete mode 100644 include/linux/fscrypt_supp.h
>  create mode 100644 include/linux/post_read_process.h
> 
> 


-- 
chandan
