From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] fs/f2fs: avoid redundant convert of inline inode
Date: Tue, 15 Sep 2015 15:10:11 +0800
Message-ID: <55F7C453.2050000@huawei.com>
References: <1442300909-34483-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1ZbkOJ-0002BZ-GR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 07:10:59 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZbkOE-0007Py-Qf
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 07:10:59 +0000
In-Reply-To: <1442300909-34483-1-git-send-email-zhenzhang.zhang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, cm224.lee@samsung.com, chao2.yu@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Encrypted inode for regular file should not have inline_data.
Here we check encrypted inode before convert of inline inode
to avoid redundant convert.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a82abe9..ec2270a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1535,6 +1535,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	size_t count = iov_iter_count(iter);
 	int err;

+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+		return 0;
+
 	/* we don't need to use inline_data strictly */
 	if (f2fs_has_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
@@ -1542,9 +1545,6 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			return err;
 	}

-	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
-		return 0;
-
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
 		return err;
-- 
1.9.1


.





------------------------------------------------------------------------------
