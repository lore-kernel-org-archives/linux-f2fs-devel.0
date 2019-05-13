From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs-for-5.2
Date: Mon, 13 May 2019 16:38:18 -0700
Message-ID: <20190513233818.GA33287@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please consider this pull request?

Thanks as lways,

The following changes since commit 8ed86627f715eacbd6db6862f9499d6d96ea4ad6:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2019-04-03 06:11:12 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-v5.2-rc1

for you to fetch changes up to 2777e654371dd4207a3a7f4fb5fa39550053a080:

  f2fs: fix to avoid accessing xattr across the boundary (2019-05-09 09:43:29 -0700)

----------------------------------------------------------------
f2fs-for-5.2-rc1

Another round of various bug fixes came in. Damien improved SMR drive support a
bit, and Chao replaced BUG_ON() with reporting errors to user since we've not
hit from users but did hit from crafted images. We've found a disk layout bug
in large_nat_bits feature which supports very large NAT entries enabled at mkfs.
If the feature is enabled, it will give a notice to run fsck to correct the
on-disk layout.

Enhancement:
 - reduce memory consumption for SMR drive
 - better discard handling for multiple partitions
 - tracepoints for f2fs_file_write_iter/f2fs_filemap_fault
 - allow to change CP_CHKSUM_OFFSET
 - detect wrong layout of large_nat_bitmap feature
 - enhance checking valid data indices

Bug fix:
 - Multiple partition support for SMR drive
 - deadlock problem in f2fs_balance_fs_bg
 - add boundary checks to fix abnormal behaviors on fuzzed images
 - inline_xattr space calculations
 - replace f2fs_bug_on with errors

In addition, this series contains various memory boundary check and sanity check
of on-disk consistency.

----------------------------------------------------------------
Chao Yu (31):
      f2fs: fix potential recursive call when enabling data_flush
      f2fs: add comment for conditional compilation statement
      f2fs: add tracepoint for f2fs_file_write_iter()
      f2fs: fix to avoid deadloop in foreground GC
      f2fs: fix error path of recovery
      f2fs: fix to retrieve inline xattr space
      f2fs: fix to use inline space only if inline_xattr is enable
      f2fs: fix to avoid panic in dec_valid_block_count()
      f2fs: fix to avoid panic in dec_valid_node_count()
      f2fs: fix wrong __is_meta_io() macro
      f2fs: remove new blank line of f2fs kernel message
      f2fs: fix to clear dirty inode in error path of f2fs_iget()
      f2fs: fix to avoid panic in f2fs_remove_inode_page()
      f2fs: fix to do checksum even if inode page is uptodate
      f2fs: fix to do sanity check on free nid
      f2fs: fix to avoid panic in do_recover_data()
      f2fs: fix to do sanity check on valid node/block count
      f2fs: fix to do sanity check on valid block count of segment
      f2fs: fix to avoid panic in f2fs_inplace_write_data()
      f2fs: fix to set FI_UPDATE_WRITE correctly
      f2fs: introduce f2fs_read_single_page() for cleanup
      f2fs: allow address pointer number of dnode aligning to specified size
      f2fs: allow unfixed f2fs_checkpoint.checksum_offset
      f2fs: relocate chksum_offset for large_nat_bitmap feature
      f2fs: fix to consider multiple device for readonly check
      f2fs: fix to skip recovery on readonly device
      f2fs: fix to be aware of readonly device in write_checkpoint()
      f2fs: fix to handle error in f2fs_disable_checkpoint()
      f2fs: introduce DATA_GENERIC_ENHANCE
      f2fs: add tracepoint for f2fs_filemap_fault()
      f2fs: fix to avoid potential race on sbi->unusable_block_count access/update

Chengguang Xu (1):
      f2fs: remove redundant check in f2fs_file_write_iter()

Damien Le Moal (3):
      f2fs: Fix use of number of devices
      f2fs: Reduce zoned block device memory usage
      f2fs: improve discard handling with multi-device volumes

Hariprasad Kelam (1):
      f2fs: data: fix warning Using plain integer as NULL pointer

Park Ju Hyung (1):
      f2fs: mark is_extension_exist() inline

Randall Huang (1):
      f2fs: fix to avoid accessing xattr across the boundary

Youngjun Yoo (2):
      f2fs: insert space before the open parenthesis '('
      f2fs: Replace spaces with tab

 fs/f2fs/acl.c               |   4 +-
 fs/f2fs/checkpoint.c        | 108 +++++++++++++----
 fs/f2fs/data.c              | 285 +++++++++++++++++++++++++-------------------
 fs/f2fs/f2fs.h              | 127 +++++++++++++++-----
 fs/f2fs/file.c              |  76 +++++++-----
 fs/f2fs/gc.c                |  16 ++-
 fs/f2fs/inline.c            |  17 +++
 fs/f2fs/inode.c             |  12 +-
 fs/f2fs/namei.c             |   2 +-
 fs/f2fs/node.c              |  43 +++++--
 fs/f2fs/recovery.c          |  37 +++++-
 fs/f2fs/segment.c           |  71 ++++++-----
 fs/f2fs/segment.h           |  16 +--
 fs/f2fs/super.c             |  70 ++++++++---
 fs/f2fs/xattr.c             |  36 ++++--
 fs/f2fs/xattr.h             |   2 +
 include/linux/f2fs_fs.h     |  11 +-
 include/trace/events/f2fs.h |  57 +++++++++
 18 files changed, 688 insertions(+), 302 deletions(-)
