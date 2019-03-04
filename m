From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to do sanity check with inode.i_inline_xattr_size
Date: Mon, 4 Mar 2019 17:19:04 +0800
Message-ID: <20190304091904.121276-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As Paul Bandha reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202709

When I run the poc on the mounted f2fs img I get a buffer overflow in
read_inline_xattr due to there being no sanity check on the value of
i_inline_xattr_size.

I created the img by just modifying the value of i_inline_xattr_size
in the inode:

i_name                        		[test1.txt]
i_ext: fofs:0 blkaddr:0 len:0
i_extra_isize                 		[0x      18 : 24]
i_inline_xattr_size           		[0x    ffff : 65535]
i_addr[ofs]                   		[0x       0 : 0]

mkdir /mnt/f2fs
mount ./f2fs1.img /mnt/f2fs
gcc poc.c -o poc
./poc

int main() {
	int y = syscall(SYS_listxattr, "/mnt/f2fs/test1.txt", NULL, 0);
	printf("ret %d", y);
	printf("errno: %d\n", errno);

}

 BUG: KASAN: slab-out-of-bounds in read_inline_xattr+0x18f/0x260
 Read of size 262140 at addr ffff88011035efd8 by task f2fs1poc/3263

 CPU: 0 PID: 3263 Comm: f2fs1poc Not tainted 4.18.0-custom #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
 Call Trace:
  dump_stack+0x71/0xab
  print_address_description+0x83/0x250
  kasan_report+0x213/0x350
  memcpy+0x1f/0x50
  read_inline_xattr+0x18f/0x260
  read_all_xattrs+0xba/0x190
  f2fs_listxattr+0x9d/0x3f0
  listxattr+0xb2/0xd0
  path_listxattr+0x93/0xe0
  do_syscall_64+0x9d/0x220
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Let's add sanity check for inode.i_inline_xattr_size during f2fs_iget()
to avoid this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix incorrect definition of MAX_INLINE_XATTR_SIZE
- fix wrong condition of sanity check
 fs/f2fs/inode.c | 15 +++++++++++++++
 fs/f2fs/super.c |  5 +----
 fs/f2fs/xattr.h |  6 ++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bec52961630b..d44e6de70cb3 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -14,6 +14,7 @@
 #include "f2fs.h"
 #include "node.h"
 #include "segment.h"
+#include "xattr.h"
 
 #include <trace/events/f2fs.h>
 
@@ -248,6 +249,20 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (f2fs_has_extra_attr(inode) &&
+		f2fs_sb_has_flexible_inline_xattr(sbi) &&
+		f2fs_has_inline_xattr(inode) &&
+		(!fi->i_inline_xattr_size ||
+		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: inode (ino=%lx) has corrupted "
+			"i_inline_xattr_size: %d, max: %zu",
+			__func__, inode->i_ino, fi->i_inline_xattr_size,
+			MAX_INLINE_XATTR_SIZE);
+		return false;
+	}
+
 	if (F2FS_I(inode)->extent_tree) {
 		struct extent_info *ei = &F2FS_I(inode)->extent_tree->largest;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42eb5c86330a..a5f9d146b64e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -837,10 +837,7 @@ static int parse_options(struct super_block *sb, char *options)
 		if (F2FS_OPTION(sbi).inline_xattr_size <
 			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
 			F2FS_OPTION(sbi).inline_xattr_size >
-			DEF_ADDRS_PER_INODE -
-			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
-			DEF_INLINE_RESERVED_SIZE -
-			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
+			MAX_INLINE_XATTR_SIZE) {
 			f2fs_msg(sb, KERN_ERR,
 					"inline xattr size is out of range");
 			return -EINVAL;
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 67db134da0f5..9172ee082ca8 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -78,6 +78,12 @@ struct f2fs_xattr_entry {
 				sizeof(struct f2fs_xattr_header) -	\
 				sizeof(struct f2fs_xattr_entry))
 
+#define MAX_INLINE_XATTR_SIZE						\
+			(DEF_ADDRS_PER_INODE -				\
+			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
+			DEF_INLINE_RESERVED_SIZE -			\
+			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
+
 /*
  * On-disk structure of f2fs_xattr
  * We use inline xattrs space + 1 block for xattr.
-- 
2.18.0.rc1
