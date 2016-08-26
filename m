From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add noinline_dentry mount option
Date: Fri, 26 Aug 2016 09:01:22 +0800
Message-ID: <20160826010122.79644-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bd5Yf-0006n6-BN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 01:03:45 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bd5Yb-00054W-E8
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 01:03:45 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds noinline_dentry mount option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 1 +
 fs/f2fs/super.c                    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index ecd8080..753dd4f 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -131,6 +131,7 @@ inline_dentry          Enable the inline dir feature: data in new created
                        directory entries can be written into inode block. The
                        space of inode block which is used to store inline
                        dentries is limited to ~3.4k.
+noinline_dentry        Diable the inline dentry feature.
 flush_merge	       Merge concurrent cache_flush commands as much as possible
                        to eliminate redundant command issues. If the underlying
 		       device handles the cache_flush command relatively slowly,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7974833..b776414 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -87,6 +87,7 @@ enum {
 	Opt_inline_xattr,
 	Opt_inline_data,
 	Opt_inline_dentry,
+	Opt_noinline_dentry,
 	Opt_flush_merge,
 	Opt_noflush_merge,
 	Opt_nobarrier,
@@ -118,6 +119,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_inline_xattr, "inline_xattr"},
 	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
+	{Opt_noinline_dentry, "noinline_dentry"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_noflush_merge, "noflush_merge"},
 	{Opt_nobarrier, "nobarrier"},
@@ -488,6 +490,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_inline_dentry:
 			set_opt(sbi, INLINE_DENTRY);
 			break;
+		case Opt_noinline_dentry:
+			clear_opt(sbi, INLINE_DENTRY);
+			break;
 		case Opt_flush_merge:
 			set_opt(sbi, FLUSH_MERGE);
 			break;
@@ -879,6 +884,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",noinline_data");
 	if (test_opt(sbi, INLINE_DENTRY))
 		seq_puts(seq, ",inline_dentry");
+	else
+		seq_puts(seq, ",noinline_dentry");
 	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
 	if (test_opt(sbi, NOBARRIER))
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
