From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: support a readonly filesystem
Date: Sun, 22 Nov 2015 11:29:21 +0800
Message-ID: <1448162962-24175-2-git-send-email-jaegeuk@kernel.org>
References: <1448162962-24175-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a0LLa-0000LI-RB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 03:29:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a0LLY-0007yH-V4 for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 03:29:50 +0000
In-Reply-To: <1448162962-24175-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If f2fs is mounted as ro, we can do fsck.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c             | 15 ++++++++-------
 fsck/main.c             | 15 ++++++++++++---
 include/f2fs_fs.h       |  1 +
 lib/libf2fs.c           | 17 +++++++++++------
 mkfs/f2fs_format_main.c |  4 +++-
 5 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index d3b5dd4..510c39d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -174,7 +174,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 			need_fix = 1;
 		}
 	}
-	if (need_fix) {
+	if (need_fix && !config.ro) {
 		u64 ssa_blk;
 		int ret2;
 
@@ -289,7 +289,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			need_fix = 1;
 		}
 	}
-	if (need_fix) {
+	if (need_fix && !config.ro) {
 		u64 ssa_blk;
 		int ret2;
 
@@ -719,7 +719,7 @@ skip_blkcnt_fix:
 					nid, i_links);
 		}
 	}
-	if (need_fix) {
+	if (need_fix && !config.ro) {
 		/* drop extent information to avoid potential wrong access */
 		node_blk->i.i_ext.len = 0;
 		ret = dev_write_block(node_blk, ni->blk_addr);
@@ -750,7 +750,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			FIX_MSG("[0x%x] dn.addr[%d] = 0", nid, idx);
 		}
 	}
-	if (need_fix) {
+	if (need_fix && !config.ro) {
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
 	}
@@ -1069,7 +1069,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			de_blk->dentry, de_blk->filename,
 			NR_DENTRY_IN_BLOCK, last_blk, encrypted);
 
-	if (dentries < 0) {
+	if (dentries < 0 && !config.ro) {
 		ret = dev_write_block(de_blk, blk_addr);
 		ASSERT(ret >= 0);
 		DBG(1, "[%3d] Dentry Block [0x%x] Fixed hash_codes\n\n",
@@ -1172,7 +1172,8 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			else if (ret)
 				ASSERT_MSG("[0x%x] wrong orphan inode", ino);
 		}
-		if (config.fix_on && entry_count != new_entry_count) {
+		if (!config.ro && config.fix_on &&
+				entry_count != new_entry_count) {
 			new_blk->entry_count = cpu_to_le32(new_entry_count);
 			ret = dev_write_block(new_blk, start_blk + i);
 			ASSERT(ret >= 0);
@@ -1475,7 +1476,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	/* fix global metadata */
-	if (force || (config.bug_on && config.fix_on)) {
+	if (force || (config.bug_on && config.fix_on && !config.ro)) {
 		fix_hard_links(sbi);
 		fix_nat_entries(sbi);
 		rewrite_sit_area_bitmap(sbi);
diff --git a/fsck/main.c b/fsck/main.c
index 844ee8a..3db4a44 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -197,8 +197,17 @@ int main(int argc, char **argv)
 
 	f2fs_parse_options(argc, argv);
 
-	if (f2fs_dev_is_umounted(&config) < 0)
-		return -1;
+	if (f2fs_dev_is_umounted(&config) < 0) {
+		if (!config.ro) {
+			MSG(0, "\tError: Not available on mounted device!\n");
+			return -1;
+		}
+
+		/* allow ro-mounted partition */
+		MSG(0, "Info: Check FS only due to RO\n");
+		config.fix_on = 0;
+		config.auto_fix = 0;
+	}
 
 	/* Get device */
 	if (f2fs_get_device_info(&config) < 0)
@@ -228,7 +237,7 @@ fsck_again:
 	f2fs_do_umount(sbi);
 out:
 	if (config.func == FSCK && config.bug_on) {
-		if (config.fix_on == 0 && config.auto_fix == 0) {
+		if (!config.ro && config.fix_on == 0 && config.auto_fix == 0) {
 			char ans[255] = {0};
 retry:
 			printf("Do you want to fix this partition? [Y/N] ");
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 359deec..c0bbfa4 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -250,6 +250,7 @@ struct f2fs_configuration {
 	int fix_on;
 	int bug_on;
 	int auto_fix;
+	int ro;
 	__le32 feature;			/* defined features */
 } __attribute__((packed));
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 83d1296..32e0651 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -362,9 +362,11 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->vol_label = "";
 	c->device_name = NULL;
 	c->trim = 1;
+	c->ro = 0;
 }
 
-static int is_mounted(const char *mpt, const char *device)
+static int is_mounted(struct f2fs_configuration *c,
+				const char *mpt, const char *device)
 {
 	FILE *file = NULL;
 	struct mntent *mnt = NULL;
@@ -374,8 +376,11 @@ static int is_mounted(const char *mpt, const char *device)
 		return 0;
 
 	while ((mnt = getmntent(file)) != NULL) {
-		if (!strcmp(device, mnt->mnt_fsname))
+		if (!strcmp(device, mnt->mnt_fsname)) {
+			if (hasmntopt(mnt, MNTOPT_RO))
+				config.ro = 1;
 			break;
+		}
 	}
 	endmntent(file);
 	return mnt ? 1 : 0;
@@ -386,9 +391,9 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	struct stat st_buf;
 	int ret = 0;
 
-	ret = is_mounted(MOUNTED, c->device_name);
+	ret = is_mounted(c, MOUNTED, c->device_name);
 	if (ret) {
-		MSG(0, "\tError: Not available on mounted device!\n");
+		MSG(0, "Info: Mounted device!\n");
 		return -1;
 	}
 
@@ -396,9 +401,9 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	 * if failed due to /etc/mtab file not present
 	 * try with /proc/mounts.
 	 */
-	ret = is_mounted("/proc/mounts", c->device_name);
+	ret = is_mounted(c, "/proc/mounts", c->device_name);
 	if (ret) {
-		MSG(0, "\tError: Not available on mounted device!\n");
+		MSG(0, "Info: Mounted device!\n");
 		return -1;
 	}
 
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 2ea809c..0eee81a 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -144,8 +144,10 @@ int main(int argc, char *argv[])
 
 	f2fs_show_info();
 
-	if (f2fs_dev_is_umounted(&config) < 0)
+	if (f2fs_dev_is_umounted(&config) < 0) {
+		MSG(0, "\tError: Not available on mounted device!\n");
 		return -1;
+	}
 
 	if (f2fs_get_device_info(&config) < 0)
 		return -1;
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
