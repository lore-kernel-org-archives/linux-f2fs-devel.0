From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs: update for 4.14-rc1
Date: Tue, 12 Sep 2017 17:32:21 -0700
Message-ID: <20170913003221.GA17027@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1drvbR-0008GP-9B
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Sep 2017 00:32:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1drvbP-0008E2-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Sep 2017 00:32:29 +0000
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
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi Linus,

Could you please consider this pull request?

Thanks all the time,

The following changes since commit fd2b2c57ec2020ae1b5e24717a876c71e31e5ab8:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/j=
ejb/scsi (2017-07-25 20:10:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-=
for-4.14

for you to fetch changes up to e6c6de18f010d9a7d592f4044d2c30213cb3a7bc:

  f2fs: hurry up to issue discard after io interruption (2017-09-12 10:02:5=
5 -0700)

----------------------------------------------------------------
for-f2fs-4.14

In this round, we've mostly tuned f2fs to provide better user experience
for Android. Especially, we've worked on atomic write feature again with
SQLite community in order to support it officially. And we added or modified
several facilities to analyze and enhance IO behaviors.

Major changes include:
- add app/fs io stat
- add inode checksum feature
- support project/journalled quota
- enhance atomic write with new ioctl() which exposes feature set
- enhance background gc/discard/fstrim flows with new gc_urgent mode
- add F2FS_IOC_FS{GET,SET}XATTR
- fix some quota flows

----------------------------------------------------------------
Arvind Yadav (1):
      f2fs: constify super_operations

Chao Yu (28):
      f2fs: spread struct f2fs_dentry_ptr for inline path
      f2fs: make background threads of f2fs being aware of freezing
      f2fs: make max inline size changeable
      f2fs: enhance on-disk inode structure scalability
      f2fs: record quota during dot{,dot} recovery
      f2fs: support project quota
      f2fs: support F2FS_IOC_FS{GET,SET}XATTR
      f2fs: introduce f2fs_statfs_project
      f2fs: support inode checksum
      f2fs: add app/fs io stat
      f2fs: avoid unneeded sync on quota file
      f2fs: fix potential overflow when adjusting GC cycle
      f2fs: support journalled quota
      f2fs: retry to revoke atomic commit in -ENOMEM case
      f2fs: add tracepoint for f2fs_gc
      f2fs: introduce discard_granularity sysfs entry
      f2fs: fix out-of-order execution in f2fs_issue_flush
      f2fs: clear FI_HOT_DATA correctly
      f2fs: trigger normal fsync for non-atomic_write file
      f2fs: fix to avoid race in between aio and gc
      f2fs: trigger fdatasync for non-atomic_write file
      f2fs: update i_flags correctly
      f2fs: remove unneeded parameter of change_curseg
      f2fs: avoid race in between atomic_read & atomic_inc
      f2fs: fix to wake up all sleeping flusher
      f2fs: detect dirty inode in evict_inode
      f2fs: fix to show correct discard_granularity in sysfs
      f2fs: hurry up to issue discard after io interruption

Daeho Jeong (1):
      f2fs: clear radix tree dirty tag of pages whose dirty flag is cleared

Ernesto A. Fern=E1ndez (1):
      f2fs: preserve i_mode if __f2fs_set_acl() fails

Jaegeuk Kim (22):
      f2fs: give a try to do atomic write in -ENOMEM case
      f2fs: don't give partially written atomic data from process crash
      f2fs: add ioctl to expose current features
      f2fs: avoid naming confusion of sysfs init
      f2fs: don't need to wait for node writes for atomic write
      f2fs: return wrong error number on f2fs_quota_write
      f2fs: expose features to sysfs entry
      f2fs: use printk_ratelimited for f2fs_msg
      f2fs: use IPU for cold files
      f2fs: introduce gc_urgent mode for background GC
      f2fs: let fill_super handle roll-forward errors
      f2fs: check hot_data for roll-forward recovery
      f2fs: issue discard commands if gc_urgent is set
      f2fs: return error when accessing insane flie offset
      f2fs: wake up discard_thread iff there is a candidate
      f2fs: don't need to update inode checksum for recovery
      f2fs: don't check inode's checksum if it was dirtied or writebacked
      f2fs: introduce f2fs_encrypted_file for clean-up
      f2fs: use generic terms used for encrypted block management
      f2fs: make get_lock_data_page to handle encrypted inode
      f2fs: better to wait for fstrim completion
      f2fs: speed up gc_urgent mode with SSR

Qiuyang Sun (1):
      f2fs: merge equivalent flags F2FS_GET_BLOCK_[READ|DIO]

Yunlei He (3):
      f2fs: remove unused input parameter
      f2fs: alloc new nids for xattr block in recovery
      f2fs: avoid race in between read xattr & write xattr

Yunlong Song (6):
      f2fs: provide f2fs_balance_fs to __write_node_page
      f2fs: update cur_valid_map_mir together with cur_valid_map
      f2fs: do not change the valid_block value if cur_valid_map was wrongl=
y set or cleared
      f2fs: fix the size value in __check_sit_bitmap
      f2fs: remove unused function overprovision_sections
      Revert "f2fs: add a new function get_ssr_cost"

 Documentation/ABI/testing/sysfs-fs-f2fs |  21 ++
 Documentation/filesystems/f2fs.txt      |  19 ++
 fs/f2fs/acl.c                           |   5 +-
 fs/f2fs/checkpoint.c                    |  60 ++++-
 fs/f2fs/data.c                          | 177 +++++++------
 fs/f2fs/dir.c                           |   7 +
 fs/f2fs/f2fs.h                          | 285 ++++++++++++++++++---
 fs/f2fs/file.c                          | 360 ++++++++++++++++++++++----
 fs/f2fs/gc.c                            | 115 ++++++---
 fs/f2fs/gc.h                            |  27 +-
 fs/f2fs/inline.c                        | 142 ++++++-----
 fs/f2fs/inode.c                         | 132 +++++++++-
 fs/f2fs/namei.c                         |  43 ++++
 fs/f2fs/node.c                          |  79 ++++--
 fs/f2fs/recovery.c                      |  83 ++++--
 fs/f2fs/segment.c                       | 292 ++++++++++++++++-----
 fs/f2fs/segment.h                       |  47 ++--
 fs/f2fs/super.c                         | 433 ++++++++++++++++++++++++++++=
+---
 fs/f2fs/sysfs.c                         | 251 +++++++++++++++---
 fs/f2fs/xattr.c                         |   8 +-
 include/linux/f2fs_fs.h                 |  40 ++-
 include/trace/events/f2fs.h             | 113 ++++++++-
 22 files changed, 2228 insertions(+), 511 deletions(-)

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
