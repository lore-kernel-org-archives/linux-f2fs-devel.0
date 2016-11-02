From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: record inode updating status correctly
Date: Wed, 2 Nov 2016 20:43:21 +0800
Message-ID: <20161102124321.20874-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should record updating status of inode only for living inode, for those
unlinked inode it needs to clear its ino cache, otherwise after the ino
was been reused, it will cause unneeded node page writing during ->fsync.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7b5e402..af06bda 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -377,6 +377,9 @@ void f2fs_evict_inode(struct inode *inode)
 		goto no_delete;
 #endif
 
+	remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
+	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+
 	sb_start_intwrite(inode->i_sb);
 	set_inode_flag(inode, FI_NO_ALLOC);
 	i_size_write(inode, 0);
@@ -409,10 +412,12 @@ void f2fs_evict_inode(struct inode *inode)
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
-	if (is_inode_flag_set(inode, FI_APPEND_WRITE))
-		add_ino_entry(sbi, inode->i_ino, APPEND_INO);
-	if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
-		add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	if (inode->i_nlink) {
+		if (is_inode_flag_set(inode, FI_APPEND_WRITE))
+			add_ino_entry(sbi, inode->i_ino, APPEND_INO);
+		if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
+			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	}
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
 		alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
-- 
2.8.2.311.gee88674
