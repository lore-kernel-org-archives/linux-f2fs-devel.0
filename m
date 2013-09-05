From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [GIT PULL] f2fs updates for v3.12
Date: Thu, 05 Sep 2013 17:08:46 +0900
Message-ID: <1378368526.2354.96.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VHUcg-0004qd-9x
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Sep 2013 08:09:02 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VHUce-0003cT-2S for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Sep 2013 08:09:02 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MSN00L3O7YTOVH0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Sep 2013 17:08:53 +0900 (KST)
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
Cc: "Linux FS DEV, Mailing List" <linux-fsdevel@vger.kernel.org>, "Linux Kernel,
	Mailing List" <linux-kernel@vger.kernel.org>, "Linux F2FS DEV,
	Mailing List" <linux-f2fs-devel@lists.sourceforge.net>

Hi Linus,

Here is the pull request on f2fs updates for v3.12.
This patch-set includes several enhancements such as inline-xattrs, sysfs,
proc entry, and performance improvement at worst case scenarios.
It also includes some bug fixes.
Thank you very much.

The following changes since commit 36f571e9ed0419e73d127e18aa8992ced867268c:

  Merge tag 'firewire-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394 (2013-07-29 17:08:22 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-3.12

for you to fetch changes up to a26b7c8a0149ce1e3b6a10f2801aada6e447e4e7:

  f2fs: optimize gc for better performance (2013-09-05 13:50:32 +0900)

----------------------------------------------------------------
f2fs updates for v3.12

This patch-set includes the following major enhancement patches.
o support inline xattrs
o add sysfs support to control GCs explicitly
o add proc entry to show the current segment usage information
o improve the GC/SSR performance

The other bug fixes are as follows.
o avoid the overflow on status calculation
o fix some error handling routines
o fix inconsistent xattr states after power-off-recovery
o fix incorrect xattr node offset definition
o fix deadlock condition in fsync
o fix the fdatasync routine for power-off-recovery

----------------------------------------------------------------
Changman Lee (1):
      f2fs: add description for fsck.f2fs and dump.f2fs

Dan Carpenter (2):
      f2fs: remove an unneeded kfree(NULL)
      f2fs: alloc_page() doesn't return an ERR_PTR

Gu Zheng (8):
      f2fs: add a help func F2FS_STAT() to get the f2fs_stat_info
      f2fs: introduce help function F2FS_NODE()
      f2fs: use seq_puts()/seq_putc() rather than seq_printf() where possible
      f2fs: use list_for_each rather than list_for_each_safe, in remove_orphan_inode()
      f2fs: move bio_private allocation out of f2fs_bio_alloc()
      f2fs: clean up the needless end 'return' of void function
      f2fs: fix a compound statement label error
      f2fs: use strncasecmp() simplify the string comparison

Jaegeuk Kim (21):
      f2fs: recover date requested by fdatasync
      f2fs: add proc entry to monitor current usage of segments
      f2fs: update file name in the inode block during f2fs_rename
      f2fs: fix i_name during f2fs_sync_file
      f2fs: fix handling orphan inodes
      f2fs: fix a build failure due to missing the kobject header
      f2fs: fix the use of XATTR_NODE_OFFSET
      f2fs: fix inconsistency between xattr node blocks and its inode
      f2fs: introduce cur_cp_version function to reduce code size
      f2fs: check the free space first in new_node_page
      f2fs: should cover i_xattr_nid with its xattr node page lock
      f2fs: fix wrong BUG_ON condition
      f2fs: add flags for inline xattrs
      f2fs: reserve the xattr space dynamically
      f2fs: introduce __find_xattr for readability
      f2fs: add the truncate_xattr_node function
      f2fs: support the inline xattrs
      f2fs: fix omitting to update inode page
      f2fs: trigger GC when there are prefree segments
      f2fs: avoid an overflow during utilization calculation
      f2fs: merge more bios of node block writes

Jin Xu (3):
      f2fs: fix a deadlock in fsync
      f2fs: avoid writing inode redundantly when creating a file
      f2fs: optimize gc for better performance

Namjae Jeon (3):
      f2fs: add sysfs support for controlling the gc_thread
      f2fs: add sysfs entries to select the gc policy
      f2fs: remove redundant code from f2fs_write_begin

Wei Yongjun (1):
      f2fs: fix error return code in init_f2fs_fs()

Zhao Hongjiang (1):
      f2fs: fix memory leak when init f2fs filesystem fail

 Documentation/ABI/testing/sysfs-fs-f2fs |  26 +++
 Documentation/filesystems/f2fs.txt      |  75 ++++++++-
 fs/f2fs/checkpoint.c                    |  24 ++-
 fs/f2fs/data.c                          |  28 ++--
 fs/f2fs/debug.c                         |  34 ++--
 fs/f2fs/dir.c                           |  19 ++-
 fs/f2fs/f2fs.h                          | 106 +++++++++---
 fs/f2fs/file.c                          |  25 ++-
 fs/f2fs/gc.c                            |  58 ++++---
 fs/f2fs/gc.h                            |  38 +++--
 fs/f2fs/inode.c                         |  15 +-
 fs/f2fs/namei.c                         |  33 ++--
 fs/f2fs/node.c                          | 100 +++++++----
 fs/f2fs/node.h                          |  44 +++--
 fs/f2fs/recovery.c                      |  29 ++--
 fs/f2fs/segment.c                       |  41 +++--
 fs/f2fs/segment.h                       |   6 +-
 fs/f2fs/super.c                         | 209 ++++++++++++++++++++++-
 fs/f2fs/xattr.c                         | 289 ++++++++++++++++++++------------
 fs/f2fs/xattr.h                         |  15 +-
 include/linux/f2fs_fs.h                 |  20 ++-
 21 files changed, 890 insertions(+), 344 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-f2fs

-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
