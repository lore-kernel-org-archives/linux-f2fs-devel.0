From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v4.6
Date: Sun, 20 Mar 2016 15:58:59 -0700
Message-ID: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ahmJK-0001BV-JS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Mar 2016 22:59:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahmJJ-0007FO-9I
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Mar 2016 22:59:02 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi Linus,

I made another pull request which removes the previous wrong commits and adds
a single commit to migrate the f2fs crypto into fs/crypto.

Could you please consider to pull this?

Thanks,

The following changes since commit 4de8ebeff8ddefaceeb7fc6a9b1a514fc9624509:

  Merge tag 'trace-fixes-v4.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2016-02-22 14:09:18 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.6

for you to fetch changes up to 12bb0a8fd47e6020a7b52dc283a2d855f03d6ef5:

  f2fs: submit node page write bios when really required (2016-03-17 21:19:47 -0700)

----------------------------------------------------------------
= New Features =
 - uplift filesystem encryption into fs/crypto/
 - give sysfs entries to control memroy consumption

= Enhancement ==
 - aio performance by preallocating blocks in ->write_iter
 - use writepages lock for only WB_SYNC_ALL
 - avoid redundant inline_data conversion
 - enhance forground GC
 - use wait_for_stable_page as possible
 - speed up SEEK_DATA and fiiemap

= Bug Fixes =
 - corner case in terms of -ENOSPC for inline_data
 - hung task caused by long latency in shrinker
 - corruption between atomic write and f2fs_trace_pid
 - avoid garbage lengths in dentries
 - revoke atomicly written pages if an error occurs

In addition, there are various minor bug fixes and clean-ups.

----------------------------------------------------------------
Arnd Bergmann (1):
      f2fs: add missing argument to f2fs_setxattr stub

Chao Yu (33):
      f2fs: relocate is_merged_page
      f2fs: flush dirty nat entries when exceeding threshold
      f2fs: export dirty_nats_ratio in sysfs
      f2fs: correct search area in get_new_segment
      f2fs: enhance foreground GC
      f2fs: simplify f2fs_map_blocks
      f2fs: simplify __allocate_data_blocks
      f2fs: remove unneeded pointer conversion
      f2fs: introduce get_next_page_offset to speed up SEEK_DATA
      f2fs: speed up handling holes in fiemap
      f2fs: introduce f2fs_submit_merged_bio_cond
      f2fs: split drop_inmem_pages from commit_inmem_pages
      f2fs: support revoking atomic written pages
      f2fs crypto: make sure the encryption info is initialized on opendir(2)
      f2fs crypto: handle unexpected lack of encryption keys
      f2fs crypto: avoid unneeded memory allocation when {en/de}crypting symlink
      f2fs: introduce f2fs_journal struct to wrap journal info
      f2fs: enhance IO path with block plug
      f2fs: split journal cache from curseg cache
      f2fs: reorder nat cache lock in cache_nat_entry
      f2fs: detect error of update_dent_inode in ->rename
      f2fs: fix to delete old dirent in converted inline directory in ->rename
      f2fs: fix the wrong stat count of calling gc
      f2fs: show more info about superblock recovery
      f2fs: try to flush inode after merging inline data
      f2fs: trace old block address for CoWed page
      f2fs: fix incorrect upper bound when iterating inode mapping tree
      f2fs crypto: fix incorrect positioning for GCing encrypted data page
      f2fs: introduce f2fs_update_data_blkaddr for cleanup
      f2fs: introduce f2fs_flush_merged_bios for cleanup
      f2fs: fix to avoid deadlock when merging inline data
      f2fs: clean up opened code with f2fs_update_dentry
      f2fs: fix to avoid unneeded unlock_new_inode

Fan Li (2):
      f2fs: avoid unnecessary search while finding victim in gc
      f2fs: modify the readahead method in ra_node_page()

Hou Pengyang (2):
      f2fs: reconstruct the code to free an extent_node
      f2fs: improve shrink performance of extent nodes

Jaegeuk Kim (32):
      f2fs: remove needless condition check
      f2fs: use writepages->lock for WB_SYNC_ALL
      f2fs: fix to overcome inline_data floods
      f2fs: do f2fs_balance_fs when block is allocated
      f2fs: avoid multiple node page writes due to inline_data
      f2fs: don't need to sync node page at every time
      f2fs: avoid needless sync_inode_page when reading inline_data
      f2fs: don't need to call set_page_dirty for io error
      f2fs: use wait_for_stable_page to avoid contention
      f2fs: use wq_has_sleeper for cp_wait wait_queue
      f2fs: move extent_node list operations being coupled with rbtree operation
      f2fs: don't set cached_en if it will be freed
      f2fs: give scheduling point in shrinking path
      f2fs: wait on page's writeback in writepages path
      f2fs: flush bios to handle cp_error in put_super
      f2fs: fix conflict on page->private usage
      f2fs: move dio preallocation into f2fs_file_write_iter
      f2fs: preallocate blocks for buffered aio writes
      f2fs: increase i_size to avoid missing data
      f2fs crypto: replace some BUG_ON()'s with error checks
      f2fs crypto: fix spelling typo in comment
      f2fs crypto: f2fs_page_crypto() doesn't need a encryption context
      f2fs crypto: check for too-short encrypted file names
      f2fs crypto: add missing locking for keyring_key access
      f2fs: use correct errno
      f2fs crypto: sync with ext4's fname padding
      f2fs: avoid garbage lenghs in dentries
      f2fs: remain last victim segment number ascending order
      fs crypto: move per-file encryption from f2fs tree to fs/crypto
      f2fs crypto: sync ext4_lookup and ext4_file_open
      f2fs: declare static functions
      f2fs: submit node page write bios when really required

