From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 7/7] f2fs: don't return value in
 truncate_data_blocks_range
Date: Thu, 30 Nov 2017 19:28:23 +0800
Message-ID: <20171130112823.100494-7-yuchao0@huawei.com>
References: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1R-0002sZ-EI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:53 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1Q-0005zV-6U
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:53 +0000
In-Reply-To: <20171130112823.100494-1-yuchao0@huawei.com>
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

There is no caller cares about return value of truncate_data_blocks_range,
remove it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 fs/f2fs/file.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b4796f064580..d92eba66263c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2503,7 +2503,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags);
 int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
 int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
-int truncate_data_blocks_range(struct dnode_of_data *dn, int count);
+void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6723d48819e9..90980f2d45b7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -490,7 +490,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	return dquot_file_open(inode, filp);
 }
 
-int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
+void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_node *raw_node;
@@ -533,7 +533,6 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	f2fs_update_time(sbi, REQ_TIME);
 	trace_f2fs_truncate_data_blocks_range(dn->inode, dn->nid,
 					 dn->ofs_in_node, nr_free);
-	return nr_free;
 }
 
 void truncate_data_blocks(struct dnode_of_data *dn)
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
