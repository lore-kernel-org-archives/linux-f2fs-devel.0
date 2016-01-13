From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v4.5
Date: Wed, 13 Jan 2016 14:23:53 -0800
Message-ID: <20160113222353.GA51737@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull this?

Thanks,

The following changes since commit fb39cbda147082a2e7dc4e2b5f3298448295e3c4:

  Merge branch 'libnvdimm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2015-12-04 11:30:45 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.5

for you to fetch changes up to 447135a86659c646017b8e707c1243c186bf2dff:

  f2fs: should unset atomic flag after successful commit (2016-01-11 15:56:44 -0800)

----------------------------------------------------------------
Regarding to the new features, this patch series adds two ioctls to control
cached data and fragmented files.
And, the other most parts are trying to fix missing error cases and bugs that
we have not covered so far. The specific changes are summarized below.

= Enhancement =
 - support an ioctl to execute online file defragmentation
 - support an ioctl to flush cached data
 - speed up shrinkg extent_cache entries
 - handle broken superblock
 - refector dirty inode management infra
 - revisit f2fs_map_blocks to handle more cases
 - reduce global lock coverage
 - add detecting user's idle time

= Major bug fix =
 - fix data race condition on cached nat entries
 - fix error cases of volatile and atomic writes

----------------------------------------------------------------
Chao Yu (40):
      f2fs: report error of f2fs_create_root_stats
      f2fs: commit atomic written page in LFS mode
      f2fs: support file defragment
      f2fs: fix memory leak of kobject in error path of fill_super
      f2fs: fix to enable missing ioctl interfaces in ->compat_ioctl
      f2fs: fix to remove directory inode from dirty list
      f2fs: clear page uptodate when dropping cache for atomic write
      f2fs: fix to report error in f2fs_readdir
      f2fs: clean up error path in f2fs_readdir
      f2fs: clean up code with __has_cursum_space
      f2fs: clean up argument of recover_data
      f2fs: kill f2fs_drop_largest_extent
      f2fs: use sbi->blocks_per_seg to avoid unnecessary calculation
      f2fs: fix to convert inline inode in ->setattr
      f2fs: clean up node page updating flow
      f2fs: do more integrity verification for superblock
      f2fs: rename {add,remove,release}_dirty_inode to {add,remove,release}_ino_entry
      f2fs: introduce dirty list node in inode info
      f2fs: introduce __remove_dirty_inode
      f2fs: don't grab super block buffer header all the time
      f2fs: introduce __f2fs_commit_super
      f2fs: record dirty status of regular/symlink inode
      f2fs: introduce new option for controlling data flush
      f2fs: stat dirty regular/symlink inodes
      f2fs: support data flush in background
      f2fs: add a tracepoint for sync_dirty_inodes
      f2fs: reduce covered region of sbi->cp_rwsem in f2fs_map_blocks
      f2fs: report error of do_checkpoint
      f2fs: don't convert inline inode when inline_data option is disable
      f2fs: add missing f2fs_balance_fs in __recover_dot_dentries
      f2fs: let user being aware of IO error
      f2fs: clean up f2fs_ioc_write_checkpoint
      f2fs: fix to skip recovering dot dentries in a readonly fs
      f2fs crypto: check CONFIG_F2FS_FS_XATTR for encrypted symlink
      f2fs: introduce max_file_blocks in sbi
      f2fs: check node id earily when readaheading node page
      f2fs: introduce __get_node_page to reuse common code
      f2fs: recognize encrypted data in f2fs_fiemap
      f2fs: use atomic type for node count in extent tree
      f2fs: skip releasing nodes in chindless extent tree

Fan Li (7):
      f2fs: optimize __find_rev_next_bit
      f2fs: write only the pages in range during defragment
      f2fs: fix to update variable correctly when skip a unmapped block
      f2fs: fix to reset variable correctlly
      f2fs: optimize the flow of f2fs_map_blocks
      f2fs: fix bugs and simplify codes of f2fs_fiemap
      f2fs: read isize while holding i_mutex in fiemap

