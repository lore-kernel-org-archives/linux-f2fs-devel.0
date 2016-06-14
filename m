From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: detect host-managed SMR by feature flag
Date: Tue, 14 Jun 2016 11:43:21 -0700
Message-ID: <20160614184322.88117-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bCtJO-0003m4-Sa
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jun 2016 18:43:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bCtJN-0004jQ-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jun 2016 18:43:42 +0000
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

If mkfs.f2fs gives a feature flag for host-managed SMR, we can set mode=lfs
by default.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 21 +++++++++++++++++++++
 fs/f2fs/super.c | 14 ++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 32be19e..1a19c02 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -133,6 +133,7 @@ struct f2fs_mount_info {
 };
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
+#define F2FS_FEATURE_HMSMR	0x0002
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -2354,6 +2355,26 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
 }
 
+static inline int f2fs_sb_mounted_hmsmr(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_HMSMR);
+}
+
+static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
+{
+	clear_opt(sbi, ADAPTIVE);
+	clear_opt(sbi, LFS);
+
+	switch (mt) {
+	case F2FS_MOUNT_ADAPTIVE:
+		set_opt(sbi, ADAPTIVE);
+		break;
+	case F2FS_MOUNT_LFS:
+		set_opt(sbi, LFS);
+		break;
+	}
+}
+
 static inline bool f2fs_may_encrypt(struct inode *inode)
 {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index edc736d..71b6066 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -515,12 +515,10 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 8 &&
 					!strncmp(name, "adaptive", 8)) {
-				set_opt(sbi, ADAPTIVE);
-				clear_opt(sbi, LFS);
+				set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
 			} else if (strlen(name) == 3 &&
 					!strncmp(name, "lfs", 3)) {
-				clear_opt(sbi, ADAPTIVE);
-				set_opt(sbi, LFS);
+				set_opt_mode(sbi, F2FS_MOUNT_LFS);
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -980,7 +978,10 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, EXTENT_CACHE);
 	sbi->sb->s_flags |= MS_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	set_opt(sbi, ADAPTIVE);
+	if (f2fs_sb_mounted_hmsmr(sbi->sb))
+		set_opt_mode(sbi, F2FS_MOUNT_LFS);
+	else
+		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
@@ -1629,6 +1630,8 @@ try_onemore:
 		goto free_sbi;
 
 	sb->s_fs_info = sbi;
+	sbi->raw_super = raw_super;
+
 	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
@@ -1658,7 +1661,6 @@ try_onemore:
 	memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
 
 	/* init f2fs-specific super block info */
-	sbi->raw_super = raw_super;
 	sbi->valid_super_block = valid_super_block;
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->cp_mutex);
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://pubads.g.doubleclick.net/gampad/clk?id=1444514421&iu=/41014381
