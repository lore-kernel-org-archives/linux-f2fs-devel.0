From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: relocate inode_{,
	un}lock in F2FS_IOC_SETFLAGS
Date: Wed,  3 May 2017 23:59:13 +0800
Message-ID: <20170503155914.6859-2-chao@kernel.org>
References: <20170503155914.6859-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1d5wij-0004Gm-SQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 16:01:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d5wif-0002mE-Uy
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 16:01:41 +0000
In-Reply-To: <20170503155914.6859-1-chao@kernel.org>
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

This patch expands cover region of inode->i_rwsem to keep setting flag
atomically.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1c1c9bc4f19a..e20a1c01e556 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1494,10 +1494,10 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	flags = f2fs_mask_flags(inode->i_mode, flags);
-
 	inode_lock(inode);
 
+	flags = f2fs_mask_flags(inode->i_mode, flags);
+
 	oldflags = fi->i_flags;
 
 	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
@@ -1511,10 +1511,11 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 	flags = flags & FS_FL_USER_MODIFIABLE;
 	flags |= oldflags & ~FS_FL_USER_MODIFIABLE;
 	fi->i_flags = flags;
-	inode_unlock(inode);
 
 	inode->i_ctime = current_time(inode);
 	f2fs_set_inode_flags(inode);
+
+	inode_unlock(inode);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
