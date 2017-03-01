From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs update for 4.11
Date: Tue, 28 Feb 2017 22:22:53 -0800
Message-ID: <20170301062253.GA16100@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cixfG-0004qT-1q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 06:23:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cixfE-0000Ox-MS
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 06:23:06 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi Linus,

Could you please consider the below pull request for v4.11?

Thanks,

The following changes since commit 53cd1ad1a68fd10f677445e04ed63aa9ce39b36b:

  Merge branch 'i2c/for-current' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2017-01-28 15:09:23 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.11

for you to fetch changes up to 900f736251c81886f3064c9d489c85eddee921b7:

  f2fs: avoid to flush nat journal entries (2017-02-28 09:57:13 -0800)

----------------------------------------------------------------
for-f2fs-4.11

This round introduces several interesting features such as on-disk NAT bitmaps,
IO alignment, and a discard thread. And it includes a couple of major bug fixes
as below.

== Enhancement ==
- introduce on-disk bitmaps to avoid scanning NAT blocks when getting free nids
- support IO alignment to prepare open-channel SSD integration in future
- introduce a discard thread to avoid long latency during checkpoint and fstrim
- use SSR for warm node and enable inline_xattr by default
- introduce in-memory bitmaps to check FS consistency for debugging
- improve write_begin by avoiding needless read IO

== Bug fix ==
- fix broken zone_reset behavior for SMR drive
- fix wrong victim selection policy during GC
- fix missing behavior when preparing discard commands
- fix bugs in atomic write support and fiemap
- workaround to handle multiple f2fs_add_link calls having same name

And it includes a bunch of clean-up patches as well.

----------------------------------------------------------------
Bhumika Goyal (1):
      f2fs: super: constify fscrypt_operations structure

Chao Yu (19):
      f2fs: don't cache nat entry if out of memory
      f2fs: clean up with list_{first, last}_entry
      f2fs: introduce FI_ATOMIC_COMMIT
      f2fs: check in-memory block bitmap
      f2fs: check in-memory nat version bitmap
      f2fs: check in-memory sit version bitmap
      f2fs: enhance lookup xattr
      f2fs: fix to avoid overflow when left shifting page offset
      f2fs: fix null pointer dereference when issuing flush in ->fsync
      f2fs: change recovery policy of xattr node block
      f2fs: introduce noinline_xattr mount option
      f2fs: enable inline_xattr by default
      f2fs: show simple call stack in fault injection message
      f2fs: select target segment with closer temperature in SSR mode
      f2fs: kill __is_extent_same
      f2fs: introduce free nid bitmap
      f2fs: fix to update F2FS_{CP_}WB_DATA count correctly
      f2fs: fix memory leak of write_io_dummy mempool during umount
      f2fs: fix to enlarge size of write_io_dummy mempool

Dan Carpenter (1):
      f2fs: remove unneeded condition

DongOh Shin (2):
      f2fs: fix 3 coding style errors in f2fs.h
      f2fs: fix 446 coding style warnings in f2fs.h

Geliang Tang (1):
      f2fs: use rb_entry_safe

Hou Pengyang (7):
      f2fs: add ovp valid_blocks check for bg gc victim to fg_gc
      f2fs: node segment is prior to data segment selected victim
      f2fs: init local extent_info to avoid stale stack info in tp
      f2fs: remove unsafe bitmap checking
      f2fs: avoid bggc->fggc when enough free segments are avaliable after cp
      f2fs: add f2fs_drop_inode tracepoint
      f2fs: fix a plint compile warning

