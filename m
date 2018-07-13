From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [RESEND] f2fs: use timespec64 for inode
 timestamps
Date: Fri, 13 Jul 2018 16:37:46 +0200
Message-ID: <20180713143800.3146610-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1fdzDD-0004aD-20
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 14:38:23 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fdzDA-00H097-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 14:38:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Deepa Dinamani <deepa.kernel@gmail.com>

The on-disk representation and the vfs both use 64-bit tv_sec values,
so let's change the last missing piece in the middle.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this on Jun 20 and got an Ack, but nobody picked up the patch
into linux-next.

Could you merge this for 4.19?
---
 fs/f2fs/f2fs.h  | 16 ++++++----------
 fs/f2fs/inode.c | 12 ++++++------
 fs/f2fs/namei.c |  2 +-
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6fe7db8d914c..1e49b896e211 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -669,8 +669,8 @@ struct f2fs_inode_info {
 	int i_extra_isize;		/* size of extra space located in i_addr */
 	kprojid_t i_projid;		/* id for project quota */
 	int i_inline_xattr_size;	/* inline xattr size */
-	struct timespec i_crtime;	/* inode creation time */
-	struct timespec i_disk_time[4];	/* inode disk times */
+	struct timespec64 i_crtime;	/* inode creation time */
+	struct timespec64 i_disk_time[4];/* inode disk times */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -2519,7 +2519,6 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
-	struct timespec ts;
 	bool ret;
 
 	if (dsync) {
@@ -2535,16 +2534,13 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 			i_size_read(inode) & ~PAGE_MASK)
 		return false;
 
-	ts = timespec64_to_timespec(inode->i_atime);
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time, &ts))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
 		return false;
-	ts = timespec64_to_timespec(inode->i_ctime);
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 1, &ts))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
 		return false;
-	ts = timespec64_to_timespec(inode->i_mtime);
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 2, &ts))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
 		return false;
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 3,
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
 						&F2FS_I(inode)->i_crtime))
 		return false;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f91dd017a65c..f9d1bccebcb6 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -300,9 +300,9 @@ static int do_read_inode(struct inode *inode)
 		fi->i_crtime.tv_nsec = le32_to_cpu(ri->i_crtime_nsec);
 	}
 
-	F2FS_I(inode)->i_disk_time[0] = timespec64_to_timespec(inode->i_atime);
-	F2FS_I(inode)->i_disk_time[1] = timespec64_to_timespec(inode->i_ctime);
-	F2FS_I(inode)->i_disk_time[2] = timespec64_to_timespec(inode->i_mtime);
+	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
+	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
+	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 	f2fs_put_page(node_page, 1);
 
@@ -473,9 +473,9 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	if (inode->i_nlink == 0)
 		clear_inline_node(node_page);
 
-	F2FS_I(inode)->i_disk_time[0] = timespec64_to_timespec(inode->i_atime);
-	F2FS_I(inode)->i_disk_time[1] = timespec64_to_timespec(inode->i_ctime);
-	F2FS_I(inode)->i_disk_time[2] = timespec64_to_timespec(inode->i_mtime);
+	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
+	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
+	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 231b7f3ea7d3..2ea0de4cbe76 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -51,7 +51,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-	F2FS_I(inode)->i_crtime = timespec64_to_timespec(inode->i_mtime);
+	F2FS_I(inode)->i_crtime = inode->i_mtime;
 	inode->i_generation = sbi->s_next_generation++;
 
 	if (S_ISDIR(inode->i_mode))
-- 
2.9.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
