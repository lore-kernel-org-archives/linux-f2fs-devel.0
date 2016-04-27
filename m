From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: move node pages only in victim section
 during foreground GC
Date: Wed, 27 Apr 2016 20:08:25 +0800
Message-ID: <633b0e8b-131b-4c35-ea5d-a4a24cd88207@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1avOH7-0006mg-Rk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Apr 2016 12:09:01 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1avOH0-00075z-R4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Apr 2016 12:09:01 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com

From: Chao Yu <yuchao0@huawei.com>

For foreground GC, we cache node blocks in victim section and set them
dirty, then we call sync_node_pages to flush these node pages, but
meanwhile, those node pages which does not locate in victim section
will be flushed together, so more bandwidth and continuous free space
would be occupied.

So for this condition, it's better to leave those unrelated node page
in cache for further write hit, and let CP or VM to flush them afterward.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
   fs/f2fs/f2fs.h |  1 +
   fs/f2fs/gc.c   | 25 ++++---------------------
   fs/f2fs/node.c | 31 +++++++++++++++++++++++++++++++
   3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1ed7f54..0786a45 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1803,6 +1803,7 @@ void ra_node_page(struct f2fs_sb_info *, nid_t);
   struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
   struct page *get_node_page_ra(struct page *, int);
   void sync_inode_page(struct dnode_of_data *);
+void move_node_page(struct page *, int);
   int fsync_node_pages(struct f2fs_sb_info *, nid_t, struct 
writeback_control *,
   								bool);
   int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e820465..19e9faf 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -465,15 +465,7 @@ next_step:
   			continue;
   		}

-		/* set page dirty and write it */
-		if (gc_type == FG_GC) {
-			f2fs_wait_on_page_writeback(node_page, NODE, true);
-			set_page_dirty(node_page);
-		} else {
-			if (!PageWriteback(node_page))
-				set_page_dirty(node_page);
-		}
-		f2fs_put_page(node_page, 1);
+		move_node_page(node_page, gc_type);
   		stat_inc_node_blk_count(sbi, 1, gc_type);
   	}

@@ -834,18 +826,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
   		f2fs_put_page(sum_page, 0);
   	}

-	if (gc_type == FG_GC) {
-		if (type == SUM_TYPE_NODE) {
-			struct writeback_control wbc = {
-				.sync_mode = WB_SYNC_ALL,
-				.nr_to_write = LONG_MAX,
-				.for_reclaim = 0,
-			};
-			sync_node_pages(sbi, &wbc);
-		} else {
-			f2fs_submit_merged_bio(sbi, DATA, WRITE);
-		}
-	}
+	if (gc_type == FG_GC)
+		f2fs_submit_merged_bio(sbi,
+				(type == SUM_TYPE_NODE) ? NODE : DATA, WRITE);

   	blk_finish_plug(&plug);

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index de070a5..f80cfb6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1222,6 +1222,37 @@ iput_out:
   	iput(inode);
   }

+void move_node_page(struct page *node_page, int gc_type)
+{
+	if (gc_type == FG_GC) {
+		struct f2fs_sb_info *sbi = F2FS_P_SB(node_page);
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL,
+			.nr_to_write = 1,
+			.for_reclaim = 0,
+		};
+
+		set_page_dirty(node_page);
+		f2fs_wait_on_page_writeback(node_page, NODE, true);
+
+		f2fs_bug_on(sbi, PageWriteback(node_page));
+		if (!clear_page_dirty_for_io(node_page))
+			goto out_page;
+
+		if (NODE_MAPPING(sbi)->a_ops->writepage(node_page, &wbc))
+			unlock_page(node_page);
+		goto release_page;
+	} else {
+		/* set page dirty and write it */
+		if (!PageWriteback(node_page))
+			set_page_dirty(node_page);
+	}
+out_page:
+	unlock_page(node_page);
+release_page:
+	f2fs_put_page(node_page, 0);
+}
+
   static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
   {
   	pgoff_t index, end;
-- 
1.9.1



------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
