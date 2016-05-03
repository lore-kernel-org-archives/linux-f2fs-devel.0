From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/11] f2fs: add mount option to select fault
	injection ratio
Date: Tue,  3 May 2016 11:21:42 -0700
Message-ID: <1462299708-67906-5-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexR-0005zI-Kv
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexQ-0007Es-RA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:05 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds a mount option to select fault ratio.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Kconfig |  8 ++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 16 ++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 1f8982a..378c221 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -94,3 +94,11 @@ config F2FS_IO_TRACE
 	  information and block IO patterns in the filesystem level.
 
 	  If unsure, say N.
+
+config F2FS_FAULT_INJECTION
+	bool "F2FS fault injection facility"
+	depends on F2FS_FS
+	help
+	  Test F2FS to inject faults such as ENOMEM, ENOSPC, and so on.
+
+	  If unsure, say N.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 364d5fd..0684d3e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -56,6 +56,7 @@
 #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
 #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
 #define F2FS_MOUNT_DATA_FLUSH		0x00008000
+#define F2FS_MOUNT_FAULT_INJECTION	0x00010000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 90d4b86..b27febd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -39,6 +39,10 @@ static struct proc_dir_entry *f2fs_proc_root;
 static struct kmem_cache *f2fs_inode_cachep;
 static struct kset *f2fs_kset;
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+u32 f2fs_fault_rate = 0;
+#endif
+
 /* f2fs-wide shrinker description */
 static struct shrinker f2fs_shrinker_info = {
 	.scan_objects = f2fs_shrink_scan,
@@ -68,6 +72,7 @@ enum {
 	Opt_noextent_cache,
 	Opt_noinline_data,
 	Opt_data_flush,
+	Opt_fault_injection,
 	Opt_err,
 };
 
@@ -93,6 +98,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
+	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_err, NULL},
 };
 
@@ -433,6 +439,16 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
+		case Opt_fault_injection:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+			f2fs_fault_rate = arg;
+#else
+			f2fs_msg(sb, KERN_INFO,
+				"FAULT_INJECTION was not selected");
+#endif
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
