From: He YunLei <heyunlei@huawei.com>
Subject: [f2fs-dev] Dwrite with non-aligned offset and size
Date: Mon, 1 Jun 2015 19:55:08 +0800
Message-ID: <556C481C.1050400@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, Bintian <bintian.wang@huawei.com>, hujianyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

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

Does f2fs allow dwrite with non-aligned offset and size? I check the code and found
dwrite with non-aligned offset and size will turn into buffered write. Whether it will
have some impact on user layer applications?

I wrote a patch, not well tested, how do you think of it?

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9bedfa8..ba5d94c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2010,8 +2010,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
         if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
                 return 0;

-       if (check_direct_IO(inode, iter, offset))
-               return 0;
+       err = check_direct_IO(inode, iter, offset)
+       if (err)
+               return -EINVAL;

         trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));

I wish you and other developers in this list could help me in a correct way.

Thanks,
He

