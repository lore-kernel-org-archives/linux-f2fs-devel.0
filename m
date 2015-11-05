From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v4.4
Date: Thu, 5 Nov 2015 10:22:53 -0800
Message-ID: <20151105182253.GA86148@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull the below f2fs updates?

Thank you so much,

The following changes since commit c6fa8e6de3dc420cba092bf155b2ed25bcd537f7:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2015-10-07 18:17:46 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.4

for you to fetch changes up to beaa57dd986d4f398728c060692fc2452895cfd8:

  f2fs: fix to skip shrinking extent nodes (2015-10-22 09:39:35 -0700)

----------------------------------------------------------------
Most part of the patches include enhancing the stability and performance of
in-memory extent caches feature.

In addition, it introduces several new features and configurable points:
 - F2FS_GOING_DOWN_METAFLUSH ioctl to test power failures
 - F2FS_IOC_WRITE_CHECKPOINT ioctl to trigger checkpoint by users
 - background_gc=sync mount option to do gc synchronously
 - periodic checkpoints
 - sysfs entry to control readahead blocks for free nids

And the following bug fixes have been merged.
- fix SSA corruption by collapse/insert_range
- correct a couple of gc behaviors
- fix the results of f2fs_map_blocks
- fix error case handling of volatile/atomic writes

----------------------------------------------------------------
Chao Yu (28):
      f2fs: trace in batches extent info update
      f2fs: verify file type early in f2fs_fallocate
      f2fs: fix incorrect searching position when shrinking extent cache
      f2fs: fix overflow of size calculation
      f2fs: reorganize f2fs_map_blocks
      f2fs: do in batches truncation in truncate_hole
      f2fs: fix to handle io error in ->direct_IO
      f2fs: use correct flag in f2fs_map_blocks()
      f2fs: disallow switch extent_cache option dynamically
      f2fs: introduce __try_update_largest_extent
      f2fs: fix incorrect bimodal calculation
      f2fs: remove unneeded f2fs_{,un}lock_op in do_recover_data()
      f2fs: fix to update {m,c}time correctly when truncating larger
      f2fs: fix to correct freed section number during gc
      f2fs: use atomic64_t for extent cache hit stat
      f2fs: fix to avoid redundant searching in dirty map during gc
      f2fs: skip searching dirty map if dirty segment is not exist
      f2fs: support synchronous gc in ioctl
      f2fs: introduce a new ioctl F2FS_IOC_WRITE_CHECKPOINT
      f2fs: add a tracepoint for f2fs_read_data_pages
      f2fs: don't tag REQ_META for temporary non-meta pages
      f2fs: support lower priority asynchronous readahead in ra_meta_pages
      f2fs: readahead for free nids building
      f2fs: export ra_nid_pages to sysfs
      f2fs crypto: fix racing of accessing encrypted page among
      f2fs: fix to clear GCed flag for atomic written page
      f2fs: fix error path of ->symlink
      f2fs: fix to skip shrinking extent nodes

Fan Li (2):
      f2fs: drop largest extent by range
      f2fs: optimize code of f2fs_update_extent_tree_range

Jaegeuk Kim (22):
      f2fs: cover number of dirty node pages under node_write lock
      f2fs: no need to lock for update_inode_page all the time
      f2fs: declare f2fs_update_extent_tree_range as static
      f2fs crypto: allocate buffer for decrypting filename
      f2fs: check end_io for metapages before making next checkpoint blocks
      f2fs: do not skip dentry block writes
      f2fs: should get a victim from retrials
      f2fs: use vmalloc to handle -ENOMEM error
      f2fs: introduce background_gc=sync mount option
      f2fs: add a tracepoint for background gc
      f2fs: introduce a periodic checkpoint flow
      f2fs: merge meta writes as many possible
      f2fs: add F2FS_GOING_DOWN_METAFLUSH to test power-failure
      Revert "f2fs: do not skip dentry block writes"
      f2fs: fix SSA updates resulting in corruption
      f2fs: set GFP_NOFS for grab_cache_page
      f2fs: relocate the tracepoint for background_gc
      f2fs: flush dirty data for bmap
      f2fs: support fiemap for inline_data
      f2fs: refactor __find_rev_next_{zero}_bit
      f2fs: fix leakage of inmemory atomic pages
      f2fs: don't need to submit bio on error case

Nicholas Krause (2):
      f2fs: fix incorrect return statement in the function f2fs_ioc_release_volatile_write
      f2fs: fix error handling for calls to various functions in the function recover_inline_data

 Documentation/ABI/testing/sysfs-fs-f2fs |  12 ++
 Documentation/filesystems/f2fs.txt      |   3 +-
 fs/f2fs/checkpoint.c                    |  49 ++++-
 fs/f2fs/data.c                          | 176 ++++++++++-------
 fs/f2fs/debug.c                         |  36 ++--
 fs/f2fs/dir.c                           |  19 +-
 fs/f2fs/extent_cache.c                  | 195 ++++++++-----------
 fs/f2fs/f2fs.h                          |  86 +++++++--
 fs/f2fs/file.c                          | 327 ++++++++++++++++----------------
 fs/f2fs/gc.c                            |  77 +++++---
 fs/f2fs/gc.h                            |   6 -
 fs/f2fs/inline.c                        |  42 +++-
 fs/f2fs/inode.c                         |   8 +-
 fs/f2fs/namei.c                         |  19 +-
 fs/f2fs/node.c                          |  26 ++-
 fs/f2fs/node.h                          |   4 +-
 fs/f2fs/recovery.c                      |  15 +-
 fs/f2fs/segment.c                       | 206 ++++++++++++--------
 fs/f2fs/segment.h                       |   4 +-
 fs/f2fs/super.c                         |  37 +++-
 include/trace/events/f2fs.h             |  69 ++++++-
 21 files changed, 869 insertions(+), 547 deletions(-)
