From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v3.20
Date: Thu, 12 Feb 2015 13:56:36 -0800
Message-ID: <20150212215636.GA99961@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

This patch-set consists of mostly clean-ups and bug fixes. Some of them refactor
old codes too.
Please, pull the following patches.

Thank you,

The following changes since commit b3d574aec7e7aa3ed545d7faf2b2cbaa8db4ce22:

  Merge branch 'akpm' (patches from Andrew) (2015-01-09 15:10:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-3.20

for you to fetch changes up to 1a118ccfd60fc78e64c0a3ab9e85075545839d6e:

  f2fs: use spinlock for segmap_lock instead of rwlock (2015-02-11 17:04:51 -0800)

----------------------------------------------------------------
Major changes are to:
 o add f2fs_io_tracer and F2FS_IOC_GETVERSION
 o fix wrong acl assignment from parent
 o fix accessing wrong data blocks
 o fix wrong condition check for f2fs_sync_fs
 o align start block address for direct_io
 o add and refactor the readahead flows of FS metadata
 o refactor atomic and volatile write policies

And most of patches are for clean-ups and minor bug fixes.

----------------------------------------------------------------
Changman Lee (1):
      f2fs: add block count by in-place-update in stat info

Chao Yu (18):
      f2fs: readahead contiguous current summary blocks in checkpoint
      f2fs: merge two uchar variable in struct node_info to reduce memory cost
      f2fs: use ra_meta_pages to simplify readahead code in restore_node_summary
      f2fs: cleanup trace event of f2fs_submit_page_{m,}bio with DECLARE_EVENT_CLASS
      f2fs: cleanup parameters for trace_f2fs_submit_{read_,write_,page_,page_m}bio with fio
      f2fs: reuse inode_entry_slab in gc procedure for using slab more effectively
      f2fs: get rid of kzalloc in __recover_inline_status
      f2fs: fix wrong memory footprint statistics in debugfs
      f2fs: fix to release count of meta page in ->invalidatepage
      f2fs: add F2FS_IOC_GETVERSION support
      f2fs: use f2fs_radix_tree_insert to clean codes
      f2fs: make truncate_inline_date static
      f2fs: clean up {in,de}create_sleep_time
      f2fs: merge flags in struct f2fs_sb_info
      f2fs: merge {invalidate,release}page for meta/node/data pages
      f2fs: fix to use highmem for pages of newly created directory
      f2fs: avoid data offset overflow when lseeking huge file
      f2fs: use spinlock for segmap_lock instead of rwlock

Jaegeuk Kim (43):
      f2fs: remove checking dirty_exceed
      f2fs: fix wrong condition check to trigger f2fs_sync_fs
      f2fs: don't need to call lock_op and lock_page for abort
      f2fs: change atomic and volatile write policies
      f2fs: fix small discards not to issue redundantly
      f2fs: remove unnecessary call to invalidate inmemory pages
      f2fs: use missing the use of f2fs_kunmap_page
      f2fs: use f2fs_io_info to clean up messy parameters during IO path
      f2fs: add f2fs_io_tracer support
      f2fs: add key functions for f2fs_io_tracer
      f2fs: activate f2fs_trace_pid
      f2fs: activate f2fs_trace_ios
      f2fs: avoid double lock for cp_rwsem
      f2fs: fix missing cold bit during recovery
      f2fs: clean up to remove parameter
      f2fs: avoid potential unnecessary codes
      f2fs: remove uncovered code path
      f2fs: align direct_io'ed data to section
      f2fs: fix wrong unlock_page call
      f2fs: free radix_tree_nodes used by nat_set entries
      f2fs: add nat/sit entries into status
      f2fs: add spin_lock to cover radix operations in IO tracer
      f2fs: add f2fs_destroy_trace_ios to free radix tree
      f2fs: avoid infinite loop on cp_error
      f2fs: update memory footprint information
      f2fs: trigger correct checkpoint during umount
      f2fs: do checkpoint when umount flag is not set
      f2fs: leave comment for code readability
      f2fs: fix not to drop mount options when retrying fill_super
      f2fs: support norecovery mount option
      f2fs: avoid write_checkpoint if f2fs is mounted readonly
      f2fs: split UMOUNT and FASTBOOT flags
      f2fs: should fail mount when trying to recover data on read-only dev
      f2fs: keep PagePrivate during releasepage
      f2fs: show the number of writeback pages in stat
      f2fs: introduce a batched trim
      f2fs: check node page contents all the time
      f2fs: call set_buffer_new for get_block
      f2fs: introduce macros to convert bytes and blocks in f2fs
      f2fs: allocate data blocks in advance for f2fs_direct_IO
      f2fs: fix sparse warnings
      f2fs: avoid variable length array
      f2fs: fix accessing wrong indexed data blocks

Kinglong Mee (1):
      f2fs: fix a bug of inheriting default ACL from parent

kbuild test robot (1):
      f2fs: pids_lock can be static

 Documentation/ABI/testing/sysfs-fs-f2fs |   6 +
 Documentation/filesystems/f2fs.txt      |   6 +
 fs/f2fs/Kconfig                         |  10 ++
 fs/f2fs/Makefile                        |   1 +
 fs/f2fs/acl.c                           |   6 +-
 fs/f2fs/checkpoint.c                    |  95 ++++++++------
 fs/f2fs/data.c                          | 218 +++++++++++++++++++++-----------
 fs/f2fs/debug.c                         |  59 ++++++---
 fs/f2fs/dir.c                           |   3 +-
 fs/f2fs/f2fs.h                          | 120 +++++++++++++-----
 fs/f2fs/file.c                          | 100 +++++++++++++--
 fs/f2fs/gc.c                            |  38 ++----
 fs/f2fs/gc.h                            |  33 ++---
 fs/f2fs/inline.c                        |  32 ++---
 fs/f2fs/inode.c                         |  37 +++---
 fs/f2fs/namei.c                         |   2 +-
 fs/f2fs/node.c                          | 154 ++++++++++------------
 fs/f2fs/node.h                          |  45 +++++--
 fs/f2fs/recovery.c                      |  11 +-
 fs/f2fs/segment.c                       | 194 ++++++++++++++++------------
 fs/f2fs/segment.h                       |  29 +++--
 fs/f2fs/super.c                         |  75 ++++++++---
 fs/f2fs/trace.c                         | 159 +++++++++++++++++++++++
 fs/f2fs/trace.h                         |  46 +++++++
 include/linux/f2fs_fs.h                 |   7 +
 include/trace/events/f2fs.h             | 148 ++++++++++------------
 26 files changed, 1075 insertions(+), 559 deletions(-)
 create mode 100644 fs/f2fs/trace.c
 create mode 100644 fs/f2fs/trace.h