Jaegeuk Kim (37):
      f2fs: avoid deadlock in f2fs_shrink_extent_tree
      f2fs: do not recover from previous remained wrong dnodes
      f2fs: enhance the bit operation for SSR
      f2fs: refactor f2fs_commit_super
      f2fs: use lock_buffer when changing superblock
      f2fs: add symbol to avoid any confusion with tools
      f2fs: relocate tracepoint of write_checkpoint
      f2fs: use atomic variable for total_extent_tree
      f2fs: speed up shrinking extent tree entries
      f2fs: check inline_data flag at converting time
      f2fs: avoid unnecessary f2fs_gc for dir operations
      f2fs: record node block allocation in dnode_of_data
      f2fs: call f2fs_balance_fs only when node was changed
      f2fs: introduce prepare_write_begin to clean up
      f2fs: return early when trying to read null nid
      f2fs: avoid f2fs_lock_op in f2fs_write_begin
      f2fs: declare static function
      f2fs: early check broken symlink length in the encrypted case
      f2fs: use i_size_read to get i_size
      f2fs: load largest extent all the time
      f2fs: fix f2fs_ioc_abort_volatile_write
      f2fs: remove f2fs_bug_on in terms of max_depth
      f2fs: write pending bios when cp_error is set
      f2fs: use IPU for fdatasync
      f2fs: monitor zombie_tree count
      f2fs: introduce zombie list for fast shrinking extent trees
      f2fs: cover more area with nat_tree_lock
      Revert "f2fs: check the node block address of newly allocated nid"
      f2fs: check the page status filled from disk
      f2fs: avoid unnecessary f2fs_balance_fs calls
      f2fs: remove redundant calls
      f2fs: clean up f2fs_balance_fs
      f2fs: introduce time and interval facility
      f2fs: detect idle time depending on user behavior
      f2fs: monitor the number of background checkpoint
      f2fs: fix wrong memory condition check
      f2fs: should unset atomic flag after successful commit

Masanari Iida (1):
      Doc: f2fs: Fix typos in Documentation/filesystems/f2fs.txt

Yunlei He (2):
      f2fs: backup raw_super in sbi
      f2fs: add a max block check for get_data_block_bmap

 Documentation/ABI/testing/sysfs-fs-f2fs |   6 +
 Documentation/filesystems/f2fs.txt      |  10 +-
 fs/f2fs/checkpoint.c                    | 177 ++++++++-------
 fs/f2fs/data.c                          | 377 ++++++++++++++++++--------------
 fs/f2fs/debug.c                         |  29 ++-
 fs/f2fs/dir.c                           |  38 ++--
 fs/f2fs/extent_cache.c                  | 122 ++++++-----
 fs/f2fs/f2fs.h                          | 142 ++++++++----
 fs/f2fs/file.c                          | 344 +++++++++++++++++++++++------
 fs/f2fs/gc.c                            |   9 +-
 fs/f2fs/gc.h                            |   8 -
 fs/f2fs/inline.c                        |   9 +-
 fs/f2fs/inode.c                         |  28 +--
 fs/f2fs/namei.c                         |  59 +++--
 fs/f2fs/node.c                          | 170 +++++++-------
 fs/f2fs/node.h                          |   6 +-
 fs/f2fs/recovery.c                      |  40 +++-
 fs/f2fs/segment.c                       | 122 +++++------
 fs/f2fs/shrinker.c                      |   3 +-
 fs/f2fs/super.c                         | 253 +++++++++++++++------
 fs/f2fs/xattr.c                         |   3 +-
 include/linux/f2fs_fs.h                 |   3 +-
 include/trace/events/f2fs.h             |  38 ++++
 23 files changed, 1266 insertions(+), 730 deletions(-)
