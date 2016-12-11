From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a missing size change in f2fs_setattr
Date: Sun, 11 Dec 2016 15:35:15 +0800
Message-ID: <20161211073515.7412-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cFybS-0002B7-Hs
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 11 Dec 2016 07:31:22 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cFybO-0000R4-9U
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 11 Dec 2016 07:31:22 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch fix a missing size change in f2fs_setattr

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4c87261..383b5c2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -677,6 +677,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int err;
+	bool size_changed = false;
 
 	err = setattr_prepare(dentry, attr);
 	if (err)
@@ -707,6 +708,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			}
 			inode->i_mtime = inode->i_ctime = current_time(inode);
 		}
+
+		size_changed = true;
 	}
 
 	__setattr_copy(inode, attr);
@@ -719,8 +722,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	/* update attributes only */
-	f2fs_mark_inode_dirty_sync(inode, false);
+	/* file size may changed here */
+	f2fs_mark_inode_dirty_sync(inode, size_changed);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
