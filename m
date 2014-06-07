From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: avoid not to call remove_dirty_inode
Date: Sun,  8 Jun 2014 01:44:32 +0900
Message-ID: <1402159472-61137-3-git-send-email-jaegeuk@kernel.org>
References: <1402159472-61137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WtJjy-00023h-0i
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jun 2014 16:45:10 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WtJjx-0004Lx-CX for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jun 2014 16:45:09 +0000
In-Reply-To: <1402159472-61137-1-git-send-email-jaegeuk@kernel.org>
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

There is an errorneous case during the recovery like below.

In recovery_dentry,
 1) dir = f2fs_iget();
 2) mark the dir with FI_DELAY_IPUT
 3) goto unmap_out

After the end of recovery routine, there is no dirty dentries so the dir cannot
be released by iput in remove_dirty_dir_inode.

This patch fixes such the bug case by handling the iget and iput in the
recovery_dentry procedure.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e950a2f..a112368 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -52,20 +52,13 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 		goto out;
 	}
 
-	if (is_inode_flag_set(F2FS_I(dir), FI_DIRTY_DIR)) {
-		iput(dir);
-	} else {
-		add_dirty_dir_inode(dir);
-		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
-	}
-
 	name.len = le32_to_cpu(raw_inode->i_namelen);
 	name.name = raw_inode->i_name;
 
 	if (unlikely(name.len > F2FS_NAME_LEN)) {
 		WARN_ON(1);
 		err = -ENAMETOOLONG;
-		goto out;
+		goto out_err;
 	}
 retry:
 	de = f2fs_find_entry(dir, &name, &page);
@@ -90,11 +83,23 @@ retry:
 		goto retry;
 	}
 	err = __f2fs_add_link(dir, &name, inode);
+	if (err)
+		goto out_err;
+
+	if (is_inode_flag_set(F2FS_I(dir), FI_DELAY_IPUT)) {
+		iput(dir);
+	} else {
+		add_dirty_dir_inode(dir);
+		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
+	}
+
 	goto out;
 
 out_unmap_put:
 	kunmap(page);
 	f2fs_put_page(page, 0);
+out_err:
+	iput(dir);
 out:
 	f2fs_msg(inode->i_sb, KERN_NOTICE,
 			"%s: ino = %x, name = %s, dir = %lx, err = %d",
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
