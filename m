From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: remove uncovered code path
Date: Tue,  6 Jan 2015 11:20:33 -0800
Message-ID: <1420572034-53758-3-git-send-email-jaegeuk@kernel.org>
References: <1420572034-53758-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y8ZgQ-0004GI-P6
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 19:20:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y8ZgP-00084x-I8 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 19:20:50 +0000
In-Reply-To: <1420572034-53758-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch removes unnecessary function calls.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 155885b..3e0f5f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -563,31 +563,22 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
 	struct f2fs_summary sum;
-	block_t new_blkaddr;
 	struct node_info ni;
 	pgoff_t fofs;
-	int type;
 
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return -EPERM;
 	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
 		return -ENOSPC;
 
-	dn->data_blkaddr = NEW_ADDR;
-	__set_data_blkaddr(dn);
-
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
-	type = CURSEG_WARM_DATA;
-
-	allocate_data_block(sbi, NULL, NULL_ADDR, &new_blkaddr, &sum, type);
+	allocate_data_block(sbi, NULL, NULL_ADDR, &dn->data_blkaddr, &sum,
+							CURSEG_WARM_DATA);
 
 	/* direct IO doesn't use extent cache to maximize the performance */
-	set_inode_flag(F2FS_I(dn->inode), FI_NO_EXTENT);
-	dn->data_blkaddr = new_blkaddr;
-	update_extent_cache(dn);
-	clear_inode_flag(F2FS_I(dn->inode), FI_NO_EXTENT);
+	__set_data_blkaddr(dn);
 
 	/* update i_size */
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
@@ -595,7 +586,6 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	if (i_size_read(dn->inode) < ((fofs + 1) << PAGE_CACHE_SHIFT))
 		i_size_write(dn->inode, ((fofs + 1) << PAGE_CACHE_SHIFT));
 
-	dn->data_blkaddr = new_blkaddr;
 	return 0;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
