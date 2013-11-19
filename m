From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 4/5] f2fs: simplify write_orphan_inodes for
	better readable
Date: Tue, 19 Nov 2013 18:03:58 +0800
Message-ID: <528B378E.2020109@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1ViiGG-0007Dp-U8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:10:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViiGF-0006FL-W9 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:10:24 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Simplify write_orphan_inodes for better readable. Because we hold the
orphan_inode_mutex, so it's safe to use list_for_each_entry instead of
list_for_each_safe.


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5716e5e..f884589 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -300,12 +300,13 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 
 static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 {
-	struct list_head *head, *this, *next;
+	struct list_head *head;
 	struct f2fs_orphan_block *orphan_blk = NULL;
 	struct page *page = NULL;
 	unsigned int nentries = 0;
 	unsigned short index = 1;
 	unsigned short orphan_blocks;
+	struct orphan_inode_entry *orphan = NULL;
 
 	orphan_blocks = (unsigned short)((sbi->n_orphans +
 		(F2FS_ORPHANS_PER_BLOCK - 1)) / F2FS_ORPHANS_PER_BLOCK);
@@ -314,12 +315,17 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	head = &sbi->orphan_inode_list;
 
 	/* loop for each orphan inode entry and write them in Jornal block */
-	list_for_each_safe(this, next, head) {
-		struct orphan_inode_entry *orphan;
+	list_for_each_entry(orphan, head, list) {
+		if (!page) {
+			page = grab_meta_page(sbi, start_blk);
+			orphan_blk =
+				(struct f2fs_orphan_block *)page_address(page);
+			memset(orphan_blk, 0, sizeof(*orphan_blk));
+		}
 
-		orphan = list_entry(this, struct orphan_inode_entry, list);
+		orphan_blk->ino[nentries] = cpu_to_le32(orphan->ino);
 
-		if (nentries == F2FS_ORPHANS_PER_BLOCK) {
+		if (nentries++ == F2FS_ORPHANS_PER_BLOCK) {
 			/*
 			 * an orphan block is full of 1020 entries,
 			 * then we need to flush current orphan blocks
@@ -335,24 +341,16 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 			nentries = 0;
 			page = NULL;
 		}
-		if (page)
-			goto page_exist;
+	}
 
-		page = grab_meta_page(sbi, start_blk);
-		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
-		memset(orphan_blk, 0, sizeof(*orphan_blk));
-page_exist:
-		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
+	if (page) {
+		orphan_blk->blk_addr = cpu_to_le16(index);
+		orphan_blk->blk_count = cpu_to_le16(orphan_blocks);
+		orphan_blk->entry_count = cpu_to_le32(nentries);
+		set_page_dirty(page);
+		f2fs_put_page(page, 1);
 	}
-	if (!page)
-		goto end;
 
-	orphan_blk->blk_addr = cpu_to_le16(index);
-	orphan_blk->blk_count = cpu_to_le16(orphan_blocks);
-	orphan_blk->entry_count = cpu_to_le32(nentries);
-	set_page_dirty(page);
-	f2fs_put_page(page, 1);
-end:
 	mutex_unlock(&sbi->orphan_inode_mutex);
 }
 
-- 
1.7.7


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
