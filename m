From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs for 4.13-rc1
Date: Mon, 10 Jul 2017 14:13:31 -0700
Message-ID: <20170710211331.GA54860@jaegeuk-macbookpro.roam.corp.google.com>
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

Thanks

The following changes since commit 2d3e4866dea96b0506395b47bfefb234f2088dac:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2017-05-08 12:37:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.13

for you to fetch changes up to 0abd675e97e60d40e61d59532f8118b0e439034e:

  f2fs: support plain user/group quota (2017-07-08 23:12:27 -0700)

----------------------------------------------------------------
for-f2fs-4.13

In this round, we've added new features such as disk quota and statx, and
modified internal bio management flow to merge more IOs depending on block
types. We've also made internal threads freezeable for Android battery life.
In addition to them, there are some patches to avoid lock contention as well
as a couple of deadlock conditions.

= Enhancement
- support usrquota, grpquota, and statx
- manage DATA/NODE typed bios separately to serialize more IOs
- modify f2fs_lock_op/wio_mutex to avoid lock contention
- prevent lock contention in migratepage

= Bug fix
- miss to load written inode flag
- fix worst case victim selection in GC
- freezeable GC and discard threads for Android battery life
- sanitize f2fs metadata to deal with security hole
- clean up sysfs-related code and docs

----------------------------------------------------------------
Chao Yu (26):
      f2fs: support statx
      f2fs: split wio_mutex
      f2fs: introduce io_list for serialize data/node IOs
      f2fs: show more info if fail to issue discard
      f2fs: wake up all waiters in f2fs_submit_discard_endio
      f2fs: wait discard IO completion without cmd_lock held
      f2fs: introduce __wait_one_discard_bio
      f2fs: add f2fs_bug_on in __remove_discard_cmd
      f2fs: don't track newly allocated nat entry in list
      f2fs: fix to avoid panic when encountering corrupt node
      f2fs: fix to show injection rate in ->show_options
      f2fs: fix incorrect document of batched_trim_sections
      f2fs: fix wrong error number of fill_super
      f2fs: fix to document fault injection option and sysfs file
      f2fs: clean up sysfs codes
      f2fs: move sysfs code from super.c to fs/f2fs/sysfs.c
      f2fs: set CP_TRIMMED_FLAG correctly
      f2fs: measure inode.i_blocks as generic filesystem
      f2fs: introduce reserved_blocks in sysfs
      f2fs: stop gc/discard thread in prior during umount
      f2fs: introduce __check_sit_bitmap
      f2fs: skip ->writepages for {mete,node}_inode during recovery
      Revert "f2fs: fix to clean previous mount option when remount_fs"
      f2fs: don't count inode block in in-memory inode.i_blocks
      f2fs: use spin_{,un}lock_irq{save,restore}
      f2fs: support plain user/group quota

Christophe JAILLET (1):
      f2fs: Fix a return value in case of error in 'f2fs_fill_super'

Damien Le Moal (1):
      f2fs: Do not issue small discards in LFS mode

Eric Biggers (3):
      f2fs: don't bother checking for encryption key in ->mmap()
      f2fs: don't bother checking for encryption key in ->write_iter()
      f2fs: require key for truncate(2) of encrypted file

Fan Li (1):
      f2fs: simplify the way of calulating next nat address

Hou Pengyang (1):
      f2fs: declare load_free_nid_bitmap static

Jaegeuk Kim (13):
      f2fs: load inode's flag from disk
      f2fs: use f2fs_submit_page_bio for ra_meta_pages
      f2fs: remove unnecessary read cases in merged IO flow
      f2fs: use fio instead of multiple parameters
      f2fs: split bio cache
      f2fs: avoid f2fs_lock_op for IPU writes
      f2fs: try to freeze in gc and discard threads
      f2fs: remove false-positive bug_on
      f2fs: don't need to check encrypted inode for partial truncation
      f2fs: add ioctl to do gc with target block address
      f2fs: report # of free inodes more precisely
      f2fs: relax migratepage for atomic written page
      f2fs: avoid deadlock caused by lock order of page and lock_op

Jin Qian (2):
      f2fs: sanity check checkpoint segno and blkoff
      f2fs: sanity check size of nat and sit cache

Qiuyang Sun (1):
      f2fs: dax: fix races between page faults and truncating pages

Sheng Yong (2):
      f2fs: do not set LOST_PINO for newly created dir
      f2fs: do not set LOST_PINO for renamed dir

Tiezhu Yang (1):
      f2fs: use proper variable name

Weichao Guo (1):
      f2fs: make sure f2fs_gc returns consistent errno

Yunlei He (4):
      f2fs: add a new function get_ssr_cost
      f2fs: fix a bug caused by NULL extent tree
      f2fs: combine huge num of discard rb tree consistence checks
      f2fs: fix a panic caused by NULL flush_cmd_control

Yunlong Song (1):
      f2fs: avoid redundant f2fs_flush after remount

Zhang Shengju (1):
      f2fs: remove the unnecessary cast for PTR_ERR

 Documentation/ABI/testing/sysfs-fs-f2fs |  20 +-
 Documentation/filesystems/f2fs.txt      |   4 +
 fs/f2fs/Makefile                        |   2 +-
 fs/f2fs/acl.c                           |   2 +-
 fs/f2fs/checkpoint.c                    |  33 +-
 fs/f2fs/data.c                          | 215 ++++++----
 fs/f2fs/dir.c                           |   3 +-
 fs/f2fs/extent_cache.c                  |  12 +-
 fs/f2fs/f2fs.h                          | 201 ++++++---
 fs/f2fs/file.c                          | 183 +++++++--
 fs/f2fs/gc.c                            |  40 +-
 fs/f2fs/inline.c                        |  22 +-
 fs/f2fs/inode.c                         |  17 +-
 fs/f2fs/namei.c                         |  71 +++-
 fs/f2fs/node.c                          |  67 +--
 fs/f2fs/node.h                          |   6 +-
 fs/f2fs/segment.c                       | 236 +++++++----
 fs/f2fs/segment.h                       |   4 +
 fs/f2fs/super.c                         | 705 +++++++++++++++++---------------
 fs/f2fs/sysfs.c                         | 364 +++++++++++++++++
 include/trace/events/f2fs.h             |  16 +-
 21 files changed, 1559 insertions(+), 664 deletions(-)
 create mode 100644 fs/f2fs/sysfs.c
