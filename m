From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to check current blkaddr in __allocate_data_blocks
Date: Thu, 12 Mar 2015 17:04:24 +0800
Message-ID: <000801d05ca3$a371c030$ea554090$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In __allocate_data_blocks, we should check current blkaddr which is located at
ofs_in_node of dnode page instead of checking first blkaddr all the time.
Otherwise we can only allocate one blkaddr in each dnode page. Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0057d4b..ba70a78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1066,7 +1066,10 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 
 		while (dn.ofs_in_node < end_offset && len) {
-			if (dn.data_blkaddr == NULL_ADDR) {
+			block_t blkaddr;
+
+			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+			if (blkaddr == NULL_ADDR) {
 				if (__allocate_data_block(&dn))
 					goto sync_out;
 				allocated = true;
-- 
2.3.1
