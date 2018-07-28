From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: print node block address
Date: Sat, 28 Jul 2018 18:40:59 +0800
Message-ID: <20180728104059.12396-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Print block address of unreachable node id in fsck_verify() for better
debugging.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bb1da0305f2c..20a569228516 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2507,7 +2507,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < fsck->nr_nat_entries; i++) {
 		if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0) {
-			printf("NID[0x%x] is unreachable\n", i);
+			struct node_info ni;
+
+			get_node_info(sbi, i, &ni);
+			printf("NID[0x%x] is unreachable, blkaddr:0x%x\n",
+							i, ni.blk_addr);
 			nr_unref_nid++;
 		}
 	}
-- 
2.18.0.rc1
