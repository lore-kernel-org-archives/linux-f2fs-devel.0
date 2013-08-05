From: Jin Xu <jinuxstyle@gmail.com>
Subject: [PATCH] f2fs: fix a deadlock in fsync
Date: Mon,  5 Aug 2013 20:02:04 +0800
Message-ID: <1375704124-22274-1-git-send-email-jinuxstyle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinuxstyle@gmail.com>) id 1V6JUx-0004xc-8V
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Aug 2013 12:02:51 +0000
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6JUv-0000Vc-I5
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Aug 2013 12:02:51 +0000
Received: by mail-pb0-f52.google.com with SMTP id wz12so3264717pbc.25
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 05 Aug 2013 05:02:43 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, jinuxstyle@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Jin Xu <jinuxstyle@gmail.com>

This patch fixes a deadlock bug that occurs quite often when there are
concurrent write and fsync on a same file.

Following is the simplified call trace when tasks get hung.

fsync thread:
- f2fs_sync_file
 ...
 - f2fs_write_data_pages
 ...
  - update_extent_cache
  ...
   - update_inode
    - wait_on_page_writeback

bdi writeback thread
- __writeback_single_inode
 - f2fs_write_data_pages
  - mutex_lock(sbi->writepages)

The deadlock happens when the fsync thread waits on a inode page that has
been added to the f2fs' cached bio sbi->bio[NODE], and unfortunately,
no one else could be able to submit the cached bio to block layer for
writeback. This is because the fsync thread already hold a sbi->fs_lock and
the sbi->writepages lock, causing the bdi thread being blocked when attempt
to write data pages for the same inode. At the same time, f2fs_gc thread
does not notice the situation and could not help. Even the sync syscall
gets blocked.

To fix it, we could submit the cached bio first before waiting on a inode page
that is being written back.

Signed-off-by: Jin Xu <jinuxstyle@gmail.com>
---
 fs/f2fs/f2fs.h    |    2 ++
 fs/f2fs/gc.c      |    5 +----
 fs/f2fs/inode.c   |    3 ++-
 fs/f2fs/segment.c |    9 +++++++++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 467d42d..064d3f9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1013,6 +1013,8 @@ void allocate_new_segments(struct f2fs_sb_info *);
 struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
 struct bio *f2fs_bio_alloc(struct block_device *, int);
 void f2fs_submit_bio(struct f2fs_sb_info *, enum page_type, bool sync);
+void f2fs_wait_on_page_writeback(struct f2fs_sb_info *sbi,
+		struct page *page, enum page_type type, bool sync);
 void write_meta_page(struct f2fs_sb_info *, struct page *);
 void write_node_page(struct f2fs_sb_info *, struct page *, unsigned int,
 					block_t, block_t *);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 35f9b1a..acfa411 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -508,10 +508,7 @@ static void move_data_page(struct inode *inode, struct page *page, int gc_type)
 	} else {
 		struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
-		if (PageWriteback(page)) {
-			f2fs_submit_bio(sbi, DATA, true);
-			wait_on_page_writeback(page);
-		}
+		f2fs_wait_on_page_writeback(sbi, page, DATA, true);
 
 		if (clear_page_dirty_for_io(page) &&
 			S_ISDIR(inode->i_mode)) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2b2d45d1..d42b85b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -148,10 +148,11 @@ bad_inode:
 
 void update_inode(struct inode *inode, struct page *node_page)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct f2fs_node *rn;
 	struct f2fs_inode *ri;
 
-	wait_on_page_writeback(node_page);
+	f2fs_wait_on_page_writeback(sbi, node_page, NODE, false);
 
 	rn = page_address(node_page);
 	ri = &(rn->i);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a86d125..7056cc0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -702,6 +702,15 @@ alloc_new:
 	trace_f2fs_submit_write_page(page, blk_addr, type);
 }
 
+void f2fs_wait_on_page_writeback(struct f2fs_sb_info *sbi,
+		struct page *page, enum page_type type, bool sync)
+{
+	if (PageWriteback(page)) {
+		f2fs_submit_bio(sbi, type, sync);
+		wait_on_page_writeback(page);
+	}
+}
+
 static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-- 
1.7.9.5


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
