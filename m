From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs updates for v4.2
Date: Wed, 24 Jun 2015 13:25:24 -0700
Message-ID: <20150624202401.GA40031@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull the following patches?

Thank you,

The following changes since commit 68c2f356c9ec65e1eb50c31690b095673dbd8010:

  Merge tag 'for-f2fs-4.1-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2015-05-07 11:18:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.2

for you to fetch changes up to 3c45414527487549f469484337a4c5ae5d84dc80:

  f2fs: do not trim preallocated blocks when truncating after i_size (2015-06-11 18:30:49 -0700)

----------------------------------------------------------------
New features are:
 o per-file encryption (e.g., ext4)
 o FALLOC_FL_ZERO_RANGE
 o FALLOC_FL_COLLAPSE_RANGE
 o RENAME_WHITEOUT

Major enhancement/fixes are to:
 o recovery broken superblocks
 o enhance f2fs_trim_fs with a discard_map
 o fix a race condition on dentry block allocation
 o fix a deadlock during summary operation
 o fix a missing fiemap result

And many minor bug fixes and clean-ups were done.

----------------------------------------------------------------
Arnd Bergmann (1):
      f2fs: fix building on 32-bit architectures

Chao Yu (22):
      f2fs: make posix_acl_create() safer and cleaner
      f2fs: use is_valid_blkaddr to verify blkaddr for readability
      f2fs: make has_fsynced_inode static
      f2fs: remove unneeded f2fs_make_empty declaration
      f2fs: do not re-lookup nat cache with same nid
      f2fs: introduce f2fs_replace_block() for reuse
      f2fs: support FALLOC_FL_COLLAPSE_RANGE
      f2fs: support FALLOC_FL_ZERO_RANGE
      f2fs crypto: fix to release buffer for fname crypto
      f2fs crypto: fix incorrect release for crypto ctx
      f2fs crypto: zero next free dnode block
      f2fs: introduce update_meta_page
      f2fs: support RENAME_WHITEOUT
      f2fs: avoid duplicated code by reusing f2fs_read_end_io
      f2fs crypto: check context consistent for rename2
      f2fs crypto: allow setting encryption policy once
      f2fs crypto: do not set encryption policy for non-directory by ioctl
      f2fs: hide common code in f2fs_replace_block
      f2fs: support FALLOC_FL_INSERT_RANGE
      f2fs: setting discard option in parse_options()
      f2fs: skip committing valid superblock
      f2fs: do not trim preallocated blocks when truncating after i_size

Chenxi Mao (1):
      f2fs: disable the discard option when device doesn't support

Dan Carpenter (1):
      f2fs: cleanup a confusing indent

Jaegeuk Kim (54):
      f2fs: export more enums for tracepoint
      f2fs: add missing version info in superblock
      f2fs: move existing definitions into f2fs.h
      f2fs: add feature facility in superblock
      f2fs: add f2fs_map_blocks
      f2fs: introduce f2fs_commit_super
      f2fs: expose f2fs_mpage_readpages
      f2fs: clean up f2fs_lookup
      f2fs: add f2fs_may_inline_{data, dentry}
      f2fs: add sbi and page pointer in f2fs_io_info
      f2fs: move get_page for gc victims
      f2fs: introduce dot and dotdot name check
      f2fs: fix race on allocating and deallocating a dentry block
      f2fs: add need_dentry_mark
      f2fs: fix counting the number of inline_data inodes
      f2fs: split find_data_page according to specific purposes
      f2fs: revmove spin_lock for write_orphan_inodes
      f2fs: introduce discard_map for f2fs_trim_fs
      f2fs: issue discard with finally produced len and minlen
      f2fs: avoid value overflow in showing current status
      f2fs: report unwritten area in f2fs_fiemap
      f2fs crypto: declare some definitions for f2fs encryption feature
      f2fs crypto: add f2fs encryption Kconfig
      f2fs crypto: add encryption xattr support
      f2fs crypto: add encryption policy and password salt support
      f2fs crypto: add f2fs encryption facilities
      f2fs crypto: add encryption key management facilities
      f2fs crypto: filename encryption facilities
      f2fs crypto: activate encryption support for fs APIs
      f2fs crypto: add encryption support in read/write paths
      f2fs crypto: add filename encryption for f2fs_add_link
      f2fs crypto: add filename encryption for f2fs_readdir
      f2fs crypto: add filename encryption for f2fs_lookup
      f2fs crypto: add filename encryption for roll-forward recovery
      f2fs crypto: add symlink encryption
      f2fs crypto: fix missing key when reading a page
      f2fs crypto: remove checking key context during lookup
      f2fs: do not issue next dnode discard redundantly
      f2fs: avoid buggy functions
      f2fs: truncate data blocks for orphan inode
      f2fs crypto: use slab caches
      f2fs crypto: get rid of ci_mode from struct f2fs_crypt_info
      f2fs crypto: shrink size of the f2fs_crypto_ctx structure
      f2fs crypto: split f2fs_crypto_init/exit with two parts
      f2fs crypto: check encryption for tmpfile
      f2fs crypto: use per-inode tfm structure
      f2fs crypto: avoid f2fs_inherit_context for symlink
      f2fs crypto: clean up error handling in f2fs_fname_setup_filename
      f2fs: fix a deadlock for summary page lock vs. sentry_lock
      f2fs crypto: remove alloc_page for bounce_page
      f2fs: fix to return exact trimmed size
      f2fs: drop the volatile_write flag only
      f2fs crypto: fix to handle errors likewise ext4
      f2fs crypto: add alloc_bounce_page

