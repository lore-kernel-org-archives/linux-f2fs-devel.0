From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v4.3
Date: Wed, 2 Sep 2015 11:53:44 -0700
Message-ID: <20150902185202.GA40646@jaegeuk-mac02.mot.com>
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

The following changes since commit 6c84461c0cb0db3f4f56695ac9944451b34bf431:

  Merge tag 'pci-v4.2-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2015-08-04 09:27:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.3

for you to fetch changes up to 01a5ad827a36e36f45e1fdb96903ea115f759865:

  f2fs: upset segment_info repair (2015-09-01 14:45:27 -0700)

----------------------------------------------------------------
The major work includes fixing and enhancing the existing extent_cache feature,
which has been well settling down so far and now it becomes a default mount
option accordingly.

Also, this version newly registers a f2fs memory shrinker to reclaim several
objects consumed by a couple of data structures in order to avoid memory
pressures.

Another new feature is to add ioctl(F2FS_GARBAGE_COLLECT) which triggers a
cleaning job explicitly by users.

Most of the other patches are to fix bugs occurred in the corner cases across
the whole code area.

----------------------------------------------------------------
Chao Yu (43):
      f2fs: fix to record dirty page count for symlink
      MAINTAINERS: add missed trace file for f2fs
      f2fs: restrict multimedia filename
      f2fs: enhance multithread performance
      f2fs: fix to update page flag
      f2fs: maintain extent cache in separated file
      f2fs: add new ioctl F2FS_IOC_GARBAGE_COLLECT
      f2fs: warm up cold page after mmaped write
      f2fs: cleanup write_orphan_inodes
      f2fs: correct return value of ->setxattr
      f2fs: expose f2fs_write_cache_pages
      f2fs: stat inline xattr inode number
      f2fs: use atomic_t to record hit ratio info of extent cache
      f2fs: reduce region of cp_rwsem covered in f2fs_do_collapse
      f2fs: fix double lock in handle_failed_inode
      f2fs: skip writing in ->writepages when no dirty pages exist
      f2fs: fix to wait all atomic written pages writeback
      f2fs: convert inline data before set atomic/volatile flag
      f2fs: fix inline data/dentry stat number leak
      f2fs: fix to build free nids from readaheaded nat pages
      f2fs: freeze filesystem when fail to update meta page due to IO error
      f2fs: fix to release inode page correctly
      f2fs: invalidate temporary meta page
      f2fs: recover invalid/reserved block address for fsynced file
      f2fs: report error of fill_zero
      f2fs: report EINVAL for unalignment direct IO
      f2fs: remove inmem radix tree
      f2fs: handle error of f2fs_iget correctly
      MAINTAINERS: add myself as a dedicated reviewer of f2fs
      f2fs: avoid clear valid page
      f2fs: shrink free_nids entries
      f2fs: add annotation for space utilization of regular/inline dentry
      f2fs: fix incorrect mapping for bmap
      f2fs: add largest/cached stat in extent cache
      f2fs: adjust showing of extent cache stat
      f2fs: kill dead code in __insert_extent_tree
      f2fs: split __insert_extent_tree_ret for readability
      f2fs: lookup neighbor extent nodes for merging later
      f2fs: avoid unneeded initializing when converting inline dentry
      f2fs: handle f2fs_truncate error correctly
      f2fs: fix to release inode correctly
      f2fs: update extent tree in batches
      f2fs: avoid accessing NULL pointer in f2fs_drop_largest_extent

Fan Li (5):
      f2fs: don't try to split extents shorter than F2FS_MIN_EXTENT_LEN
      f2fs: add new interfaces for extent tree
      f2fs: change the timing of f2fs_wait_on_page_writeback
      f2fs: use extent cache to optimize f2fs_reserve_block
      f2fs: fix to update cached_en of extent tree properly

Jaegeuk Kim (30):
      f2fs: avoid freed stat information
      f2fs: avoid to use failed inode immediately
      f2fs: convert inline_data for various fallocate
      f2fs: fix wrong block address calculation for a split extent
      f2fs: update on-disk extents even under extent_cache
      f2fs: set cached_en after checking finally
      f2fs: introduce a shrinker for mounted fs
      f2fs: shrink nat_cache entries
      f2fs: shrink extent_cache entries
      f2fs: add noextent_cache mount option
      f2fs: use extent_cache by default
      f2fs: check the largest extent at look-up time
      f2fs: shrink unreferenced extent_caches first
      f2fs: use a page temporarily for encrypted gced page
      f2fs: callers take care of the page from bio error
      f2fs: handle error cases in commit_inmem_pages
      f2fs: do not assign a new segment for dio under space shortage
      f2fs: avoid a build warning
      f2fs: do not write any node pages related to orphan inodes
      f2fs: skip checkpoint if there is no dirty and prefree segments
      f2fs: increase the number of max hard links
      f2fs: handle failed bio allocation
      f2fs: avoid garbage collecting already moved node blocks
      f2fs: reuse nids more aggressively
      f2fs: fix to cover lock_op for update_inode_page
      f2fs: retry gc if one section is not successfully reclaimed
      f2fs: go out for insert_inode_locked failure
      f2fs: check the node block address of newly allocated nid
      f2fs: use __GFP_NOFAIL to avoid infinite loop
      f2fs: fix wrong pointer access during try_to_free_nids

Junesung Lee (1):
      f2fs: fix typo

Liu Xue (1):
      f2fs: unify f2fs_bug_on when check blocks and segment

Markus Elfring (1):
      f2fs crypto: delete an unnecessary check before the function call "key_put"

Nicholas Krause (1):
      f2fs: make the function check_dnode have a return type of bool and change it's name to is_alive

Tiezhu Yang (1):
      f2fs: optimize f2fs_write_cache_pages

Yunlei He (1):
      f2fs: upset segment_info repair

Zhang Zhen (1):
      f2fs: atomically set inode->i_flags

 Documentation/filesystems/f2fs.txt |   4 +-
 MAINTAINERS                        |   2 +
 fs/f2fs/Kconfig                    |   2 +-
 fs/f2fs/Makefile                   |   1 +
 fs/f2fs/checkpoint.c               |  93 ++--
 fs/f2fs/crypto_key.c               |   3 +-
 fs/f2fs/data.c                     | 953 +++++++++----------------------------
 fs/f2fs/debug.c                    |  30 +-
 fs/f2fs/dir.c                      |   4 +-
 fs/f2fs/extent_cache.c             | 791 ++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h                     | 134 ++++--
 fs/f2fs/file.c                     | 185 +++++--
 fs/f2fs/gc.c                       |  81 ++--
 fs/f2fs/gc.h                       |   6 +
 fs/f2fs/inline.c                   |  23 +-
 fs/f2fs/inode.c                    |  97 ++--
 fs/f2fs/namei.c                    |  21 +-
 fs/f2fs/node.c                     |  86 +++-
 fs/f2fs/recovery.c                 |  43 +-
 fs/f2fs/segment.c                  |  78 +--
 fs/f2fs/segment.h                  |  55 +--
 fs/f2fs/shrinker.c                 | 139 ++++++
 fs/f2fs/super.c                    |  65 ++-
 fs/f2fs/xattr.c                    |   5 +-
 include/linux/f2fs_fs.h            |  16 +-
 include/trace/events/f2fs.h        |  12 +-
 26 files changed, 1903 insertions(+), 1026 deletions(-)
 create mode 100644 fs/f2fs/extent_cache.c
 create mode 100644 fs/f2fs/shrinker.c
