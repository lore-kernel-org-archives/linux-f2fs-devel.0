From: Chao Yu <chao@kernel.org>
Subject: [PATCH 6/6] f2fs: introduce f2fs_statfs_project
Date: Sun, 16 Jul 2017 15:08:59 +0800
Message-ID: <20170716070859.25246-6-chao@kernel.org>
References: <20170716070859.25246-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170716070859.25246-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch introduces f2fs_statfs_project, it enables to show usage
status of directory tree which is limited with project quota.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56cea32348fa..815bb6365ba0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -705,6 +705,48 @@ static int f2fs_unfreeze(struct super_block *sb)
 	return 0;
 }
 
+#ifdef CONFIG_QUOTA
+static int f2fs_statfs_project(struct super_block *sb,
+				kprojid_t projid, struct kstatfs *buf)
+{
+	struct kqid qid;
+	struct dquot *dquot;
+	u64 limit;
+	u64 curblock;
+
+	qid = make_kqid_projid(projid);
+	dquot = dqget(sb, qid);
+	if (IS_ERR(dquot))
+		return PTR_ERR(dquot);
+	spin_lock(&dq_data_lock);
+
+	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
+		 dquot->dq_dqb.dqb_bsoftlimit :
+		 dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
+	if (limit && buf->f_blocks > limit) {
+		curblock = dquot->dq_dqb.dqb_curspace >> sb->s_blocksize_bits;
+		buf->f_blocks = limit;
+		buf->f_bfree = buf->f_bavail =
+			(buf->f_blocks > curblock) ?
+			 (buf->f_blocks - curblock) : 0;
+	}
+
+	limit = dquot->dq_dqb.dqb_isoftlimit ?
+		dquot->dq_dqb.dqb_isoftlimit :
+		dquot->dq_dqb.dqb_ihardlimit;
+	if (limit && buf->f_files > limit) {
+		buf->f_files = limit;
+		buf->f_ffree =
+			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
+			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
+	}
+
+	spin_unlock(&dq_data_lock);
+	dqput(dquot);
+	return 0;
+}
+#endif
+
 static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -740,6 +782,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_fsid.val[0] = (u32)id;
 	buf->f_fsid.val[1] = (u32)(id >> 32);
 
+#ifdef CONFIG_QUOTA
+	if (is_inode_flag_set(dentry->d_inode, FI_PROJ_INHERIT) &&
+			sb_has_quota_limits_enabled(sb, PRJQUOTA)) {
+		f2fs_statfs_project(sb, F2FS_I(dentry->d_inode)->i_projid, buf);
+	}
+#endif
 	return 0;
 }
 
-- 
2.13.0.90.g1eb437020
