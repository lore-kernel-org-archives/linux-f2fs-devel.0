From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/10] f2fs: get io size bit from mount option
Date: Fri, 30 Dec 2016 10:51:12 -0800
Message-ID: <20161230185117.3832-5-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2H6-0006BI-KT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2H5-0003sx-P7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:32 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
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

This patch adds to set io_size_bits from mount option.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt |  2 ++
 fs/f2fs/super.c                    | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 753dd4f96afe..d99faced79cb 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -157,6 +157,8 @@ data_flush             Enable data flushing before checkpoint in order to
 mode=%s                Control block allocation mode which supports "adaptive"
                        and "lfs". In "lfs" mode, there should be no random
                        writes towards main area.
+io_bits=%u             Set the bit size of write IO requests. It should be set
+                       with "mode=lfs".
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 692ff1b5adf5..f3697f97e527 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -101,6 +101,7 @@ enum {
 	Opt_noinline_data,
 	Opt_data_flush,
 	Opt_mode,
+	Opt_io_size_bits,
 	Opt_fault_injection,
 	Opt_lazytime,
 	Opt_nolazytime,
@@ -133,6 +134,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
 	{Opt_mode, "mode=%s"},
+	{Opt_io_size_bits, "io_bits=%u"},
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
@@ -535,6 +537,17 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			kfree(name);
 			break;
+		case Opt_io_size_bits:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+			if (arg > __ilog2_u32(BIO_MAX_PAGES)) {
+				f2fs_msg(sb, KERN_WARNING,
+					"Not support %d, larger than %d",
+					1 << arg, BIO_MAX_PAGES);
+				return -EINVAL;
+			}
+			sbi->write_io_size_bits = arg;
+			break;
 		case Opt_fault_injection:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
@@ -558,6 +571,13 @@ static int parse_options(struct super_block *sb, char *options)
 			return -EINVAL;
 		}
 	}
+
+	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
+		f2fs_msg(sb, KERN_ERR,
+				"Should set mode=lfs with %uKB-sized IO",
+				F2FS_IO_SIZE_KB(sbi));
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -918,6 +938,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (test_opt(sbi, LFS))
 		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
+	if (F2FS_IO_SIZE_BITS(sbi))
+		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 
 	return 0;
 }
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
