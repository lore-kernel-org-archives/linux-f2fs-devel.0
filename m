From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/6] f2fs: fix to keep project quota consistent
Date: Tue, 25 Sep 2018 15:36:02 +0800
Message-ID: <20180925073603.102125-5-yuchao0@huawei.com>
References: <20180925073603.102125-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g4htV-0003sB-A6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:36:29 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g4htT-003HEd-OF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:36:29 +0000
In-Reply-To: <20180925073603.102125-1-yuchao0@huawei.com>
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

This patch does below changes to keep consistence of project quota data
in sudden power-cut case:
- update inode.i_projid and project quota atomically under lock_op() in
f2fs_ioc_setproject()
- recover inode.i_projid and project quota in recover_inode()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/file.c     | 37 ++++++++++++++++++++++++++++---------
 fs/f2fs/recovery.c | 12 ++++++++++--
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index be16a49c8b62..171917c0961c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2793,6 +2793,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid);
 int f2fs_pin_file_control(struct inode *inode, bool inc);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a388866e71ee..6f02c8daff76 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2604,13 +2604,29 @@ static int f2fs_ioc_get_features(struct file *filp, unsigned long arg)
 }
 
 #ifdef CONFIG_QUOTA
+int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
+{
+	struct dquot *transfer_to[MAXQUOTAS] = {};
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct super_block *sb = sbi->sb;
+	int err = 0;
+
+	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
+	if (!IS_ERR(transfer_to[PRJQUOTA])) {
+		err = __dquot_transfer(inode, transfer_to);
+		if (err)
+			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+		dqput(transfer_to[PRJQUOTA]);
+	}
+	return err;
+}
+
 static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
-	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct page *ipage;
 	kprojid_t kprojid;
 	int err;
@@ -2651,21 +2667,24 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	if (err)
 		return err;
 
-	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
-	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-		err = __dquot_transfer(inode, transfer_to);
-		dqput(transfer_to[PRJQUOTA]);
-		if (err)
-			goto out_dirty;
-	}
+	f2fs_lock_op(sbi);
+	err = f2fs_transfer_project_quota(inode, kprojid);
+	if (err)
+		goto out_unlock;
 
 	F2FS_I(inode)->i_projid = kprojid;
 	inode->i_ctime = current_time(inode);
-out_dirty:
 	f2fs_mark_inode_dirty_sync(inode, true);
+out_unlock:
+	f2fs_unlock_op(sbi);
 	return err;
 }
 #else
+int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
+{
+	return 0;
+}
+
 static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 {
 	if (projid != F2FS_DEF_PROJID)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 71577f30a889..5e68e31989c8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -250,10 +250,18 @@ static int recover_inode(struct inode *inode, struct page *page)
 			F2FS_FITS_IN_INODE(raw, le16_to_cpu(raw->i_extra_isize),
 								i_projid)) {
 			projid_t i_projid;
+			kprojid_t kprojid;
 
 			i_projid = (projid_t)le32_to_cpu(raw->i_projid);
-			F2FS_I(inode)->i_projid =
-				make_kprojid(&init_user_ns, i_projid);
+			kprojid = make_kprojid(&init_user_ns, i_projid);
+
+			if (!projid_eq(kprojid, F2FS_I(inode)->i_projid)) {
+				err = f2fs_transfer_project_quota(inode,
+								kprojid);
+				if (err)
+					return err;
+				F2FS_I(inode)->i_projid = kprojid;
+			}
 		}
 	}
 
-- 
2.18.0.rc1
