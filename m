From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] fsck.f2fs: check nid range before use to avoid segmentation fault
Date: Fri, 15 Dec 2017 14:26:14 +0800
Message-ID: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 11b8b0b..2212aa3 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -14,6 +14,15 @@
 char *tree_mark;
 uint32_t tree_mark_size = 256;
 
+static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
+{
+    if (nid < F2FS_ROOT_INO(sbi))
+        return -EINVAL;
+    if (nid >= NM_I(sbi)->max_nid)
+        return -EINVAL;
+    return 0;
+}
+
 int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk, int type)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -740,7 +749,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	for (idx = 0; idx < 5; idx++) {
 		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
 
-		if (nid != 0) {
+		if (nid != 0 && !check_nid_range(sbi, nid)) {
 			struct node_info ni;
 
 			get_node_info(sbi, nid, &ni);
-- 
1.8.5.2
