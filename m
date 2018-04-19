From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: factor out feature table from
 mkfs.f2fs
Date: Thu, 19 Apr 2018 13:56:16 -0700
Message-ID: <20180419205616.22105-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f9GbR-0007ux-Tu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 20:56:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9GbQ-002zPP-Fx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 20:56:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch makes feature bit work be global in f2fs-tools.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h       | 77 +++++++++++++++++++++++++++++++++++++++++
 mkfs/f2fs_format_main.c | 67 ++---------------------------------
 2 files changed, 80 insertions(+), 64 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 54ac1c8..a1274fd 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -40,6 +40,14 @@
 #include <linux/blkzoned.h>
 #endif
 
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
+
+#ifdef HAVE_STRING_H
+#include <string.h>
+#endif
+
 #ifdef HAVE_LIBSELINUX
 #include <selinux/selinux.h>
 #include <selinux/label.h>
@@ -1307,4 +1315,73 @@ static inline void show_version(const char *prog)
 	MSG(0, "%s %s (%s)\n", prog, F2FS_TOOLS_VERSION, F2FS_TOOLS_DATE);
 }
 
+struct feature {
+	char *name;
+	u32  mask;
+};
+
+#define INIT_FEATURE_TABLE						\
+struct feature feature_table[] = {					\
+	{ "encrypt",			F2FS_FEATURE_ENCRYPT },		\
+	{ "extra_attr",			F2FS_FEATURE_EXTRA_ATTR },	\
+	{ "project_quota",		F2FS_FEATURE_PRJQUOTA },	\
+	{ "inode_checksum",		F2FS_FEATURE_INODE_CHKSUM },	\
+	{ "flexible_inline_xattr",	F2FS_FEATURE_FLEXIBLE_INLINE_XATTR },\
+	{ "quota",			F2FS_FEATURE_QUOTA_INO },	\
+	{ "inode_crtime",		F2FS_FEATURE_INODE_CRTIME },	\
+	{ "lost_found",			F2FS_FEATURE_LOST_FOUND },	\
+	{ "verity",			F2FS_FEATURE_VERITY },	/* reserved */ \
+	{ NULL,				0x0},				\
+};
+
+static inline u32 feature_map(struct feature *table, char *feature)
+{
+	struct feature *p;
+	for (p = table; p->name && strcmp(p->name, feature); p++)
+		;
+	return p->mask;
+}
+
+static inline int set_feature_bits(struct feature *table, char *features)
+{
+	u32 mask = feature_map(table, features);
+	if (mask) {
+		c.feature |= cpu_to_le32(mask);
+	} else {
+		MSG(0, "Error: Wrong features %s\n", features);
+		return -1;
+	}
+	return 0;
+}
+
+static inline int parse_feature(struct feature *table, const char *features)
+{
+	char *buf, *sub, *next;
+
+	buf = calloc(strlen(features) + 1, sizeof(char));
+	ASSERT(buf);
+	strncpy(buf, features, strlen(features) + 1);
+
+	for (sub = buf; sub && *sub; sub = next ? next + 1 : NULL) {
+		/* Skip the beginning blanks */
+		while (*sub && *sub == ' ')
+			sub++;
+		next = sub;
+		/* Skip a feature word */
+		while (*next && *next != ' ' && *next != ',')
+			next++;
+
+		if (*next == 0)
+			next = NULL;
+		else
+			*next = 0;
+
+		if (set_feature_bits(table, sub)) {
+			free(buf);
+			return -1;
+		}
+	}
+	free(buf);
+	return 0;
+}
 #endif	/*__F2FS_FS_H */
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 4e39fbd..8af70a2 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -37,23 +37,7 @@ extern struct sparse_file *f2fs_sparse_file;
 extern struct f2fs_configuration c;
 static int force_overwrite = 0;
 
-struct feature {
-	char *name;
-	u32  mask;
-};
-
-struct feature feature_table[] = {
-	{ "encrypt",			F2FS_FEATURE_ENCRYPT },
-	{ "extra_attr",			F2FS_FEATURE_EXTRA_ATTR },
-	{ "project_quota",		F2FS_FEATURE_PRJQUOTA },
-	{ "inode_checksum",		F2FS_FEATURE_INODE_CHKSUM },
-	{ "flexible_inline_xattr",	F2FS_FEATURE_FLEXIBLE_INLINE_XATTR },
-	{ "quota",			F2FS_FEATURE_QUOTA_INO },
-	{ "inode_crtime",		F2FS_FEATURE_INODE_CRTIME },
-	{ "lost_found",			F2FS_FEATURE_LOST_FOUND },
-	{ "verity",			F2FS_FEATURE_VERITY },	/* reserved */
-	{ NULL,				0x0},
-};
+INIT_FEATURE_TABLE;
 
 static void mkfs_usage()
 {
@@ -104,52 +88,6 @@ static void f2fs_show_info()
 		MSG(0, "Info: Set conf for android\n");
 }
 
-static inline u32 feature_map(char *feature)
-{
-	struct feature *p;
-	for (p = feature_table; p->name && strcmp(p->name, feature); p++)
-		;
-	return p->mask;
-}
-
-static void set_feature_bits(char *features)
-{
-	u32 mask = feature_map(features);
-	if (mask) {
-		c.feature |= cpu_to_le32(mask);
-	} else {
-		MSG(0, "Error: Wrong features %s\n", features);
-		mkfs_usage();
-	}
-}
-
-static void parse_feature(const char *features)
-{
-	char *buf, *sub, *next;
-
-	buf = calloc(strlen(features) + 1, sizeof(char));
-	ASSERT(buf);
-	strncpy(buf, features, strlen(features) + 1);
-
-	for (sub = buf; sub && *sub; sub = next ? next + 1 : NULL) {
-		/* Skip the beginning blanks */
-		while (*sub && *sub == ' ')
-			sub++;
-		next = sub;
-		/* Skip a feature word */
-		while (*next && *next != ' ' && *next != ',')
-			next++;
-
-		if (*next == 0)
-			next = NULL;
-		else
-			*next = 0;
-
-		set_feature_bits(sub);
-	}
-	free(buf);
-}
-
 static void add_default_options(void)
 {
 	switch (c.defset) {
@@ -221,7 +159,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 			c.overprovision = atof(optarg);
 			break;
 		case 'O':
-			parse_feature(optarg);
+			if (parse_feature(feature_table, optarg))
+				mkfs_usage();
 			break;
 		case 's':
 			c.segs_per_sec = atoi(optarg);
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
