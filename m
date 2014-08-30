From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: reposition unlock_new_inode to prevent
 accessing invalid inode
Date: Sat, 30 Aug 2014 09:52:34 +0800
Message-ID: <000901cfc3f5$2baaee60$8300cb20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XNXr7-0007xn-Hh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 01:53:29 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XNXr5-00041s-17
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 01:53:29 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NB300DMQJWV3720@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 10:53:19 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As the race condition on the inode cache, following scenario can appear:
[Thread a]				[Thread b]
					->f2fs_mkdir
					  ->f2fs_add_link
					    ->__f2fs_add_link
					      ->init_inode_metadata failed here
->gc_thread_func
  ->f2fs_gc
    ->do_garbage_collect
      ->gc_data_segment
        ->f2fs_iget
          ->iget_locked
            ->wait_on_inode
					  ->unlock_new_inode
        ->move_data_page
					  ->make_bad_inode
					  ->iput

When we fail in create/symlink/mkdir/mknod/tmpfile, the new allocated inode
should be set as bad to avoid being accessed by other thread. But in above
scenario, it allows f2fs to access the invalid inode before this inode was set
as bad.
This patch fix the potential problem, and this issue was found by code review.

change log from v1:
 o Add condition judgment in gc_data_segment() suggested by Changman Lee.
 o use iget_failed to simplify code.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c    |  2 +-
 fs/f2fs/namei.c | 20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e8507b1..943a31d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -593,7 +593,7 @@ next_step:
 
 		if (phase == 2) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
 
 			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6b53ce9..ee103fd 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -134,9 +134,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return 0;
 out:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, ino);
 	return err;
 }
@@ -267,9 +265,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	return err;
 out:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }
@@ -308,9 +304,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 out_fail:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }
@@ -354,9 +348,7 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	return 0;
 out:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }
@@ -688,9 +680,7 @@ release_out:
 out:
 	f2fs_unlock_op(sbi);
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
