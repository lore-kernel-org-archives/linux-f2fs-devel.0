From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix wrong i_atime recovery
Date: Fri,  4 Nov 2016 00:26:55 +0800
Message-ID: <20161103162656.2982-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1c2Kt9-0007Xl-E9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 16:29:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2Kt8-0003Tn-Fi
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 16:29:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Shouldn't update in-memory i_atime with on-disk i_mtime of inode when
recovering inode.

Shuoran found this bug which is hidden for a long time, honour is belong
to him.

Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2fc84a9..d2ba4da 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -180,10 +180,10 @@ static void recover_inode(struct inode *inode, struct page *page)
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
-	inode->i_atime.tv_sec = le64_to_cpu(raw->i_mtime);
+	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
 	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
 	inode->i_mtime.tv_sec = le64_to_cpu(raw->i_mtime);
-	inode->i_atime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
+	inode->i_atime.tv_nsec = le32_to_cpu(raw->i_atime_nsec);
 	inode->i_ctime.tv_nsec = le32_to_cpu(raw->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
