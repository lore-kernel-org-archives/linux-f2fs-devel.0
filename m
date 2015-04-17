From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v4.1
Date: Fri, 17 Apr 2015 11:25:02 -0700
Message-ID: <20150417182502.GA28203@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull the following patches?

Thank you very much,

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.1

for you to fetch changes up to 10027551ccf5459cc771c31ac8bc8e5cc8db45f8:

  f2fs: pass checkpoint reason on roll-forward recovery (2015-04-16 09:45:40 -0700)

----------------------------------------------------------------
New features are:
 o in-memory extent_cache
 o fs_shutdown to test power-off-recovery
 o use inline_data to store symlink path
 o show f2fs as a non-misc filesystem

Major fixes are to:
 o avoid CPU stalls on sync_dirty_dir_inodes
 o fix some power-off-recovery procedure
 o fix to handle broken symlink correctly
 o fix missing dot and dotdot made by sudden power cuts
 o handle wrong data index during roll-forward recovery
 o preallocate data blocks for direct_io

And it includes a bunch of minor bug fixes and cleanups.

----------------------------------------------------------------
Changman Lee (2):
      f2fs: add stat info for moved blocks by background gc
      f2fs: cleanup statement about max orphan inodes calc

Chao Yu (31):
      f2fs: remove unused inline_dentry_addr
      f2fs: introduce f2fs_update_dentry to clean up duplicated codes
      f2fs: use ->writepage in sync_meta_pages
      f2fs: fix incorrectly stat number of inline data inode
      f2fs: move ext_lock out of struct extent_info
      f2fs: simplfy a field name in struct f2fs_extent,extent_info
      f2fs: introduce f2fs_map_bh to clean codes of check_extent_cache
      f2fs: introduce universal lookup/update interface for extent cache
      f2fs: introduce infra macro and data structure of rb-tree extent cache
      f2fs: add core functions for rb-tree extent cache
      f2fs: add a mount option for rb-tree extent cache
      f2fs: enable rb-tree extent cache
      f2fs: show extent tree, node stat info in debugfs
      f2fs: add trace for rb-tree extent cache ops
      f2fs: support fast lookup in extent cache
      f2fs: switch to check FI_NO_EXTENT in f2fs_{lookup,update}_extent_cache
      f2fs: use extent cache for dir
      f2fs: fix to issue small discard in real-time mode discard
      f2fs: fix to calculate max length of contiguous free slots correctly
      f2fs: fix reference leaks in f2fs_acl_create
      f2fs: fix to truncate inline data past EOF
      f2fs: fix to check current blkaddr in __allocate_data_blocks
      f2fs: set SBI_NEED_FSCK when encountering exception in recovery
      f2fs: split set_data_blkaddr from f2fs_update_extent_cache
      f2fs: introduce __{find,grab}_extent_tree
      f2fs: initialize extent tree with on-disk extent info of inode
      f2fs: preserve extent info for extent cache
      f2fs: preallocate fallocated blocks for direct IO
      f2fs: avoid NULL pointer dereference in f2fs_xattr_advise_get
      f2fs: persist system.advise into on-disk inode
      f2fs: limit b_size of mapped bh in f2fs_map_bh

Jaegeuk Kim (24):
      f2fs: remove obsolete code
      f2fs: avoid wrong error during recovery
      f2fs: support fs shutdown
      f2fs: clear page's up-to-date if block was deallocated
      f2fs: check its block allocation to avoid producing wrong dirty pages
      f2fs: avoid to trigger writepage during POR
      f2fs: clear append/update flags once fsync is done
      f2fs: report -ENOENT for unreached data indices
      f2fs: relocate Kconfig from misc filesystems
      f2fs: fix to cover sentry_lock for block allocation
      f2fs: set buffer_new when new blocks are allocated
      f2fs: enhance multi-threads performance
      f2fs: avoid wrong f2fs_bug_on when truncating inline_data
      f2fs: avoid punch_hole overhead when releasing volatile data
      f2fs: add some tracepoints to debug volatile and atomic writes
      f2fs: fix sparse warnings
      f2fs: fix mismatching lock and unlock pages for roll-forward recovery
      f2fs: add F2FS_INLINE_DOTS to recover missing dot dentries
      f2fs: assign parent's i_mode for empty dir
      f2fs: do not increase link count during recovery
      f2fs: do not recover wrong data index
      f2fs: flush symlink path to avoid broken symlink after POR
      f2fs: avoid abnormal behavior on broken symlink
      f2fs: pass checkpoint reason on roll-forward recovery

Sebastian Andrzej Siewior (1):
      f2fs: add cond_resched() to sync_dirty_dir_inodes()

Taehee Yoo (1):
      f2fs: change 0 to false for bool type

Wanpeng Li (10):
      f2fs: introduce macro __cp_payload
      f2fs: fix the number of orphan inode blocks
      f2fs: fix block_ops trace point
      f2fs: don't need to collect dirty sit entries and flush journal when there's no dirty sit entries
      f2fs: fix max orphan inodes calculation
      f2fs: fix extent cache memory leak
      f2fs: reduce searching region of segmap when set free section
      f2fs: fix unlocked nat set cache operation
      f2fs: enable fast symlink by utilizing inline data
      f2fs: enable inline data by default

Yuan Zhong (2):
      f2fs: set the correct place of initializing *res_page
      f2fs: remove unnecessary condition judgment

 Documentation/filesystems/f2fs.txt |   6 +
 fs/Kconfig                         |   2 +-
 fs/f2fs/Kconfig                    |   2 +-
 fs/f2fs/acl.c                      |  14 +-
 fs/f2fs/checkpoint.c               |  38 +-
 fs/f2fs/data.c                     | 742 +++++++++++++++++++++++++++++++++----
 fs/f2fs/debug.c                    |  22 +-
 fs/f2fs/dir.c                      |  93 +++--
 fs/f2fs/f2fs.h                     | 174 +++++++--
 fs/f2fs/file.c                     |  64 +++-
 fs/f2fs/gc.c                       |   6 +-
 fs/f2fs/inline.c                   |  69 ++--
 fs/f2fs/inode.c                    |  25 +-
 fs/f2fs/namei.c                    |  81 +++-
 fs/f2fs/node.c                     |  18 +-
 fs/f2fs/node.h                     |   1 +
 fs/f2fs/recovery.c                 |  76 ++--
 fs/f2fs/segment.c                  |  17 +-
 fs/f2fs/segment.h                  |   3 +-
 fs/f2fs/super.c                    |  40 +-
 fs/f2fs/xattr.c                    |   4 +-
 include/linux/f2fs_fs.h            |   3 +-
 include/trace/events/f2fs.h        | 162 +++++++-
 23 files changed, 1399 insertions(+), 263 deletions(-)