Keith Mok (1):
      f2fs: use cryptoapi crc32 functions

Liu Xue (1):
      f2fs: recovery missing dot dentries in root directory

Shawn Lin (3):
      f2fs: slightly reorganize read_raw_super_block
      f2fs: move sanity checking of cp into get_valid_checkpoint
      f2fs: reuse read_inline_data for f2fs_convert_inline_page

Sheng Yong (1):
      f2fs: fix endianness of on-disk summary_footer

Shuoran Liu (1):
      f2fs: introduce lifetime write IO statistics

Yang Shi (1):
      f2fs: mutex can't be used by down_write_nest_lock()

Yunlei He (3):
      f2fs: delete unnecessary wait for page writeback
      f2fs: fix missing skip pages info
      f2fs: avoid hungtask problem caused by losing wake_up

 Documentation/ABI/testing/sysfs-fs-f2fs    |  14 +
 fs/Kconfig                                 |   2 +
 fs/Makefile                                |   1 +
 fs/crypto/Kconfig                          |  18 +
 fs/crypto/Makefile                         |   3 +
 fs/crypto/crypto.c                         | 556 +++++++++++++++++++++++++++++
 fs/{f2fs/crypto_fname.c => crypto/fname.c} | 245 ++++++-------
 fs/crypto/keyinfo.c                        | 278 +++++++++++++++
 fs/crypto/policy.c                         | 229 ++++++++++++
 fs/f2fs/Kconfig                            |  12 +-
 fs/f2fs/Makefile                           |   2 -
 fs/f2fs/checkpoint.c                       |  77 ++--
 fs/f2fs/crypto.c                           | 491 -------------------------
 fs/f2fs/crypto_key.c                       | 254 -------------
 fs/f2fs/crypto_policy.c                    | 209 -----------
 fs/f2fs/data.c                             | 428 +++++++++++-----------
 fs/f2fs/dir.c                              |  94 ++---
 fs/f2fs/extent_cache.c                     | 176 ++++-----
 fs/f2fs/f2fs.h                             | 315 +++++++---------
 fs/f2fs/f2fs_crypto.h                      | 151 --------
 fs/f2fs/file.c                             | 114 +++---
 fs/f2fs/gc.c                               | 245 +++++++------
 fs/f2fs/inline.c                           |  43 +--
 fs/f2fs/inode.c                            |  15 +-
 fs/f2fs/namei.c                            | 168 +++++----
 fs/f2fs/node.c                             | 223 ++++++++----
 fs/f2fs/node.h                             |  26 +-
 fs/f2fs/recovery.c                         |  14 +-
 fs/f2fs/segment.c                          | 386 ++++++++++++--------
 fs/f2fs/segment.h                          |   5 +-
 fs/f2fs/super.c                            | 204 +++++++----
 fs/f2fs/trace.c                            |   6 +-
 fs/f2fs/xattr.c                            |   6 +-
 fs/f2fs/xattr.h                            |   3 +-
 include/linux/dcache.h                     |   2 +
 include/linux/f2fs_fs.h                    |  34 +-
 include/linux/fs.h                         |   8 +
 include/linux/fscrypto.h                   | 433 ++++++++++++++++++++++
 include/trace/events/f2fs.h                |  12 +-
 include/uapi/linux/fs.h                    |  18 +
 40 files changed, 3142 insertions(+), 2378 deletions(-)
 create mode 100644 fs/crypto/Kconfig
 create mode 100644 fs/crypto/Makefile
 create mode 100644 fs/crypto/crypto.c
 rename fs/{f2fs/crypto_fname.c => crypto/fname.c} (60%)
 create mode 100644 fs/crypto/keyinfo.c
 create mode 100644 fs/crypto/policy.c
 delete mode 100644 fs/f2fs/crypto.c
 delete mode 100644 fs/f2fs/crypto_key.c
 delete mode 100644 fs/f2fs/crypto_policy.c
 delete mode 100644 fs/f2fs/f2fs_crypto.h
 create mode 100644 include/linux/fscrypto.h


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
