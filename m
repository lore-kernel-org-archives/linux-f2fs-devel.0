From: Yunlei He <heyunlei@huawei.com>
Subject: [RFC PATCH] f2fs: preallocate blocks for encrypted file
Date: Wed, 14 Sep 2016 18:06:55 +0800
Message-ID: <1473847615-2793-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bk743-0003LG-3E
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Sep 2016 10:05:11 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bk73z-0001Qi-IU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Sep 2016 10:05:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch allow preallocates data blocks for buffered aio writes
in encrypted file.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3e0ef2d..529e9a2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -639,9 +639,6 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 
 	map.m_next_pgofs = NULL;
 
-	if (f2fs_encrypted_inode(inode))
-		return 0;
-
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = f2fs_convert_inline_inode(inode);
 		if (ret)
-- 
1.9.1


------------------------------------------------------------------------------
