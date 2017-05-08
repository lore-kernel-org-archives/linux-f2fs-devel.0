From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs for 4.12-rc1
Date: Mon, 8 May 2017 10:15:03 -0700
Message-ID: <20170508171503.GA42466@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you consider this pull request?

Thanks,

The following changes since commit 1f02071358301e376f5a54e40531db37a1d7c7ab:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2017-03-21 13:10:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.12

for you to fetch changes up to e9cdd307704b5a8f685fa3fff4403691fbf64f97:

  f2fs: fix a mount fail for wrong next_scan_nid (2017-05-03 19:00:30 -0700)

----------------------------------------------------------------
for-f2fs-4.12

In this round, we've focused on enhancing performance with regards to block
allocation, GC, and discard/in-place-update IO controls. There are a bunch
of clean-ups as well as minor bug fixes.

= Enhancement
- disable heap-based allocation by default
- issue small-sized discard commands by default
- change the policy of data hotness for logging
- distinguish IOs in terms of size and wbc type
- start SSR earlier to avoid foreground GC
- enhance data structures managing discard commands
- enhance in-place update flow
- add some more fault injection routines
- secure one more xattr entry

= Bug fix
- calculate victim cost for GC correctly
- remain correct victim segment number for GC
- race condition in nid allocator and initializer
- stale pointer produced by atomic_writes
- fix missing REQ_SYNC for flush commands
- handle missing errors in more corner cases

----------------------------------------------------------------
Arnd Bergmann (1):
      f2fs: improve definition of statistic macros

Chao Yu (35):
      f2fs: don't allow volatile writes for non-regular file
      f2fs: cover update_free_nid_bitmap with nid_list_lock
      f2fs: add missing INMEM_REVOKE trace enum definition
      f2fs: fix recording invalid last_victim
      f2fs: fix race condition in between free nid allocator/initializer
      f2fs: show the max number of volatile operations
      f2fs: don't track volatile file in dirty inode list
      f2fs: clean up xattr operation
      f2fs: don't reserve additional space in xattr block
      f2fs: show issued flush/discard count
      f2fs: count discard command entry
      f2fs: clean up destroy_discard_cmd_control
      f2fs: use bitmap in discard_entry
      f2fs: split discard_cmd_list
      f2fs: introduce f2fs_wait_discard_bios
      f2fs: prevent waiter encountering incorrect discard states
      f2fs: extract rb-tree operation infrastructure
      f2fs: shrink blk plug region
      f2fs: use rb-tree to track pending discard commands
      f2fs: clean up discard_cmd_control structure
      f2fs: in prior to issue big discard
      f2fs: trace __submit_discard_cmd
      f2fs: introduce __check_rb_tree_consistence
      f2fs: unlock cp_rwsem early for IPU writes
      f2fs: add undiscard blocks stat
      f2fs: delay awaking discard thread
      f2fs: enable small discard by default
      f2fs: introduce __issue_discard_cmd
      f2fs: introduce __wait_discard_cmd
      f2fs: don't hold cmd_lock during waiting discard command
      f2fs: shrink size of struct discard_cmd
      f2fs: allow cpc->reason to indicate more than one reason
      f2fs: introduce CP_TRIMMED_FLAG to avoid unneeded discard
      f2fs: relocate inode_{,un}lock in F2FS_IOC_SETFLAGS
      f2fs: enhance scalability of trace macro

Fan Li (1):
      f2fs: adjust the way of calculating nat block

Hou Pengyang (5):
      f2fs: introduce async IPU policy
      f2fs: skip encrypted inode in ASYNC IPU policy
      f2fs: reconstruct code to write a data page
      f2fs: lookup extent cache first under IPU scenario
      f2fs: release cp and dnode lock before IPU

