From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix missing cold bit during recovery
Date: Tue, 23 Dec 2014 18:01:01 -0800
Message-ID: <1419386461-15903-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In do_recover_data, we find and update previous node pages after updating
its new block addresses.
After then, we call fill_node_footer without reset field, we erase its
cold bit so that this new cold node block is written to wrong log area.
This patch fixes not to miss its old flag.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.h          | 10 +++++++++-
 include/linux/f2fs_fs.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index fa6f959..cac8a3d 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -212,11 +212,19 @@ static inline void fill_node_footer(struct page *page, nid_t nid,
 				nid_t ino, unsigned int ofs, bool reset)
 {
 	struct f2fs_node *rn = F2FS_NODE(page);
+	unsigned int old_flag = 0;
+
 	if (reset)
 		memset(rn, 0, sizeof(*rn));
+	else
+		old_flag = le32_to_cpu(rn->footer.flag);
+
 	rn->footer.nid = cpu_to_le32(nid);
 	rn->footer.ino = cpu_to_le32(ino);
-	rn->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
+
+	/* should remain old flag bits such as COLD_BIT_SHIFT */
+	rn->footer.flag = cpu_to_le32((ofs << OFFSET_BIT_SHIFT) |
+					(old_flag & OFFSET_BIT_MASK));
 }
 
 static inline void copy_node_footer(struct page *dst, struct page *src)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 87f14e9..e993b0b 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -224,6 +224,8 @@ enum {
 	OFFSET_BIT_SHIFT
 };
 
+#define OFFSET_BIT_MASK		(0x07)	/* (0x01 << OFFSET_BIT_SHIFT) - 1 */
+
 struct node_footer {
 	__le32 nid;		/* node id */
 	__le32 ino;		/* inode nunmber */
-- 
2.1.1
