From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clean up codying style and redundancy
Date: Fri, 22 Jul 2016 17:21:25 -0700
Message-ID: <20160723002125.49089-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bQkhG-0004vN-4E
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jul 2016 00:21:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bQkhF-0001Yl-9T
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jul 2016 00:21:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch includes minor clean-ups.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.h  | 2 +-
 fs/f2fs/data.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 997ca8e..b2334d1 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -37,7 +37,7 @@ struct f2fs_acl_header {
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 
 extern struct posix_acl *f2fs_get_acl(struct inode *, int);
-extern int f2fs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+extern int f2fs_set_acl(struct inode *, struct posix_acl *, int);
 extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
 							struct page *);
 #else
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 87a458f..614154f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1731,7 +1731,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (test_opt(F2FS_I_SB(inode), LFS))
 		return 0;
 
-	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
+	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
 	down_read(&F2FS_I(inode)->dio_rwsem[rw]);
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
@@ -1744,7 +1744,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			f2fs_write_failed(mapping, offset + count);
 	}
 
-	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
+	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
 
 	return err;
 }
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
