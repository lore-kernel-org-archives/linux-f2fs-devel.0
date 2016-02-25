From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: fix to avoid deadlock when merging
	inline data
Date: Thu, 25 Feb 2016 17:42:49 +0800
Message-ID: <013201d16fb0$fbe1edf0$f3a5c9d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aYsSP-0004cJ-8V
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 09:43:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aYsSN-0000te-Pd
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 09:43:37 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3302V03KCG2P90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 18:43:28 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When testing with fsstress, kworker and user threads were both blocked:

INFO: task kworker/u16:1:16580 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u16:1   D ffff8803f2595390     0 16580      2 0x00000000
Workqueue: writeback bdi_writeback_workfn (flush-251:0)
 ffff8802730e5760 0000000000000046 ffff880274729fc0 0000000000012440
 ffff8802730e5fd8 ffff8802730e4010 0000000000012440 0000000000012440
 ffff8802730e5fd8 0000000000012440 ffff880274729fc0 ffff88026eb50000
Call Trace:
 [<ffffffff816fe9d9>] schedule+0x29/0x70
 [<ffffffff816ff895>] rwsem_down_read_failed+0xa5/0xf9
 [<ffffffff81378584>] call_rwsem_down_read_failed+0x14/0x30
 [<ffffffffa0694feb>] f2fs_write_data_page+0x31b/0x420 [f2fs]
 [<ffffffffa0690f1a>] __f2fs_writepage+0x1a/0x50 [f2fs]
 [<ffffffffa06922a0>] f2fs_write_data_pages+0xe0/0x290 [f2fs]
 [<ffffffff811473b3>] do_writepages+0x23/0x40
 [<ffffffff811cc3ee>] __writeback_single_inode+0x4e/0x250
 [<ffffffff811cd4f1>] writeback_sb_inodes+0x2c1/0x470
 [<ffffffff811cd73e>] __writeback_inodes_wb+0x9e/0xd0
 [<ffffffff811cda0b>] wb_writeback+0x1fb/0x2d0
 [<ffffffff811cdb7c>] wb_do_writeback+0x9c/0x220
 [<ffffffff811ce232>] bdi_writeback_workfn+0x72/0x1c0
 [<ffffffff8106b74e>] process_one_work+0x1de/0x5b0
 [<ffffffff8106e78f>] worker_thread+0x11f/0x3e0
 [<ffffffff810750ce>] kthread+0xde/0xf0
 [<ffffffff817093f8>] ret_from_fork+0x58/0x90

fsstress thread stack:
 [<ffffffff81139f0e>] sleep_on_page+0xe/0x20
 [<ffffffff81139ef7>] __lock_page+0x67/0x70
 [<ffffffff8113b100>] find_lock_page+0x50/0x80
 [<ffffffff8113b24f>] find_or_create_page+0x3f/0xb0
 [<ffffffffa06983a9>] sync_node_pages+0x259/0x810 [f2fs]
 [<ffffffffa068d874>] write_checkpoint+0x1a4/0xce0 [f2fs]
 [<ffffffffa0686b0c>] f2fs_sync_fs+0x7c/0xd0 [f2fs]
 [<ffffffffa067c813>] f2fs_sync_file+0x143/0x5f0 [f2fs]
 [<ffffffff811d301b>] vfs_fsync_range+0x2b/0x40
 [<ffffffff811d304c>] vfs_fsync+0x1c/0x20
 [<ffffffff811d3291>] do_fsync+0x41/0x70
 [<ffffffff811d32d3>] SyS_fdatasync+0x13/0x20
 [<ffffffff817094a2>] system_call_fastpath+0x16/0x1b
 [<ffffffffffffffff>] 0xffffffffffffffff

The reason of this issue is:
CPU0:					CPU1:
 - f2fs_write_data_pages
					 - f2fs_sync_fs
					  - write_checkpoint
					   - block_operations
					    - f2fs_lock_all
					     - down_write(sbi->cp_rwsem)
  - lock_page(page)
  - f2fs_write_data_page
					    - sync_node_pages
					     - flush_inline_data
					      - pagecache_get_page(page, GFP_LOCK)
   - f2fs_lock_op
    - down_read(sbi->cp_rwsem)

This patch alters to use trylock_page in flush_inline_data to fix this ABBA
deadlock issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7b613dd..689610c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1203,10 +1203,13 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	if (!inode)
 		return;
 
-	page = pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
+	page = pagecache_get_page(inode->i_mapping, 0, FGP_NOWAIT, 0);
 	if (!page)
 		goto iput_out;
 
+	if (!trylock_page(page))
+		goto page_out;
+
 	if (!PageUptodate(page))
 		goto page_out;
 
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
