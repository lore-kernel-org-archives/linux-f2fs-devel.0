From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: avoid failure and warnings for
	android build
Date: Thu, 14 Jan 2016 15:57:34 -0800
Message-ID: <1452815854-56869-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aJrm7-00054K-N7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Jan 2016 23:57:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aJrm5-0001IQ-QR for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Jan 2016 23:57:55 +0000
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

This patch fixes to resolve build failure and warnings when compiling it
under AOSP.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c        |  8 +++++---
 fsck/mount.c       |  2 +-
 lib/libf2fs.c      | 13 +++++++------
 mkfs/f2fs_format.c |  4 ++++
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 3e67ffc..e7dd02f 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -21,7 +21,7 @@ static inline int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk,
 	int fix = 0;
 
 	se = get_seg_entry(sbi, GET_SEGNO(sbi, blk));
-	if (se->type < 0 || se->type >= NO_CHECK_TYPE)
+	if (se->type >= NO_CHECK_TYPE)
 		fix = 1;
 	else if (IS_DATASEG(se->type) != IS_DATASEG(type))
 		fix = 1;
@@ -945,7 +945,6 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 	int dentries = 0;
 	u32 blk_cnt;
 	u8 *name;
-	u32 ino;
 	u16 name_len;;
 	int ret = 0;
 	int fixed = 0;
@@ -953,6 +952,8 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 	/* readahead inode blocks */
 	for (i = 0; i < max; i++) {
+		u32 ino;
+
 		if (test_bit_le(i, bitmap) == 0)
 			continue;
 
@@ -992,7 +993,8 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 		ftype = dentry[i].file_type;
 		if ((ftype <= F2FS_FT_UNKNOWN || ftype > F2FS_FT_LAST_FILE_TYPE)) {
-			ASSERT_MSG("Bad dentry 0x%x with unexpected ftype 0x%x", ino, ftype);
+			ASSERT_MSG("Bad dentry 0x%x with unexpected ftype 0x%x",
+						le32_to_cpu(dentry[i].ino), ftype);
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ftype 0x%x",
 					i, ftype);
diff --git a/fsck/mount.c b/fsck/mount.c
index 7533926..b01230f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1410,7 +1410,7 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 		}
 		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec)) {
 			struct seg_entry *se2;
-			int i;
+			unsigned int i;
 
 			for (i = 0; i < sbi->segs_per_sec; i++) {
 				se2 = get_seg_entry(sbi, segno + i);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index e9a1606..d61eb85 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -94,7 +94,7 @@ int utf8_to_utf16(u_int16_t *output, const char *input, size_t outsize,
 	u_int16_t *outp = output;
 	wchar_t wc;
 
-	while (inp - input < insize && *inp) {
+	while ((size_t)(inp - input) < insize && *inp) {
 		inp = utf8_to_wchar(inp, &wc, insize - (inp - input));
 		if (inp == NULL) {
 			DBG(0, "illegal UTF-8 sequence\n");
@@ -180,7 +180,7 @@ int utf16_to_utf8(char *output, const u_int16_t *input, size_t outsize,
 	char *outp = output;
 	wchar_t wc;
 
-	while (inp - input < insize && le16_to_cpu(*inp)) {
+	while ((size_t)(inp - input) < insize && le16_to_cpu(*inp)) {
 		inp = utf16_to_wchar(inp, &wc, insize - (inp - input));
 		if (inp == NULL) {
 			DBG(0, "illegal UTF-16 sequence\n");
@@ -503,8 +503,7 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->ro = 0;
 }
 
-static int is_mounted(struct f2fs_configuration *c,
-				const char *mpt, const char *device)
+static int is_mounted(const char *mpt, const char *device)
 {
 	FILE *file = NULL;
 	struct mntent *mnt = NULL;
@@ -515,8 +514,10 @@ static int is_mounted(struct f2fs_configuration *c,
 
 	while ((mnt = getmntent(file)) != NULL) {
 		if (!strcmp(device, mnt->mnt_fsname)) {
+#ifdef MNTOPT_RO
 			if (hasmntopt(mnt, MNTOPT_RO))
 				config.ro = 1;
+#endif
 			break;
 		}
 	}
@@ -529,7 +530,7 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	struct stat st_buf;
 	int ret = 0;
 
-	ret = is_mounted(c, MOUNTED, c->device_name);
+	ret = is_mounted(MOUNTED, c->device_name);
 	if (ret) {
 		MSG(0, "Info: Mounted device!\n");
 		return -1;
@@ -539,7 +540,7 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	 * if failed due to /etc/mtab file not present
 	 * try with /proc/mounts.
 	 */
-	ret = is_mounted(c, "/proc/mounts", c->device_name);
+	ret = is_mounted("/proc/mounts", c->device_name);
 	if (ret) {
 		MSG(0, "Info: Mounted device!\n");
 		return -1;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index fd61757..2c81ecc 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -697,6 +697,7 @@ static int f2fs_write_super_block(void)
 	return 0;
 }
 
+#ifndef WITH_ANDROID
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
 	do {
@@ -722,6 +723,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 
 	return 0;
 }
+#endif
 
 static int f2fs_write_root_inode(void)
 {
@@ -789,10 +791,12 @@ static int f2fs_write_root_inode(void)
 	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_WARM_NODE] *
 					config.blks_per_seg;
 
+#ifndef WITH_ANDROID
 	if (discard_obsolete_dnode(raw_node, main_area_node_seg_blk_offset)) {
 		free(raw_node);
 		return -1;
 	}
+#endif
 
 	free(raw_node);
 	return 0;
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
