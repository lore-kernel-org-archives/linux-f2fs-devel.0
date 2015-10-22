From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix leakage of inmemory atomic pages
Date: Wed, 21 Oct 2015 20:03:43 -0700
Message-ID: <1445483024-49724-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zp6B3-0001ra-QG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Oct 2015 03:04:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zp6Ax-00064S-2j for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Oct 2015 03:04:29 +0000
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

If we got failure during commit_atomic_write, abort_volatile_write will be
called, but will not drop the inmemory pages due to no FI_ATOMIC_FILE.
Actually, there is no reason to check the flag in abort_volatile_write.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 91c51a6..a197215 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1443,13 +1443,9 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 
 	f2fs_balance_fs(F2FS_I_SB(inode));
 
-	if (f2fs_is_atomic_file(inode)) {
-		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
-		commit_inmem_pages(inode, true);
-	}
-
-	if (f2fs_is_volatile_file(inode))
-		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+	commit_inmem_pages(inode, true);
 
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.1.1


------------------------------------------------------------------------------
