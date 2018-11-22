From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] f2fs: read page index before freeing
Date: Thu, 22 Nov 2018 18:58:46 +0800
Message-ID: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The function truncate_node frees the page with f2fs_put_page. However,
the page index is read after that. So, the patch reads the index before
freeing the page.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d338740..88be946 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -826,6 +826,7 @@ static int truncate_node(struct dnode_of_data *dn)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
 	int err;
+	pgoff_t index;
 
 	err = f2fs_get_node_info(sbi, dn->nid, &ni);
 	if (err)
@@ -845,10 +846,11 @@ static int truncate_node(struct dnode_of_data *dn)
 	clear_node_page_dirty(dn->node_page);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	index = dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);
-- 
2.7.4
