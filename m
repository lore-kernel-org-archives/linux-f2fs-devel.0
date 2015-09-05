From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] f2fs:Fix locking requirements in the function
	recover_dentry
Date: Sat,  5 Sep 2015 13:27:17 -0400
Message-ID: <1441474037-6931-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZYHFR-0001ZY-0u
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 05 Sep 2015 17:27:29 +0000
Received: from mail-ig0-f182.google.com ([209.85.213.182])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZYHFP-0004Em-7T
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 05 Sep 2015 17:27:29 +0000
Received: by igbut12 with SMTP id ut12so34229105igb.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 05 Sep 2015 10:27:21 -0700 (PDT)
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

This fixes locking requirements in the function recover_dentry to
properly lock the critical region between the labels retry and out
with the read/write semaphone of the f2fs's superblock representation
in order to protect against other concurrent threads of execution
accessing the same regions of memory used by the code in this critical

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/recovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index faec2ca..5f1226c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -75,6 +75,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage)
 	struct qstr name;
 	struct page *page;
 	struct inode *dir, *einode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err = 0;
 
 	dir = f2fs_iget(inode->i_sb, pino);
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
@@ -138,6 +141,7 @@ out_unmap_put:
 out_err:
 	iput(dir);
 out:
+	f2fs_unlock_op(sbi);
 	f2fs_msg(inode->i_sb, KERN_NOTICE,
 			"%s: ino = %x, name = %s, dir = %lx, err = %d",
 			__func__, ino_of_node(ipage), raw_inode->i_name,
-- 
2.1.4


------------------------------------------------------------------------------
