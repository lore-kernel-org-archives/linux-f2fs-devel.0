From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: avoid unneeded sync on quota file
Date: Mon, 7 Aug 2017 16:37:59 +0800
Message-ID: <20170807083759.43251-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We only need to sync quota file with appointed quota type instead of all
types in f2fs_quota_{on,off}.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5310bd80f72c..4b292f5dce89 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1458,7 +1458,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 	struct inode *inode;
 	int err;
 
-	err = f2fs_quota_sync(sb, -1);
+	err = f2fs_quota_sync(sb, type);
 	if (err)
 		return err;
 
@@ -1486,7 +1486,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	if (!inode || !igrab(inode))
 		return dquot_quota_off(sb, type);
 
-	f2fs_quota_sync(sb, -1);
+	f2fs_quota_sync(sb, type);
 
 	err = dquot_quota_off(sb, type);
 	if (err)
-- 
2.13.1.388.g69e6b9b4f4a9
