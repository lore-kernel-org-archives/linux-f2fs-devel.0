From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid race when accessing
 last_disk_size
Date: Mon, 9 Oct 2017 17:55:19 +0800
Message-ID: <20171009095519.12648-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e1Un8-0003ZG-W1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Oct 2017 09:56:07 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e1Un7-0007Tz-4Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Oct 2017 09:56:06 +0000
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

last_disk_size could be wrong due to concurrently updating, so using
i_sem semaphore to make last_disk_size updating exclusive to fix this
issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c |  3 +++
 fs/f2fs/f2fs.h | 10 ++++++++--
 fs/f2fs/file.c |  4 ++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77c238b81e32..467f56521e9b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1569,8 +1569,11 @@ static int __write_data_page(struct page *page, bool *submitted,
 			err = do_write_data_page(&fio);
 		}
 	}
+
+	down_write(&F2FS_I(inode)->i_sem);
 	if (F2FS_I(inode)->last_disk_size < psize)
 		F2FS_I(inode)->last_disk_size = psize;
+	up_write(&F2FS_I(inode)->i_sem);
 
 done:
 	if (err && err != -ENOENT)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5bd7631975f5..08190df79195 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2313,9 +2313,10 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
+	bool ret;
+
 	if (dsync) {
 		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-		bool ret;
 
 		spin_lock(&sbi->inode_lock[DIRTY_META]);
 		ret = list_empty(&F2FS_I(inode)->gdirty_list);
@@ -2326,7 +2327,12 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 			file_keep_isize(inode) ||
 			i_size_read(inode) & PAGE_MASK)
 		return false;
-	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
+
+	down_read(&F2FS_I(inode)->i_sem);
+	ret = F2FS_I(inode)->last_disk_size == i_size_read(inode);
+	up_read(&F2FS_I(inode)->i_sem);
+
+	return ret;
 }
 
 static inline int f2fs_readonly(struct super_block *sb)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 463f7cd17f71..fe92fb0d7bfe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -802,6 +802,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			inode->i_mtime = inode->i_ctime = current_time(inode);
 		}
 
+		down_write(&F2FS_I(inode)->i_sem);
+		F2FS_I(inode)->last_disk_size = i_size_read(inode);
+		up_write(&F2FS_I(inode)->i_sem);
+
 		size_changed = true;
 	}
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