Jaegeuk Kim (36):
      f2fs: don't need to invalidate wrong node page
      f2fs: le16_to_cpu for xattr->e_value_size
      f2fs: fix wrong error injection for evict_inode
      f2fs: don't allow to get pino when filename is encrypted
      f2fs: build stat_info before orphan inode recovery
      f2fs: fix stale ATOMIC_WRITTEN_PAGE private pointer
      f2fs: don't allow atomic writes for not regular files
      f2fs: show more precise message on orphan recovery failure
      f2fs: allocate a bio for discarding when actually issuing it
      f2fs: add fault injection on f2fs_truncate
      f2fs: fix wrong max cost initialization
      f2fs: allocate node and hot data in the beginning of partition
      f2fs: start SSR much eariler to avoid FG_GC
      f2fs: relax node version check for victim data in gc
      f2fs: write small sized IO to hot log
      f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE
      f2fs: submit bio of in-place-update pages
      Revert "f2fs: put allocate_segment after refresh_sit_entry"
      f2fs: use segment number for get_valid_blocks
      f2fs: clean up get_valid_blocks with consistent parameter
      f2fs: clean up some macros in terms of GET_SEGNO
      f2fs: avoid frequent checkpoint during f2fs_gc
      f2fs: fix fs corruption due to zero inode page
      f2fs: give time to flush dirty pages for checkpoint
      f2fs: allocate hot_data for atomic writes
      f2fs: fix not to set fsync/dentry mark
      f2fs: avoid dirty node pages in check_only recovery
      f2fs: add ioctl to flush data from faster device to cold area
      f2fs: fix _IOW usage
      f2fs: assign allocation hint for warm/cold data
      f2fs: add parentheses for macro variables more
      f2fs: fix out-of free segments
      f2fs: introduce valid_ipu_blkaddr to clean up
      f2fs: nullify fio->encrypted_page for each writes
      f2fs: flush dirty nats periodically
      f2fs: show available_nids in f2fs/status

Jan Kara (1):
      f2fs: Make flush bios explicitely sync

Jin Qian (1):
      f2fs: sanity check segment count

Kaixu Xia (1):
      f2fs: remove the redundant variable definition

Kinglong Mee (17):
      f2fs: le32_to_cpu for ckpt->cp_pack_total_block_count
      f2fs: fix the fault of checking F2FS_LINK_MAX for rename inode
      f2fs: fix the fault of calculating blkstart twice
      f2fs: make sure trace all f2fs_issue_flush
      f2fs: drop duplicate radix tree lookup of nat_entry_set
      f2fs: remove dead macro PGOFS_OF_NEXT_DNODE
      f2fs: drop duplicate new_size assign in f2fs_zero_range
      f2fs: avoid copy date to user-space if move file range fail
      f2fs: check new size by inode_newsize_ok in f2fs_insert_range
      f2fs: move mnt_want_write_file after arguments checking
      f2fs: clear FI_DATA_EXIST flag in truncate_inline_inode
      f2fs: fix bad prefetchw of NULL page
      f2fs: cleanup the disk level filename updating
      f2fs: sanity check of crc_offset from raw checkpoint
      f2fs: avoid stat_inc_atomic_write for non-atomic file
      f2fs: calculate the f2fs_stat_info into base_mem
      f2fs: more reasonable mem_size calculating of ino_entry

Sheng Yong (3):
      f2fs: use parameter max_items instead of PIDVEC_SIZE
      f2fs: check range before defragment
      f2fs: fix multiple f2fs_add_link() having same name for inline dentry

Tomohiro Kusumi (3):
      f2fs: split make_dentry_ptr() into block and inline versions
      f2fs: fix comment on f2fs_flush_merged_bios() after 86531d6b
      f2fs: guard macro variables with braces

Yunlei He (7):
      f2fs: fix an error return value in truncate_partial_data_page
      f2fs: skip writeback meta pages if cp_mutex acquire failed
      f2fs: add a punch discard command function
      f2fs: use set_page_private marcro in f2fs_trace_pid
      f2fs: allow write page cache when writting cp
      f2fs: seperate read nat page from nat_tree_lock
      f2fs: fix a mount fail for wrong next_scan_nid

 fs/f2fs/checkpoint.c        |  77 +++--
 fs/f2fs/data.c              | 200 +++++++++---
 fs/f2fs/debug.c             |  62 +++-
 fs/f2fs/dir.c               |  46 +--
 fs/f2fs/extent_cache.c      | 326 +++++++++++--------
 fs/f2fs/f2fs.h              | 320 +++++++++++-------
 fs/f2fs/file.c              | 173 +++++++---
 fs/f2fs/gc.c                |  93 ++++--
 fs/f2fs/inline.c            |  34 +-
 fs/f2fs/inode.c             |  23 +-
 fs/f2fs/namei.c             |  53 +--
 fs/f2fs/node.c              | 144 ++++----
 fs/f2fs/node.h              |  31 +-
 fs/f2fs/recovery.c          |   8 +-
 fs/f2fs/segment.c           | 776 ++++++++++++++++++++++++++++++++------------
 fs/f2fs/segment.h           | 139 ++++----
 fs/f2fs/super.c             |  48 ++-
 fs/f2fs/trace.c             |   4 +-
 fs/f2fs/xattr.c             |  31 +-
 fs/f2fs/xattr.h             |   8 +-
 include/linux/f2fs_fs.h     |  17 +-
 include/trace/events/f2fs.h |  62 ++--
 22 files changed, 1747 insertions(+), 928 deletions(-)
