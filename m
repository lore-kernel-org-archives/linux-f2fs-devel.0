From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: remove nested usage of plug list
Date: Sun, 8 Apr 2018 10:52:09 +0800
Message-ID: <1523155929-17542-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f50ep-0001LL-W8
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 03:06:20 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f50en-00EuwH-Ko
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 03:06:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

-f2fs_file_write_iter
  -blk_start_plug
    -__generic_file_write_iter
	...
	  -do_blockdev_direct_IO
	    -blk_start_plug
		...
	    -blk_finish_plug
	...
  -blk_finish_plug

which may conduct performance decrease in our platform

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b94f19..6ce27ab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2939,9 +2939,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				return err;
 			}
 		}
-		blk_start_plug(&plug);
 		ret = __generic_file_write_iter(iocb, from);
-		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
 		/* if we couldn't write data, we should deallocate blocks. */
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
