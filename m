From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs update for 4.9
Date: Thu, 6 Oct 2016 14:36:24 -0700
Message-ID: <20161006213624.GA30039@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bsGLD-0003rE-7o
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Oct 2016 21:36:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bsGLC-0004JR-05
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Oct 2016 21:36:35 +0000
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

Could you please consider this pull request?

Thanks,

The following changes since commit cad9d20784e9b31f0fa8eb82b4ae5dad633b560d:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2016-08-24 07:43:27 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.9

for you to fetch changes up to e4c5d8489a41209534699220021dab409e4d4f55:

  f2fs: introduce update_ckpt_flags to clean up (2016-09-30 17:55:24 -0700)

----------------------------------------------------------------
In this round, we've investigated how f2fs deals with errors given by our fault
injection facility. With this, we could fix several corner cases. And, in order
to improve the performance, we set inline_dentry by default and enhance the
exisiting discard issue flow. In addition, we added f2fs_migrate_page for better
memory management.

= Enhancement =
 - set inline_dentry by default
 - improve discard issue flow
 - add more fault injection cases in f2fs
 - allow block preallocation for encrypted files
 - introduce migrate_page callback function
 - avoid truncating the next direct node block at every checkpoint

= Bug fixes =
 - set page flag correctly between write_begin and write_end
 - missing error handling cases detected by fault injection
 - preallocate blocks regarding to 4KB alignement correctly
 - dentry and filename handling of encryption
 - lost xattrs of directories

----------------------------------------------------------------
Chao Yu (32):
      f2fs: clean up bio cache trace
      f2fs: set dirty state for filesystem only when updating meta data
      f2fs: clean up foreground GC flow
      f2fs: avoid unneeded loop in build_sit_entries
      f2fs: fix to do f2fs_balance_fs in f2fs_map_blocks correctly
      f2fs: check return value of write_checkpoint during fstrim
      f2fs: remove redundant judgement condition in available_free_memory
      f2fs: fix to preallocate block only aligned to 4K
      f2fs: enable inline_dentry by default and add noinline_dentry option
      f2fs: schedule in between two continous batch discards
      f2fs: do in batch synchronously readahead during GC
      f2fs: fix to do security initialization of encrypted inode with original filename
      f2fs crypto: avoid unneeded memory allocation in ->readdir
      f2fs: support async discard
      f2fs: fix to set superblock dirty correctly
      f2fs: fix minor typo
      f2fs: fix to detect temporary name of multimedia file
      MAINTAINERS: update f2fs entry
      f2fs: make f2fs_filetype_table static
      f2fs: fix to return error number of read_all_xattrs correctly
      f2fs: support IO error injection
      f2fs: show dirty inode number
      f2fs: fix to avoid race condition when updating sbi flag
      f2fs: introduce cp_lock to protect updating of ckpt_flags
      f2fs: adjust display format of segment bit
      f2fs: support configuring fault injection per superblock
      f2fs: do fault injection initialization in default_options
      f2fs: fix to recover old fault injection config in ->remount_fs
      f2fs: support checkpoint error injection
      f2fs: remove redundant io plug
      f2fs: fix to commit bio cache after flushing node pages
      f2fs: don't submit irrelevant page

Eric Biggers (1):
      f2fs: do not unnecessarily null-terminate encrypted symlink data

Fan Li (2):
      f2fs: fix parameters of __exchange_data_block
      f2fs: exclude special cases for f2fs_move_file_range

Jaegeuk Kim (19):
      f2fs: do not use discard_map for hard disks
      f2fs: reduce batch size of fstrim
      f2fs: fix lost xattrs of directories
      f2fs: set dentry bits on random location in memory
      f2fs: no need to make zeros beyond i_size
      f2fs: avoid page allocation for truncating partial inline_data
      f2fs: check free_sections for defragmentation
      f2fs: add common iget in add_fsync_inode
      f2fs: avoid ENOMEM during roll-forward recovery
      f2fs: fix to set PageUptodate in f2fs_write_end correctly
      f2fs: handle error in recover_orphan_inode
      f2fs: use crc and cp version to determine roll-forward recovery
      f2fs: put directory inodes before checkpoint in roll-forward recovery
      f2fs: assign return value in f2fs_gc
      f2fs: should put_page for summary page
      f2fs: avoid gc in cp_error case
      f2fs: handle errors during recover_orphan_inodes
      f2fs: remove dirty inode pages in error path
      f2fs: introduce update_ckpt_flags to clean up

Sheng Yong (2):
      f2fs: remove unnecessary initialization
      f2fs: remove dead variable

Shuoran Liu (3):
      f2fs: fix a bug when using namehash to locate dentry bucket
      f2fs: set encryption name flag in add inline entry path
      f2fs: add roll-forward recovery process for encrypted dentry

Tiezhu Yang (2):
      f2fs: remove dead code f2fs_check_acl
      f2fs: introduce get_checkpoint_version for cleanup

Wei Yongjun (1):
      f2fs: fix non static symbol warning

Weichao Guo (1):
      f2fs: add customized migrate_page callback

Yunlei He (6):
      f2fs: not allow to write illegal blkaddr
      f2fs: add discard info to sys entry of f2fs status
      f2fs: skip new checkpoint when doing fstrim without fs change
      f2fs: forbid to do fstrim if fs has some error
      f2fs: preallocate blocks for encrypted file
      f2fs: remove redundant value definition

 Documentation/filesystems/f2fs.txt |   1 +
 MAINTAINERS                        |   5 +-
 fs/f2fs/acl.c                      |  12 +-
 fs/f2fs/acl.h                      |   1 -
 fs/f2fs/checkpoint.c               | 205 +++++++++++++++++++++-------------
 fs/f2fs/data.c                     | 131 +++++++++++++++++-----
 fs/f2fs/debug.c                    |  17 ++-
 fs/f2fs/dir.c                      | 110 +++++++++++--------
 fs/f2fs/f2fs.h                     | 175 +++++++++++++++++++----------
 fs/f2fs/file.c                     |  20 +++-
 fs/f2fs/gc.c                       |  90 +++++++++------
 fs/f2fs/inline.c                   |  25 +++--
 fs/f2fs/inode.c                    |  17 ++-
 fs/f2fs/namei.c                    |  15 ++-
 fs/f2fs/node.c                     |  33 ++++--
 fs/f2fs/node.h                     |  77 ++++++++-----
 fs/f2fs/recovery.c                 | 124 +++++++++------------
 fs/f2fs/segment.c                  | 219 +++++++++++++++++++++++++++----------
 fs/f2fs/segment.h                  |  11 +-
 fs/f2fs/super.c                    |  93 ++++++++--------
 fs/f2fs/xattr.c                    |  39 ++++---
 include/linux/f2fs_fs.h            |   1 +
 include/trace/events/f2fs.h        |  18 ++-
 23 files changed, 915 insertions(+), 524 deletions(-)

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
