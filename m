From: Chao Yu <chao@kernel.org>
Subject: [PATCH 5/8] f2fs: don't miss any f2fs_balance_fs cases
Date: Tue, 11 Oct 2016 22:57:03 +0800
Message-ID: <20161011145706.5028-5-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyWl-0007eq-Kz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWk-0005Qu-RZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:35 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In f2fs_map_blocks, let f2fs_balance_fs detects node page modification
with dn.node_changed to avoid miss some corner cases.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1818781..edfd2de 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -676,7 +676,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	unsigned int ofs_in_node, last_ofs_in_node;
 	blkcnt_t prealloc;
 	struct extent_info ei;
-	bool allocated = false;
 	block_t blkaddr;
 
 	if (!maxblocks)
@@ -735,10 +734,8 @@ next_block:
 				}
 			} else {
 				err = __allocate_data_block(&dn);
-				if (!err) {
+				if (!err)
 					set_inode_flag(inode, FI_APPEND_WRITE);
-					allocated = true;
-				}
 			}
 			if (err)
 				goto sync_out;
@@ -793,7 +790,6 @@ skip:
 		err = reserve_new_blocks(&dn, prealloc);
 		if (err)
 			goto sync_out;
-		allocated = dn.node_changed;
 
 		map->m_len += dn.ofs_in_node - ofs_in_node;
 		if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {
@@ -812,9 +808,8 @@ skip:
 
 	if (create) {
 		f2fs_unlock_op(sbi);
-		f2fs_balance_fs(sbi, allocated);
+		f2fs_balance_fs(sbi, dn.node_changed);
 	}
-	allocated = false;
 	goto next_dnode;
 
 sync_out:
@@ -822,7 +817,7 @@ sync_out:
 unlock_out:
 	if (create) {
 		f2fs_unlock_op(sbi);
-		f2fs_balance_fs(sbi, allocated);
+		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
 	trace_f2fs_map_blocks(inode, map, err);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
