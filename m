From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: support FIEMAP_FLAG_CACHE
Date: Mon, 8 Jan 2018 18:48:32 +0800
Message-ID: <20180108104834.108983-2-yuchao0@huawei.com>
References: <20180108104834.108983-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eYUzO-0002l9-W4
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jan 2018 10:49:10 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYUzN-0008VY-Uj
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jan 2018 10:49:10 +0000
In-Reply-To: <20180108104834.108983-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch factors out f2fs_precache_extents from
f2fs_ioc_precache_extents, with the new function we can support
FIEMAP_FLAG_CACHE in ->fiemap.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 12 +++++++++---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 10 +++++++---
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f38e660bc889..33ae1bd14a8e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1228,11 +1228,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u32 flags = 0;
 	int ret = 0;
 
+	inode_lock(inode);
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
+		ret = f2fs_precache_extents(inode);
+		if (ret)
+			goto out;
+	}
+
 	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
 	if (ret)
-		return ret;
-
-	inode_lock(inode);
+		goto out;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		ret = f2fs_xattr_fiemap(inode, fieinfo);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 14177cebc3e7..3c3a055c3d4a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2543,6 +2543,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
 int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
+int f2fs_precache_extents(struct inode *inode);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int f2fs_pin_file_control(struct inode *inode, bool inc);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 14e75871acf3..6e30016f26ad 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2734,9 +2734,8 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
+int f2fs_precache_extents(struct inode *inode)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_map_blocks map;
 	pgoff_t next_pgofs;
@@ -2763,7 +2762,12 @@ static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
 		map.m_lblk = next_pgofs;
 	}
 
-	return 0;
+	return err;
+}
+
+static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
+{
+	return f2fs_precache_extents(file_inode(filp));
 }
 
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
