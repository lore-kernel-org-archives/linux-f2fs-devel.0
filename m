From: Chao Yu <chao2.yu@samsung.com>
Subject: [RFC PATCH 1/2] f2fs: enhance multithread dio write
	performance
Date: Mon, 28 Dec 2015 18:04:35 +0800
Message-ID: <006d01d14157$3f76de50$be649af0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aDUg9-0007Lb-EN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 10:05:25 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aDUg7-0007R4-HE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 10:05:25 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O02029XDC0PLL40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 19:05:15 +0900 (KST)
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

When performing big dio writes concurrently, our performace will be low
because of Thread A's allocation of multi continuous blocks will be
interrupted by Thread B, there are two cases as below:
 - In Thread B, we may change current segment to a new segment for LFS
   allocation if we dio write in the beginning of the file.
 - In Thread B, we may allocate blocks in the middle of Thread A's
   allocation, which make blocks allocated in Thread A being inconsecutive.

This patch adds writepages mutex lock to make block allocation in dio write
being atomic to avoid above issues.

Test environment 1:
ubuntu os with linux kernel 4.4-rc4, intel i7-3770, 16g memory,
32g kingston sd card.

fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/mnt/f2fs --filesize=256m --size=16m --bs=2m --direct=1
--numjobs=10

before:
  WRITE: io=163840KB, aggrb=5125KB/s, minb=512KB/s, maxb=776KB/s, mint=21105msec, maxt=31967msec
patched:
  WRITE: io=163840KB, aggrb=10424KB/s, minb=1042KB/s, maxb=1172KB/s, mint=13975msec, maxt=15717msec

Test environment 2:
Note4 eMMC

fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/data/test/ --filesize=256m --size=64m --bs=2m --direct=1
--numjobs=16

before:
  WRITE: io=1024.0MB, aggrb=103583KB/s, minb=6473KB/s, maxb=8806KB/s, mint=7442msec, maxt=10123msec
patched:
  WRITE: io=1024.0MB, aggrb=124860KB/s, minb=7803KB/s, maxb=9315KB/s, mint=7035msec, maxt=8398msec

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5c43b2d..6b24446 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1640,7 +1640,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	size_t count = iov_iter_count(iter);
+	int rw = iov_iter_rw(iter);
 	int err;
 
 	/* we don't need to use inline_data strictly */
@@ -1655,20 +1657,26 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	if (err)
 		return err;
 
-	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
+	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
+
+	if (rw == WRITE) {
+		bool serialized = (F2FS_BYTES_TO_BLK(count) >= 64);
 
-	if (iov_iter_rw(iter) == WRITE) {
+		if (serialized)
+			mutex_lock(&sbi->writepages);
 		err = __allocate_data_blocks(inode, offset, count);
+		if (serialized)
+			mutex_unlock(&sbi->writepages);
 		if (err)
 			goto out;
 	}
 
 	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
 out:
-	if (err < 0 && iov_iter_rw(iter) == WRITE)
+	if (err < 0 && rw == WRITE)
 		f2fs_write_failed(mapping, offset + count);
 
-	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
+	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
 
 	return err;
 }
-- 
2.6.3



------------------------------------------------------------------------------
