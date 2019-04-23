From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: fix to repair ro mounted device w/ -f
Date: Tue, 23 Apr 2019 10:42:20 +0800
Message-ID: <20190423024220.127840-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hIlOJ-0007fz-2U
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 02:42:39 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIlOF-006yw5-Cs
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 02:42:39 +0000
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
Cc: jaegeuk@kernel.org

As Hagbard Celine reported:

"
Referring to the output from the fsck running against a "ro"
filesystem, especially this line:
Info: Check FS only due to RO

As far as i can tell this says that opposed to other filesystems
running fsck against a "ro" mounted f2fs partition will never fix any
errors.
So I tried running fsck against the same partition mounted "rw":
- mount -o remount,rw /mnt/f2fstest/
- fsck.f2fs  -f /dev/nvme0n1p7
Info: Force to fix corruption
Info: Mounted device!
        Error: Not available on mounted device!

I might be misunderstanding something, but all this tells me that
unless one make a custom initramfs that runs fsck before root is
mounted (something no distributions has, as far as I know), fsck will
never fix an f2fs formatted root partition during boot.
If this is by design and not a bug/unintended behavior, it should be
documented somewhere least more people will experience system crashes
like mine.

All tests above done with kernel 5.0.5 and f2fs-tools 1.12.0 with
"fsck.f2fs: allow to fsck readonly image w/ -f option"-patch by Chao
Yu.
"

We try to make our fsck behavior keeping line with e2fsprogs, but w/
-f option, we can just check a RO mounted device rather repair it, so
let's fix this.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c       | 20 ++++++++++----------
 fsck/main.c       | 10 +++++++---
 include/f2fs_fs.h |  1 +
 lib/libf2fs.c     |  5 +++++
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8d7deb5..a1791d4 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -199,7 +199,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 			need_fix = 1;
 		}
 	}
-	if (need_fix && !c.ro) {
+	if (need_fix && f2fs_dev_is_writable()) {
 		u64 ssa_blk;
 		int ret2;
 
@@ -325,7 +325,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			need_fix = 1;
 		}
 	}
-	if (need_fix && !c.ro) {
+	if (need_fix && f2fs_dev_is_writable()) {
 		u64 ssa_blk;
 		int ret2;
 
@@ -1015,7 +1015,7 @@ skip_blkcnt_fix:
 	}
 
 	/* drop extent information to avoid potential wrong access */
-	if (need_fix && !c.ro)
+	if (need_fix && f2fs_dev_is_writable())
 		node_blk->i.i_ext.len = 0;
 
 	if ((c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) &&
@@ -1038,7 +1038,7 @@ skip_blkcnt_fix:
 		}
 	}
 
-	if (need_fix && !c.ro) {
+	if (need_fix && f2fs_dev_is_writable()) {
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
 	}
@@ -1073,7 +1073,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			FIX_MSG("[0x%x] dn.addr[%d] = 0", nid, idx);
 		}
 	}
-	if (need_fix && !c.ro) {
+	if (need_fix && f2fs_dev_is_writable()) {
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
 	}
@@ -1110,7 +1110,7 @@ skip:
 		}
 	}
 
-	if (need_fix && !c.ro) {
+	if (need_fix && f2fs_dev_is_writable()) {
 		struct node_info ni;
 		nid_t nid = le32_to_cpu(node_blk->footer.nid);
 
@@ -1152,7 +1152,7 @@ skip:
 		}
 	}
 
-	if (need_fix && !c.ro) {
+	if (need_fix && f2fs_dev_is_writable()) {
 		struct node_info ni;
 		nid_t nid = le32_to_cpu(node_blk->footer.nid);
 
@@ -1595,7 +1595,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			de_blk->dentry, de_blk->filename,
 			NR_DENTRY_IN_BLOCK, last_blk, enc_name);
 
-	if (dentries < 0 && !c.ro) {
+	if (dentries < 0 && f2fs_dev_is_writable()) {
 		ret = dev_write_block(de_blk, blk_addr);
 		ASSERT(ret >= 0);
 		DBG(1, "[%3d] Dentry Block [0x%x] Fixed hash_codes\n\n",
@@ -1708,7 +1708,7 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			else if (ret)
 				ASSERT_MSG("[0x%x] wrong orphan inode", ino);
 		}
-		if (!c.ro && c.fix_on &&
+		if (f2fs_dev_is_writable() && c.fix_on &&
 				entry_count != new_entry_count) {
 			new_blk->entry_count = cpu_to_le32(new_entry_count);
 			ret = dev_write_block(new_blk, start_blk + i);
@@ -2719,7 +2719,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 #endif
 	/* fix global metadata */
-	if (force || (c.fix_on && !c.ro)) {
+	if (force || (c.fix_on && f2fs_dev_is_writable())) {
 		struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
 		if (force || c.bug_on || c.bug_nat_bits) {
diff --git a/fsck/main.c b/fsck/main.c
index e61bb91..afdfec9 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -759,9 +759,13 @@ int main(int argc, char **argv)
 		}
 
 		/* allow ro-mounted partition */
-		MSG(0, "Info: Check FS only due to RO\n");
-		c.fix_on = 0;
-		c.auto_fix = 0;
+		if (c.force) {
+			MSG(0, "Info: Force to check/repair FS on RO mounted device\n");
+		} else {
+			MSG(0, "Info: Check FS only on RO mounted device\n");
+			c.fix_on = 0;
+			c.auto_fix = 0;
+		}
 	}
 
 	/* Get device */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 89b8a0c..6def302 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1155,6 +1155,7 @@ extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
 
 extern void f2fs_init_configuration(void);
 extern int f2fs_devs_are_umounted(void);
+extern int f2fs_dev_is_writable(void);
 extern int f2fs_dev_is_umounted(char *);
 extern int f2fs_get_device_info(void);
 extern int get_device_info(int);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 757328b..6f5da9d 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -644,6 +644,11 @@ void f2fs_init_configuration(void)
 	c.root_gid = getgid();
 }
 
+int f2fs_dev_is_writable(void)
+{
+	return !c.ro || c.force;
+}
+
 #ifdef HAVE_SETMNTENT
 static int is_mounted(const char *mpt, const char *device)
 {
-- 
2.18.0.rc1
