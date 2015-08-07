From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/4] f2fs: report EINVAL for unalignment direct IO
Date: Fri, 07 Aug 2015 18:39:32 +0800
Message-ID: <017f01d0d0fd$7f0917b0$7d1b4710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi all

This patch is submitted by Yunlei He originally, but it's not complete one,
so I modified it and add some description, then resubmit it.

>From 3f8de7fe93354215b9b12293302a0a999cf3888a Mon Sep 17 00:00:00 2001
From: Yunlei He <heyunlei@huawei.com>
Date: Wed, 29 Jul 2015 15:10:24 +0800
Subject: [PATCH 2/4] f2fs: report EINVAL for unalignment direct IO

We run ltp testcase with f2fs and obtain a TFAIL in diotest4, the result in detail is
as fallow:

dio04

<<<test_start>>>
tag=dio04 stime=1432278894
cmdline="diotest4"
contacts=""
analysis=exit
<<<test_output>>>
diotest4    1  TPASS  :  Negative Offset
diotest4    2  TPASS  :  removed
diotest4    3  TFAIL  :  diotest4.c:129: write allows odd count.returns 1: Success
diotest4    4  TFAIL  :  diotest4.c:183: Odd count of read and write
diotest4    5  TPASS  :  Read beyond the file size
......

the result of ext4 with same environment:

dio04

<<<test_start>>>
tag=dio04 stime=1432259643
cmdline="diotest4"
contacts=""
analysis=exit
<<<test_output>>>
diotest4    1  TPASS  :  Negative Offset
diotest4    2  TPASS  :  removed
diotest4    3  TPASS  :  Odd count of read and write
diotest4    4  TPASS  :  Read beyond the file size
......

The reason is that when triggering DIO in f2fs, we will return zero value
in ->direct_IO if writer's buffer offset, file offset and transfer size is
not alignment to block size of filesystem, resulting in falling back into
buffered write instead of returning -EINVAL.

This patch fixes that problem by returning correct error number for above
case, and removing the judgement condition in check_direct_IO to make sure
the verification will be enabled for direct reader too.

Besides, Jaegeuk Kim pointed out that there is expectional cases we should
always make direct-io falling back into buffered write, such as dio in
encrypted file.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
[Chao Yu make small change and add detail description in commit message]
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4fabdd4..7ea8eda 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1494,9 +1494,6 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 {
 	unsigned blocksize_mask = inode->i_sb->s_blocksize - 1;
 
-	if (iov_iter_rw(iter) == READ)
-		return 0;
-
 	if (offset & blocksize_mask)
 		return -EINVAL;
 
@@ -1525,8 +1522,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		return 0;
 
-	if (check_direct_IO(inode, iter, offset))
-		return 0;
+	err = check_direct_IO(inode, iter, offset);
+	if (err)
+		return err;
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
-- 
2.4.2
