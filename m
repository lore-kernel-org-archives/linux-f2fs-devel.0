From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs for 4.7-rc1
Date: Sat, 21 May 2016 17:39:18 -0700
Message-ID: <20160522003918.GA8422@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b4HQW-0002CZ-2D
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 May 2016 00:39:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b4HQU-0003XF-Pd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 May 2016 00:39:28 +0000
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

In this round, as Ted pointed out, fscrypto allows one more key prefix given by
filesystem to resolve backward compatibility issue. Other than that, we could
fix several error handling flow by introducing fault injection facility. We've
also achieved performance improvement in some workloads as well as a bunch of
bug fixes.

Could you consider pulling the below patches?

Thanks,

The following changes since commit 806fdcce017dc98c4dbf8ed001750a0d7d2bb0af:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2016-04-14 19:53:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.7

for you to fetch changes up to 0f3311a8c266b9f4fae4e5cdfcd9a86970e2b9bd:

  f2fs: fix to update dirty page count correctly (2016-05-20 14:55:41 -0700)

----------------------------------------------------------------
Enhancement
- fs-specific prefix for fscrypto
- fault injection facility
- expose validity bitmaps for user to be aware of fragmentation
- fallocate/rm/preallocation speed up
- use percpu counters

Bug fixes
- some inline_dentry/inline_data bugs
- error handling for atomic/volatile/orphan inodes
- recover broken superblock

----------------------------------------------------------------
Chao Yu (22):
      f2fs: fix to convert inline directory correctly
      MAINTAINERS: update my email address
      f2fs: be aware of invalid filename length
      f2fs: move node pages only in victim section during GC
      f2fs: fix to clear private data in page
      f2fs: fix to clear page private flag
      f2fs: factor out fsync inode entry operations
      f2fs: remove unneeded readahead in find_fsync_dnodes
      f2fs: remove unneeded memset when updating xattr
      f2fs: reuse get_extent_info
      f2fs: shrink size of struct seg_entry
      f2fs: fix incorrect mapping in ->bmap
      f2fs: avoid panic when truncating to max filesize
      f2fs: fix inode cache leak
      f2fs: use mnt_{want,drop}_write_file in ioctl
      f2fs: make atomic/volatile operation exclusive
      f2fs: support in batch multi blocks preallocation
      f2fs: support in batch fzero in dnode page
      f2fs: fix deadlock when flush inline data
      f2fs: fix i_current_depth during inline dentry conversion
      f2fs: fix incorrect error path handling in f2fs_move_rehashed_dirents
      f2fs: fix to update dirty page count correctly

Jaegeuk Kim (46):
      f2fs: give RO message when recovering superblock
      f2fs: recover superblock at RW remounts
      f2fs: give -EINVAL for norecovery and rw mount
      f2fs: treat as a normal umount when remounting ro
      f2fs: show current mount status
      f2fs: use PGP_LOCK to check its truncation
      f2fs: add BUG_ON to avoid unnecessary flow
      f2fs: fix dropping inmemory pages in a wrong time
      f2fs: unset atomic/volatile flag in f2fs_release_file
      f2fs: remove redundant condition check
      f2fs: give -E2BIG for no space in xattr
      f2fs: don't invalidate atomic page if successful
      f2fs: flush dirty pages before starting atomic writes
      f2fs: avoid needless lock for node pages when fsyncing a file
      f2fs: avoid writing 0'th page in volatile writes
      f2fs: split sync_node_pages with fsync_node_pages
      f2fs: report unwritten status in fsync_node_pages
      f2fs: set fsync mark only for the last dnode
      f2fs: issue cache flush on direct IO
      f2fs: introduce macros for proc entries
      f2fs: add proc entry to show valid block bitmap
      f2fs: introduce f2fs_kmalloc to wrap kmalloc
      f2fs: use f2fs_grab_cache_page instead of grab_cache_page
      f2fs: add mount option to select fault injection ratio
      f2fs: inject kmalloc failure
      f2fs: inject page allocation failures
      f2fs: inject ENOSPC failures
      f2fs: revisit error handling flows
      f2fs: fix leak of orphan inode objects
      f2fs: retry to truncate blocks in -ENOMEM case
      f2fs: don't worry about inode leak in evict_inode
      f2fs: remove an obsolete variable
      fscrypto/f2fs: allow fs-specific key prefix for fs encryption
      f2fs: fallocate data blocks in single locked node page
      f2fs: read node blocks ahead when truncating blocks
      f2fs: do not preallocate block unaligned to 4KB
      f2fs: show # of orphan inodes
      f2fs: avoid f2fs_bug_on during recovery
      f2fs: manipulate dirty file inodes when DATA_FLUSH is set
      f2fs: use bio count instead of F2FS_WRITEBACK page count
      f2fs: use percpu_counter for page counters
      f2fs: use percpu_counter for # of dirty pages in inode
      f2fs: use percpu_counter for alloc_valid_block_count
      f2fs: use percpu_counter for total_valid_inode_count
      f2fs: avoid ENOSPC fault in the recovery process
      f2fs: flush pending bios right away when error occurs

Sheng Yong (2):
      f2fs: correct return value type of f2fs_fill_super
      f2fs: add fault injection to sysfs

Tiezhu Yang (1):
      f2fs: make exit_f2fs_fs more clear

Yunlei He (1):
      f2fs: no need inc dirty pages under inode lock

Yunlong Song (1):
      f2fs: fix to return 0 if err == -ENOENT in f2fs_readdir

 MAINTAINERS                 |   2 +-
 fs/crypto/keyinfo.c         | 120 +++++++++++------
 fs/f2fs/Kconfig             |   8 ++
 fs/f2fs/acl.c               |   4 +-
 fs/f2fs/checkpoint.c        |  67 +++++-----
 fs/f2fs/data.c              | 197 ++++++++++++++++++---------
 fs/f2fs/debug.c             |  25 ++--
 fs/f2fs/dir.c               | 128 +++++++++---------
 fs/f2fs/extent_cache.c      |   3 +-
 fs/f2fs/f2fs.h              | 197 +++++++++++++++++++--------
 fs/f2fs/file.c              | 309 +++++++++++++++++++++++++++++++------------
 fs/f2fs/gc.c                |  27 +---
 fs/f2fs/inline.c            | 111 ++++++++++++++--
 fs/f2fs/inode.c             |  66 ++++-----
 fs/f2fs/node.c              | 316 ++++++++++++++++++++++++++++++++++----------
 fs/f2fs/recovery.c          | 149 ++++++++++++---------
 fs/f2fs/segment.c           |   8 +-
 fs/f2fs/segment.h           |   9 +-
 fs/f2fs/super.c             | 288 ++++++++++++++++++++++++++++++++++------
 fs/f2fs/xattr.c             |   3 +-
 include/linux/f2fs_fs.h     |   2 +
 include/linux/fscrypto.h    |   1 +
 include/trace/events/f2fs.h |  24 ++--
 23 files changed, 1449 insertions(+), 615 deletions(-)

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
