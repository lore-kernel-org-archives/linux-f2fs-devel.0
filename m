From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] sload.f2fs: give correct file type
Date: Mon,  7 May 2018 11:58:33 -0700
Message-ID: <20180507185833.76359-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fFlLO-0006VY-CN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 18:58:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFlLM-00BB2E-Vo
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 18:58:42 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Lianjun Huang <huanglianjun@vivo.com>

From: Lianjun Huang <huanglianjun@vivo.com>

This fixes permission error due to wrong file type.

Signed-off-by: Lianjun Huang <huanglianjun@vivo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/sload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/sload.c b/fsck/sload.c
index 2842f2c..2fb13f2 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -106,7 +106,7 @@ static int set_perms_and_caps(struct dentry *de)
 
 	/* Permissions */
 	if (fs_config_func != NULL) {
-		fs_config_func(mnt_path, S_ISDIR(de->mode),
+		fs_config_func(mnt_path, de->file_type == F2FS_FT_DIR,
 				c.target_out_dir, &uid, &gid, &imode,
 				&capabilities);
 		de->uid = uid & 0xffff;
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
