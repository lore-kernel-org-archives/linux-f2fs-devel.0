From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/7] fsck.f2fs: check ino in nat entry and node
	footer
Date: Wed, 23 Mar 2016 13:41:18 -0700
Message-ID: <1458765681-24123-4-git-send-email-jaegeuk@kernel.org>
References: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipav-0004QZ-Vz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipav-0002m6-7E
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

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 1d99375..51d50ec 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1683,6 +1683,10 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 			if (lookup_nat_in_journal(sbi, nid + i,
 							&raw_nat) >= 0) {
 				node_info_from_raw_nat(&ni, &raw_nat);
+				if ((ni.ino == 0x0 && ni.blk_addr != 0x0))
+					ASSERT_MSG("\tError: ino[0x%8x] or blk_addr[0x%16x]"
+						" is invalid\n",
+						ni.ino, ni.blk_addr);
 				if (ni.ino == (nid + i) && ni.blk_addr != 0) {
 					fsck->nat_valid_inode_cnt++;
 					DBG(3, "ino[0x%8x] maybe is inode\n",
@@ -1700,6 +1704,10 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 			} else {
 				node_info_from_raw_nat(&ni,
 						&nat_block->entries[i]);
+				if ((ni.ino == 0x0 && ni.blk_addr != 0x0))
+					ASSERT_MSG("\tError: ino[0x%8x] or blk_addr[0x%16x]"
+						" is invalid\n",
+						ni.ino, ni.blk_addr);
 				if (ni.ino == (nid + i) && ni.blk_addr != 0) {
 					fsck->nat_valid_inode_cnt++;
 					DBG(3, "ino[0x%8x] maybe is inode\n",
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
