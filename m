From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs-tools: set namelen parameter of
 convert_encrypted_name as unsigned
Date: Tue, 10 Jul 2018 22:47:38 +0800
Message-ID: <20180710144738.167229-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fctw7-0001Ub-61
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 14:48:15 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fctw2-0001Cx-TH
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 14:48:15 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

To avoid overflow, set namelen parameter of convert_encrypted_name as
unsigned int. convert_encrypted_name() will check if namelen exceeds the
limitation.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c  | 6 +++---
 fsck/fsck.h  | 2 +-
 fsck/mount.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6fd9dc2..f6fd1d8 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -657,7 +657,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	int ofs;
 	unsigned char *en;
-	int namelen;
+	u32 namelen;
 	unsigned int idx = 0;
 	int need_fix = 0;
 	int ret;
@@ -1139,7 +1139,7 @@ static int digest_encode(const char *src, int len, char *dst)
 	return cp - dst;
 }
 
-int convert_encrypted_name(unsigned char *name, int len,
+int convert_encrypted_name(unsigned char *name, u32 len,
 				unsigned char *new, int enc_name)
 {
 	if (!enc_name) {
@@ -1160,7 +1160,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 {
 	int last_de = 0;
 	int next_idx = 0;
-	int name_len;
+	u32 name_len;
 	unsigned int i;
 	int bit_offset;
 	unsigned char new[F2FS_NAME_LEN + 1];
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5530aff..185e157 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -145,7 +145,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
 int fsck_chk_curseg_info(struct f2fs_sb_info *);
-int convert_encrypted_name(unsigned char *, int, unsigned char *, int);
+int convert_encrypted_name(unsigned char *, u32, unsigned char *, int);
 
 extern void update_free_segments(struct f2fs_sb_info *);
 void print_cp_state(u32);
diff --git a/fsck/mount.c b/fsck/mount.c
index 0767a8f..5040764 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -175,7 +175,7 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 	struct f2fs_xattr_entry *ent;
 	unsigned char en[F2FS_NAME_LEN + 1];
 	unsigned int i = 0;
-	int namelen = le32_to_cpu(inode->i_namelen);
+	u32 namelen = le32_to_cpu(inode->i_namelen);
 	int enc_name = file_enc_name(inode);
 	int ofs = __get_extra_isize(inode);
 
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
