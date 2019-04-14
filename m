From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH V2 00/14] Consolidate Post read processing
 code
Date: Sun, 14 Apr 2019 17:07:50 +0530
Message-ID: <20190414113804.26769-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hFdRy-0001Jy-0q
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:37:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFdRv-00558w-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:37:29 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3EBYFVh032803
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:37:22 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ruw2x2u3r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:37:22 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 14 Apr 2019 12:37:21 +0100
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Cc: tytso@mit.edu, ebiggers@kernel.org, Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca, jaegeuk@kernel.org

This patchset moves the "post read processing" code into a file of its
own (i.e. fs/post_read_process.c) and modifies the generic
do_mpage_readpge() to make use of the functionality provided.

"Post read processing" implements code to track the state machine that
needs to be executed after reading data from files that are encrypted
and/or have verity metadata associated with them.

With these changes in place, the patchset changes Ext4 to use
mpage_readpage[s] instead of its own custom ext4_readpage[s]()
functions. This is done to reduce duplicity of code across
filesystems. Also, Post read processing source files will be built
only if one of CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY is enabled.

Members of "struct fscrypt_ctx" that tracked status of a "write"
operation are now made an anonymous structure since the decryption
state tracking members are now moved into "struct post_read_ctx".

The patchset also modifies fs/buffer.c and fscrypt functionality to
get file encryption/decryption to work with subpage-sized blocks.

The following fixes from Eric Biggers are prerequisites for this
patchset,
  fscrypt: fix race where ->lookup() marks plaintext dentry as ciphertext
  fscrypt: only set dentry_operations on ciphertext dentries
  fscrypt: clear DCACHE_ENCRYPTED_NAME when unaliasing directory
  fscrypt: fix race allowing rename() and link() of ciphertext dentries
  fscrypt: clean up and improve dentry revalidation

The patches can also be obtained from,
"https://github.com/chandanr/linux.git subpage-encryption"

TODO:
1. The subset of the fscrypt_encrypt_page() that deals with
   FS_CFLG_OWN_PAGES case still needs to be tested. UBIFS seems to be the
   only user of this piece of code.
2. Verity changes needs to be added for F2FS and I will add them in the
   next patchset based on the review comments obtained for the current
   patchset.

Changelog:
RFC V1 -> RFC V2:
1. Describe the purpose of "Post processing code" in the cover letter.
2. Fix build errors when CONFIG_FS_VERITY is enabled.

Chandan Rajendra (14):
  ext4: Clear BH_Uptodate flag on decryption error
  Consolidate "post read processing" into a new file
  fsverity: Add call back to decide if verity check has to be performed
  fsverity: Add call back to determine readpage limit
  fs/mpage.c: Integrate post read processing
  ext4: Wire up ext4_readpage[s] to use mpage_readpage[s]
  Remove the term "bio" from post read processing
  Add decryption support for sub-pagesized blocks
  ext4: Decrypt all boundary blocks when doing buffered write
  ext4: Decrypt the block that needs to be partially zeroed
  fscrypt_encrypt_page: Loop across all blocks mapped by a page range
  ext4: Compute logical block and the page range to be encrypted
  fscrypt_zeroout_range: Encrypt all zeroed out blocks of a page
  ext4: Enable encryption for subpage-sized blocks

 Documentation/filesystems/fscrypt.rst |   4 +-
 fs/Makefile                           |   4 +
 fs/buffer.c                           |  85 +++--
 fs/crypto/bio.c                       | 109 ++++---
 fs/crypto/crypto.c                    |  73 +++--
 fs/crypto/fscrypt_private.h           |   3 +
 fs/ext4/Makefile                      |   2 +-
 fs/ext4/ext4.h                        |   2 -
 fs/ext4/inode.c                       |  47 ++-
 fs/ext4/page-io.c                     |   9 +-
 fs/ext4/readpage.c                    | 445 --------------------------
 fs/ext4/super.c                       |  40 ++-
 fs/f2fs/data.c                        | 148 ++-------
 fs/f2fs/super.c                       |   9 +-
 fs/mpage.c                            |  51 ++-
 fs/post_read_process.c                | 155 +++++++++
 fs/verity/verify.c                    |  12 +
 include/linux/buffer_head.h           |   1 +
 include/linux/fscrypt.h               |  20 +-
 include/linux/fsverity.h              |   2 +
 include/linux/post_read_process.h     |  22 ++
 21 files changed, 511 insertions(+), 732 deletions(-)
 delete mode 100644 fs/ext4/readpage.c
 create mode 100644 fs/post_read_process.c
 create mode 100644 include/linux/post_read_process.h

-- 
2.19.1
