From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: report error if quota off error during umount
Date: Thu, 6 Sep 2018 20:44:35 +0800
Message-ID: <20180906124436.89193-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Yunlei He <heyunlei@huawei.com>, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Yunlei He <heyunlei@huawei.com>

Now, we depend on fsck to ensure quota file data is ok,
so we scan whole partition if checkpoint without umount
flag. It's same for quota off error case, which may make
quota file data inconsistent.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8f026ba226fb..c026aaccf218 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1874,7 +1874,9 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	if (!inode || !igrab(inode))
 		return dquot_quota_off(sb, type);
 
-	f2fs_quota_sync(sb, type);
+	err = f2fs_quota_sync(sb, type);
+	if (err)
+		goto out_put;
 
 	err = dquot_quota_off(sb, type);
 	if (err || f2fs_sb_has_quota_ino(sb))
@@ -1893,9 +1895,18 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 void f2fs_quota_off_umount(struct super_block *sb)
 {
 	int type;
+	int err;
 
-	for (type = 0; type < MAXQUOTAS; type++)
-		f2fs_quota_off(sb, type);
+	for (type = 0; type < MAXQUOTAS; type++) {
+		err = f2fs_quota_off(sb, type);
+		if (err) {
+			f2fs_msg(sb, KERN_ERR,
+				"Fail to turn off disk quota "
+				"(type: %d, err: %d), Please "
+				"run fsck to fix it.", type, err);
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
+		}
+	}
 }
 
 static int f2fs_dquot_commit(struct dquot *dquot)
-- 
2.18.0.rc1
