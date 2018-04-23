From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH] f2fs-tools: introduce tune.f2fs
Date: Mon, 23 Apr 2018 15:32:02 +0800
Message-ID: <20180423073202.150763-1-zhengjunling@huawei.com>
References: <13c34f59-6f6a-8252-0a9f-effccbcd6db0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fAVxk-0006bp-09
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 07:32:36 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fAVxh-00BOxv-2X
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 07:32:35 +0000
In-Reply-To: <13c34f59-6f6a-8252-0a9f-effccbcd6db0@huawei.com>
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

Introduce tune.f2fs tool to change the f2fs parameters.
Currently this tool only supports adding or removing encrypt
feature bit in superblock.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/Makefile.am  |  3 ++-
 fsck/fsck.h       |  5 +++++
 fsck/main.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/tune.c       | 46 +++++++++++++++++++++++++++++++++++++++++
 include/f2fs_fs.h | 61 +++++++++++++++++++++++++++++++++++++++----------------
 man/Makefile.am   |  2 +-
 man/tune.f2fs.8   | 50 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 207 insertions(+), 20 deletions(-)
 create mode 100644 fsck/tune.c
 create mode 100644 man/tune.f2fs.8

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 1fc7310..3efacfd 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -5,7 +5,7 @@ AM_CFLAGS = -Wall
 sbin_PROGRAMS = fsck.f2fs
 noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h quotaio_tree.h quotaio_v2.h xattr.h
 include_HEADERS = $(top_srcdir)/include/quota.h
-fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c resize.c \
+fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c resize.c tune.c \
 		node.c segment.c dir.c sload.c xattr.c \
 		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c
 fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
@@ -15,3 +15,4 @@ install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/defrag.f2fs
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/resize.f2fs
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/sload.f2fs
+	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/tune.f2fs
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 3e13fc6..39d6ed4 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -180,6 +180,8 @@ extern void write_superblock(struct f2fs_super_block *);
 extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
 extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
 
+extern int validate_super_block(struct f2fs_sb_info *, int);
+extern void print_sb_state(struct f2fs_super_block *);
 extern void print_raw_sb_info(struct f2fs_super_block *);
 
 extern u32 get_free_segments(struct f2fs_sb_info *);
@@ -220,6 +222,9 @@ int f2fs_resize(struct f2fs_sb_info *);
 /* sload.c */
 int f2fs_sload(struct f2fs_sb_info *);
 
+/* tune.c */
+int f2fs_tune(struct f2fs_sb_info *);
+
 /* segment.c */
 void reserve_new_block(struct f2fs_sb_info *, block_t *,
 					struct f2fs_summary *, int);
diff --git a/fsck/main.c b/fsck/main.c
index c4dd8b1..b8e1aee 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -29,6 +29,7 @@ extern struct sparse_file *f2fs_sparse_file;
 #endif
 
 INIT_FEATURE_TABLE;
+INIT_TUNE_FEATURE_TABLE;
 
 static char *absolute_path(const char *file)
 {
@@ -123,6 +124,15 @@ void sload_usage()
 	exit(1);
 }
 
+void tune_usage()
+{
+	MSG(0, "\nUsage: tune.f2fs [options] device\n");
+	MSG(0, "[options]:\n");
+	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -O [^]feature[,...]\n");
+	exit(1);
+}
+
 static int is_digits(char *optarg)
 {
 	unsigned int i;
@@ -145,6 +155,8 @@ static void error_out(char *prog)
 		resize_usage();
 	else if (!strcmp("sload.f2fs", prog))
 		sload_usage();
+	else if (!strcmp("tune.f2fs", prog))
+		tune_usage();
 	else
 		MSG(0, "\nWrong program.\n");
 }
@@ -528,6 +540,32 @@ void f2fs_parse_options(int argc, char *argv[])
 			if (err != NOERROR)
 				break;
 		}
+	} else if (!strcmp("tune.f2fs", prog)) {
+		const char *option_string = "d:O:";
+
+		c.func = TUNE;
+		while ((option = getopt(argc, argv, option_string)) != EOF) {
+			switch (option) {
+			case 'd':
+				if (!is_digits(optarg)) {
+					err = EWRONG_OPT;
+					break;
+				}
+				c.dbg_lv = atoi(optarg);
+				MSG(0, "Info: Debug level = %d\n",
+							c.dbg_lv);
+				break;
+			case 'O':
+				if (parse_feature(tune_feature_table, optarg))
+					tune_usage();
+				break;
+			default:
+				err = EUNKNOWN_OPT;
+				break;
+			}
+			if (err != NOERROR)
+				break;
+		}
 	}
 
 	add_default_options();
