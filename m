From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 2/3] f2fs:dax: Export interfaces:
	dax_map/unmap_atomic()
Date: Thu, 4 May 2017 08:17:25 +0800
Message-ID: <1493857045-40693-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunqiuyang@huawei.com>) id 1d64Q9-00066k-6m
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 00:15:01 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d64Q6-0006Pq-9T
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 00:15:01 +0000
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
Cc: wenyuzhong1@huawei.com, wangxiaojun11@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, guzheng1@huawei.com, yanaijie@huawei.com, zhaohongjiang@huawei.com, dingxiang@huawei.com, wangyijing@huawei.com, sunqiuyang@huawei.com

Export interfaces of dax_map/unmap_atomic() for usage in moving data 
pages of DAX files in garbage collection of F2FS.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/dax.c            | 6 ++++--
 include/linux/dax.h | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 85abd74..615a4c1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -55,7 +55,7 @@ static int __init init_dax_wait_table(void)
 }
 fs_initcall(init_dax_wait_table);
 
-static long dax_map_atomic(struct block_device *bdev, struct blk_dax_ctl *dax)
+long dax_map_atomic(struct block_device *bdev, struct blk_dax_ctl *dax)
 {
 	struct request_queue *q = bdev->bd_queue;
 	long rc = -EIO;
@@ -72,14 +72,16 @@ static long dax_map_atomic(struct block_device *bdev, struct blk_dax_ctl *dax)
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(dax_map_atomic);
 
-static void dax_unmap_atomic(struct block_device *bdev,
+void dax_unmap_atomic(struct block_device *bdev,
 		const struct blk_dax_ctl *dax)
 {
 	if (IS_ERR(dax->addr))
 		return;
 	blk_queue_exit(bdev->bd_queue);
 }
+EXPORT_SYMBOL_GPL(dax_unmap_atomic);
 
 static int dax_is_pmd_entry(void *entry)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index d8a3dc0..b6451b2 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -7,6 +7,7 @@
 #include <asm/pgtable.h>
 
 struct iomap_ops;
+struct blk_dax_ctl;
 
 /*
  * We use lowest available bit in exceptional entry for locking, one bit for
@@ -36,6 +37,8 @@ static inline void *dax_radix_locked_entry(sector_t sector, unsigned long flags)
 			RADIX_DAX_ENTRY_LOCK);
 }
 
+long dax_map_atomic(struct block_device *bdev, struct blk_dax_ctl *dax);
+void dax_unmap_atomic(struct block_device *bdev, const struct blk_dax_ctl *dax);
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 int dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
