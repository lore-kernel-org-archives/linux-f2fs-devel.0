From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs update for 4.10
Date: Mon, 12 Dec 2016 14:15:48 -0800
Message-ID: <20161212221548.GA4001@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit ded9b5dd205ef04aa095c3b731c635b201191a59:

  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2016-11-23 08:09:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.10

for you to fetch changes up to c0ed4405a99ec9be2a0f062eaafc002d8d26c99f:

  f2fs: fix a missing size change in f2fs_setattr (2016-12-12 11:09:05 -0800)

----------------------------------------------------------------
for-f2fs-4.10

This patch series contains several performance tuning patches regarding to the
IO submission flow, in addition to supporting new features such as a ZBC-base
drive and multiple devices.

It also includes some major bug fixes such as:
 - checkpoint version control
 - fdatasync-related roll-forward recovery routine
 - memory boundary or null-pointer access in corner cases
 - missing error cases

It has various minor clean-up patches as well.

----------------------------------------------------------------
Arnd Bergmann (2):
      f2fs: hide a maybe-uninitialized warning
      f2fs: fix 32-bit build

Chao Yu (21):
      f2fs: exclude free nids building and allocation
      f2fs: fix to release discard entries during checkpoint
      f2fs: give a chance to detach from dirty list
      f2fs: add missing f2fs_balance_fs in f2fs_zero_range
      f2fs: don't miss any f2fs_balance_fs cases
      f2fs: be aware of extent beyond EOF in fiemap
      f2fs: fix to update largest extent under lock
      f2fs: fix error handling in fsync_node_pages
      f2fs: clear nlink if fail to add_link
      f2fs: split free nid list
      f2fs: don't interrupt free nids building during nid allocation
      f2fs: avoid casted negative value as shrink count
      f2fs: report error of f2fs_fill_dentries
      f2fs: record inode updating status correctly
      f2fs: fix wrong i_atime recovery
      Revert "f2fs: do not recover from previous remained wrong dnodes"
      f2fs: don't wait writeback for datas during checkpoint
      f2fs: fix to account total free nid correctly
      f2fs: fix fdatasync
      f2fs: fix incorrect free inode count in ->statfs
      f2fs: return AOP_WRITEPAGE_ACTIVATE for writepage

Damien Le Moal (9):
      f2fs: Add missing break in switch-case
      f2fs: Use generic zoned block device terminology
      f2fs: Check zoned block feature for host-managed zoned block devices
      f2fs: Suppress discard warning message for zoned block devices
      f2fs: Always enable discard for zoned blocks devices
      f2fs: Do not allow adaptive mode for host-managed zoned block devices
      f2fs: Cache zoned block devices zone type
      f2fs: Reset sequential zones on zoned block devices
      f2fs: Trace reset zone events

Eric Biggers (1):
      f2fs: fix sparse warnings

Geliang Tang (1):
      f2fs: drop duplicate header timer.h

Jaegeuk Kim (28):
      f2fs: fix overflow due to condition check order
      f2fs: clean up free nid list operations
      f2fs: count dirty inodes to flush node pages during checkpoint
      f2fs: call f2fs_balance_fs for setattr
      f2fs: declare static function for __build_free_nids
      f2fs: use BIO_MAX_PAGES for bio allocation
      f2fs: keep dirty inodes selectively for checkpoint
      f2fs: make clean inodes when flushing inode page
      f2fs: remove percpu_count due to performance regression
      f2fs: avoid infinite loop in the EIO case on recover_orphan_inodes
      f2fs: assign segments correctly for direct_io
      f2fs: remove checkpoint in f2fs_freeze
      f2fs: revert segment allocation for direct IO
      f2fs: allow dio read for LFS mode
      f2fs: support multiple devices
      f2fs: use err for f2fs_preallocate_blocks
      f2fs: fix redundant block allocation
      f2fs: avoid BG_GC in f2fs_balance_fs
      f2fs: fix wrong written_valid_blocks counting
      f2fs: do not recover i_size if it's valid
      f2fs: fix wrong AUTO_RECOVER condition
      f2fs: fix to determine start_cp_addr by sbi->cur_cp_pack
      f2fs: do not activate auto_recovery for fallocated i_size
      Revert "f2fs: use percpu_counter for # of dirty pages in inode"
      f2fs: call sync_fs when f2fs is idle
      f2fs: detect wrong layout
      f2fs: free meta pages if sanity check for ckpt is failed
      f2fs: fix to access nullified flush_cmd_control pointer

Nicolai Stange (1):
      f2fs: set ->owner for debugfs status file's file_operations

Yunlei He (3):
      f2fs: return directly if block has been removed from the victim
      f2fs: fix an infinite loop when flush nodes in cp
      f2fs: fix a missing size change in f2fs_setattr

 fs/f2fs/acl.c               |   2 +-
 fs/f2fs/checkpoint.c        |  34 ++++--
 fs/f2fs/data.c              | 192 ++++++++++++++++++++----------
 fs/f2fs/debug.c             |  29 +++--
 fs/f2fs/dir.c               |  30 +++--
 fs/f2fs/extent_cache.c      |   2 +-
 fs/f2fs/f2fs.h              | 197 +++++++++++++++++++++----------
 fs/f2fs/file.c              |  67 ++++++-----
 fs/f2fs/gc.c                |  29 +++--
 fs/f2fs/inline.c            |  14 ++-
 fs/f2fs/inode.c             |  47 ++++++--
 fs/f2fs/namei.c             |   6 +-
 fs/f2fs/node.c              | 226 +++++++++++++++++++++--------------
 fs/f2fs/node.h              |  13 +-
 fs/f2fs/recovery.c          |  46 ++------
 fs/f2fs/segment.c           | 236 +++++++++++++++++++++++++++----------
 fs/f2fs/segment.h           |  28 ++---
 fs/f2fs/shrinker.c          |  10 +-
 fs/f2fs/super.c             | 281 +++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/xattr.c             |   4 +-
 include/linux/f2fs_fs.h     |  10 +-
 include/trace/events/f2fs.h |  21 ++++
 22 files changed, 1048 insertions(+), 476 deletions(-)
