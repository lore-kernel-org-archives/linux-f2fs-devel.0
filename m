From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 9/9] fsck.f2fs: format output message of
 FIX_MSG
Date: Thu, 2 Nov 2017 11:56:12 +0800
Message-ID: <20171102035612.217263-10-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cZ-0002zZ-3I
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:47 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1eA6cX-0003oe-3M
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:47 +0000
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

This patch removes an extra '\n' at the end of the string in FIX_MSG.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c  | 4 ++--
 fsck/mount.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 77490d8..1905319 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -966,7 +966,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			else {
 				node_blk->in.nid[i] = 0;
 				need_fix = 1;
-				FIX_MSG("Set indirect node 0x%x -> 0\n", i);
+				FIX_MSG("Set indirect node 0x%x -> 0", i);
 			}
 skip:
 			child->pgofs += ADDRS_PER_BLOCK;
@@ -1006,7 +1006,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			else {
 				node_blk->in.nid[i] = 0;
 				need_fix = 1;
-				FIX_MSG("Set double indirect node 0x%x -> 0\n", i);
+				FIX_MSG("Set double indirect node 0x%x -> 0", i);
 			}
 skip:
 			child->pgofs += ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
diff --git a/fsck/mount.c b/fsck/mount.c
index d631547..cf2ef8e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1981,7 +1981,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 		if (le32_to_cpu(nid_in_journal(journal, i)) == nid) {
 			memset(&nat_in_journal(journal, i), 0,
 					sizeof(struct f2fs_nat_entry));
-			FIX_MSG("Remove nid [0x%x] in nat journal\n", nid);
+			FIX_MSG("Remove nid [0x%x] in nat journal", nid);
 			return;
 		}
 	}
@@ -2001,6 +2001,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 	} else {
 		memset(&nat_block->entries[entry_off], 0,
 					sizeof(struct f2fs_nat_entry));
+		FIX_MSG("Remove nid [0x%x] in NAT", nid);
 	}
 
 	ret = dev_write_block(nat_block, block_addr);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
