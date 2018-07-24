From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/3] f2fs: quota: do not mount as RDWR without
 QUOTA if quota feature enabled
Date: Tue, 24 Jul 2018 20:17:52 +0800
Message-ID: <20180724121754.19920-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fhwGe-0006iO-Uq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Jul 2018 12:18:16 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fhwGb-00GkIM-FQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Jul 2018 12:18:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

If quota feature is enabled, quota is on by default. However, if
CONFIG_QUOTA is not built in kernel, dquot entries will not get updated,
which leads to quota inconsistency.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/super.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0a8e12662174..796a2d756572 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -346,12 +346,6 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 			"QUOTA feature is enabled, so ignore jquota_fmt");
 		F2FS_OPTION(sbi).s_jquota_fmt = 0;
 	}
-	if (f2fs_sb_has_quota_ino(sbi->sb) && f2fs_readonly(sbi->sb)) {
-		f2fs_msg(sbi->sb, KERN_INFO,
-			 "Filesystem with quota feature cannot be mounted RDWR "
-			 "without CONFIG_QUOTA");
-		return -1;
-	}
 	return 0;
 }
 #endif
@@ -774,6 +768,13 @@ static int parse_options(struct super_block *sb, char *options)
 #ifdef CONFIG_QUOTA
 	if (f2fs_check_quota_options(sbi))
 		return -EINVAL;
+#else
+	if (f2fs_sb_has_quota_ino(sbi->sb) && !f2fs_readonly(sbi->sb)) {
+		f2fs_msg(sbi->sb, KERN_INFO,
+			 "Filesystem with quota feature cannot be mounted RDWR "
+			 "without CONFIG_QUOTA");
+		return -EINVAL;
+	}
 #endif
 
 	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
