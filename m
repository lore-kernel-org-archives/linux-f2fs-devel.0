From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: make has_fsynced_inode static
Date: Sat, 18 Apr 2015 18:06:49 +0800
Message-ID: <007d01d079bf$7b2f0d60$718d2820$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

has_fsynced_inode() has no other caller out of node.c, make it static.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h | 1 -
 fs/f2fs/node.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5cf7e9f..9fd730a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1506,7 +1506,6 @@ struct node_info;
 
 bool available_free_memory(struct f2fs_sb_info *, int);
 bool is_checkpointed_node(struct f2fs_sb_info *, nid_t);
-bool has_fsynced_inode(struct f2fs_sb_info *, nid_t);
 bool need_inode_block_update(struct f2fs_sb_info *, nid_t);
 void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8ab0cf1..1676c7a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -209,7 +209,7 @@ bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 	return is_cp;
 }
 
-bool has_fsynced_inode(struct f2fs_sb_info *sbi, nid_t ino)
+static bool has_fsynced_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
-- 
2.3.3
