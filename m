From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: relocate readdir_ra configure
 initialization
Date: Mon, 11 Jun 2018 18:02:01 +0800
Message-ID: <20180611100202.68674-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fSJfM-0002PM-SX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 10:03:12 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fSJfL-00FY00-4X
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 10:03:12 +0000
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

readdir_ra is sysfs configuration instead of mount option, so it should
not be initialized in default_options(), otherwise after remount, it can
be reset to be enabled which may not as user wish, so let's move it to
f2fs_tuning_parameters().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56f3af86f62c..19ef966a99e9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1357,7 +1357,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).test_dummy_encryption = false;
 	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
 	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
-	sbi->readdir_ra = 1;
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
@@ -2655,6 +2654,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 		sm_i->dcc_info->discard_granularity = 1;
 		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
 	}
+
+	sbi->readdir_ra = 1;
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
