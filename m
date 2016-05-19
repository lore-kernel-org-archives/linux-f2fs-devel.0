From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Thu, 19 May 2016 10:46:06 -0700
Message-ID: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>
Date: Wed, 18 May 2016 15:58:00 -0700
Subject: [PATCH] f2fs: introduce on-disk layout version checking functionality

Currently, F2FS has 16TB limitation on volume size.
But 16TB NAND-based SSDs are around the corner. Unfortunately,
support of 16TB+ volume size needs in modification of on-disk
layout metadata structures that will be incompatible with
current version of F2FS's on-disk layout.

This patch implements support of checking version of
F2FS on-disk layout. The F2FS superblock contains major_ver and
feature fields. Implemented functionality checks the major_ver
field and presence of flag that declares 16TB+ volumes support.
If file system driver is unable to support 16TB+ volume size then
mount of operation of F2FS volume with incompatible version or
feature will fail.

Signed-off-by: Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>
CC: Vyacheslav Dubeyko <slava@dubeyko.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Cyril Guyot <Cyril.Guyot@hgst.com>
CC: Adam Manzanares <Adam.Manzanares@hgst.com>
CC: Damien Le Moal <Damien.LeMoal@hgst.com>
---
 fs/f2fs/Kconfig | 12 ++++++++++++
 fs/f2fs/f2fs.h  | 10 +++++++++-
 fs/f2fs/super.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 1f8982a..ec6bba4 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -94,3 +94,15 @@ config F2FS_IO_TRACE
 	  information and block IO patterns in the filesystem level.
 
 	  If unsure, say N.
+
+config F2FS_16TB_VOLUME_SUPPORT
+	bool "Support for large (16TB+) F2FS volumes"
+	depends on F2FS_FS
+	default n
+	help
+	  Enable support of 16TB and larger F2FS volumes.
+
+	  This feature is under implementation right now. So, no real support
+	  is available yet.
+
+	  If unsure, say N.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7a4558d..8fa3acc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -37,6 +37,13 @@
 	} while (0)
 #endif
 
+#ifdef CONFIG_F2FS_16TB_VOLUME_SUPPORT
+#define F2FS_MAX_SUPP_MAJOR_VERSION		(2)
+#define F2FS_MIN_16TB_VOLUME_SUPPORT_VERSION	(2)
+#else
+#define F2FS_MAX_SUPP_MAJOR_VERSION		(1)
+#endif
+
 /*
  * For mount options
  */
@@ -75,7 +82,8 @@ struct f2fs_mount_info {
 	unsigned int	opt;
 };
 
-#define F2FS_FEATURE_ENCRYPT	0x0001
+#define F2FS_FEATURE_ENCRYPT		(1 << 0)
+#define F2FS_FEATURE_16TB_SUPPORT	(1 << 1)
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 006f87d..9dcb7a4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1318,6 +1318,53 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	return err;
 }
 
+static int f2fs_check_version_and_features(struct super_block *sb,
+					   struct f2fs_super_block *raw_super)
+{
+	u16 major_ver = le16_to_cpu(raw_super->major_ver);
+	u32 feature = le32_to_cpu(raw_super->feature);
+
+	if (major_ver > F2FS_MAX_SUPP_MAJOR_VERSION) {
+		f2fs_msg(sb, KERN_CRIT,
+			 "Failed to mount volume: "
+			 "major version %u, max supported version %u",
+			 major_ver,
+			 F2FS_MAX_SUPP_MAJOR_VERSION);
+		return -EOPNOTSUPP;
+	}
+
+#ifdef CONFIG_F2FS_16TB_VOLUME_SUPPORT
+
+	if (major_ver < F2FS_MIN_16TB_VOLUME_SUPPORT_VERSION) {
+		if (feature & F2FS_FEATURE_16TB_SUPPORT) {
+			f2fs_msg(sb, KERN_CRIT,
+				 "Failed to mount corrupted volume. "
+				 "Please, check the volume by FSCK utility.");
+			return -EOPNOTSUPP;
+		}
+	} else {
+		if (!(feature & F2FS_FEATURE_16TB_SUPPORT)) {
+			f2fs_msg(sb, KERN_CRIT,
+				 "Failed to mount corrupted volume. "
+				 "Please, check the volume by FSCK utility.");
+			return -EOPNOTSUPP;
+		}
+	}
+
+#else
+
+	if (feature & F2FS_FEATURE_16TB_SUPPORT) {
+		f2fs_msg(sb, KERN_CRIT,
+			 "Failed to mount corrupted volume. "
+			 "Please, check the volume by FSCK utility.");
+		return -EOPNOTSUPP;
+	}
+
+#endif
+
+	return 0;
+}
+
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
@@ -1360,6 +1407,10 @@ try_onemore:
 	if (err)
 		goto free_sbi;
 
+	err = f2fs_check_version_and_features(sb, raw_super);
+	if (err)
+		goto free_sbi;
+
 	sb->s_fs_info = sbi;
 	default_options(sbi);
 	/* parse mount options */
-- 
1.9.1



