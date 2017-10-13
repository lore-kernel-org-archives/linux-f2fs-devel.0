From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: allow readdir() to be interrupted
Date: Fri, 13 Oct 2017 18:01:34 +0800
Message-ID: <20171013100136.35212-3-yuchao0@huawei.com>
References: <20171013100136.35212-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e2wn7-0004Gj-DH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 10:02:05 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e2wn5-00016x-SH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 10:02:05 +0000
In-Reply-To: <20171013100136.35212-1-yuchao0@huawei.com>
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

This patch follows ext4 to allow readdir() in large empty directory to
be interrupted. Referenced commit of ext4: 1f60fbe72749 ("ext4: allow
readdir()'s of large empty directories to be interrupted").

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 148927f5bc93..1ebd206a4085 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -10,6 +10,7 @@
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
+#include <linux/sched/signal.h>
 #include "f2fs.h"
 #include "node.h"
 #include "acl.h"
@@ -875,6 +876,14 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
 
 	for (; n < npages; n++) {
+
+		/* allow readdir() to be interrupted */
+		if (fatal_signal_pending(current)) {
+			err = -ERESTARTSYS;
+			goto out_free;
+		}
+		cond_resched();
+
 		dentry_page = get_lock_data_page(inode, n, false);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
