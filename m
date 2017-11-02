From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 2/9] fsck.f2fs: do not fix corrupted nat
 entries in build_nat_area_bitmap
Date: Thu, 2 Nov 2017 11:56:05 +0800
Message-ID: <20171102035612.217263-3-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cL-0002qx-Dr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:33 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eA6cJ-00015m-SY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:33 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Fixing corrupted data depends on c.fix_on. If it's not set, we should not
force fixing corrupted data.  So if nat entries are found invalid when
building nat_area_bitmap, we should just set c.bug_on, and fix it later.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 17da814..d8bc50c 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1877,8 +1877,14 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
 
-	memset(&nat_block->entries[entry_off], 0,
+	if (nid == F2FS_NODE_INO(sbi) || nid == F2FS_META_INO(sbi)) {
+		FIX_MSG("nid [0x%x] block_addr= 0x%x -> 0x1", nid,
+			le32_to_cpu(nat_block->entries[entry_off].block_addr));
+		nat_block->entries[entry_off].block_addr = cpu_to_le32(0x1);
+	} else {
+		memset(&nat_block->entries[entry_off], 0,
 					sizeof(struct f2fs_nat_entry));
+	}
 
 	ret = dev_write_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
@@ -2000,13 +2006,14 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 
 			if ((nid + i) == F2FS_NODE_INO(sbi) ||
 					(nid + i) == F2FS_META_INO(sbi)) {
-				/* block_addr of node/meta inode should be 0x1 */
+				/*
+				 * block_addr of node/meta inode should be 0x1.
+				 * Set this bit, and fsck_verify will fix it.
+				 */
 				if (le32_to_cpu(nat_block->entries[i].block_addr) != 0x1) {
-					FIX_MSG("ino: 0x%x node/meta inode, block_addr= 0x%x -> 0x1",
+					ASSERT_MSG("\tError: ino[0x%x] block_addr[0x%x] is invalid\n",
 							nid + i, le32_to_cpu(nat_block->entries[i].block_addr));
-					nat_block->entries[i].block_addr = cpu_to_le32(0x1);
-					ret = dev_write_block(nat_block, block_addr);
-					ASSERT(ret >= 0);
+					f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
 				}
 				continue;
 			}
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
