From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: invalidate inode and data pages if inode
	is no longer used
Date: Wed, 24 Aug 2016 19:34:19 -0700
Message-ID: <20160825023419.82566-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bckUw-0004DW-9R
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 02:34:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bckUv-0007qG-3J
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 02:34:30 +0000
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

When a file is closed, let's deactivate inode page to mitigate further memory
pressure. We can do data pages as well in the corner case of f2fs_drop_inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c  | 4 ++++
 fs/f2fs/super.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e460211..5f9a6dc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1465,6 +1465,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 		filemap_fdatawrite(inode->i_mapping);
 		clear_inode_flag(inode, FI_DROP_CACHE);
 	}
+
+	/* deactivate written inode page */
+	invalidate_mapping_pages(NODE_MAPPING(F2FS_I_SB(inode)),
+					inode->i_ino, inode->i_ino);
 	return 0;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7f863a6..f84696d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -618,6 +618,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			fscrypt_put_encryption_info(inode, NULL);
+			invalidate_mapping_pages(inode->i_mapping, 0, -1);
 			spin_lock(&inode->i_lock);
 			atomic_dec(&inode->i_count);
 		}
-- 
2.8.3


------------------------------------------------------------------------------
