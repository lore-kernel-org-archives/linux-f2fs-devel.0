From: hujianyang <hujianyang@huawei.com>
Subject: Space leak in f2fs
Date: Wed, 13 May 2015 15:17:17 +0800
Message-ID: <5552FA7D.7000704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao2.yu@samsung.com>, cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

I found a space leak problem in f2fs. This problem could lead to
ENOSPC error during stress tests, e.g. ltp.

<<<test_output>>>
growfiles(gf15): 11656 growfiles.c/2249: 16920 tlibio.c/739 write(6, buf, 1352) ret:-1, errno=28 No space left on device
gf15        1  TFAIL  :  growfiles.c:132: Test failed

...

And can be reproduced by these steps whether background_gc is on
or not:

1) format a 4GB f2fs partition
2) dd a 3G file,
3) unlink it.

Do these steps again and again. Soon, after one unlink operation,
you can see the space of the 3G file is not free.

Fs-Server:/mnt/f2fs # df .
Filesystem     1K-blocks   Used Available Use% Mounted on
/dev/sdd3        4193280 301064   3854328   8% /mnt/f2fs
Fs-Server:/mnt/f2fs # dd if=/dev/zero of=./test bs=1M count=3072
3072+0 records in
3072+0 records out
3221225472 bytes (3.2 GB) copied, 3.1892 s, 1.0 GB/s
Fs-Server:/mnt/f2fs # unlink ./test
Fs-Server:/mnt/f2fs # dd if=/dev/zero of=./test bs=1M count=3072
3072+0 records in
3072+0 records out
3221225472 bytes (3.2 GB) copied, 3.44288 s, 936 MB/s
Fs-Server:/mnt/f2fs # unlink ./test
Fs-Server:/mnt/f2fs # df .
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sdd3        4193280 3449888    705504  84% /mnt/f2fs
Fs-Server:/mnt/f2fs # ls
Fs-Server:/mnt/f2fs # ls
Fs-Server:/mnt/f2fs # df .
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sdd3        4193280 3449888    705504  84% /mnt/f2fs
Fs-Server:/mnt/f2fs # dd if=/dev/zero of=./test bs=1M count=3072
dd: writing `./test': No space left on device
689+0 records in
688+0 records out
721719296 bytes (722 MB) copied, 0.618972 s, 1.2 GB/s
Fs-Server:/mnt/f2fs # df .
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sdd3        4193280 4155392         0 100% /mnt/f2fs
Fs-Server:/mnt/f2fs # ls -l test
-rw-r--r-- 1 root root 721719296 May 13 14:52 test


We can reuse the leaking space after a sync call:


Fs-Server:/mnt/f2fs # df .
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sdd3        4193280 4155392         0 100% /mnt/f2fs
Fs-Server:/mnt/f2fs # sync
Fs-Server:/mnt/f2fs # df .
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sdd3        4193280 1006568   3148824  25% /mnt/f2fs


I found this may caused by .drop_inode in f2fs. see f2fs_drop_inode()

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19438f2..7646d2a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -424,15 +424,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)

 static int f2fs_drop_inode(struct inode *inode)
 {
-       /*
-        * This is to avoid a deadlock condition like below.
-        * writeback_single_inode(inode)
-        *  - f2fs_write_data_page
-        *    - f2fs_gc -> iput -> evict
-        *       - inode_wait_for_writeback(inode)
-        */
-       if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
-               return 0;
        return generic_drop_inode(inode);
 }

After removing these code, this problem is fixed. But this function is
introduced by commit 531ad7d58c6476c5856653448b4c7d26427502b4 to fix
a deadlock problem.

I wish you and other developers in this list could help me to fix this
problem in a correct way.

Thanks,
Hu

