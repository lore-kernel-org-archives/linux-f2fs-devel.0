From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/7] fsck.f2fs: count the number of inodes during
	building nat_area_bitmap
Date: Wed, 23 Mar 2016 13:41:16 -0700
Message-ID: <1458765681-24123-2-git-send-email-jaegeuk@kernel.org>
References: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipat-0003qc-KG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipas-0000Tk-Qa
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:31 +0000
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

The nid and ino of an inode are the same. So during building
nat_area_bitmap, we can know which nat entry represents an
inode, thus, we can count the number of inodes.

Then in fsck_chk_meta, the amount of inodes can be compared
with that recorded in CP.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c  |  8 ++++++++
 fsck/fsck.h  |  1 +
 fsck/mount.c | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index fede8e1..7100397 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1573,6 +1573,14 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 		return -EINVAL;
 	}
 
+	if (fsck->nat_valid_inode_cnt != le32_to_cpu(cp->valid_inode_count)) {
+		ASSERT_MSG("valid inode does not match: nat_valid_inode_cnt %u,"
+				" valid_inode_count %u",
+				fsck->nat_valid_inode_cnt,
+				le32_to_cpu(cp->valid_inode_count));
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index f03efb8..da4e6ad 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -76,6 +76,7 @@ struct f2fs_fsck {
 	u32 nr_nat_entries;
 
 	u32 dentry_depth;
+	u32 nat_valid_inode_cnt;
 };
 
 #define BLOCK_SZ		4096
diff --git a/fsck/mount.c b/fsck/mount.c
index af1e0c3..4f907ef 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1679,6 +1679,11 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 			if (lookup_nat_in_journal(sbi, nid + i,
 							&raw_nat) >= 0) {
 				node_info_from_raw_nat(&ni, &raw_nat);
+				if (ni.ino == (nid + i) && ni.blk_addr != 0) {
+					fsck->nat_valid_inode_cnt++;
+					DBG(3, "ino[0x%8x] maybe is inode\n",
+								ni.ino);
+				}
 				if (ni.blk_addr != 0x0) {
 					f2fs_set_bit(nid + i,
 							fsck->nat_area_bitmap);
@@ -1689,6 +1694,11 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 			} else {
 				node_info_from_raw_nat(&ni,
 						&nat_block->entries[i]);
+				if (ni.ino == (nid + i) && ni.blk_addr != 0) {
+					fsck->nat_valid_inode_cnt++;
+					DBG(3, "ino[0x%8x] maybe is inode\n",
+								ni.ino);
+				}
 				if (ni.blk_addr == 0)
 					continue;
 				if (nid + i == 0) {
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
