From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix fdatasync
Date: Thu, 17 Nov 2016 20:53:31 +0800
Message-ID: <20161117125331.68497-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c7MHi-000281-Qr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 12:59:22 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c7MHh-0001KE-0Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 12:59:22 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

For below two cases, we can't guarantee data consistence:

a)
1. xfs_io "pwrite 0 4195328" "fsync"
2. xfs_io "pwrite 4195328 1024" "fdatasync"
3. godown
4. umount & mount
--> isize we updated before fdatasync won't be recovered

b)
1. xfs_io "pwrite -S 0xcc 0 4202496" "fsync"
2. xfs_io "fpunch 4194304 4096" "fdatasync"
3. godown
4. umount & mount
--> dnode we punched before fdatasync won't be recovered

The reason is that normally fdatasync won't be aware of modification
of metadata in file, e.g. isize changing, dnode updating, so in ->fsync
we will skip flushing node pages for above cases, result in making
fdatasynced file being lost during recovery.

Currently we have introduced DIRTY_META global list in sbi for tracking
dirty inode selectively, so in fdatasync we can choose to flush nodes
depend on dirty state of current inode in the list.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 11 ++++++++++-
 fs/f2fs/file.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cf74ec6..4ddcf75 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1722,8 +1722,17 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
-static inline bool f2fs_skip_inode_update(struct inode *inode)
+static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
+	if (dsync) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		bool ret;
+
+		spin_lock(&sbi->inode_lock[DIRTY_META]);
+		ret = list_empty(&F2FS_I(inode)->gdirty_list);
+		spin_unlock(&sbi->inode_lock[DIRTY_META]);
+		return ret;
+	}
 	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		return false;
 	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 47b7b13..2957d1f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -210,7 +210,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	}
 
 	/* if the inode is dirty, let's recover all the time */
-	if (!datasync && !f2fs_skip_inode_update(inode)) {
+	if (!f2fs_skip_inode_update(inode, datasync)) {
 		f2fs_write_inode(inode, NULL);
 		goto go_write;
 	}
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
