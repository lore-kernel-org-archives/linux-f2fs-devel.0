From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: detect and recover corrupted quota
 file
Date: Wed, 29 Aug 2018 20:09:23 +0800
Message-ID: <20180829120923.61173-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fuzIc-0006l4-TI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Aug 2018 12:10:14 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuzIX-001zjT-JE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Aug 2018 12:10:14 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Once quota file is corrupted, kernel will set CP_QUOTA_NEED_FSCK_FLAG
into checkpoint pack, this patch makes fsck supporting to detect the flag
and try to rebuild corrupted quota file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c       | 3 ++-
 fsck/mount.c      | 6 ++++--
 include/f2fs_fs.h | 2 ++
 lib/libf2fs.c     | 2 ++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index f080d3c8741c..10b69ef403ef 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2668,7 +2668,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 				flush_curseg_sit_entries(sbi);
 			}
 			fix_checkpoint(sbi);
-		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
+		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG) ||
+			is_set_ckpt_flags(cp, CP_QUOTA_NEED_FSCK_FLAG)) {
 			write_checkpoint(sbi);
 		}
 	}
diff --git a/fsck/mount.c b/fsck/mount.c
index a2448e370c0b..168cf387991f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -405,6 +405,8 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 void print_cp_state(u32 flag)
 {
 	MSG(0, "Info: checkpoint state = %x : ", flag);
+	if (flag & CP_QUOTA_NEED_FSCK_FLAG)
+		MSG(0, "%s", " quota_need_fsck");
 	if (flag & CP_LARGE_NAT_BITMAP_FLAG)
 		MSG(0, "%s", " large_nat_bitmap");
 	if (flag & CP_NOCRC_RECOVERY_FLAG)
@@ -2532,8 +2534,8 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		u32 flag = get_cp(ckpt_flags);
 
 		if (flag & CP_FSCK_FLAG ||
-			(exist_qf_ino(sb) && (!(flag & CP_UMOUNT_FLAG) ||
-						flag & CP_ERROR_FLAG))) {
+			flag & CP_QUOTA_NEED_FSCK_FLAG ||
+			(exist_qf_ino(sb) && (flag & CP_ERROR_FLAG))) {
 			c.fix_on = 1;
 		} else if (!c.preen_mode) {
 			print_cp_state(flag);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9396c785a254..160eaf72f0b6 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -372,6 +372,7 @@ struct f2fs_configuration {
 	int defset;
 	int bug_on;
 	int auto_fix;
+	int quota_fix;
 	int preen_mode;
 	int ro;
 	int preserve_limits;		/* preserve quota limits */
@@ -641,6 +642,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
 #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
 #define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a1f8beb1f78d..192b8125de36 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -619,6 +619,8 @@ void f2fs_init_configuration(void)
 	/* default root owner */
 	c.root_uid = getuid();
 	c.root_gid = getgid();
+
+	c.quota_fix = 1;
 }
 
 #ifdef HAVE_SETMNTENT
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
