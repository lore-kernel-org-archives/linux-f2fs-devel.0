From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 6/7] f2fs: introduce new option for
	controlling data flush
Date: Wed, 16 Dec 2015 13:12:16 +0800
Message-ID: <014201d137c0$6bdf7470$439e5d50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a94Oe-0004LZ-IX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 05:13:04 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a94Oc-0006Wy-OZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 05:13:04 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZF006EVQH7WS70@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 14:12:55 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Add a new option 'data_flush' to enable data flush functionality.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - rebase last dev-test branch.
 - fix to set option correctly.
---
 Documentation/filesystems/f2fs.txt | 2 ++
 fs/f2fs/f2fs.h                     | 1 +
 fs/f2fs/super.c                    | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index ad10494..e1c9f08 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -149,6 +149,8 @@ noextent_cache         Disable an extent cache based on rb-tree explicitly, see
                        the above extent_cache mount option.
 noinline_data          Disable the inline data feature, inline data feature is
                        enabled by default.
+data_flush             Enable data flushing before checkpoint in order to
+                       persist data of regular and symlink.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e73ddea..e907d9e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -54,6 +54,7 @@
 #define F2FS_MOUNT_FASTBOOT		0x00001000
 #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
 #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
+#define F2FS_MOUNT_DATA_FLUSH		0x00008000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 551688e..1f7f87e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -67,6 +67,7 @@ enum {
 	Opt_extent_cache,
 	Opt_noextent_cache,
 	Opt_noinline_data,
+	Opt_data_flush,
 	Opt_err,
 };
 
@@ -91,6 +92,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_extent_cache, "extent_cache"},
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
+	{Opt_data_flush, "data_flush"},
 	{Opt_err, NULL},
 };
 
@@ -406,6 +408,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_noinline_data:
 			clear_opt(sbi, INLINE_DATA);
 			break;
+		case Opt_data_flush:
+			set_opt(sbi, DATA_FLUSH);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -687,6 +692,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",extent_cache");
 	else
 		seq_puts(seq, ",noextent_cache");
+	if (test_opt(sbi, DATA_FLUSH))
+		seq_puts(seq, ",data_flush");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
 	return 0;
-- 
2.6.3



------------------------------------------------------------------------------
