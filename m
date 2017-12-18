From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v3] fsck.f2fs: check and fix i_namelen to avoid double free
Date: Mon, 18 Dec 2017 21:10:57 +0800
Message-ID: <1513602657-162087-1-git-send-email-yunlong.song@huawei.com>
References: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 26 +++++++++++++++++++++-----
 fsck/fsck.h |  3 ++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2212aa3..b52b6e4 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -539,7 +539,7 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 
 		if (sanity_check_inode(sbi, node_blk))
 			goto err;
-		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni);
+		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni, child);
 		quota_add_inode_usage(fsck->qctx, nid, &node_blk->i);
 	} else {
 		switch (ntype) {
@@ -633,7 +633,7 @@ unmatched:
 /* start with valid nid and blkaddr */
 void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk,
-		u32 *blk_cnt, struct node_info *ni)
+		u32 *blk_cnt, struct node_info *ni, struct child_info *child_d)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct child_info child;
@@ -850,8 +850,23 @@ skip_blkcnt_fix:
 	en = malloc(F2FS_NAME_LEN + 1);
 	ASSERT(en);
 
-	namelen = convert_encrypted_name(node_blk->i.i_name,
-					le32_to_cpu(node_blk->i.i_namelen),
+	namelen = le32_to_cpu(node_blk->i.i_namelen);
+	if (namelen > F2FS_NAME_LEN) {
+		if (child_d && child_d->i_namelen <= F2FS_NAME_LEN) {
+			ASSERT_MSG("ino: 0x%x has i_namelen: 0x%x, "
+					"but has %d characters for name",
+					nid, namelen, child_d->i_namelen);
+			if (c.fix_on) {
+				FIX_MSG("[0x%x] i_namelen=0x%x -> 0x%x", nid, namelen,
+					child_d->i_namelen);
+				node_blk->i.i_namelen = cpu_to_le32(child_d->i_namelen);
+				need_fix = 1;
+			}
+			namelen = child_d->i_namelen;
+		} else
+			namelen = F2FS_NAME_LEN;
+	}
+	namelen = convert_encrypted_name(node_blk->i.i_name, namelen,
 					en, file_enc_name(&node_blk->i));
 	en[namelen] = '\0';
 	if (ftype == F2FS_FT_ORPHAN)
@@ -1414,9 +1429,10 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 				dentry, max, i, last_blk, enc_name);
 
 		blk_cnt = 1;
+		child->i_namelen = name_len;
 		ret = fsck_chk_node_blk(sbi,
 				NULL, le32_to_cpu(dentry[i].ino),
-				ftype, TYPE_INODE, &blk_cnt, NULL);
+				ftype, TYPE_INODE, &blk_cnt, child);
 
 		if (ret && c.fix_on) {
 			int j;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 0343fbd..d635c5a 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -54,6 +54,7 @@ struct child_info {
 	u32 pp_ino;		/*parent parent ino*/
 	struct extent_info ei;
 	u32 last_blk;
+	u32 i_namelen;  /* dentry namelen */
 };
 
 struct f2fs_fsck {
@@ -128,7 +129,7 @@ extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		enum FILE_TYPE, enum NODE_TYPE, u32 *,
 		struct child_info *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
-		struct f2fs_node *, u32 *, struct node_info *);
+		struct f2fs_node *, u32 *, struct node_info *, struct child_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
 		struct child_info *, struct node_info *);
-- 
1.8.5.2
