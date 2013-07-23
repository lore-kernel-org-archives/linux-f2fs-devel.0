From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix i_name during f2fs_sync_file
Date: Tue, 23 Jul 2013 17:31:27 +0900
Message-ID: <1374568287-26045-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V1Y19-0003Gh-SN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 08:32:23 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1Y17-0002oB-W5 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 08:32:23 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQD00L09ROX2530@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 17:31:48 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As similar as the i_pino fix, i_name also should be fixed when i_nlink is 1.

The errorneous scenario is like this.

1. touch test1
2. link test1 test2
3. unlink test2
4. fsync test1

After this, i_name should be test1.

CC: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 65ca3b3..c2deb27 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -112,11 +112,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 	if (!dentry)
 		return 0;
 
-	inode = igrab(dentry->d_parent->d_inode);
-	dput(dentry);
+	if (update_dent_inode(inode, &dentry->d_name)) {
+		dput(dentry);
+		return 0;
+	}
 
-	*pino = inode->i_ino;
-	iput(inode);
+	*pino = parent_ino(dentry);
+	dput(dentry);
 	return 1;
 }
 
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
