From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/7] f2fs: enhance multithread dio write
	performance
Date: Fri, 11 Sep 2015 14:41:53 +0800
Message-ID: <000001d0ec5d$0bbd1880$23374980$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZaI2o-0002qU-3Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 06:42:46 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZaI2m-0004a8-GP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 06:42:46 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUI00YLK2N0WI10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 15:42:36 +0900 (KST)
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

When dio writes perform concurrently, our performace will be low because of
Thread A's allocation of multi continuous blocks will be break by Thread B,
there are two cases as below:
 - In Thread B, we may change current segment to a new segment for LFS
   allocation if we dio write in the beginning of the file.
 - In Thread B, we may allocate blocks in the middle of Thread A's
   allocation, which make blocks which allocated in Thread A being
   discontinuous.

This patch adds writepages mutex lock to make block allocation in dio write
atomic to avoid above issues.

Test environment:
ubuntu os with linux kernel 4.2+, intel i7-3770, 16g memory,
32g kingston sd card.

fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/mnt/f2fs --filesize=256m --size=16m --bs=2m --direct=1
--numjobs=10

before:
  WRITE: io=163840KB, aggrb=3145KB/s, minb=314KB/s, maxb=411KB/s, mint=39836msec, maxt=52083msec

patched:
  WRITE: io=163840KB, aggrb=10033KB/s, minb=1003KB/s, maxb=1124KB/s, mint=14565msec, maxt=16329msec

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a737ca5..a0a5849 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1536,7 +1536,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	size_t count = iov_iter_count(iter);
+	int rw = iov_iter_rw(iter);
 	int err;
 
 	/* we don't need to use inline_data strictly */
@@ -1555,12 +1557,17 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
-	if (iov_iter_rw(iter) == WRITE)
+	if (rw == WRITE) {
+		mutex_lock(&sbi->writepages);
 		__allocate_data_blocks(inode, offset, count);
+	}
 
 	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
-	if (err < 0 && iov_iter_rw(iter) == WRITE)
-		f2fs_write_failed(mapping, offset + count);
+	if (rw == WRITE) {
+		mutex_unlock(&sbi->writepages);
+		if (err)
+			f2fs_write_failed(mapping, offset + count);
+	}
 
 	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
 
-- 
2.4.2



------------------------------------------------------------------------------