Taehee Yoo (1):
      f2fs: add offset check routine before punch_hole() in f2fs_fallocate()

Yunlei He (1):
      f2fs: add default mount options to remount

hujianyang (2):
      f2fs: add compat_ioctl to provide backward compatability
      f2fs: recovering broken superblock during mount

 fs/f2fs/Kconfig             |  19 ++
 fs/f2fs/Makefile            |   2 +
 fs/f2fs/acl.c               |  46 ++--
 fs/f2fs/checkpoint.c        |  56 ++---
 fs/f2fs/crypto.c            | 491 ++++++++++++++++++++++++++++++++++++
 fs/f2fs/crypto_fname.c      | 440 ++++++++++++++++++++++++++++++++
 fs/f2fs/crypto_key.c        | 255 +++++++++++++++++++
 fs/f2fs/crypto_policy.c     | 209 ++++++++++++++++
 fs/f2fs/data.c              | 593 ++++++++++++++++++++++++++++++++------------
 fs/f2fs/debug.c             |  11 +-
 fs/f2fs/dir.c               | 194 ++++++++++-----
 fs/f2fs/f2fs.h              | 320 ++++++++++++++++++++++--
 fs/f2fs/f2fs_crypto.h       | 151 +++++++++++
 fs/f2fs/file.c              | 516 +++++++++++++++++++++++++++++++++++---
 fs/f2fs/gc.c                | 115 ++++++++-
 fs/f2fs/hash.c              |   3 +-
 fs/f2fs/inline.c            |  43 +++-
 fs/f2fs/inode.c             |   9 +-
 fs/f2fs/namei.c             | 374 ++++++++++++++++++++++------
 fs/f2fs/node.c              |  48 ++--
 fs/f2fs/node.h              |  22 --
 fs/f2fs/recovery.c          |  28 ++-
 fs/f2fs/segment.c           | 250 +++++++++++++------
 fs/f2fs/segment.h           |   1 +
 fs/f2fs/super.c             | 178 ++++++++++---
 fs/f2fs/trace.c             |   6 +-
 fs/f2fs/trace.h             |   4 +-
 fs/f2fs/xattr.c             |   3 +
 fs/f2fs/xattr.h             |   4 +
 include/linux/f2fs_fs.h     |   8 +
 include/trace/events/f2fs.h |  33 +--
 31 files changed, 3803 insertions(+), 629 deletions(-)
 create mode 100644 fs/f2fs/crypto.c
 create mode 100644 fs/f2fs/crypto_fname.c
 create mode 100644 fs/f2fs/crypto_key.c
 create mode 100644 fs/f2fs/crypto_policy.c
 create mode 100644 fs/f2fs/f2fs_crypto.h
