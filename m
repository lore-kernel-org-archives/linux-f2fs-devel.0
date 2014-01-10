From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 3/3] f2fs: use spinlock rather than mutex for
 better speed
Date: Fri, 10 Jan 2014 18:09:14 +0800
Message-ID: <52CFC6CA.3060406@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1W1Z8r-0007jV-92
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 10:16:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W1Z8q-0001Eb-Aj for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 10:16:41 +0000
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

With the 2 previous changes, all the long time operations are moved out
of the protection region, so here we can use spinlock rather than mutex
(orphan_inode_mutex) for lower overhead.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   24 ++++++++++++------------
 fs/f2fs/f2fs.h       |    2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 007f64c..d0c797f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -196,22 +196,22 @@ int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 {
 	int err = 0;
 
-	mutex_lock(&sbi->orphan_inode_mutex);
+	spin_lock(&sbi->orphan_inode_lock);
 	if (unlikely(sbi->n_orphans >= sbi->max_orphans))
 		err = -ENOSPC;
 	else
 		sbi->n_orphans++;
-	mutex_unlock(&sbi->orphan_inode_mutex);
+	spin_unlock(&sbi->orphan_inode_lock);
 
 	return err;
 }
 
 void release_orphan_inode(struct f2fs_sb_info *sbi)
 {
-	mutex_lock(&sbi->orphan_inode_mutex);
+	spin_lock(&sbi->orphan_inode_lock);
 	f2fs_bug_on(sbi->n_orphans == 0);
 	sbi->n_orphans--;
-	mutex_unlock(&sbi->orphan_inode_mutex);
+	spin_unlock(&sbi->orphan_inode_lock);
 }
 
 void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
@@ -222,12 +222,12 @@ void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	new = f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
 	new->ino = ino;
 
-	mutex_lock(&sbi->orphan_inode_mutex);
+	spin_lock(&sbi->orphan_inode_lock);
 	head = &sbi->orphan_inode_list;
 	list_for_each(this, head) {
 		orphan = list_entry(this, struct orphan_inode_entry, list);
 		if (orphan->ino == ino) {
-			mutex_unlock(&sbi->orphan_inode_mutex);
+			spin_unlock(&sbi->orphan_inode_lock);
 			kmem_cache_free(orphan_entry_slab, new);
 			return;
 		}
@@ -242,7 +242,7 @@ void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 		list_add(&new->list, this->prev);
 	else
 		list_add_tail(&new->list, head);
-	mutex_unlock(&sbi->orphan_inode_mutex);
+	spin_unlock(&sbi->orphan_inode_lock);
 }
 
 void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
@@ -250,7 +250,7 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	struct list_head *head;
 	struct orphan_inode_entry *orphan;
 
-	mutex_lock(&sbi->orphan_inode_mutex);
+	spin_lock(&sbi->orphan_inode_lock);
 	head = &sbi->orphan_inode_list;
 	list_for_each_entry(orphan, head, list) {
 		if (orphan->ino == ino) {
@@ -261,7 +261,7 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 			break;
 		}
 	}
-	mutex_unlock(&sbi->orphan_inode_mutex);
+	spin_unlock(&sbi->orphan_inode_lock);
 }
 
 static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
@@ -318,7 +318,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 		pages[index] = grab_meta_page(sbi, start_blk + index);
 
 	index = 1;
-	mutex_lock(&sbi->orphan_inode_mutex);
+	spin_lock(&sbi->orphan_inode_lock);
 	head = &sbi->orphan_inode_list;
 
 	/* loop for each orphan inode entry and write them in Jornal block */
@@ -358,7 +358,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 		f2fs_put_page(page, 1);
 	}
 
-	mutex_unlock(&sbi->orphan_inode_mutex);
+	spin_unlock(&sbi->orphan_inode_lock);
 }
 
 static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
@@ -829,7 +829,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 
 void init_orphan_info(struct f2fs_sb_info *sbi)
 {
-	mutex_init(&sbi->orphan_inode_mutex);
+	spin_lock_init(&sbi->orphan_inode_lock);
 	INIT_LIST_HEAD(&sbi->orphan_inode_list);
 	sbi->n_orphans = 0;
 	/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5f7dc4f..2d3f531 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -412,7 +412,7 @@ struct f2fs_sb_info {
 
 	/* for orphan inode management */
 	struct list_head orphan_inode_list;	/* orphan inode list */
-	struct mutex orphan_inode_mutex;	/* for orphan inode list */
+	spinlock_t orphan_inode_lock;		/* for orphan inode list */
 	unsigned int n_orphans;			/* # of orphan inodes */
 	unsigned int max_orphans;		/* max orphan inodes */
 
-- 
1.7.7


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