@@ -736,6 +774,13 @@ static int do_sload(struct f2fs_sb_info *sbi)
 	return f2fs_sload(sbi);
 }
 
+static int do_tune(struct f2fs_sb_info *sbi)
+{
+	// TODO: check global configuration
+
+	return f2fs_tune(sbi);
+}
+
 int main(int argc, char **argv)
 {
 	struct f2fs_sb_info *sbi;
@@ -768,6 +813,18 @@ fsck_again:
 	gfsck.sbi.fsck = &gfsck;
 	sbi = &gfsck.sbi;
 
+#ifdef WITH_TUNE
+	if (c.func == TUNE) {
+		ret = do_tune(sbi);
+		if (ret)
+			goto out_err;
+		/* If tune successfully, then call
+		 * f2fs_finalize_device to fsync.
+		 */
+		goto out;
+	}
+#endif
+
 	ret = f2fs_do_mount(sbi);
 	if (ret != 0) {
 		if (ret == 1) {
@@ -836,6 +893,9 @@ retry:
 				goto fsck_again;
 		}
 	}
+#ifdef WITH_TUNE
+out:
+#endif
 	ret = f2fs_finalize_device();
 	if (ret < 0)
 		return ret;
diff --git a/fsck/tune.c b/fsck/tune.c
new file mode 100644
index 0000000..1322639
--- /dev/null
+++ b/fsck/tune.c
@@ -0,0 +1,46 @@
+/**
+ * tune.c
+ *
+ * Copyright (C) 2018 Huawei Ltd.
+ * Witten by:
+ *   Junling Zheng <zhengjunling@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+
+int f2fs_tune(struct f2fs_sb_info *sbi)
+{
+	int ret;
+
+	/* Get and validate sbi->raw_super */
+	ret = validate_super_block(sbi, 0);
+	if (ret) {
+		ret = validate_super_block(sbi, 1);
+		if (ret)
+			return -1;
+	}
+
+	/* Tune features in sb */
+	if (c.feature)
+		sbi->raw_super->feature |= c.feature;
+	if (c.nofeature)
+		sbi->raw_super->feature &= ~c.nofeature;
+
+	MSG(0, "Info: Tune feature successfully!\n");
+	/* Print features in sb */
+	print_sb_state(sbi->raw_super);
+
+	/* Write raw_super back to both 1st and 2nd sb on disk */
+	ret = dev_write(sbi->raw_super, F2FS_SUPER_OFFSET,
+				sizeof(struct f2fs_super_block));
+	ASSERT(ret >= 0);
+	ret = dev_write(sbi->raw_super, F2FS_SUPER_OFFSET + F2FS_BLKSIZE,
+						sizeof(struct f2fs_super_block));
+	ASSERT(ret >= 0);
+	MSG(0, "Info: Writeback successfully!\n");
+
+	return ret;
+}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a1274fd..87d2fe9 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -13,6 +13,7 @@
 #define __F2FS_FS_H__
 
 #include <stdio.h>
+#include <ctype.h>
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -28,6 +29,7 @@
 #define WITH_DEFRAG
 #define WITH_RESIZE
 #define WITH_SLOAD
+#define WITH_TUNE
 #endif
 
 #include <inttypes.h>
