From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce noinline_xattr mount option
Date: Wed, 15 Feb 2017 10:34:45 +0800
Message-ID: <20170215023445.9746-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cdpR7-0007go-H7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Feb 2017 02:35:17 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cdpR5-0002bu-86
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Feb 2017 02:35:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces new mount option 'noinline_xattr', so we can disable
inline xattr functionality which is already set as a default mount option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt |  1 +
 fs/f2fs/super.c                    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 8c8691b2b199..999341236979 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -125,6 +125,7 @@ active_logs=%u         Support configuring the number of active logs. In the
 disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
 inline_xattr           Enable the inline xattrs feature.
+noinline_xattr         Disable the inline xattrs feature.
 inline_data            Enable the inline data feature: New created small(<~3.4k)
                        files can be written into inode block.
 inline_dentry          Enable the inline dir feature: data in new created
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d09ebabc459a..95230f0c4eee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -89,6 +89,7 @@ enum {
 	Opt_active_logs,
 	Opt_disable_ext_identify,
 	Opt_inline_xattr,
+	Opt_noinline_xattr,
 	Opt_inline_data,
 	Opt_inline_dentry,
 	Opt_noinline_dentry,
@@ -123,6 +124,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_active_logs, "active_logs=%u"},
 	{Opt_disable_ext_identify, "disable_ext_identify"},
 	{Opt_inline_xattr, "inline_xattr"},
+	{Opt_noinline_xattr, "noinline_xattr"},
 	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_noinline_dentry, "noinline_dentry"},
@@ -444,6 +446,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_inline_xattr:
 			set_opt(sbi, INLINE_XATTR);
 			break;
+		case Opt_noinline_xattr:
+			clear_opt(sbi, INLINE_XATTR);
+			break;
 #else
 		case Opt_user_xattr:
 			f2fs_msg(sb, KERN_INFO,
@@ -457,6 +462,10 @@ static int parse_options(struct super_block *sb, char *options)
 			f2fs_msg(sb, KERN_INFO,
 				"inline_xattr options not supported");
 			break;
+		case Opt_noinline_xattr:
+			f2fs_msg(sb, KERN_INFO,
+				"noinline_xattr options not supported");
+			break;
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 		case Opt_acl:
@@ -912,6 +921,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",nouser_xattr");
 	if (test_opt(sbi, INLINE_XATTR))
 		seq_puts(seq, ",inline_xattr");
+	else
+		seq_puts(seq, ",noinline_xattr");
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 	if (test_opt(sbi, POSIX_ACL))
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
