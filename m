From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [GIT PULL] f2fs updates for v3.13
Date: Mon, 11 Nov 2013 21:12:27 +0900
Message-ID: <1384171947.14041.95.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Linux Kernel, Mailing List" <linux-kernel@vger.kernel.org>, "Linux FS DEV, Mailing List" <linux-fsdevel@vger.kernel.org>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

This is a pull request on f2fs updates for v3.13.

In this round, a couple of patches were introduced to improve GC and
checkpoint overheads.
In addition, a sysfs entry and some tracepoints were added for users to
maintain the f2fs filesystem.
And there are a number of clean-ups and bug fixes.

Thank you very much.

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-3.13

for you to fetch changes up to 29e59c14ae5c21d25db1580d9651b5855d656a30:

  f2fs: issue more large discard command (2013-11-11 09:36:32 +0900)

----------------------------------------------------------------
f2fs updates for v3.13

This patch-set includes the following major enhancement patches.
o add a sysfs to control reclaiming free segments
o enhance the f2fs global lock procedures
o enhance the victim selection flow
o wait for selected node blocks during fsync
o add some tracepoints
o add a config to remove abundant BUG_ONs

The other bug fixes are as follows.
o fix deadlock on acl operations
o fix some bugs with respect to orphan inodes

And, there are a bunch of cleanups.

----------------------------------------------------------------
Changman Lee (3):
      f2fs: remove unnecessary segment bitmap updates
      f2fs: cleanup waiting routine for writeback pages in cp
      f2fs: issue more large discard command

Chao Yu (8):
      f2fs: avoid allocating failure in bio_alloc
      f2fs: remove unneeded write checkpoint in recover_fsync_data
      f2fs: remove redundant set_page_dirty from write_compacted_summaries
      f2fs: fix calculating incorrect free size when update xattr in __f2fs_setxattr
      f2fs: check all ones or zeros bitmap with bitops for better mount performance
      f2fs: remove unnecessary TestClearPageError when wait pages writeback
      f2fs: avoid to use a NULL point in destroy_segment_manager
      f2fs: fix memory leak after kobject init failed in fill_super

Fan Li (1):
      f2fs: change the method of calculating the number summary blocks

Gu Zheng (4):
      f2fs: use rw_sem instead of fs_lock(locks mutex)
      f2fs: introduce function read_raw_super_block()
      f2fs: avoid wait if IO end up when do_checkpoint for better performance
      f2fs: introduce f2fs_kmem_cache_alloc to hide the unfailed, kmem cache allocation

Haicheng Li (3):
      f2fs: use true and false for boolean value
      f2fs: no need to check other dirty_segmap when the seg has been found
      f2fs: use bool for booleans

Jaegeuk Kim (17):
      f2fs: avoid unnecessary checkpoints
      f2fs: fix writing incorrect orphan blocks
      f2fs: fix to store and retrieve i_rdev correctly
      f2fs: fix the starvation problem on cp_rwsem
      f2fs: avoid to write during the recovery
      f2fs: clean up several status-related operations
      f2fs: reclaim prefree segments periodically
      f2fs: introduce f2fs_balance_fs_bg for some background jobs
      f2fs: add reclaiming control by sysfs
      f2fs: add tracepoint for set_page_dirty
      f2fs: add tracepoint for vm_page_mkwrite
      f2fs: clean up acl flow for better readability
      f2fs: fix a deadlock during init_acl procedure
      f2fs: introduce CONFIG_F2FS_CHECK_FS for BUG_ON control
      f2fs: add an option to avoid unnecessary BUG_ONs
      f2fs: avoid to wait all the node blocks during fsync
      f2fs: update f2fs document

Jin Xu (1):
      f2fs: optimize the victim searching loop slightly

Kelly Anderson (1):
      f2fs: handle remount options correctly

Russ Knize (1):
      f2fs: don't GC or take an fs_lock from f2fs_initxattrs()

Russ W. Knize (2):
      f2fs: don't let the orphan inode counter underflow
      f2fs: account for orphan inodes during recovery

Yu Chao (1):
      f2fs: optimize fs_lock for better performance

 Documentation/filesystems/f2fs.txt |   7 ++
 fs/f2fs/Kconfig                    |   8 +++
 fs/f2fs/acl.c                      |  36 +++++-----
 fs/f2fs/acl.h                      |   9 +--
 fs/f2fs/checkpoint.c               |  75 +++++++++----------
 fs/f2fs/data.c                     |  29 ++++----
 fs/f2fs/dir.c                      |   4 +-
 fs/f2fs/f2fs.h                     | 117 ++++++++++++++++--------------
 fs/f2fs/file.c                     |  45 ++++++------
 fs/f2fs/gc.c                       |  31 ++++----
 fs/f2fs/inode.c                    |  62 +++++++++-------
 fs/f2fs/namei.c                    |  52 +++++++-------
 fs/f2fs/node.c                     | 142 +++++++++++++++++++++++-------------
 fs/f2fs/recovery.c                 |  45 +++++++-----
 fs/f2fs/segment.c                  | 133 ++++++++++++++++++----------------
 fs/f2fs/segment.h                  |  38 +++++++---
 fs/f2fs/super.c                    | 143 ++++++++++++++++++++++++++-----------
 fs/f2fs/xattr.c                    |  36 ++++++----
 include/trace/events/f2fs.h        |  51 +++++++++++++
 19 files changed, 651 insertions(+), 412 deletions(-)


-- 
Jaegeuk Kim
Samsung

