From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] f2fs:Fix concurrent access issues in the
	function recover_dentry
Date: Fri,  7 Aug 2015 23:12:49 -0400
Message-ID: <1439003569-17358-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZNuZA-0003id-FW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 03:13:00 +0000
Received: from mail-ig0-f169.google.com ([209.85.213.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZNuZ9-0008Ha-Qa
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 03:13:00 +0000
Received: by igr7 with SMTP id 7so41944462igr.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 07 Aug 2015 20:12:54 -0700 (PDT)
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

This fixes concurrent access issues in the function recover_dentry
by locking and locking another the block labeled retry with the
functions f2fs_lock_op/f2fs_unlock_op on a pointer of the
superblock used by the passed inode structure pointer by this

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/recovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 24a8c1d..b86ea29 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -70,6 +70,7 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
 static int recover_dentry(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t pino = le32_to_cpu(raw_inode->i_pino);
 	struct f2fs_dir_entry *de;
 	struct qstr name;
@@ -97,6 +98,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage)
 		goto out_err;
 	}
 retry:
+	f2fs_lock_op(sbi);
 	de = f2fs_find_entry(dir, &name, &page);
 	if (de && inode->i_ino == le32_to_cpu(de->ino))
 		goto out_unmap_put;
@@ -117,6 +119,7 @@ retry:
 		}
 		f2fs_delete_entry(de, page, dir, einode);
 		iput(einode);
+		f2fs_unlock_op(sbi);
 		goto retry;
 	}
 	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
@@ -129,7 +132,8 @@ retry:
 		add_dirty_dir_inode(dir);
 		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
 	}
-
+
+	f2fs_unlock_op(sbi);
 	goto out;
 
 out_unmap_put:
-- 
2.1.4


------------------------------------------------------------------------------
