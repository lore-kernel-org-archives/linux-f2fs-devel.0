From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/7] f2fs: issue cache flush on direct IO
Date: Mon, 25 Apr 2016 17:06:59 -0700
Message-ID: <1461629220-16280-6-git-send-email-jaegeuk@kernel.org>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqX2-0003Vs-Lp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqX1-00018U-W6
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:12 +0000
In-Reply-To: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
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

Under direct IO path with O_(D)SYNC, it needs to set proper APPEND or UPDATE
flags, so taht f2fs_sync_file can make its data safe.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e54489b..38ce5d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -673,6 +673,9 @@ next_block:
 					err = reserve_new_block(&dn);
 			} else {
 				err = __allocate_data_block(&dn);
+				if (!err)
+					set_inode_flag(F2FS_I(inode),
+							FI_APPEND_WRITE);
 			}
 			if (err)
 				goto sync_out;
@@ -1685,8 +1688,12 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
 	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
-	if (err < 0 && iov_iter_rw(iter) == WRITE)
-		f2fs_write_failed(mapping, offset + count);
+	if (iov_iter_rw(iter) == WRITE) {
+		if (err > 0)
+			set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
+		else if (err < 0)
+			f2fs_write_failed(mapping, offset + count);
+	}
 
 	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
 
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
