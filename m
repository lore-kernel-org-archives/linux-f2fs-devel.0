From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: fix return value of f2fs_set_qf_name and
 parse_options
Date: Sat, 11 Aug 2018 14:49:10 +0800 (CST)
Message-ID: <4a798044.262f.16527bef428.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kernelpatch@126.com>) id 1foNiK-0000V4-9X
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 11 Aug 2018 06:49:28 +0000
Received: from m15-36.126.com ([220.181.15.36])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1foNiE-00Ec0Y-OM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 11 Aug 2018 06:49:28 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

match_strdup() returns NULL when kmalloc failed, so the caller
function f2fs_set_qf_name() should return -ENOMEM in this case;
match_int() returns -ENOMEM, -EINVAL, or -ERANGE on failure,
so the caller function parse_options() should not always return
-EINVAL in this case.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/super.c | 60 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 53d70b6..bf6505e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -269,7 +269,7 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 	if (!qname) {
 		f2fs_msg(sb, KERN_ERR,
 			"Not enough memory for storing quotafile name");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 	if (F2FS_OPTION(sbi).s_qf_names[qtype]) {
 		if (strcmp(F2FS_OPTION(sbi).s_qf_names[qtype], qname) == 0)
@@ -366,9 +366,7 @@ static int parse_options(struct super_block *sb, char *options)
 	int arg = 0;
 	kuid_t uid;
 	kgid_t gid;
-#ifdef CONFIG_QUOTA
 	int ret;
-#endif
 
 	if (!options)
 		return 0;
@@ -452,8 +450,11 @@ static int parse_options(struct super_block *sb, char *options)
 			clear_opt(sbi, INLINE_XATTR);
 			break;
 		case Opt_inline_xattr_size:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 			set_opt(sbi, INLINE_XATTR_SIZE);
 			F2FS_OPTION(sbi).inline_xattr_size = arg;
 			break;
@@ -491,8 +492,11 @@ static int parse_options(struct super_block *sb, char *options)
 			break;
 #endif
 		case Opt_active_logs:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 			if (arg != 2 && arg != 4 && arg != NR_CURSEG_TYPE)
 				return -EINVAL;
 			F2FS_OPTION(sbi).active_logs = arg;
@@ -534,8 +538,11 @@ static int parse_options(struct super_block *sb, char *options)
 			set_opt(sbi, DATA_FLUSH);
 			break;
 		case Opt_reserve_root:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 			if (test_opt(sbi, RESERVE_ROOT)) {
 				f2fs_msg(sb, KERN_INFO,
 					"Preserve previous reserve_root=%u",
@@ -546,8 +553,11 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			break;
 		case Opt_resuid:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 			uid = make_kuid(current_user_ns(), arg);
 			if (!uid_valid(uid)) {
 				f2fs_msg(sb, KERN_ERR,
@@ -557,8 +567,11 @@ static int parse_options(struct super_block *sb, char *options)
 			F2FS_OPTION(sbi).s_resuid = uid;
 			break;
 		case Opt_resgid:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 			gid = make_kgid(current_user_ns(), arg);
 			if (!gid_valid(gid)) {
 				f2fs_msg(sb, KERN_ERR,
@@ -592,8 +605,11 @@ static int parse_options(struct super_block *sb, char *options)
 			kfree(name);
 			break;
 		case Opt_io_size_bits:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 			if (arg > __ilog2_u32(BIO_MAX_PAGES)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"Not support %d, larger than %d",
@@ -603,8 +619,11 @@ static int parse_options(struct super_block *sb, char *options)
 			F2FS_OPTION(sbi).write_io_size_bits = arg;
 			break;
 		case Opt_fault_injection:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 			f2fs_build_fault_attr(sbi, arg, F2FS_ALL_FAULT_TYPE);
 			set_opt(sbi, FAULT_INJECTION);
@@ -614,8 +633,11 @@ static int parse_options(struct super_block *sb, char *options)
 #endif
 			break;
 		case Opt_fault_type:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
+			if (args->from) {
+				ret = match_int(args, &arg);
+				if (ret)
+					return ret;
+			}
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 			f2fs_build_fault_attr(sbi, 0, arg);
 			set_opt(sbi, FAULT_INJECTION);
-- 
1.8.3.1
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
