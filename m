From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: use ihold
Date: Wed, 22 May 2013 12:33:04 +0900
Message-ID: <1369193584-2963-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1369193584-2963-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Uezoo-0005Xw-Bx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 03:34:26 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uezon-0002rc-89 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 03:34:26 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN6007P2KKTT1C0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 12:34:16 +0900 (KST)
In-reply-to: <1369193584-2963-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use the following helper function committed by Al.

commit 7de9c6ee3ecffd99e1628e81a5ea5468f7581a1f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Oct 23 11:11:40 2010 -0400

    new helper: ihold()

...

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 71aa305..efe0a12 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -172,7 +172,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	f2fs_balance_fs(sbi);
 
 	inode->i_ctime = CURRENT_TIME;
-	atomic_inc(&inode->i_count);
+	ihold(inode);
 
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	ilock = mutex_lock_op(sbi);
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
