From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 003/123] f2fs: fix to avoid deadlock
 in f2fs_read_inline_dir()
Date: Wed, 27 Mar 2019 14:14:27 -0400
Message-ID: <20190327181628.15899-3-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1h9D6a-0005FW-8m
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 18:16:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h9D6L-00GCbZ-TZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 18:16:52 +0000
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit aadcef64b22f668c1a107b86d3521d9cac915c24 ]

As Jiqun Li reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202883

sometimes, dead lock when make system call SYS_getdents64 with fsync() is
called by another process.

monkey running on android9.0

1.  task 9785 held sbi->cp_rwsem and waiting lock_page()
2.  task 10349 held mm_sem and waiting sbi->cp_rwsem
3. task 9709 held lock_page() and waiting mm_sem

so this is a dead lock scenario.

task stack is show by crash tools as following

crash_arm64> bt ffffffc03c354080
PID: 9785   TASK: ffffffc03c354080  CPU: 1   COMMAND: "RxIoScheduler-3"
>> #7 [ffffffc01b50fac0] __lock_page at ffffff80081b11e8

crash-arm64> bt 10349
PID: 10349  TASK: ffffffc018b83080  CPU: 1   COMMAND: "BUGLY_ASYNC_UPL"
>> #3 [ffffffc01f8cfa40] rwsem_down_read_failed at ffffff8008a93afc
     PC: 00000033  LR: 00000000  SP: 00000000  PSTATE: ffffffffffffffff

crash-arm64> bt 9709
PID: 9709   TASK: ffffffc03e7f3080  CPU: 1   COMMAND: "IntentService[A"
>> #3 [ffffffc001e67850] rwsem_down_read_failed at ffffff8008a93afc
>> #8 [ffffffc001e67b80] el1_ia at ffffff8008084fc4
     PC: ffffff8008274114  [compat_filldir64+120]
     LR: ffffff80083584d4  [f2fs_fill_dentries+448]
     SP: ffffffc001e67b80  PSTATE: 80400145
    X29: ffffffc001e67b80  X28: 0000000000000000  X27: 000000000000001a
    X26: 00000000000093d7  X25: ffffffc070d52480  X24: 0000000000000008
    X23: 0000000000000028  X22: 00000000d43dfd60  X21: ffffffc001e67e90
    X20: 0000000000000011  X19: ffffff80093a4000  X18: 0000000000000000
    X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
    X14: ffffffffffffffff  X13: 0000000000000008  X12: 0101010101010101
    X11: 7f7f7f7f7f7f7f7f  X10: 6a6a6a6a6a6a6a6a   X9: 7f7f7f7f7f7f7f7f
     X8: 0000000080808000   X7: ffffff800827409c   X6: 0000000080808000
     X5: 0000000000000008   X4: 00000000000093d7   X3: 000000000000001a
     X2: 0000000000000011   X1: ffffffc070d52480   X0: 0000000000800238
>> #9 [ffffffc001e67be0] f2fs_fill_dentries at ffffff80083584d0
     PC: 0000003c  LR: 00000000  SP: 00000000  PSTATE: 000000d9
    X12: f48a02ff X11: d4678960 X10: d43dfc00  X9: d4678ae4
     X8: 00000058  X7: d4678994  X6: d43de800  X5: 000000d9
     X4: d43dfc0c  X3: d43dfc10  X2: d46799c8  X1: 00000000
     X0: 00001068

Below potential deadlock will happen between three threads:
Thread A		Thread B		Thread C
- f2fs_do_sync_file
 - f2fs_write_checkpoint
  - down_write(&sbi->node_change) -- 1)
			- do_page_fault
			 - down_write(&mm->mmap_sem) -- 2)
			  - do_wp_page
			   - f2fs_vm_page_mkwrite
						- getdents64
						 - f2fs_read_inline_dir
						  - lock_page -- 3)
  - f2fs_sync_node_pages
   - lock_page -- 3)
			    - __do_map_lock
			     - down_read(&sbi->node_change) -- 1)
						  - f2fs_fill_dentries
						   - dir_emit
						    - compat_filldir64
						     - do_page_fault
						      - down_read(&mm->mmap_sem) -- 2)

Since f2fs_readdir is protected by inode.i_rwsem, there should not be
any updates in inode page, we're safe to lookup dents in inode page
without its lock held, so taking off the lock to improve concurrency
of readdir and avoid potential deadlock.

Reported-by: Jiqun Li <jiqun.li@unisoc.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 888a9dc13677..506e365cf903 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -656,6 +656,12 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
+	/*
+	 * f2fs_readdir was protected by inode.i_rwsem, it is safe to access
+	 * ipage without page's lock held.
+	 */
+	unlock_page(ipage);
+
 	inline_dentry = inline_data_addr(inode, ipage);
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
@@ -664,7 +670,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (!err)
 		ctx->pos = d.max;
 
-	f2fs_put_page(ipage, 1);
+	f2fs_put_page(ipage, 0);
 	return err < 0 ? err : 0;
 }
 
-- 
2.19.1
