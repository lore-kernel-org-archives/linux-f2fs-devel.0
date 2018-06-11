From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 09:52:12 -0700
Message-ID: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

So sorry for a bit late pull request. I had to take a look at the test results
run during the weekend. Could you please consider this?

Thanks,

The following changes since commit 2d618bdf71635463a4aa4ad0fe46ec852292bc0c:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel (2018-05-01 19:54:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.18

for you to fetch changes up to dfa742803fbbd8b82790c152600e09c5ad99caca:

  f2fs: fix to clear FI_VOLATILE_FILE correctly (2018-06-04 14:33:27 -0700)

----------------------------------------------------------------
f2fs-for-4.18-rc1

In this round, we've mainly focused on discard, aka unmap, control along with
fstrim for Android-specific usage model. In addition, we've fixed writepage flow
which returned EAGAIN previously resulting in EIO of fsync(2) due to mapping's
error state. In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
for the mapping for node and meta page caches. As always, we've cleaned up many
places for future fsverity and symbol conflicts.

Enhancement:
 - do discard/fstrim in lower priority considering fs utilization
 - split large discard commands into smaller ones for better responsiveness
 - add more sanity checks to address syzbot reports
 - add a mount option, fsync_mode=nobarrier, which can reduce # of cache flushes
 - clean up symbol namespace with modified function names
 - be strict on block allocation and IO control in corner cases

Bug fix:
 - don't use __GFP_ZERO for mappings
 - fix error reports in writepage to avoid fsync() failure
 - avoid selinux denial on CAP_RESOURCE on resgid/resuid
 - fix some subtle race conditions in GC/atomic writes/shutdown
 - fix overflow bugs in sanity_check_raw_super
 - fix missing bits on get_flags

Clean-up:
 - prepare the generic flow for future fsverity integration
 - fix some broken coding standard

[1] https://lkml.org/lkml/2018/4/8/661

----------------------------------------------------------------
Anatoly Pugachev (1):
      disable loading f2fs module on PAGE_SIZE > 4KB

Chao Yu (39):
      f2fs: don't split checkpoint in fstrim
      f2fs: turn down IO priority of discard from background
      f2fs: introduce private inode status mapping
      f2fs: remove redundant block plug
      f2fs: don't use GFP_ZERO for page caches
      f2fs: remove unneeded F2FS_PROJINHERIT_FL
      f2fs: fix to show missing bits in FS_IOC_GETFLAGS
      f2fs: correct return value of f2fs_trim_fs
      f2fs: fix race in between GC and atomic open
      f2fs: fix return value in f2fs_ioc_commit_atomic_write
      f2fs: fix to detect failure of dquot_initialize
      f2fs: clean up commit_inmem_pages()
      f2fs: rename dio_rwsem to i_gc_rwsem
      f2fs: fix potential overflow
      f2fs: introduce release_discard_addr() for cleanup
      f2fs: treat volatile file's data as hot one
      Revert "f2fs: add ovp valid_blocks check for bg gc victim to fg_gc"
      f2fs: fix to initialize i_current_depth according to inode type
      f2fs: fix to let checkpoint guarantee atomic page persistence
      f2fs: fix to initialize min_mtime with ULLONG_MAX
      f2fs: clean up with is_valid_blkaddr()
      f2fs: detect synchronous writeback more earlier
      f2fs: fix to wait page writeback during revoking atomic write
      f2fs: keep migration IO order in LFS mode
      f2fs: avoid stucking GC due to atomic write
      f2fs: fix to don't trigger writeback during recovery
      f2fs: clean up with clear_radix_tree_dirty_tag
      f2fs: fix to avoid race during access gc_thread pointer
      f2fs: don't drop dentry pages after fs shutdown
      f2fs: fix error path of move_data_page
      f2fs: fix to let caller retry allocating block address
      f2fs: fix to avoid accessing cross the boundary
      f2fs: make __f2fs_write_data_pages() static
      f2fs: make set_de_type() static
      f2fs: clean up symbol namespace
      f2fs: fix to update mtime correctly
      f2fs: don't change wbc->sync_mode
      f2fs: let sync node IO interrupt async one
      f2fs: fix to clear FI_VOLATILE_FILE correctly

Colin Ian King (1):
      f2fs: fix spelling mistake: "extenstion" -> "extension"

Eric Biggers (4):
      fscrypt: allow synchronous bio decryption
      f2fs: refactor read path to allow multiple postprocessing steps
      f2fs: call unlock_new_inode() before d_instantiate()
      f2fs: fix features filename in sysfs documentation

Jaegeuk Kim (16):
      Revert "f2fs: introduce f2fs_set_page_dirty_nobuffer"
      f2fs: check cap_resource only for data blocks
      f2fs: clear PageError on writepage
      f2fs: avoid fsync() failure caused by EAGAIN in writepage()
      f2fs: let fstrim issue discard commands in lower priority
      f2fs: add fsync_mode=nobarrier for non-atomic files
      f2fs: issue discard commands proactively in high fs utilization
      f2fs: run fstrim asynchronously if runtime discard is on
      f2fs: give message and set need_fsck given broken node id
      f2fs: avoid bug_on on corrupted inode
      f2fs: sanity check on sit entry
      f2fs: sanity check for total valid node blocks
      f2fs: enforce fsync_mode=strict for renamed directory
      f2fs: enhance sanity_check_raw_super() to avoid potential overflows
      f2fs: don't drop any page on f2fs_cp_error() case
      f2fs: introduce sbi->gc_mode to determine the policy

Sahitya Tummala (1):
      f2fs: Fix deadlock in shutdown ioctl

Sheng Yong (4):
      f2fs: check if inmem_pages list is empty correctly
      f2fs: remove duplicated dquot_initialize and fix error handling
      f2fs: do not check F2FS_INLINE_DOTS in recover
      f2fs: clear discard_wake earlier

Souptick Joarder (1):
      fs: f2fs: Adding new return type vm_fault_t

Yunlei He (6):
      f2fs: issue all big range discards in umount process
      f2fs: allocate hot_data for atomic write more strictly
      f2fs: stop issue discard if something wrong with f2fs
      f2fs: fix missing clear FI_NO_PREALLOC in some error case
      f2fs: move mnt_want_write_file after range check
      f2fs: let discard thread wait a little longer if dev is busy

Yunlong Song (1):
      f2fs: remove unmatched zero_user_segment when convert inline dentry

Zhikang Zhang (2):
      f2fs: check cur_valid_map_mir & raw_sit block count when flush sit entries
      f2fs: change le32 to le16 of f2fs_inode->i_extra_size

youngjun yoo (3):
      fs: f2fs: changed variable type of offset "unsigned" to "loff_t"
      fs: f2fs: add missing blank lines after declarations
      fs: f2fs: insert space around that ':' and ', '

 Documentation/ABI/testing/sysfs-fs-f2fs |   3 +-
 Documentation/filesystems/f2fs.txt      |  16 +-
 fs/crypto/bio.c                         |  35 +-
 fs/crypto/crypto.c                      |   8 +-
 fs/crypto/fscrypt_private.h             |   1 -
 fs/ext4/readpage.c                      |   2 +-
 fs/f2fs/checkpoint.c                    | 149 ++++----
 fs/f2fs/data.c                          | 399 ++++++++++++--------
 fs/f2fs/debug.c                         |   6 +
 fs/f2fs/dir.c                           |  76 ++--
 fs/f2fs/extent_cache.c                  |  22 +-
 fs/f2fs/f2fs.h                          | 460 +++++++++++++----------
 fs/f2fs/file.c                          | 335 +++++++++--------
 fs/f2fs/gc.c                            | 183 +++++-----
 fs/f2fs/gc.h                            |   2 -
 fs/f2fs/inline.c                        |  78 ++--
 fs/f2fs/inode.c                         | 115 +++---
 fs/f2fs/namei.c                         |  75 ++--
 fs/f2fs/node.c                          | 285 ++++++++-------
 fs/f2fs/recovery.c                      |  65 ++--
 fs/f2fs/segment.c                       | 621 ++++++++++++++++++--------------
 fs/f2fs/segment.h                       |  31 +-
 fs/f2fs/shrinker.c                      |   4 +-
 fs/f2fs/super.c                         | 198 +++++++---
 fs/f2fs/sysfs.c                         |  63 +++-
 fs/f2fs/xattr.c                         |  26 +-
 include/linux/fscrypt_notsupp.h         |  13 +-
 include/linux/fscrypt_supp.h            |   5 +-
 28 files changed, 1884 insertions(+), 1392 deletions(-)
