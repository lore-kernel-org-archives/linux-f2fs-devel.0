From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: use sbi->wr_mutex for write bios
Date: Mon, 18 Nov 2013 18:12:02 +0900
Message-ID: <1384765922-24028-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1ViKtH-0001Mz-FL
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Nov 2013 09:13:07 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViKtE-0002yf-Dc for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Nov 2013 09:13:07 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWG00I0HC9J0S00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Nov 2013 18:12:55 +0900 (KST)
In-reply-to: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch removes an unnecessary semaphore (i.e., sbi->bio_sem).
There is no reason to use the semaphore when f2fs submits read and write IOs.
Instead, let's use a write mutex and cover the sbi->bio[] by the lock.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c    |  4 ----
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 13 +++++++++----
 fs/f2fs/super.c   |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 84867dc..7550026 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -390,8 +390,6 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
 
 	trace_f2fs_readpage(page, blk_addr, type);
 
-	down_read(&sbi->bio_sem);
-
 	/* Allocate a new bio */
 	bio = f2fs_bio_alloc(bdev, 1);
 
@@ -401,13 +399,11 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
 		bio_put(bio);
-		up_read(&sbi->bio_sem);
 		f2fs_put_page(page, 1);
 		return -EFAULT;
 	}
 
 	submit_bio(type, bio);
-	up_read(&sbi->bio_sem);
 	return 0;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1c783fd..76f5586 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -375,7 +375,7 @@ struct f2fs_sb_info {
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
 	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
-	struct rw_semaphore bio_sem;		/* IO semaphore */
+	struct mutex write_mutex;		/* mutex for writing IOs */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dad5f1a..893d489 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -871,9 +871,14 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 
 void f2fs_submit_bio(struct f2fs_sb_info *sbi, enum page_type type, bool sync)
 {
-	down_write(&sbi->bio_sem);
+	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+
+	if (!sbi->bio[btype])
+		return;
+
+	mutex_lock(&sbi->write_mutex);
 	do_submit_bio(sbi, type, sync);
-	up_write(&sbi->bio_sem);
+	mutex_unlock(&sbi->write_mutex);
 }
 
 static void submit_write_page(struct f2fs_sb_info *sbi, struct page *page,
@@ -884,7 +889,7 @@ static void submit_write_page(struct f2fs_sb_info *sbi, struct page *page,
 
 	verify_block_addr(sbi, blk_addr);
 
-	down_write(&sbi->bio_sem);
+	mutex_lock(&sbi->write_mutex);
 
 	inc_page_count(sbi, F2FS_WRITEBACK);
 
@@ -919,7 +924,7 @@ retry:
 
 	sbi->last_block_in_bio[type] = blk_addr;
 
-	up_write(&sbi->bio_sem);
+	mutex_unlock(&sbi->write_mutex);
 	trace_f2fs_submit_write_page(page, blk_addr, type);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2c52527..c7b6300 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -882,7 +882,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->node_write);
 	sbi->por_doing = false;
 	spin_lock_init(&sbi->stat_lock);
-	init_rwsem(&sbi->bio_sem);
+	mutex_init(&sbi->write_mutex);
 	init_rwsem(&sbi->cp_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
