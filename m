From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: write pending bios when cp_error is set
Date: Thu, 31 Dec 2015 15:49:51 -0800
Message-ID: <1451605794-5636-2-git-send-email-jaegeuk@kernel.org>
References: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aEmyv-0003IO-9e
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aEmyu-00073l-FO for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:09 +0000
In-Reply-To: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When testing ioc_shutdown, put_super is able to be hanged by waiting for
writebacking pages as follows.

INFO: task umount:2723 blocked for more than 120 seconds.
      Tainted: G           O    4.4.0-rc3+ #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
umount          D ffff88000859f9d8     0  2723   2110 0x00000000
 ffff88000859f9d8 0000000000000000 0000000000000000 ffffffff81e11540
 ffff880078c225c0 ffff8800085a0000 ffff88007fc17440 7fffffffffffffff
 ffffffff818239f0 ffff88000859fb48 ffff88000859f9f0 ffffffff8182310c
Call Trace:
 [<ffffffff818239f0>] ? bit_wait+0x50/0x50
 [<ffffffff8182310c>] schedule+0x3c/0x90
 [<ffffffff81827fb9>] schedule_timeout+0x2d9/0x430
 [<ffffffff810e0f8f>] ? mark_held_locks+0x6f/0xa0
 [<ffffffff8111614d>] ? ktime_get+0x7d/0x140
 [<ffffffff818239f0>] ? bit_wait+0x50/0x50
 [<ffffffff8106a655>] ? kvm_clock_get_cycles+0x25/0x30
 [<ffffffff8111617c>] ? ktime_get+0xac/0x140
 [<ffffffff818239f0>] ? bit_wait+0x50/0x50
 [<ffffffff81822564>] io_schedule_timeout+0xa4/0x110
 [<ffffffff81823a25>] bit_wait_io+0x35/0x50
 [<ffffffff818235bd>] __wait_on_bit+0x5d/0x90
 [<ffffffff811b9e8b>] wait_on_page_bit+0xcb/0xf0
 [<ffffffff810d5f90>] ? autoremove_wake_function+0x40/0x40
 [<ffffffff811cf84c>] truncate_inode_pages_range+0x4bc/0x840
 [<ffffffff811cfc3d>] truncate_inode_pages_final+0x4d/0x60
 [<ffffffffc023ced5>] f2fs_evict_inode+0x75/0x400 [f2fs]
 [<ffffffff812639bc>] evict+0xbc/0x190
 [<ffffffff81263d19>] iput+0x229/0x2c0
 [<ffffffffc0241885>] f2fs_put_super+0x105/0x1a0 [f2fs]
 [<ffffffff8124756a>] generic_shutdown_super+0x6a/0xf0
 [<ffffffff812478f7>] kill_block_super+0x27/0x70
 [<ffffffffc0241290>] kill_f2fs_super+0x20/0x30 [f2fs]
 [<ffffffff81247b03>] deactivate_locked_super+0x43/0x70
 [<ffffffff81247f4c>] deactivate_super+0x5c/0x60
 [<ffffffff81268d2f>] cleanup_mnt+0x3f/0x90
 [<ffffffff81268dc2>] __cleanup_mnt+0x12/0x20
 [<ffffffff810ac463>] task_work_run+0x73/0xa0
 [<ffffffff810032ac>] exit_to_usermode_loop+0xcc/0xd0
 [<ffffffff81003e7c>] syscall_return_slowpath+0xcc/0xe0
 [<ffffffff81829ea2>] int_ret_from_sys_call+0x25/0x9f

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/data.c       | 2 +-
 fs/f2fs/node.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6b89ac6..5dbafd5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -237,7 +237,7 @@ static int f2fs_write_meta_page(struct page *page,
 	dec_page_count(sbi, F2FS_DIRTY_META);
 	unlock_page(page);
 
-	if (wbc->for_reclaim)
+	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_bio(sbi, META, WRITE);
 	return 0;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 14b40a9..4851e84 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1179,7 +1179,7 @@ out:
 	unlock_page(page);
 	if (need_balance_fs)
 		f2fs_balance_fs(sbi);
-	if (wbc->for_reclaim) {
+	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
 		remove_dirty_inode(inode);
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 94d9753..669c44e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1368,7 +1368,7 @@ static int f2fs_write_node_page(struct page *page,
 	up_read(&sbi->node_write);
 	unlock_page(page);
 
-	if (wbc->for_reclaim)
+	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_bio(sbi, NODE, WRITE);
 
 	return 0;
-- 
2.6.3


------------------------------------------------------------------------------
