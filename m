From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: check the blocksize before calling generic_direct_IO path
Date: Thu, 26 Dec 2013 20:27:31 +0900
Message-ID: <1388057251-2640-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

The f2fs supports 4KB block size. If user requests dwrite with under 4KB data,
it allocates a new 4KB data block.
However, f2fs doesn't add zero data into the untouched data area inside the
newly allocated data block.

This incurs an error during the xfstest #263 test as follow.

263 12s ... [failed, exit status 1] - output mismatch (see 263.out.bad)
	--- 263.out	2013-03-09 03:37:15.043967603 +0900
	+++ 263.out.bad	2013-12-27 04:20:39.230203114 +0900
	@@ -1,3 +1,976 @@
	QA output created by 263
	fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
	-fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
	+fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
	+truncating to largest ever: 0x12a00
	+truncating to largest ever: 0x75400
	+fallocating to largest ever: 0x79cbf
	...
	(Run 'diff -u 263.out 263.out.bad' to see the entire diff)
	Ran: 263
	Failures: 263
	Failed 1 of 1 tests

It turns out that, when the test tries to write 2KB data with dio, the new dio
path allocates 4KB data block without filling zero data inside the remained 2KB
area. Finally, the output file contains a garbage data for that region.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 991e368..e0965b4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -953,11 +953,33 @@ static int f2fs_write_end(struct file *file,
 	return copied;
 }
 
+static int check_direct_IO(struct inode *inode, int rw,
+		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
+{
+	unsigned blocksize_mask = inode->i_sb->s_blocksize - 1;
+	int i;
+
+	if (rw == READ)
+		return 0;
+
+	if (offset & blocksize_mask)
+		return -EINVAL;
+
+	for (i = 0; i < nr_segs; i++)
+		if (iov[i].iov_len & blocksize_mask)
+			return -EINVAL;
+	return 0;
+}
+
 static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
+
+	if (check_direct_IO(inode, rw, iov, offset, nr_segs))
+		return 0;
+
 	return blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
 							get_data_block);
 }
-- 
1.8.4.474.g128a96c

