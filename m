From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs-for-5.1
Date: Thu, 14 Mar 2019 15:18:06 -0700
Message-ID: <20190314221806.GA87066@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Sorry for late request. Could you please consider this pull request?

Thanks,

The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.1

for you to fetch changes up to aff7b628ac2d58616b74789389ebb1e987081f49:

  f2fs: set pin_file under CAP_SYS_ADMIN (2019-03-14 10:20:54 -0700)

----------------------------------------------------------------
f2fs-for-5.1-rc1

We've continued mainly to fix bugs in this round, as f2fs has been shipped
in more devices. Especially, we've focused on stabilizing checkpoint=disable
feature, and provided some interfaces for QA.

Enhancement:
 - expose FS_NOCOW_FL for pin_file
 - run discard jobs at unmount time with timeout
 - tune discarding thread to avoid idling which consumes power
 - some checking codes to address vulnerabilities
 - give random value to i_generation
 - shutdown with more flags for QA

Bug fix:
 - clean up stale objects when mount is failed along with checkpoint=disable
 - fix system being stuck due to wrong count by atomic writes
 - handle some corrupted disk cases
 - fix a deadlock in f2fs_read_inline_dir

We've also added some minor build errors and clean-up patches.

----------------------------------------------------------------
Chao Yu (23):
      f2fs: check inject_rate validity during configuring
      f2fs: fix to trigger fsck if dirent.name_len is zero
      f2fs: fix to initialize variable to avoid UBSAN/smatch warning
      f2fs: fix to set sbi dirty correctly
      f2fs: fix to document inline_xattr_size option
      f2fs: fix potential data inconsistence of checkpoint
      f2fs: fix to check inline_xattr_size boundary correctly
      f2fs: don't allow negative ->write_io_size_bits
      f2fs: fix to retry fill_super only if recovery failed
      f2fs: make fault injection covering __submit_flush_wait()
      f2fs: fix encrypted page memory leak
      f2fs: fix to update iostat correctly in IPU path
      f2fs: fix to dirty inode for i_mode recovery
      f2fs: fix to avoid deadlock of atomic file operations
      f2fs: trace f2fs_ioc_shutdown
      f2fs: print more parameters in trace_f2fs_map_blocks
      f2fs: fix to use kvfree instead of kzfree
      f2fs: remove wrong comment in f2fs_invalidate_page()
      f2fs: fix to add refcount once page is tagged PG_private
      f2fs: don't trigger read IO for beyond EOF page
      f2fs: fix to do sanity check with inode.i_inline_xattr_size
      f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
      f2fs: fix to avoid deadlock in f2fs_read_inline_dir()

Chengguang Xu (2):
      f2fs: change error code to -ENOMEM from -EINVAL
      f2fs: jump to label 'free_node_inode' when failing from d_make_root()

Gao Xiang (3):
      f2fs: use xattr_prefix to wrap up
      f2fs: silence VM_WARN_ON_ONCE in mempool_alloc
      f2fs: no need to take page lock in readdir

Geliang Tang (1):
      f2fs: fix typos in code comments

Greg Kroah-Hartman (1):
      f2fs: no need to check return value of debugfs_create functions

Jaegeuk Kim (15):
      f2fs: wait on atomic writes to count F2FS_CP_WB_DATA
      f2fs: don't access node/meta inode mapping after iput
      f2fs: export FS_NOCOW_FL flag to user
      f2fs: run discard jobs when put_super
      f2fs: add quick mode of checkpoint=disable for QA
      f2fs: try to keep CP_TRIMMED_FLAG after successful umount
      f2fs: don't wake up too frequently, if there is lots of IOs
      f2fs: avoid null pointer exception in dcc_info
      f2fs: flush quota blocks after turnning it off
      f2fs: sync filesystem after roll-forward recovery
      f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
      f2fs: fix wrong #endif
      f2fs: give random value to i_generation
      f2fs: give some messages for inline_xattr_size
      f2fs: set pin_file under CAP_SYS_ADMIN

Sahitya Tummala (1):
      f2fs: do not use mutex lock in atomic context

Sheng Yong (3):
      f2fs: check if file namelen exceeds max value
      f2fs: add brackets for macros
      f2fs: UBSAN: set boolean value iostat_enable correctly

YueHaibing (1):
      f2fs: remove set but not used variable 'err'

Zeng Guangyue (1):
      f2fs: correct spelling mistake

Zhikang Zhang (1):
      f2fs: fix compile warnings: 'struct *' declared inside parameter list

zhengliang (1):
      f2fs: fix to data block override node segment by mistake

 Documentation/ABI/testing/sysfs-fs-f2fs |   7 ++
 Documentation/filesystems/f2fs.txt      |   2 +
 fs/f2fs/checkpoint.c                    |  20 ++++--
 fs/f2fs/data.c                          |  59 ++++++++---------
 fs/f2fs/debug.c                         |  39 +++++------
 fs/f2fs/dir.c                           |  15 +++--
 fs/f2fs/extent_cache.c                  |   2 +-
 fs/f2fs/f2fs.h                          |  81 +++++++++++++++--------
 fs/f2fs/file.c                          |  46 +++++++------
 fs/f2fs/inline.c                        |  12 +++-
 fs/f2fs/inode.c                         |  15 +++++
 fs/f2fs/namei.c                         |   3 +-
 fs/f2fs/node.c                          |   6 +-
 fs/f2fs/segment.c                       |  80 +++++++++++++++-------
 fs/f2fs/segment.h                       |   2 +-
 fs/f2fs/super.c                         | 114 ++++++++++++++++++++++----------
 fs/f2fs/sysfs.c                         |  17 ++++-
 fs/f2fs/trace.c                         |  20 ++++--
 fs/f2fs/xattr.c                         |  25 ++++---
 fs/f2fs/xattr.h                         |   6 ++
 include/linux/f2fs_fs.h                 |  20 +++---
 include/trace/events/f2fs.h             |  47 ++++++++++++-
 22 files changed, 430 insertions(+), 208 deletions(-)