@@ -309,6 +311,7 @@ enum f2fs_config_func {
 	DEFRAG,
 	RESIZE,
 	SLOAD,
+	TUNE,
 };
 
 enum default_set {
@@ -381,7 +384,8 @@ struct f2fs_configuration {
 	int ro;
 	int preserve_limits;		/* preserve quota limits */
 	int large_nat_bitmap;
-	__le32 feature;			/* defined features */
+	__le32 feature;			/* defined features to enable */
+	__le32 nofeature;		/* defined features to disable */
 
 	/* mkfs parameters */
 	u_int32_t next_free_nid;
@@ -1334,6 +1338,12 @@ struct feature feature_table[] = {					\
 	{ NULL,				0x0},				\
 };
 
+#define INIT_TUNE_FEATURE_TABLE						\
+struct feature tune_feature_table[] = {					\
+	{ "encrypt",			F2FS_FEATURE_ENCRYPT },		\
+	{ NULL,				0x0},				\
+};
+
 static inline u32 feature_map(struct feature *table, char *feature)
 {
 	struct feature *p;
@@ -1342,21 +1352,11 @@ static inline u32 feature_map(struct feature *table, char *feature)
 	return p->mask;
 }
 
-static inline int set_feature_bits(struct feature *table, char *features)
-{
-	u32 mask = feature_map(table, features);
-	if (mask) {
-		c.feature |= cpu_to_le32(mask);
-	} else {
-		MSG(0, "Error: Wrong features %s\n", features);
-		return -1;
-	}
-	return 0;
-}
-
 static inline int parse_feature(struct feature *table, const char *features)
 {
-	char *buf, *sub, *next;
+	char op, *buf, *sub, *next;
+	u32 feature_bit = 0;
+	int ret = 0;
 
 	buf = calloc(strlen(features) + 1, sizeof(char));
 	ASSERT(buf);
@@ -1376,12 +1376,37 @@ static inline int parse_feature(struct feature *table, const char *features)
 		else
 			*next = 0;
 
-		if (set_feature_bits(table, sub)) {
-			free(buf);
-			return -1;
+		if (!isalnum(*sub)) {
+			op = *sub;
+			sub++;
+		} else {
+			op = '+';
+		}
+
+		feature_bit = feature_map(table, sub);
+		if (!feature_bit) {
+			ERR_MSG("\tError: Not support feature %s\n", sub);
+			ret = -1;
+			goto out;
+		}
+
+		switch (op) {
+		case '+':
+			c.feature |= cpu_to_le32(feature_bit);
+			break;
+		case '-':
+		case '^':
+			c.nofeature |= cpu_to_le32(feature_bit);
+			break;
+		default:
+			ERR_MSG("\tError: Wrong operation %c\n", op);
+			ret = -1;
+			goto out;
 		}
 	}
+
+out:
 	free(buf);
-	return 0;
+	return ret;
 }
 #endif	/*__F2FS_FS_H */
diff --git a/man/Makefile.am b/man/Makefile.am
index 7856586..bfc4d19 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,3 +1,3 @@
 ## Makefile.am
 
-dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8 resize.f2fs.8 sload.f2fs.8
+dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8 resize.f2fs.8 sload.f2fs.8 tune.f2fs.8
diff --git a/man/tune.f2fs.8 b/man/tune.f2fs.8
new file mode 100644
index 0000000..5ee6790
--- /dev/null
+++ b/man/tune.f2fs.8
@@ -0,0 +1,50 @@
+.\" Copyright (C) 2015 Huawei Ltd.
+.\"
+.TH TUNE.F2FS 8
+.SH NAME
+tune.f2fs \- change the parameters of f2fs
+.SH SYNOPSIS
+.B tune.f2fs
+[
+.B \-d
+.I debugging-level
+]
+[
+.B \-O
+.I features to change
+]
+.I device
+.SH DESCRIPTION
+.B tune.f2fs
+is used to change the parameters of an f2fs file system (usually in a disk partition).
+\fIdevice\fP is the special file corresponding to the device (e.g.
+\fI/dev/sdXX\fP).
+
+Current version only supports enabling and disabling 'encrypt' feature.
+
+.PP
+The exit code returned by
+.B tune.f2fs
+is 0 on success and -1 on failure.
+.SH OPTIONS
+.TP
+.BI \-d " debug-level"
+Specify the level of debugging options.
+The default number is 0, which shows basic debugging messages.
+.TP
+.BI \-O " features"
+Specify the features to enable or disable. Currently only support 'encrypt' feature.
+.TP
+.SH AUTHOR
+This version of
+.B tune.f2fs
+has been written by Junling Zheng <zhengjunling@huawei.com>.
+.SH AVAILABILITY
+.B tune.f2fs
+is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
+.SH SEE ALSO
+.BR mkfs.f2fs(8),
+.BR fsck.f2fs(8),
+.BR dump.f2fs(8),
+.BR defrag.f2fs(8),
+.BR sload.f2fs(8).
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
