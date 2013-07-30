From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 4/4] f2fs-tools: add option to display directory
	tree
Date: Tue, 30 Jul 2013 16:39:06 +0900
Message-ID: <1375169946-2887-4-git-send-email-cm224.lee@samsung.com>
References: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1V44YO-0004Gn-NL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:08 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V44YM-0001R5-Q1 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:08 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQQ00FQUO04FOQ0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 16:40:55 +0900 (KST)
In-reply-to: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
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

This option shows directory tree of f2fs.

Usage: fsck.f2fs -t /dev/sdx

`-- p0
   |-- f4
   `-- d6
        |-- f5e
        |-- cb6
        |-- fdb
        |-- fe8
        `-- l9a

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/fsck.c       |   53 +++++++++++++++++++++++++++++++++++++---
 fsck/main.c       |    5 +++-
 include/f2fs_fs.h |    3 ++-
 lib/libf2fs.c     |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index b5619ba..2a4d064 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -10,6 +10,9 @@
  */
 #include "fsck.h"
 
+char *tree_mark;
+int tree_mark_size = 256;
+
 static int add_into_hard_link_list(struct f2fs_sb_info *sbi, u32 nid, u32 link_cnt)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -267,7 +270,7 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 	u32 child_cnt = 0, child_files = 0;
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
-	u64 i_blocks = le32_to_cpu(node_blk->i.i_blocks);
+	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	int idx = 0;
 	int ret = 0;
 
@@ -409,7 +412,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi,
 				le32_to_cpu(node_blk->dn.addr[idx]),
 				&child_cnt,
 				&child_files,
-				le32_to_cpu(inode->i_blocks == *blk_cnt),
+				le64_to_cpu(inode->i_blocks) == *blk_cnt,
 				ftype,
 				nid,
 				idx,
@@ -467,6 +470,45 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+static void print_dentry(__u32 depth, __u8 *name,
+		struct f2fs_dentry_block *de_blk, int idx, int last_blk)
+{
+	int last_de = 0;
+	int next_idx = 0;
+	int name_len;
+	int i;
+	int bit_offset;
+
+	if (config.dbg_lv != -1)
+		return;
+
+	name_len = le16_to_cpu(de_blk->dentry[idx].name_len);
+	next_idx = idx + (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
+
+	bit_offset = find_next_bit((unsigned long *)de_blk->dentry_bitmap,
+			NR_DENTRY_IN_BLOCK, next_idx);
+	if (bit_offset >= NR_DENTRY_IN_BLOCK && last_blk)
+		last_de = 1;
+
+	if (tree_mark_size <= depth) {
+		tree_mark_size *= 2;
+		tree_mark = realloc(tree_mark, tree_mark_size);
+	}
+
+	if (last_de)
+		tree_mark[depth] = '`';
+	else
+		tree_mark[depth] = '|';
+
+	if (tree_mark[depth - 1] == '`')
+		tree_mark[depth - 1] = ' ';
+
+
+	for (i = 1; i < depth; i++)
+		printf("%c   ", tree_mark[i]);
+	printf("%c-- %s\n", last_de ? '`' : '|', name);
+}
+
 int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 		struct f2fs_inode *inode,
 		u32 blk_addr,
@@ -484,7 +526,6 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 	u16 name_len;;
 
 	enum FILE_TYPE ftype;
-
 	struct f2fs_dentry_block *de_blk;
 
 	de_blk = (struct f2fs_dentry_block *)calloc(BLOCK_SZ, 1);
@@ -527,6 +568,8 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 				le32_to_cpu(de_blk->dentry[i].ino),
 				de_blk->dentry[i].file_type);
 
+		print_dentry(fsck->dentry_depth, name, de_blk, i, last_blk);
+
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
 				NULL,
@@ -702,6 +745,7 @@ int fsck_init(struct f2fs_sb_info *sbi)
 
 	build_sit_area_bitmap(sbi);
 
+	tree_mark = calloc(tree_mark_size, 1);
 	return 0;
 }
 
@@ -801,4 +845,7 @@ void fsck_free(struct f2fs_sb_info *sbi)
 
 	if (fsck->sit_area_bitmap)
 		free(fsck->sit_area_bitmap);
+
+	if (tree_mark)
+		free(tree_mark);
 }
diff --git a/fsck/main.c b/fsck/main.c
index 60bebc2..80db15d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -42,7 +42,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "d:";
+		const char *option_string = "d:t";
 
 		config.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -51,6 +51,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					config.dbg_lv = atoi(optarg);
 					MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
 					break;
+				case 't':
+					config.dbg_lv = -1;
+					break;
 				default:
 					MSG(0, "\tError: Unknown option %c\n",option);
 					fsck_usage();
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 2fdd283..d0fc79e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -185,7 +185,7 @@ struct f2fs_configuration {
 	void *private;
 } __attribute__((packed));
 
-#ifdef CONFIG_64BIT
+#ifndef CONFIG_64BIT
 #define BITS_PER_LONG	64
 #else
 #define BITS_PER_LONG	32
@@ -635,6 +635,7 @@ extern int test_bit(unsigned int nr, const void * addr);
 extern int f2fs_test_bit(unsigned int, const char *);
 extern int f2fs_set_bit(unsigned int, char *);
 extern int f2fs_clear_bit(unsigned int, char *);
+extern unsigned long find_next_bit(const unsigned long *, unsigned long, unsigned long);
 
 extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 898dbf1..23e8543 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -146,6 +146,76 @@ int f2fs_clear_bit(unsigned int nr, char *addr)
 	return ret;
 }
 
+static inline unsigned long __ffs(unsigned long word)
+{
+	int num = 0;
+
+#if BITS_PER_LONG == 64
+	if ((word & 0xffffffff) == 0) {
+		num += 32;
+		word >>= 32;
+	}
+#endif
+	if ((word & 0xffff) == 0) {
+		num += 16;
+		word >>= 16;
+	}
+	if ((word & 0xff) == 0) {
+		num += 8;
+		word >>= 8;
+	}
+	if ((word & 0xf) == 0) {
+		num += 4;
+		word >>= 4;
+	}
+	if ((word & 0x3) == 0) {
+		num += 2;
+		word >>= 2;
+	}
+	if ((word & 0x1) == 0)
+		num += 1;
+	return num;
+}
+
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+                unsigned long offset)
+{
+        const unsigned long *p = addr + BIT_WORD(offset);
+        unsigned long result = offset & ~(BITS_PER_LONG-1);
+        unsigned long tmp;
+
+        if (offset >= size)
+                return size;
+        size -= result;
+        offset %= BITS_PER_LONG;
+        if (offset) {
+                tmp = *(p++);
+                tmp &= (~0UL << offset);
+                if (size < BITS_PER_LONG)
+                        goto found_first;
+                if (tmp)
+                        goto found_middle;
+                size -= BITS_PER_LONG;
+                result += BITS_PER_LONG;
+        }
+        while (size & ~(BITS_PER_LONG-1)) {
+                if ((tmp = *(p++)))
+                        goto found_middle;
+                result += BITS_PER_LONG;
+                size -= BITS_PER_LONG;
+        }
+        if (!size)
+                return result;
+        tmp = *p;
+
+found_first:
+        tmp &= (~0UL >> (BITS_PER_LONG - size));
+        if (tmp == 0UL)		/* Are any bits set? */
+                return result + size;   /* Nope. */
+found_middle:
+        return result + __ffs(tmp);
+}
+
 /*
  * Hashing code adapted from ext3
  */
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
