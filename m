From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: quota: remove journalled project quota
Date: Thu, 26 Jul 2018 19:25:34 +0800
Message-ID: <20180726112534.59007-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fieP3-0003zH-P5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 11:25:53 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fieP2-0096Ou-3F
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 11:25:53 +0000
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

Quota sysfiles are already using journalled method to save quota value.
And non-journalled project quota is not supported by userspace tools. So
there is no need to implement journalled project quota.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 Documentation/filesystems/f2fs.txt |  2 --
 fs/f2fs/super.c                    | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 69f8de995739..acfb95d0d655 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -167,11 +167,9 @@ grpquota               Enable plain group disk quota accounting.
 prjquota               Enable plain project quota accounting.
 usrjquota=<file>       Appoint specified file and type during mount, so that quota
 grpjquota=<file>       information can be properly updated during recovery flow,
-prjjquota=<file>       <quota file>: must be in root directory;
 jqfmt=<quota type>     <quota type>: [vfsold,vfsv0,vfsv1].
 offusrjquota           Turn off user journelled quota.
 offgrpjquota           Turn off group journelled quota.
-offprjjquota           Turn off project journelled quota.
 quota                  Enable plain user disk quota accounting.
 noquota                Disable all plain disk quota option.
 whint_mode=%s          Control which write hints are passed down to block
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6ad0414ba303..c683952fe6e6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -121,10 +121,8 @@ enum {
 	Opt_prjquota,
 	Opt_usrjquota,
 	Opt_grpjquota,
-	Opt_prjjquota,
 	Opt_offusrjquota,
 	Opt_offgrpjquota,
-	Opt_offprjjquota,
 	Opt_jqfmt_vfsold,
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
@@ -178,10 +176,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_prjquota, "prjquota"},
 	{Opt_usrjquota, "usrjquota=%s"},
 	{Opt_grpjquota, "grpjquota=%s"},
-	{Opt_prjjquota, "prjjquota=%s"},
 	{Opt_offusrjquota, "usrjquota="},
 	{Opt_offgrpjquota, "grpjquota="},
-	{Opt_offprjjquota, "prjjquota="},
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
@@ -639,11 +635,6 @@ static int parse_options(struct super_block *sb, char *options)
 			if (ret)
 				return ret;
 			break;
-		case Opt_prjjquota:
-			ret = f2fs_set_qf_name(sb, PRJQUOTA, &args[0]);
-			if (ret)
-				return ret;
-			break;
 		case Opt_offusrjquota:
 			ret = f2fs_clear_qf_name(sb, USRQUOTA);
 			if (ret)
@@ -654,11 +645,6 @@ static int parse_options(struct super_block *sb, char *options)
 			if (ret)
 				return ret;
 			break;
-		case Opt_offprjjquota:
-			ret = f2fs_clear_qf_name(sb, PRJQUOTA);
-			if (ret)
-				return ret;
-			break;
 		case Opt_jqfmt_vfsold:
 			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_OLD;
 			break;
@@ -681,10 +667,8 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_prjquota:
 		case Opt_usrjquota:
 		case Opt_grpjquota:
-		case Opt_prjjquota:
 		case Opt_offusrjquota:
 		case Opt_offgrpjquota:
-		case Opt_offprjjquota:
 		case Opt_jqfmt_vfsold:
 		case Opt_jqfmt_vfsv0:
 		case Opt_jqfmt_vfsv1:
@@ -1224,10 +1208,6 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 	if (F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
 		seq_show_option(seq, "grpjquota",
 			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA]);
-
-	if (F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
-		seq_show_option(seq, "prjjquota",
-			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]);
 #endif
 }
 
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
