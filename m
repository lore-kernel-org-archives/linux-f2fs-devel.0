From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: fix potential deadlock when hitting
	checkpoint error
Date: Fri, 23 Sep 2016 13:24:58 +0800
Message-ID: <20160923052458.83849-3-yuchao0@huawei.com>
References: <20160923052458.83849-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bnIzJ-0004iK-8q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 05:25:29 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bnIzG-0003Zk-Dz
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 05:25:29 +0000
In-Reply-To: <20160923052458.83849-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

tests/generic/013 of fstest suit complains us with below dmesg when we
trigger checkpoint error injection in f2fs.

F2FS-fs : inject checkpoint error in sync_node_pages+0x69f/0x6f0 [f2fs]
F2FS-fs (zram0): Cannot recover all fsync data errno=-5
INFO: task mount:97685 blocked for more than 120 seconds.
      Tainted: G           OE   4.8.0-rc4 #11
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
mount           D ffff8801c1bf7960     0 97685  97397 0x00080000
 ffff8801c1bf7960 ffff8801c1bf7930 ffff880175900000 ffff8801c1bf7980
 ffff8801c1bf8000 0000000000000000 7fffffffffffffff ffff88021f7be340
 ffffffff817c8880 ffff8801c1bf7978 ffffffff817c80a5 ffff880214f58fc0
Call Trace:
 [<ffffffff817c8880>] ? bit_wait+0x50/0x50
 [<ffffffff817c80a5>] schedule+0x35/0x80
 [<ffffffff817cb152>] schedule_timeout+0x292/0x3d0
 [<ffffffff81022ab5>] ? xen_clocksource_get_cycles+0x15/0x20
 [<ffffffff810eeb5c>] ? ktime_get+0x3c/0xb0
 [<ffffffff817c8880>] ? bit_wait+0x50/0x50
 [<ffffffff817c7906>] io_schedule_timeout+0xa6/0x110
 [<ffffffff817c889b>] bit_wait_io+0x1b/0x60
 [<ffffffff817c84e4>] __wait_on_bit+0x64/0x90
 [<ffffffff8117dcd4>] wait_on_page_bit+0xc4/0xd0
 [<ffffffff810bc4d0>] ? autoremove_wake_function+0x40/0x40
 [<ffffffff81190a29>] truncate_inode_pages_range+0x409/0x840
 [<ffffffff811a406d>] ? pcpu_free_area+0x13d/0x1a0
 [<ffffffff810bc025>] ? wake_up_bit+0x25/0x30
 [<ffffffff81190ecc>] truncate_inode_pages_final+0x4c/0x60
 [<ffffffffa025e9e8>] f2fs_evict_inode+0x48/0x390 [f2fs]
 [<ffffffff812212f7>] evict+0xc7/0x1a0
 [<ffffffff81221f77>] iput+0x197/0x200
 [<ffffffffa0268242>] f2fs_fill_super+0xab2/0x1130 [f2fs]
 [<ffffffff81209454>] mount_bdev+0x184/0x1c0
 [<ffffffffa0267790>] ? f2fs_commit_super+0x100/0x100 [f2fs]
 [<ffffffffa02646a5>] f2fs_mount+0x15/0x20 [f2fs]
 [<ffffffff81209e19>] mount_fs+0x39/0x160
 [<ffffffff81225e47>] vfs_kern_mount+0x67/0x110
 [<ffffffff812283bb>] do_mount+0x1bb/0xc80
 [<ffffffff81229163>] SyS_mount+0x83/0xd0
 [<ffffffff8100391e>] do_syscall_64+0x6e/0x170
 [<ffffffff817cc325>] entry_SYSCALL64_slow_path+0x25/0x25

The reason is that after we commit at least one page into f2fs private
bio cache, if there occurs checkpoint error, we will lose the chance to
commit private bio, result in deadlock in f2fs_evict_inode when wait
that page being writebacked. So giving a chance to do committing in
sync_node_pages for fixing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 55c22a9..c2d953e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1416,6 +1416,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
 	struct pagevec pvec;
 	int step = 0;
 	int nwritten = 0;
+	int ret = 0;
 
 	pagevec_init(&pvec, 0);
 
@@ -1436,7 +1437,8 @@ next_step:
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				pagevec_release(&pvec);
-				return -EIO;
+				ret = -EIO;
+				goto out;
 			}
 
 			/*
@@ -1485,9 +1487,11 @@ continue_unlock:
 			set_fsync_mark(page, 0);
 			set_dentry_mark(page, 0);
 
-			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
+			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc)) {
 				unlock_page(page);
-
+			} else {
+				nwritten++;
+			}
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
@@ -1504,7 +1508,10 @@ continue_unlock:
 		step++;
 		goto next_step;
 	}
-	return nwritten;
+out:
+	if (ret && nwritten)
+		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+	return ret;
 }
 
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
