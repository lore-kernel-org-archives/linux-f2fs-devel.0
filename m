From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/3] f2fs: introduce f2fs_balance_fs_bg for some
	background jobs
Date: Thu, 24 Oct 2013 16:57:41 +0900
Message-ID: <1382601462-7989-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1382601462-7989-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VZFoO-0002hX-AQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 07:58:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZFoM-0001ia-Ph for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 07:58:32 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MV500CH7Y582OF0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 16:58:21 +0900 (KST)
In-reply-to: <1382601462-7989-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch merges some background jobs into this new function.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/gc.c      |  5 ++---
 fs/f2fs/node.c    | 10 +++-------
 fs/f2fs/segment.c |  8 ++++++++
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c95d35..602a41d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -965,6 +965,7 @@ long f2fs_compat_ioctl(struct file *, unsigned int, unsigned long);
  */
 void f2fs_set_inode_flags(struct inode *);
 struct inode *f2fs_iget(struct super_block *, unsigned long);
+int try_to_free_nats(struct f2fs_sb_info *, int);
 void update_inode(struct inode *, struct page *);
 int update_inode_page(struct inode *);
 int f2fs_write_inode(struct inode *, struct writeback_control *);
@@ -1045,6 +1046,7 @@ void destroy_node_manager_caches(void);
  * segment.c
  */
 void f2fs_balance_fs(struct f2fs_sb_info *);
+void f2fs_balance_fs_bg(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 void clear_prefree_segments(struct f2fs_sb_info *);
 int npages_for_summary_flush(struct f2fs_sb_info *);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 783c6cc..b7ad1ec 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -83,9 +83,8 @@ static int gc_thread_func(void *data)
 		if (f2fs_gc(sbi))
 			wait_ms = gc_th->no_gc_sleep_time;
 
-		/* balancing prefree segments */
-		if (excess_prefree_segs(sbi))
-			f2fs_sync_fs(sbi->sb, true);
+		/* balancing f2fs's metadata periodically */
+		f2fs_balance_fs_bg(sbi);
 
 	} while (!kthread_should_stop());
 	return 0;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 89dd8a5..7bac481 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -240,7 +240,7 @@ retry:
 	write_unlock(&nm_i->nat_tree_lock);
 }
 
-static int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
+int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
@@ -1205,12 +1205,8 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
 	long nr_to_write = wbc->nr_to_write;
 
-	/* First check balancing cached NAT entries */
-	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK) ||
-				excess_prefree_segs(sbi)) {
-		f2fs_sync_fs(sbi->sb, true);
-		return 0;
-	}
+	/* balancing f2fs's metadata in background */
+	f2fs_balance_fs_bg(sbi);
 
 	/* collect a number of dirty node pages and write together */
 	if (get_pages(sbi, F2FS_DIRTY_NODES) < COLLECT_DIRTY_NODES)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 43ee91e..77aee83 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -36,6 +36,14 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi)
 	}
 }
 
+void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
+{
+	/* check the # of cached NAT entries and prefree segments */
+	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK) ||
+				excess_prefree_segs(sbi))
+		f2fs_sync_fs(sbi->sb, true);
+}
+
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type dirty_type)
 {
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
