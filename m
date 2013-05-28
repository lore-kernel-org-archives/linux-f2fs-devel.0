From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/3] f2fs: iput only if whole data blocks are
	flushed
Date: Tue, 28 May 2013 10:19:43 +0900
Message-ID: <1369703985-26284-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Uh8b8-0004pi-2g
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 01:21:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uh8b4-0002Pu-Iw for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 01:21:10 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNH00H58IEW3DB0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 10:21:00 +0900 (KST)
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

If there remains some unwritten blocks from the recovery, we should not call
iput on that directory inode.
Otherwise, we can loose some dentry blocks after the recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 01ddc91..0d3701d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -501,8 +501,10 @@ void remove_dirty_dir_inode(struct inode *inode)
 		return;
 
 	spin_lock(&sbi->dir_inode_lock);
-	if (atomic_read(&F2FS_I(inode)->dirty_dents))
-		goto out;
+	if (atomic_read(&F2FS_I(inode)->dirty_dents)) {
+		spin_unlock(&sbi->dir_inode_lock);
+		return;
+	}
 
 	list_for_each(this, head) {
 		struct dir_inode_entry *entry;
@@ -516,7 +518,6 @@ void remove_dirty_dir_inode(struct inode *inode)
 			break;
 		}
 	}
-out:
 	spin_unlock(&sbi->dir_inode_lock);
 
 	/* Only from the recovery routine */
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
