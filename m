From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [GIT PULL] f2fs updates for v3.15
Date: Mon, 07 Apr 2014 13:19:34 +0900
Message-ID: <1396844374.24638.9.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, "Linux FS DEV, Mailing List" <linux-fsdevel@vger.kernel.org>, "Linux Kernel, Mailing List" <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

This is a pull request on f2fs updates for v3.15.

In this round, a couple of sysfs entries were introduced to tune the
f2fs at runtime. In addition, f2fs starts to support large directory and
f2fs_issue_flush thread to improve the performance under some server
workloads.
Most of the other patches are related to bug fixes and clean-ups.

Thank you very much.

The following changes since commit
6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
tags/for-f2fs-3.15

for you to fetch changes up to 48b230a583965d33c32b4e3c29a1e5e15d7e55de:

  f2fs: fix wrong statistics of inline data (2014-04-07 12:40:58 +0900)

----------------------------------------------------------------
f2fs updates for v3.15

This patch-set includes the following major enhancement patches.
 o introduce large directory support
 o introduce f2fs_issue_flush to merge redundant flush commands
 o merge write IOs as much as possible aligned to the segment
 o add sysfs entries to tune the f2fs configuration
 o use radix_tree for the free_nid_list to reduce in-memory operations
 o remove costly bit operations in f2fs_find_entry
 o enhance the readahead flow for CP/NAT/SIT/SSA blocks

The other bug fixes are as follows.
 o recover xattr node blocks correctly after sudden-power-cut
 o fix to calculate the maximum number of node ids
 o enhance to handle many error cases

And, there are a bunch of cleanups.

----------------------------------------------------------------
Changman Lee (1):
      f2fs: show counts of checkpoint in status

Chao Yu (18):
      f2fs: use inode mutex to keep atomicity of f2fs_falloc
      f2fs: introduce ra_meta_pages to readahead CP/NAT/SIT pages
      f2fs: readahead contiguous SSA blocks for f2fs_gc
      f2fs: use existing macro to clean up some codes
      f2fs: fix dirty page accounting when redirty
      f2fs: recover inline xattr data in roll-forward process
      f2fs: introduce f2fs_has_inline_xattr for better readability
      f2fs: check upper bound of ino value in f2fs_nfs_get_inode
      f2fs: print type for each segment in segment_info's show
      f2fs: introduce f2fs_has_xattr_block for better readability
      f2fs: avoid to return incorrect errno of read_normal_summaries
      f2fs: fix incorrect parsing with option string
      f2fs: avoid unnecessary bio submit when wait page writeback
      f2fs: avoid unneeded lookup when xattr name length is too long
      f2fs: avoid free slab cache under spinlock
      f2fs: use list_for_each_entry{_safe} for simplyfying code
      f2fs: fix error path when fail to read inline data
      f2fs: fix wrong statistics of inline data

Gu Zheng (5):
      f2fs: introduce help macro on_build_free_nids()
      f2fs: update start nid only once each circle
      f2fs: remove the unused ctor argument of f2fs_kmem_cache_create()
      f2fs: format segment_info's show for better legibility
      f2fs: optimize restore_node_summary slightly

Jaegeuk Kim (37):
      f2fs: update_inode_page should be done all the time
      f2fs: handle dirty segments inside refresh_sit_entry
      f2fs: fix to recover xattr node block
      f2fs: remove the ugly pointer conversion
      f2fs: fix the potential mismatch between dir's i_size and i_blocks
      f2fs: clean up with a macro
      f2fs: fix a build warning
      f2fs: fix to truncate dentry pages in the error case
      f2fs: fix f2fs_write_meta_page at no checkpoint status
      f2fs: clean up redundant function call
      f2fs: fix the calculation of max_nids
      f2fs: fix not to write data pages on the page reclaiming path
      f2fs: fix to do build_stat prior to the recovery procedure
      f2fs: fix to mark the checkpointed nat entry correctly
      f2fs: introduce a radix_tree for the free_nid list
      f2fs: implement a lock-free stat_show
      f2fs: remove costly bit operations for f2fs_find_entry
      f2fs: introduce large directory support
      f2fs: add an sysfs entry to control the directory level
      f2fs: fix to write node pages with WRITE_SYNC
      f2fs: fix wrong kernel coding style
      f2fs: introduce get_dirty_dents for readability
      f2fs: avoid small data writes by skipping writepages
      f2fs: increase pages_skipped when skipping writepages
      f2fs: introduce nr_pages_to_write for segment alignment
      f2fs: call f2fs_wait_on_page_writeback instead of native function
      f2fs: avoid to drop nat entries due to the negative nr_shrink
      f2fs: throttle the memory footprint with a sysfs entry
      f2fs: remove unnecessary threshold
      f2fs: add missing documentation for dir_level
      f2fs: change reclaim rate in percentage
      f2fs: introduce fi->i_sem to protect fi's info
      f2fs: skip unnecessary node writes during fsync
      f2fs: avoid RECLAIM_FS-ON-W warning
      f2fs: return -EIO when node id is not matched
      f2fs: fix to cover io->bio with io_rwsem
      f2fs: introduce f2fs_issue_flush to avoid redundant flush issue

ZhangZhen (1):
      f2fs: check the acl's validity before setting

 Documentation/ABI/testing/sysfs-fs-f2fs |  12 ++
 Documentation/filesystems/f2fs.txt      |  29 ++-
 fs/f2fs/acl.c                           |   8 +-
 fs/f2fs/checkpoint.c                    | 208 ++++++++++++++------
 fs/f2fs/data.c                          | 106 +++++-----
 fs/f2fs/debug.c                         |  12 +-
 fs/f2fs/dir.c                           |  85 ++++----
 fs/f2fs/f2fs.h                          | 105 +++++++---
 fs/f2fs/file.c                          |  31 ++-
 fs/f2fs/gc.c                            |  16 +-
 fs/f2fs/inline.c                        |   4 +-
 fs/f2fs/inode.c                         |  27 ++-
 fs/f2fs/namei.c                         |   9 +
 fs/f2fs/node.c                          | 334
+++++++++++++++++++-------------
 fs/f2fs/node.h                          |  25 ++-
 fs/f2fs/recovery.c                      |  37 ++--
 fs/f2fs/segment.c                       | 222 ++++++++++++++-------
 fs/f2fs/segment.h                       |  75 ++++---
 fs/f2fs/super.c                         |  97 ++++++----
 fs/f2fs/xattr.c                         |   7 +-
 include/linux/f2fs_fs.h                 |   2 +-
 21 files changed, 939 insertions(+), 512 deletions(-)


-- 
Jaegeuk Kim
Samsung

