From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: introduce -o fastboot for reducing
	booting time only
Date: Thu, 30 Oct 2014 23:16:16 -0700
Message-ID: <1414736176-13201-4-git-send-email-jaegeuk@kernel.org>
References: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xk5VY-0000bC-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:16:24 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xk5VX-0001QI-3r for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:16:24 +0000
In-Reply-To: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
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

If a system wants to reduce the booting time as a top priority, now we can
use a mount option, -o fastboot.
With this option, f2fs conducts a little bit slow write_checkpoint, but
it can avoid the node page reads during the next mount time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt |  3 +++
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/file.c                     |  2 ++
 fs/f2fs/gc.c                       |  6 +++---
 fs/f2fs/super.c                    | 13 ++++++++++---
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 4bb9f27..e0950c4 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -135,6 +135,9 @@ nobarrier              This option can be used if underlying storage guarantees
 		       If this option is set, no cache_flush commands are issued
 		       but f2fs still guarantees the write ordering of all the
 		       data writes.
+fastboot               This option is used when a system wants to reduce mount
+                       time as much as possible, even though normal performance
+		       can be sacrificed.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a97058..d45f3f4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -49,6 +49,7 @@
 #define F2FS_MOUNT_INLINE_DENTRY	0x00000200
 #define F2FS_MOUNT_FLUSH_MERGE		0x00000400
 #define F2FS_MOUNT_NOBARRIER		0x00000800
+#define F2FS_MOUNT_FASTBOOT		0x00001000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3e44333..11fc6b1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -135,6 +135,8 @@ static inline bool need_do_checkpoint(struct inode *inode)
 		need_cp = true;
 	else if (F2FS_I(inode)->xattr_ver == cur_cp_version(F2FS_CKPT(sbi)))
 		need_cp = true;
+	else if (test_opt(sbi, FASTBOOT))
+		need_cp = true;
 
 	return need_cp;
 }
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7151d7d..b197a2f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -695,9 +695,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
 	int gc_type = BG_GC;
 	int nfree = 0;
 	int ret = -1;
-	struct cp_control cpc = {
-		.reason = CP_SYNC,
-	};
+	struct cp_control cpc;
+
+	cpc.reason = test_opt(sbi, FASTBOOT) ? CP_UMOUNT : CP_SYNC;
 
 	INIT_LIST_HEAD(&ilist);
 gc_more:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6c5fc76..512ffd8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -54,6 +54,7 @@ enum {
 	Opt_inline_dentry,
 	Opt_flush_merge,
 	Opt_nobarrier,
+	Opt_fastboot,
 	Opt_err,
 };
 
@@ -73,6 +74,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_nobarrier, "nobarrier"},
+	{Opt_fastboot, "fastboot"},
 	{Opt_err, NULL},
 };
 
@@ -351,6 +353,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_nobarrier:
 			set_opt(sbi, NOBARRIER);
 			break;
+		case Opt_fastboot:
+			set_opt(sbi, FASTBOOT);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -479,9 +484,9 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	trace_f2fs_sync_fs(sb, sync);
 
 	if (sync) {
-		struct cp_control cpc = {
-			.reason = CP_SYNC,
-		};
+		struct cp_control cpc;
+
+		cpc.reason = test_opt(sbi, FASTBOOT) ? CP_UMOUNT : CP_SYNC;
 		mutex_lock(&sbi->gc_mutex);
 		write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
@@ -574,6 +579,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",flush_merge");
 	if (test_opt(sbi, NOBARRIER))
 		seq_puts(seq, ",nobarrier");
+	if (test_opt(sbi, FASTBOOT))
+		seq_puts(seq, ",fastboot");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
 	return 0;
-- 
2.1.1


------------------------------------------------------------------------------
