From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add default mount options to remount
Date: Thu, 7 May 2015 17:20:35 +0800
Message-ID: <1430990435-3679-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1YqHyf-0004fc-JZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 May 2015 09:20:21 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YqHyW-0006nv-Cq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 May 2015 09:20:21 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, cm224.lee@samsung.com

I use f2fs filesystem with /data partition on my Android phone
by the default mount options. When I remount /data in order to
adding discard option to run some benchmarks, I find the default
options such as background_gc, user_xattr and acl turned off.

So I introduce a function named default_options in super.c. It do
some default setting, and both mount and remount operations will
call this function to complete default setting.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 138fa93..1f9f18a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -658,6 +658,22 @@ static const struct file_operations f2fs_seq_segment_info_fops = {
 	.release = single_release,
 };
 
+static void default_options(struct f2fs_sb_info *sbi)
+{
+	/* init some FS parameters */
+	sbi->active_logs = NR_CURSEG_TYPE;
+
+	set_opt(sbi, BG_GC);
+	set_opt(sbi, INLINE_DATA);
+
+#ifdef CONFIG_F2FS_FS_XATTR
+	set_opt(sbi, XATTR_USER);
+#endif
+#ifdef CONFIG_F2FS_FS_POSIX_ACL
+	set_opt(sbi, POSIX_ACL);
+#endif
+}
+
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -675,8 +691,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	org_mount_opt = sbi->mount_opt;
 	active_logs = sbi->active_logs;
 
-	sbi->mount_opt.opt = 0;
-	sbi->active_logs = NR_CURSEG_TYPE;
+	default_options(sbi);
 
 	/* parse mount options */
 	err = parse_options(sb, data);
@@ -1018,18 +1033,7 @@ try_onemore:
 		goto free_sbi;
 
 	sb->s_fs_info = sbi;
-	/* init some FS parameters */
-	sbi->active_logs = NR_CURSEG_TYPE;
-
-	set_opt(sbi, BG_GC);
-	set_opt(sbi, INLINE_DATA);
-
-#ifdef CONFIG_F2FS_FS_XATTR
-	set_opt(sbi, XATTR_USER);
-#endif
-#ifdef CONFIG_F2FS_FS_POSIX_ACL
-	set_opt(sbi, POSIX_ACL);
-#endif
+	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
 	if (data && !options) {
-- 
1.9.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
