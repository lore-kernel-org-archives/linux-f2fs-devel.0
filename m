From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to clear FI_NO_PREALLOC
Date: Mon, 13 Nov 2017 17:32:39 +0800
Message-ID: <20171113093240.47560-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eEB7o-00019Z-JH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Nov 2017 09:33:52 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eEB7n-0008Be-JF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Nov 2017 09:33:52 +0000
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

We need to clear FI_NO_PREALLOC flag in error path of f2fs_file_write_iter,
otherwise we will lose the chance to preallocate blocks in latter write()
at one time.

Fixes: dc91de78e5e1 ("f2fs: do not preallocate blocks which has wrong buffer")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8742c028acc6..41a6f1f70416 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2750,6 +2750,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		err = f2fs_preallocate_blocks(iocb, from);
 		if (err) {
+			clear_inode_flag(inode, FI_NO_PREALLOC);
 			inode_unlock(inode);
 			return err;
 		}
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
