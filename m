From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 3/5] f2fs: convert inc/dec_valid_node_count to
 inc/dec one count
Date: Tue, 19 Nov 2013 18:03:38 +0800
Message-ID: <528B377A.8060602@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1ViiFu-0001LY-FG
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:10:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViiFq-0006e0-RR for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:10:01 +0000
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


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h |   32 +++++++++++++++-----------------
 fs/f2fs/node.c |    6 +++---
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d0c6738..125bef0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -685,50 +685,48 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 }
 
 static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
-						struct inode *inode,
-						unsigned int count)
+						struct inode *inode)
 {
 	block_t	valid_block_count;
 	unsigned int valid_node_count;
 
 	spin_lock(&sbi->stat_lock);
 
-	valid_block_count = sbi->total_valid_block_count + (block_t)count;
-	sbi->alloc_valid_block_count += (block_t)count;
-	valid_node_count = sbi->total_valid_node_count + count;
-
+	valid_block_count = sbi->total_valid_block_count + 1;
 	if (valid_block_count > sbi->user_block_count) {
 		spin_unlock(&sbi->stat_lock);
 		return false;
 	}
 
+	valid_node_count = sbi->total_valid_node_count + 1;
 	if (valid_node_count > sbi->total_node_count) {
 		spin_unlock(&sbi->stat_lock);
 		return false;
 	}
 
 	if (inode)
-		inode->i_blocks += count;
-	sbi->total_valid_node_count = valid_node_count;
-	sbi->total_valid_block_count = valid_block_count;
+		inode->i_blocks++;
+
+	sbi->alloc_valid_block_count++;
+	sbi->total_valid_node_count++;
+	sbi->total_valid_block_count++;
 	spin_unlock(&sbi->stat_lock);
 
 	return true;
 }
 
 static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
-						struct inode *inode,
-						unsigned int count)
+						struct inode *inode)
 {
 	spin_lock(&sbi->stat_lock);
 
-	f2fs_bug_on(sbi->total_valid_block_count < count);
-	f2fs_bug_on(sbi->total_valid_node_count < count);
-	f2fs_bug_on(inode->i_blocks < count);
+	f2fs_bug_on(!sbi->total_valid_block_count);
+	f2fs_bug_on(!sbi->total_valid_node_count);
+	f2fs_bug_on(!inode->i_blocks);
 
-	inode->i_blocks -= count;
-	sbi->total_valid_node_count -= count;
-	sbi->total_valid_block_count -= (block_t)count;
+	inode->i_blocks--;
+	sbi->total_valid_node_count--;
+	sbi->total_valid_block_count--;
 
 	spin_unlock(&sbi->stat_lock);
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e7b6826..b843a5b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -502,7 +502,7 @@ static void truncate_node(struct dnode_of_data *dn)
 
 	/* Deallocate node address */
 	invalidate_blocks(sbi, ni.blk_addr);
-	dec_valid_node_count(sbi, dn->inode, 1);
+	dec_valid_node_count(sbi, dn->inode);
 	set_node_addr(sbi, &ni, NULL_ADDR);
 
 	if (dn->nid == dn->inode->i_ino) {
@@ -851,7 +851,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	if (!inc_valid_node_count(sbi, dn->inode, 1)) {
+	if (!inc_valid_node_count(sbi, dn->inode)) {
 		err = -ENOSPC;
 		goto fail;
 	}
@@ -1560,7 +1560,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	new_ni = old_ni;
 	new_ni.ino = ino;
 
-	if (!inc_valid_node_count(sbi, NULL, 1))
+	if (!inc_valid_node_count(sbi, NULL))
 		WARN_ON(1);
 	set_node_addr(sbi, &new_ni, NEW_ADDR);
 	inc_valid_inode_count(sbi);
-- 
1.7.7


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
