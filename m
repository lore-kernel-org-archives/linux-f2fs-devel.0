From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] fsck.f2fs: cache all nat entries and check
	each of them
Date: Wed, 23 Mar 2016 13:41:17 -0700
Message-ID: <1458765681-24123-3-git-send-email-jaegeuk@kernel.org>
References: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipav-0004QU-2P
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipau-0002m2-3A
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:33 +0000
In-Reply-To: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

From: Sheng Yong <shengyong1@huawei.com>

All nat entries are cached during building nat_area_bitmap, so that, in
fsck_chk_meta, we can get and check blk_addr and ino directly, to see if
they are in the valid range. Also, blk_addr is checked to see if the block
is valid in sit's valid maps.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 fsck/fsck.h  |  1 +
 fsck/mount.c | 11 ++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 7100397..bc7655c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1581,6 +1581,46 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 		return -EINVAL;
 	}
 
+	/*check nat entry with sit_area_bitmap*/
+	for (i = 0; i < fsck->nr_nat_entries; i++) {
+		u32 blk = le32_to_cpu(fsck->entries[i].block_addr);
+		nid_t ino = le32_to_cpu(fsck->entries[i].ino);
+
+		if (!blk)
+			/*
+			 * skip entry whose ino is 0, otherwise, we will
+			 * get a negative number by BLKOFF_FROM_MAIN(sbi, blk)
+			 */
+			continue;
+
+		if (!IS_VALID_BLK_ADDR(sbi, blk)) {
+			MSG(0, "\tError: nat entry[ino %u block_addr 0x%x]"
+				" is in valid\n",
+				ino, blk);
+			return -EINVAL;
+		}
+
+		if (!f2fs_test_sit_bitmap(sbi, blk)) {
+			MSG(0, "\tError: nat entry[ino %u block_addr 0x%x]"
+				" not find it in sit_area_bitmap\n",
+				ino, blk);
+			return -EINVAL;
+		}
+
+		if (!IS_VALID_NID(sbi, ino)) {
+			MSG(0, "\tError: nat_entry->ino %u exceeds the range"
+				" of nat entries %u\n",
+				ino, fsck->nr_nat_entries);
+			return -EINVAL;
+		}
+
+		if (!f2fs_test_bit(ino, fsck->nat_area_bitmap)) {
+			MSG(0, "\tError: nat_entry->ino %u is not set in"
+				" nat_area_bitmap\n", ino);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index da4e6ad..5fc214e 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -76,6 +76,7 @@ struct f2fs_fsck {
 	u32 nr_nat_entries;
 
 	u32 dentry_depth;
+	struct f2fs_nat_entry *entries;
 	u32 nat_valid_inode_cnt;
 };
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 4f907ef..1d99375 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1644,6 +1644,10 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	fsck->nat_area_bitmap = calloc(fsck->nat_area_bitmap_sz, 1);
 	ASSERT(fsck->nat_area_bitmap != NULL);
 
+	fsck->entries = calloc(sizeof(struct f2fs_nat_entry),
+					fsck->nr_nat_entries);
+	ASSERT(fsck->entries);
+
 	for (block_off = 0; block_off < nr_nat_blks; block_off++) {
 
 		seg_off = block_off >> sbi->log_blocks_per_seg;
@@ -1691,6 +1695,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 					DBG(3, "nid[0x%x] in nat cache\n",
 								nid + i);
 				}
+
+				fsck->entries[nid + i] = raw_nat;
 			} else {
 				node_info_from_raw_nat(&ni,
 						&nat_block->entries[i]);
@@ -1708,7 +1714,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 					 * nat_area_bitmap, fsck_verify will
 					 * nullify it
 					 */
-					ASSERT_MSG("Invalid nat entry[0]: blk_addr[0x%x]\n",
+					ASSERT_MSG("Invalid nat entry[0]: "
+						"blk_addr[0x%x]\n",
 						ni.blk_addr);
 					config.fix_on = 1;
 					fsck->chk.valid_nat_entry_cnt--;
@@ -1718,6 +1725,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 					nid + i, ni.blk_addr, ni.ino);
 				f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
 				fsck->chk.valid_nat_entry_cnt++;
+
+				fsck->entries[nid + i] = nat_block->entries[i];
 			}
 		}
 	}
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
