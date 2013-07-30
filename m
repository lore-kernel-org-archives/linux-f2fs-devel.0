From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/4] f2fs-tools: cleanup debug statement
Date: Tue, 30 Jul 2013 16:39:04 +0900
Message-ID: <1375169946-2887-2-git-send-email-cm224.lee@samsung.com>
References: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1V44YL-0004GU-F7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:05 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V44YJ-0001R5-IU for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:05 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQQ00KKHO05G2N0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 16:40:53 +0900 (KST)
In-reply-to: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
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

The debug message is too verbose therefore decrease message.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/dump.c      |    2 +-
 fsck/mount.c     |   12 ++++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 4c113dd..1b19bbc 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -170,7 +170,7 @@ read_node_blk:
 	ino = le32_to_cpu(node_blk->footer.ino);
 	nid = le32_to_cpu(node_blk->footer.nid);
 	if (ino == nid) {
-		print_inode_info(&node_blk->i);
+		print_node_info(node_blk);
 	} else {
 		ret = get_node_info(sbi, ino, &ni);
 		goto read_node_blk;
diff --git a/fsck/mount.c b/fsck/mount.c
index 13a3ef1..d936600 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -88,6 +88,10 @@ void print_node_info(struct f2fs_node *node_block)
 void print_raw_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+
+	if (!config.dbg_lv)
+		return;
+
 	printf("\n");
 	printf("+--------------------------------------------------------+\n");
 	printf("| Super block                                            |\n");
@@ -132,6 +136,9 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
+	if (!config.dbg_lv)
+		return;
+
 	printf("\n");
 	printf("+--------------------------------------------------------+\n");
 	printf("| Checkpoint                                             |\n");
@@ -938,7 +945,8 @@ int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	fsck->chk.sit_valid_blocks = sum_vblocks;
 	fsck->chk.sit_free_segs = free_segs;
 
-	DBG(0, "Blocks [0x%x] Free Segs [0x%x]\n\n", sum_vblocks, free_segs);
+	DBG(1, "Blocks [0x%x : %d] Free Segs [0x%x : %d]\n\n", sum_vblocks, sum_vblocks,
+			free_segs, free_segs);
 	return 0;
 }
 
@@ -1031,7 +1039,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	}
 	free(nat_block);
 
-	DBG(0, "valid nat entries (block_addr != 0x0) [0x%8x : %u]\n",
+	DBG(1, "valid nat entries (block_addr != 0x0) [0x%8x : %u]\n",
 			fsck->chk.valid_nat_entry_cnt, fsck->chk.valid_nat_entry_cnt);
 
 }
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
