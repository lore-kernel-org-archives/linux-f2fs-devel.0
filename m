From: Oded Gabbay <ogabbay@advaoptical.com>
Subject: [f2fs-dev] [PATCH] Fix bug in endianness at f2fs_update_nat_root
Date: Thu, 13 Jun 2013 13:57:32 +0300
Message-ID: <1371121052-6350-1-git-send-email-ogabbay@advaoptical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <OGabbay@advaoptical.com>) id 1Un5jL-0007ys-GR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Jun 2013 11:30:15 +0000
Received: from mail.advaoptical.com ([91.217.199.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Un5jJ-0000Er-SE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Jun 2013 11:30:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, ogabbay@advaoptical.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch fixes a bug in the function "f2fs_update_nat_root", where the
access to the array "nat_blk->entries" was done using an index without
encapsulation of the "le32_to_cpu" macro.
The bug happens when trying to format an SD card in a powerpc architecture,
which natively runs at big-endian mode

Signed-off-by: Oded Gabbay <ogabbay@advaoptical.com>
---
 mkfs/f2fs_format.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9010298..8e49ed4 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -810,18 +810,18 @@ static int f2fs_update_nat_root(void)
 	}
 
 	/* update root */
-	nat_blk->entries[super_block.root_ino].block_addr = cpu_to_le32(
+	nat_blk->entries[le32_to_cpu(super_block.root_ino)].block_addr = cpu_to_le32(
 		le32_to_cpu(super_block.main_blkaddr) +
 		config.cur_seg[CURSEG_HOT_NODE] * config.blks_per_seg);
-	nat_blk->entries[super_block.root_ino].ino = super_block.root_ino;
+	nat_blk->entries[le32_to_cpu(super_block.root_ino)].ino = super_block.root_ino;
 
 	/* update node nat */
-	nat_blk->entries[super_block.node_ino].block_addr = cpu_to_le32(1);
-	nat_blk->entries[super_block.node_ino].ino = super_block.node_ino;
+	nat_blk->entries[le32_to_cpu(super_block.node_ino)].block_addr = cpu_to_le32(1);
+	nat_blk->entries[le32_to_cpu(super_block.node_ino)].ino = super_block.node_ino;
 
 	/* update meta nat */
-	nat_blk->entries[super_block.meta_ino].block_addr = cpu_to_le32(1);
-	nat_blk->entries[super_block.meta_ino].ino = super_block.meta_ino;
+	nat_blk->entries[le32_to_cpu(super_block.meta_ino)].block_addr = cpu_to_le32(1);
+	nat_blk->entries[le32_to_cpu(super_block.meta_ino)].ino = super_block.meta_ino;
 
 	blk_size_bytes = 1 << le32_to_cpu(super_block.log_blocksize);
 	nat_seg_blk_offset = le32_to_cpu(super_block.nat_blkaddr);
-- 
1.8.3.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
