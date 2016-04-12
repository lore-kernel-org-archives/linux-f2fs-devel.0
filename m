From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: fix dropping inmemory pages in a wrong
	time
Date: Tue, 12 Apr 2016 10:42:38 -0700
Message-ID: <1460482960-14227-3-git-send-email-jaegeuk@kernel.org>
References: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq2LA-0001Cw-B5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq2L9-0002k4-Ks
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:04 +0000
In-Reply-To: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When one reader closes its file while the other writer is doing atomic writes,
f2fs_release_file drops atomic data resulting in an empty commit.
This patch fixes this wrong commit problem by checking openess of the file.

 Process0                       Process1
 				open file
 start atomic write
 write data
 read data
				close file
				f2fs_release_file()
				clear atomic data
 commit atomic write

Reported-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 90d1157..e10eb61 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1254,6 +1254,14 @@ out:
 
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
+	/*
+	 * f2fs_relase_file is called at every close calls. So we should
+	 * not drop any inmemory pages by close called by other process.
+	 */
+	if (!(filp->f_mode & FMODE_WRITE) ||
+			atomic_read(&inode->i_writecount) != 1)
+		return 0;
+
 	/* some remained atomic pages should discarded */
 	if (f2fs_is_atomic_file(inode))
 		drop_inmem_pages(inode);
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
