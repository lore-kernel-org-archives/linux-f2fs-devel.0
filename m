From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs update for 4.15-rc1
Date: Wed, 15 Nov 2017 20:07:16 -0800
Message-ID: <20171116040716.GA77527@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eFBSY-0006eR-6a
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 04:07:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eFBSU-0006Y2-Go
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 04:07:26 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi Linux,

Could you please consider this pull request?

Thanks,

The following changes since commit 7056964a85031f42e2360617b14272593729ce1b:

  Merge tag 'f2fs-for-4.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2017-10-10 11:04:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.15-rc1

for you to fetch changes up to ead710b7d82dc9e8184e10871c155a3ed8b3f673:

  f2fs: deny accessing encryption policy if encryption is off (2017-11-15 08:30:19 -0800)

----------------------------------------------------------------
f2fs-for-4.15-rc1

In this round, we introduce sysfile-based quota support which is required
for Android by default. In addition, we allow that users are able to reserve
some blocks in runtime to mitigate performance drops in low free space.

Enhancement
- assign proper data segments according to write_hints given by user
- issue cache_flush on dirty devices only among multiple devices
- exploit cp_error flag and add more faults to enhance fault injection test
- conduct more readaheads during f2fs_readdir
- add a range for discard commands

Bug fix
- fix zero stat->st_blocks when inline_data is set
- drop crypto key and free stale memory pointer while evict_inode is failing
- fix some corner cases in free space and segment management
- fix wrong last_disk_size

This series includes lots of clean-ups and code enhancement in terms of xattr
operations, discard/flush command control. In addition, it adds versatile
debugfs entries to monitor f2fs status.

----------------------------------------------------------------
Arnd Bergmann (1):
      f2fs: avoid using timespec

Chao Yu (41):
      Revert "f2fs: reuse nids more aggressively"
      f2fs: introduce read_inline_xattr
      f2fs: introduce read_xattr_block
      f2fs: show flush list status in sysfs
      f2fs: obsolete ALLOC_NID_LIST list
      f2fs: drop FI_UPDATE_WRITE tag after f2fs_issue_flush
      f2fs: fix to show ino management cache size correctly
      f2fs: enhance multiple device flush
      f2fs: fix to flush multiple device in checkpoint
      f2fs: support issuing/waiting discard in range
      f2fs: wrap discard policy
      f2fs: split discard policy
      f2fs: reduce cmd_lock coverage in __issue_discard_cmd
      f2fs: trace f2fs_remove_discard
      f2fs: give up CP_TRIMMED_FLAG if it drops discards
      f2fs: fix to avoid race when accessing last_disk_size
      f2fs: trace f2fs_lookup
      f2fs: trace f2fs_readdir
      f2fs: allow readdir() to be interrupted
      f2fs: relocate readahead codes in readdir()
      f2fs: update ctx->pos correctly when hitting hole in directory
      f2fs: fix to correct no_fggc_candidate
      f2fs: support flexible inline xattr size
      f2fs: add missing sysfs description
      f2fs: support get_page error injection
      f2fs: support bio allocation error injection
      f2fs: give correct trimmed blocks in fstrim
      f2fs: export SSR allocation threshold
      f2fs: use rw_semaphore to protect SIT cache
      f2fs: check curseg space before foreground GC
      f2fs: remove unneeded semicolon
      f2fs: remove dead code in update_meta_page
      f2fs: fix summary info corruption
      f2fs: avoid race in between GC and block exchange
      f2fs: keep isize once block is reserved cross EOF
      f2fs: trace checkpoint reason in fsync()
      f2fs: introduce scan_curseg_cache for cleanup
      f2fs: avoid opened loop codes in __add_ino_entry
      f2fs: fix to clear FI_NO_PREALLOC
      f2fs: inject fault in inc_valid_node_count
      f2fs: deny accessing encryption policy if encryption is off

Colin Ian King (1):
      f2fs: remove several redundant assignments

Fan Li (5):
      f2fs: add a function to move nid
      f2fs: optimize __update_nat_bits
      f2fs: save a multiplication for last_nid calculation
      f2fs: keep scanning until enough free nids are acquired
      f2fs: optimize the way of traversing free_nid_bitmap

Hsiang Kao (1):
      f2fs: allow readpages with NULL file pointer

Hyunchul Lee (1):
      f2fs: apply write hints to select the type of segments for buffered write

Jaegeuk Kim (15):
      f2fs/crypto: drop crypto key at evict_inode only
      f2fs: avoid stale fi->gdirty_list pointer
      f2fs: expose some sectors to user in inline data or dentry case
      f2fs: limit # of inmemory pages
      f2fs: retry ENOMEM for quota_read|write
      f2fs: remove obsolete pointer for truncate_xattr_node
      Revert "f2fs: return wrong error number on f2fs_quota_write"
      f2fs: stop all the operations by cp_error flag
      f2fs: show # of dirty segments via sysfs
      f2fs: add missing quota_initialize
      f2fs: show current cp state
      f2fs: handle error case when adding xattr entry
      f2fs: add quota_ino feature infra
      f2fs: support quota sys files
      f2fs: expose quota information in debugfs

Jeff Layton (1):
      f2fs: don't bother with inode->i_version

LiFan (1):
      f2fs: validate before set/clear free nat bitmap

Thomas Meyer (1):
      f2fs: Fix bool initialization/comparison

Weichao Guo (2):
      f2fs: convert inline data for direct I/O & FI_NO_PREALLOC
      f2fs: skip searching non-exist range in truncate_hole

Yunlei He (2):
      f2fs: modify for accurate fggc node io stat
      f2fs: separate nat entry mem alloc from nat_tree_lock

Yunlong Song (3):
      Revert "f2fs: node segment is prior to data segment selected victim"
      f2fs: support soft block reservation
      Revert "f2fs: handle dirty segments inside refresh_sit_entry"

 Documentation/ABI/testing/sysfs-fs-f2fs |  37 ++-
 fs/f2fs/acl.c                           |   3 +
 fs/f2fs/checkpoint.c                    |  64 +++-
 fs/f2fs/data.c                          |  37 ++-
 fs/f2fs/debug.c                         |  31 +-
 fs/f2fs/dir.c                           |  32 +-
 fs/f2fs/f2fs.h                          | 222 +++++++++++---
 fs/f2fs/file.c                          | 123 ++++++--
 fs/f2fs/gc.c                            |  37 ++-
 fs/f2fs/inline.c                        |   1 +
 fs/f2fs/inode.c                         |  26 +-
 fs/f2fs/namei.c                         | 101 +++++--
 fs/f2fs/node.c                          | 410 +++++++++++++------------
 fs/f2fs/node.h                          |  16 +-
 fs/f2fs/recovery.c                      |   8 +-
 fs/f2fs/segment.c                       | 509 ++++++++++++++++++++++++--------
 fs/f2fs/segment.h                       |  39 ++-
 fs/f2fs/shrinker.c                      |   2 +-
 fs/f2fs/super.c                         | 219 ++++++++++++--
 fs/f2fs/sysfs.c                         |  53 +++-
 fs/f2fs/xattr.c                         | 174 ++++++-----
 include/linux/f2fs_fs.h                 |  10 +-
 include/trace/events/f2fs.h             | 116 +++++++-
 23 files changed, 1648 insertions(+), 622 deletions(-)

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
