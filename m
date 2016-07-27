From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs for 4.8
Date: Tue, 26 Jul 2016 21:08:00 -0700
Message-ID: <20160727040800.GA69756@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bSG8g-00059B-0u
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jul 2016 04:08:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bSG8e-0006Bn-Rf
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jul 2016 04:08:09 +0000
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

The following changes since commit 4340fa55298d17049e71c7a34e04647379c269f3:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2016-06-02 15:08:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.8

for you to fetch changes up to 5302fb000def84100740a84d7f176c0e167b2141:

  f2fs: clean up coding style and redundancy (2016-07-25 12:58:12 -0700)

----------------------------------------------------------------
The major change in this version is mitigating cpu overheads on write paths by
replacing redundant inode page updates with mark_inode_dirty calls. And we tried
to reduce lock contentions as well to improve filesystem scalability.
Other feature is setting F2FS automatically when detecting host-managed SMR.

= Enhancement =
 - ioctl to move a range of data between files
 - inject orphan inode errors
 - avoid flush commands congestion
 - support lazytime

= Bug fixes =
 - return proper results for some dentry operations
 - fix deadlock in add_link failure
 - disable extent_cache for fcollapse/finsert

----------------------------------------------------------------
Chao Yu (9):
      f2fs: fix to avoid reading out encrypted data in page cache
      f2fs: fix to detect truncation prior rather than EIO during read
      f2fs: fix to redirty page if fail to gc data page
      f2fs: add nodiscard mount option
      f2fs: fix incorrect f_bfree calculation in ->statfs
      f2fs: fix to avoid redundant discard during fstrim
      f2fs: fix to avoid data update racing between GC and DIO
      f2fs: reset default idle interval value
      f2fs: fix to report error number of f2fs_find_entry

Jaegeuk Kim (54):
      Revert "f2fs: no need inc dirty pages under inode lock"
      f2fs: use inode pointer for {set, clear}_inode_flag
      f2fs: introduce f2fs_i_size_write with mark_inode_dirty_sync
      f2fs: introduce f2fs_i_blocks_write with mark_inode_dirty_sync
      f2fs: introduce f2fs_i_links_write with mark_inode_dirty_sync
      f2fs: call mark_inode_dirty_sync for i_field changes
      f2fs: flush inode metadata when checkpoint is doing
      f2fs: remove syncing inode page in all the cases
      f2fs: avoid unnecessary updating inode during fsync
      f2fs: add lazytime mount option
      f2fs: detect congestion of flush command issues
      f2fs: set flush_merge by default
      f2fs: remove writepages lock
      f2fs: propagate error given by f2fs_find_entry
      f2fs: inject to produce some orphan inodes
      f2fs: do not skip writing data pages
      f2fs: remove two steps to flush dirty data pages
      f2fs: return error of f2fs_lookup
      f2fs: handle writepage correctly
      f2fs: remove deprecated parameter
      f2fs: avoid wrong count on dirty inodes
      f2fs: remove obsolete parameter in f2fs_truncate
      f2fs: avoid data race between FI_DIRTY_INODE flag and update_inode
      f2fs: fix wrong percentage
      f2fs: control not to exceed # of cached nat entries
      f2fs: set mapping error for EIO
      f2fs: avoid reverse IO order for NODE and DATA
      f2fs: drop any block plugging
      f2fs: skip clean segment for gc
      f2fs: introduce mode=lfs mount option
      f2fs: fix deadlock in add_link failure
      f2fs: report error for f2fs_parent_dir
      f2fs: call update_inode_page for orphan inodes
      f2fs: detect host-managed SMR by feature flag
      f2fs: produce more nids and reduce readahead nats
      f2fs: avoid writing node/metapages during writes
      f2fs: avoid latency-critical readahead of node pages
      f2fs: introduce f2fs_set_page_dirty_nobuffer
      f2fs: call SetPageUptodate if needed
      f2fs: shrink critical region in spin_lock
      f2fs: skip to check the block address of node page
      f2fs: use percpu_rw_semaphore
      f2fs: move i_size_write in f2fs_write_end
      f2fs: avoid mark_inode_dirty
      f2fs: fix ERR_PTR returned by bio
      f2fs: refactor __exchange_data_block for speed up
      f2fs: disable extent_cache for fcollapse/finsert inodes
      f2fs: add maximum prefree segments
      f2fs: use blk_plug in all the possible paths
      f2fs: avoid memory allocation failure due to a long length
      f2fs: support an ioctl to move a range of data blocks
      f2fs: avoid data race when deciding checkpoin in f2fs_sync_file
      f2fs: handle error case with f2fs_bug_on
      f2fs: clean up coding style and redundancy

Sheng Yong (1):
      f2fs: find parent dentry correctly

Tiezhu Yang (1):
      f2fs: remove unnecessary goto statement

Yunlei He (2):
      f2fs: avoid mismatching block range for discard
      f2fs: get victim segment again after new cp

Yunlong Song (1):
      f2fs: return the errno to the caller to avoid using a wrong page

 Documentation/filesystems/f2fs.txt |   7 +-
 fs/f2fs/acl.c                      |   9 +-
 fs/f2fs/acl.h                      |   2 +-
 fs/f2fs/checkpoint.c               |  80 ++++--
 fs/f2fs/data.c                     | 307 ++++++++++++-----------
 fs/f2fs/debug.c                    |   5 +-
 fs/f2fs/dir.c                      | 123 ++++-----
 fs/f2fs/extent_cache.c             |  50 ++--
 fs/f2fs/f2fs.h                     | 286 +++++++++++++++------
 fs/f2fs/file.c                     | 499 +++++++++++++++++++++++++++----------
 fs/f2fs/gc.c                       |  52 +++-
 fs/f2fs/inline.c                   |  92 +++----
 fs/f2fs/inode.c                    |  53 ++--
 fs/f2fs/namei.c                    | 147 ++++++-----
 fs/f2fs/node.c                     | 144 ++++++-----
 fs/f2fs/node.h                     |  14 +-
 fs/f2fs/recovery.c                 |  23 +-
 fs/f2fs/segment.c                  |  59 ++++-
 fs/f2fs/segment.h                  |  22 +-
 fs/f2fs/shrinker.c                 |   5 +-
 fs/f2fs/super.c                    | 134 +++++++++-
 fs/f2fs/xattr.c                    |  20 +-
 22 files changed, 1385 insertions(+), 748 deletions(-)

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
