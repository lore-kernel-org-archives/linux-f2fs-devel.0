From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [RFC PATCH] fsck.f2fs: check valid values for dot
	dentries
Date: Fri, 26 Feb 2016 06:42:13 +0000
Message-ID: <1456468933-21881-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1aZC78-0001DF-6W
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 06:42:58 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aZC73-0004En-7T
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 06:42:58 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

Check valid values for '.' and '..', such as ino, hash_code, and the
number of dot or dotdot in the directory.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
Signed-off-by: Yong Sheng <shengyong1@huawei.com>
---
 fsck/fsck.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fsck/fsck.h |  2 ++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 809c78d..3e37a58 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -553,6 +553,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
+	child.p_ino = nid;
+	child.pp_ino = le32_to_cpu(node_blk->i.i_pino);
 	struct extent_info i_extent;
 	unsigned int idx = 0;
 	int need_fix = 0;
@@ -787,6 +789,8 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 {
 	int idx, ret;
 	int need_fix = 0;
+	child->p_ino = nid;
+	child->pp_ino = le32_to_cpu(inode->i_pino);
 
 	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
 		block_t blkaddr = le32_to_cpu(node_blk->dn.addr[idx]);
@@ -979,6 +983,60 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 	return 0;
 }
 
+static int __chk_dots_dentries(struct f2fs_sb_info *sbi,
+			       struct f2fs_dir_entry *dentry,
+			       struct child_info *child,
+			       u8 *name, int len,
+			       __u8 (*filename)[F2FS_SLOT_LEN],
+			       int encrypted)
+{
+	int fixed = 0;
+
+	if ((name[0] == '.' && len == 1)) {
+		if (le32_to_cpu(dentry->ino) != child->p_ino) {
+			ASSERT_MSG("Bad inode number[0x%x] for '.', parent_ino is [0x%x]\n",
+				le32_to_cpu(dentry->ino), child->p_ino);
+			dentry->ino = cpu_to_le32(child->p_ino);
+			fixed = 1;
+		}
+	}
+
+	if (name[0] == '.' && name[1] == '.' && len == 2) {
+		if (child->p_ino == F2FS_ROOT_INO(sbi)) {
+			if (le32_to_cpu(dentry->ino) != F2FS_ROOT_INO(sbi)) {
+				ASSERT_MSG("Bad inode number[0x%x] for '..'\n",
+					le32_to_cpu(dentry->ino));
+				dentry->ino = cpu_to_le32(F2FS_ROOT_INO(sbi));
+				fixed = 1;
+			}
+		} else if (le32_to_cpu(dentry->ino) != child->pp_ino) {
+			ASSERT_MSG("Bad inode number[0x%x] for '..', parent parent ino is [0x%x]\n",
+				le32_to_cpu(dentry->ino), child->pp_ino);
+			dentry->ino = cpu_to_le32(child->pp_ino);
+			fixed = 1;
+		}
+	}
+
+	if (f2fs_check_hash_code(dentry, name, len, encrypted))
+		fixed = 1;
+
+	if (name[len] != '\0') {
+		ASSERT_MSG("'.' is not NULL terminated\n");
+		name[len] = '\0';
+		memcpy(*filename, name, len);
+		fixed = 1;
+	}
+	return fixed;
+}
+
+static void nullify_dentry(struct f2fs_dir_entry *dentry, int offs,
+			   __u8 (*filename)[F2FS_SLOT_LEN], u8 **bitmap)
+{
+	memset(dentry, 0, sizeof(struct f2fs_dir_entry));
+	test_and_clear_bit_le(offs, *bitmap);
+	memset(*filename, 0, F2FS_SLOT_LEN);
+}
+
 static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			u8 *bitmap, struct f2fs_dir_entry *dentry,
 			__u8 (*filenames)[F2FS_SLOT_LEN],
@@ -1068,9 +1126,27 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			if ((name[0] == '.' && name_len == 1) ||
 				(name[0] == '.' && name[1] == '.' &&
 							name_len == 2)) {
+				ret = __chk_dots_dentries(sbi, &dentry[i],
+					child, name, name_len, &filenames[i],
+					encrypted);
+				switch (ret) {
+				case 1:
+					fixed = 1;
+				case 0:
+					child->dots++;
+					break;
+				}
+
+				if (child->dots > 2) {
+					ASSERT_MSG("More than one '.' or '..', should delete the extra one\n");
+					nullify_dentry(&dentry[i], i,
+						       &filenames[i], &bitmap);
+					child->dots--;
+					fixed = 1;
+				}
+
 				i++;
 				free(name);
-				child->dots++;
 				continue;
 			}
 		}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 2ac3ee2..5d06b2f 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -30,6 +30,8 @@ struct child_info {
 	u32 links;
 	u32 files;
 	u8 dots;
+	u32 p_ino;		/*parent ino*/
+	u32 pp_ino;		/*parent parent ino*/
 };
 
 struct extent_info {
-- 
1.8.5.2


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
