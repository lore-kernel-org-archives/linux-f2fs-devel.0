From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 00/10 v2] File-level Encryption Support by VFS
Date: Thu, 25 Feb 2016 11:25:58 -0800
Message-ID: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aZ1Yl-0001Rc-Q8
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 19:26:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aZ1Yk-0006uf-Vv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 19:26:47 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch series migrates the existing ext4 and f2fs per-file encryption
feature into VFS layer.

Due to the upcoming merge window, let me consider the following schedule.
1. migrate f2fs and there-in crypto codes into VFS during the next merge window
2. settle down new crypto lib in VFS during rc series
3. review, test, and migrate EXT4 changes accordingly

Change log from v1:
 o Adjust recent ext4 crypto patches

Jaegeuk Kim (10):
  fs crypto: add basic definitions for per-file encryption
  fs crypto: add crypto.c for encrypt/decrypt functions
  fs crypto: add policy.c to handle contexts
  fs crypto: add keyinfo.c to handle permissions
  fs crypto: add fname.c to support filename encryption
  fs crypto: add Makefile and Kconfig
  fs crypto: add dentry revalidation facility in crypto
  f2fs crypto: migrate into vfs's crypto engine
  f2fs crypto: sync ext4_lookup and ext4_file_open
  ext4 crypto: migrate into vfs's crypto engine

 fs/Kconfig               |   2 +
 fs/Makefile              |   1 +
 fs/crypto/Kconfig        |  17 ++
 fs/crypto/Makefile       |   2 +
 fs/crypto/crypto.c       | 554 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/crypto/fname.c        | 437 +++++++++++++++++++++++++++++++++++++
 fs/crypto/keyinfo.c      | 278 ++++++++++++++++++++++++
 fs/crypto/policy.c       | 229 ++++++++++++++++++++
 fs/ext4/Kconfig          |  12 +-
 fs/ext4/Makefile         |   2 -
 fs/ext4/crypto.c         | 525 --------------------------------------------
 fs/ext4/crypto_fname.c   | 470 ----------------------------------------
 fs/ext4/crypto_key.c     | 276 -----------------------
 fs/ext4/crypto_policy.c  | 229 --------------------
 fs/ext4/dir.c            |  28 +--
 fs/ext4/ext4.h           | 172 ++++-----------
 fs/ext4/ext4_crypto.h    | 159 --------------
 fs/ext4/file.c           |  10 +-
 fs/ext4/ialloc.c         |   7 +-
 fs/ext4/inline.c         |  14 +-
 fs/ext4/inode.c          |   8 +-
 fs/ext4/ioctl.c          |  20 +-
 fs/ext4/namei.c          | 120 +++++-----
 fs/ext4/page-io.c        |  13 +-
 fs/ext4/readpage.c       |  45 +---
 fs/ext4/super.c          |  85 +++++++-
 fs/ext4/symlink.c        |  33 ++-
 fs/f2fs/Kconfig          |  10 +-
 fs/f2fs/Makefile         |   2 -
 fs/f2fs/crypto.c         | 473 ----------------------------------------
 fs/f2fs/crypto_fname.c   | 446 --------------------------------------
 fs/f2fs/crypto_key.c     | 267 -----------------------
 fs/f2fs/crypto_policy.c  | 210 ------------------
 fs/f2fs/data.c           |  31 ++-
 fs/f2fs/dir.c            |  46 ++--
 fs/f2fs/f2fs.h           | 151 +------------
 fs/f2fs/f2fs_crypto.h    | 151 -------------
 fs/f2fs/file.c           |  40 ++--
 fs/f2fs/inline.c         |   4 +-
 fs/f2fs/inode.c          |   5 +-
 fs/f2fs/namei.c          |  79 ++++---
 fs/f2fs/super.c          |  55 +++--
 include/linux/dcache.h   |   2 +
 include/linux/fs.h       |   8 +
 include/linux/fscrypto.h | 383 ++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h  |  18 ++
 46 files changed, 2334 insertions(+), 3795 deletions(-)
 create mode 100644 fs/crypto/Kconfig
 create mode 100644 fs/crypto/Makefile
 create mode 100644 fs/crypto/crypto.c
 create mode 100644 fs/crypto/fname.c
 create mode 100644 fs/crypto/keyinfo.c
 create mode 100644 fs/crypto/policy.c
 delete mode 100644 fs/ext4/crypto.c
 delete mode 100644 fs/ext4/crypto_fname.c
 delete mode 100644 fs/ext4/crypto_key.c
 delete mode 100644 fs/ext4/crypto_policy.c
 delete mode 100644 fs/ext4/ext4_crypto.h
 delete mode 100644 fs/f2fs/crypto.c
 delete mode 100644 fs/f2fs/crypto_fname.c
 delete mode 100644 fs/f2fs/crypto_key.c
 delete mode 100644 fs/f2fs/crypto_policy.c
 delete mode 100644 fs/f2fs/f2fs_crypto.h
 create mode 100644 include/linux/fscrypto.h

-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
