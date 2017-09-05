From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: avoid race in between read xattr & write
 xattr
Date: Tue, 5 Sep 2017 17:42:01 +0800
Message-ID: <1504604521-26925-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1dpAaQ-0000tl-4k
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Sep 2017 09:56:02 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dpAaJ-0007Jy-Bk
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Sep 2017 09:56:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: heyunlei@huawei.com, morgan.wang@huawei.com

Thread A:					Thread B:
-f2fs_getxattr
   -lookup_all_xattrs
      -xnid = F2FS_I(inode)->i_xattr_nid;
						-f2fs_setxattr
						    -__f2fs_setxattr
						        -write_all_xattrs
						            -truncate_xattr_node
							          ...  ...
						-write_checkpoint
								  ...  ...
						-alloc_nid   <- nid reuse
          -get_node_page
              -f2fs_bug_on  <- nid != node_footer->nid

It's need a rw_sem to avoid the race

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/super.c | 1 +
 fs/f2fs/xattr.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b99396..e99c1fe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -589,6 +589,7 @@ struct f2fs_inode_info {
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
 	struct rw_semaphore i_mmap_sem;
+	struct rw_semaphore xattr_sem;
 
 	int i_extra_isize;		/* size of extra space located in i_addr */
 	kprojid_t i_projid;		/* id for project quota */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7730316..03950eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -630,6 +630,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_rwsem(&fi->dio_rwsem[READ]);
 	init_rwsem(&fi->dio_rwsem[WRITE]);
 	init_rwsem(&fi->i_mmap_sem);
+	init_rwsem(&fi->xattr_sem);
 
 #ifdef CONFIG_QUOTA
 	memset(&fi->i_dquot, 0, sizeof(fi->i_dquot));
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ef3a372..590fe3a 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -503,7 +503,9 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	int error = 0;
 	size_t rest = buffer_size;
 
+	down_read(&F2FS_I(inode)->xattr_sem);
 	error = read_all_xattrs(inode, NULL, &base_addr);
+	up_read(&F2FS_I(inode)->xattr_sem);
 	if (error)
 		return error;
 
@@ -573,7 +575,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (size > MAX_VALUE_LEN(inode))
 		return -E2BIG;
 
+	down_read(&F2FS_I(inode)->xattr_sem);
 	error = read_all_xattrs(inode, ipage, &base_addr);
+	up_read(&F2FS_I(inode)->xattr_sem);
 	if (error)
 		return error;
 
@@ -650,7 +654,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		new_hsize += newsize;
 	}
 
+	down_write(&F2FS_I(inode)->xattr_sem);
 	error = write_all_xattrs(inode, new_hsize, base_addr, ipage);
+	up_write(&F2FS_I(inode)->xattr_sem);
 	if (error)
 		goto exit;
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
