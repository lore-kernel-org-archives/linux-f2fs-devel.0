From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/4] f2fs: preallocate fallocated blocks for direct IO
Date: Mon, 23 Mar 2015 10:33:37 +0800
Message-ID: <002301d06511$de54e760$9afeb620$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Normally, due to DIO_SKIP_HOLES flag is set by default, blockdev_direct_IO in
f2fs_direct_IO tries to skip DIO in holes when writing inside i_size, this
makes us falling back to buffered IO which shows lower performance.

So in commit 59b802e5a453 ("f2fs: allocate data blocks in advance for
f2fs_direct_IO"), we improve perfromance by allocating data blocks in advance
if we meet holes no matter in i_size or not, since with it we can avoid falling
back to buffered IO.

But we forget to consider for unwritten fallocated block in this commit.
This patch tries to fix it for fallocate case, this helps to improve
performance.

Test result:
Storage info: sandisk ultra 64G micro sd card.

touch /mnt/f2fs/file
truncate -s 67108864 /mnt/f2fs/file
fallocate -o 0 -l 67108864 /mnt/f2fs/file
time dd if=/dev/zero of=/mnt/f2fs/file bs=1M count=64 conv=notrunc oflag=direct

Time before applying the patch:
67108864 bytes (67 MB) copied, 36.16 s, 1.9 MB/s
real    0m36.162s
user    0m0.000s
sys     0m0.180s

Time after applying the patch:
67108864 bytes (67 MB) copied, 27.7776 s, 2.4 MB/s
real    0m27.780s
user    0m0.000s
sys     0m0.036s

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a99bc7f..e20c4c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1021,16 +1021,23 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return -EPERM;
+
+	dn->data_blkaddr = datablock_addr(dn->node_page, dn->ofs_in_node);
+	if (dn->data_blkaddr == NEW_ADDR)
+		goto alloc;
+
 	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
 		return -ENOSPC;
 
+alloc:
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
 	if (dn->ofs_in_node == 0 && dn->inode_page == dn->node_page)
 		seg = CURSEG_DIRECT_IO;
 
-	allocate_data_block(sbi, NULL, NULL_ADDR, &dn->data_blkaddr, &sum, seg);
+	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
+								&sum, seg);
 
 	/* direct IO doesn't use extent cache to maximize the performance */
 	__set_data_blkaddr(dn);
@@ -1070,7 +1077,7 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 			block_t blkaddr;
 
 			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
-			if (blkaddr == NULL_ADDR) {
+			if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
 				if (__allocate_data_block(&dn))
 					goto sync_out;
 				allocated = true;
-- 
2.3.3
