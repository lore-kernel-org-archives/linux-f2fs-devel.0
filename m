From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix potential hangtask in f2fs_trace_pid
Date: Tue, 12 Dec 2017 14:11:40 +0800
Message-ID: <20171212061140.118506-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eOdnd-0001HG-RF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Dec 2017 06:12:17 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eOdnb-00010z-Se
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Dec 2017 06:12:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As Jia-Ju Bai reported:

"According to fs/f2fs/trace.c, the kernel module may sleep under a spinlock.
The function call path is:
f2fs_trace_pid (acquire the spinlock)
   f2fs_radix_tree_insert
     cond_resched --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and my code
review."

Obviously, it's problemetic to schedule in critical region of spinlock,
which will cause uninterruptable sleep if there is no waker.

This patch changes to use mutex lock intead of spinlock to avoid this
condition.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/trace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index bccbbf2616d2..a1fcd00bbb2b 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 
 static RADIX_TREE(pids, GFP_ATOMIC);
-static spinlock_t pids_lock;
+static struct mutex pids_lock;
 static struct last_io_info last_io;
 
 static inline void __print_last_io(void)
@@ -64,7 +64,7 @@ void f2fs_trace_pid(struct page *page)
 	if (radix_tree_preload(GFP_NOFS))
 		return;
 
-	spin_lock(&pids_lock);
+	mutex_lock(&pids_lock);
 	p = radix_tree_lookup(&pids, pid);
 	if (p == current)
 		goto out;
@@ -77,7 +77,7 @@ void f2fs_trace_pid(struct page *page)
 			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
 			pid, current->comm);
 out:
-	spin_unlock(&pids_lock);
+	mutex_unlock(&pids_lock);
 	radix_tree_preload_end();
 }
 
@@ -122,7 +122,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 
 void f2fs_build_trace_ios(void)
 {
-	spin_lock_init(&pids_lock);
+	mutex_init(&pids_lock);
 }
 
 #define PIDVEC_SIZE	128
@@ -150,7 +150,7 @@ void f2fs_destroy_trace_ios(void)
 	pid_t next_pid = 0;
 	unsigned int found;
 
-	spin_lock(&pids_lock);
+	mutex_lock(&pids_lock);
 	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
 		unsigned idx;
 
@@ -158,5 +158,5 @@ void f2fs_destroy_trace_ios(void)
 		for (idx = 0; idx < found; idx++)
 			radix_tree_delete(&pids, pid[idx]);
 	}
-	spin_unlock(&pids_lock);
+	mutex_unlock(&pids_lock);
 }
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