Jaegeuk Kim (44):
      f2fs: reassign new segment for mode=lfs
      f2fs: fix wrong tracepoints for op and op_flags
      f2fs: add submit_bio tracepoint
      f2fs: support IO alignment for DATA and NODE writes
      f2fs: get io size bit from mount option
      f2fs: show the max number of atomic operations
      f2fs: don't allow encrypted operations without keys
      f2fs: drop exist_data for inline_data when truncated to 0
      f2fs: relax async discard commands more
      f2fs: avoid needless checkpoint in f2fs_trim_fs
      f2fs: return fs_trim if there is no candidate
      f2fs: clean up flush/discard command namings
      f2fs: reorganize stat information
      f2fs: factor out discard command info into discard_cmd_control
      f2fs: add a kernel thread to issue discard commands asynchronously
      f2fs: show # of on-going flush and discard bios
      f2fs: do not preallocate blocks which has wrong buffer
      f2fs: declare missing static function
      f2fs: show # of APPEND and UPDATE inodes
      f2fs: move flush tracepoint
      f2fs: move write_node_page above fsync_node_pages
      f2fs: avoid out-of-order execution of atomic writes
      f2fs: call internal __write_data_page directly
      f2fs: check io submission more precisely
      f2fs: check last page index in cached bio to decide submission
      f2fs: remove preflush for nobarrier case
      f2fs: show checkpoint version at mount time
      f2fs: remove build_free_nids() during checkpoint
      f2fs: avoid reading NAT page by get_node_info
      f2fs: use SSR for warm node as well
      f2fs: show actual device info in tracepoints
      f2fs: fix multiple f2fs_add_link() calls having same name
      f2fs: trace victim's cost selectecd by f2fs_gc
      f2fs: do not wait for writeback in write_begin
      f2fs: do SSR in higher priority
      f2fs: find data segments across all the types
      f2fs: do SSR for node segments more aggresively
      f2fs: avoid very large discard command
      f2fs: much larger batched trim_fs job
      f2fs: wait for discard completion after submission
      f2fs: check discard alignment only for SEQWRITE zones
      f2fs: add bitmaps for empty or full NAT blocks
      f2fs: avoid to issue redundant discard commands
      f2fs: avoid to flush nat journal entries

Kaixu Xia (1):
      f2fs: show the fault injection mount option

Kinglong Mee (6):
      f2fs: avoid m_flags overlay when allocating more data blocks
      f2fs: Don't update the xattr data that same as the exist
      f2fs: drop the duplicate pval in f2fs_getxattr
      f2fs: update the comment of default nr_pages to skipping
      f2fs: new helper cur_cp_crc() getting crc in f2fs_checkpoint
      f2fs: use MAX_FREE_NIDS for the free nids target

Masanari Iida (1):
      Doc: f2fs: Fix typo in Documentation/filesystems/f2fs.txt

Masato Suzuki (1):
      f2fs: Fix zoned block device support

Tiezhu Yang (1):
      f2fs: fix a typo in f2fs.txt

Wei Fang (1):
      f2fs: fix a dead loop in f2fs_fiemap()

Yunlei He (8):
      f2fs: remove unused values in recover_fsync_data
      f2fs: fix a problem of using memory after free
      f2fs: add a case of no need to read a page in write begin
      f2fs: fix a missing discard prefree segments
      f2fs: replace __get_victim by dirty_segments in FG_GC
      f2fs: replace rw semaphore extent_tree_lock with mutex lock
      f2fs: no need lock_op in f2fs_write_inline_data
      f2fs: remove redundant set_page_dirty()

Yunlong Song (3):
      f2fs: put allocate_segment after refresh_sit_entry
      f2fs: do SSR for data when there is enough free space
      f2fs: remove unnecessary condition check for write_checkpoint in f2fs_gc

 Documentation/filesystems/f2fs.txt |   7 +-
 fs/f2fs/checkpoint.c               |  70 ++--
 fs/f2fs/data.c                     | 191 ++++++++---
 fs/f2fs/debug.c                    |  31 +-
 fs/f2fs/dir.c                      |  38 ++-
 fs/f2fs/extent_cache.c             |  52 ++-
 fs/f2fs/f2fs.h                     | 644 ++++++++++++++++++++++---------------
 fs/f2fs/file.c                     |  36 ++-
 fs/f2fs/gc.c                       |  79 +++--
 fs/f2fs/inode.c                    |   4 +-
 fs/f2fs/namei.c                    |  18 +-
 fs/f2fs/node.c                     | 560 +++++++++++++++++++++++++-------
 fs/f2fs/node.h                     |  33 +-
 fs/f2fs/recovery.c                 |  17 +-
 fs/f2fs/segment.c                  | 501 +++++++++++++++++++++--------
 fs/f2fs/segment.h                  |  40 ++-
 fs/f2fs/super.c                    | 142 ++++++--
 fs/f2fs/xattr.c                    | 151 +++++++--
 fs/f2fs/xattr.h                    |   7 +-
 include/linux/f2fs_fs.h            |   8 +
 include/trace/events/f2fs.h        | 151 +++++----
 21 files changed, 1968 insertions(+), 812 deletions(-)

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
