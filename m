From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: split sbi->write_mutex for
 DATA/NODE/META to avoid unnecessary race
Date: Tue, 19 Nov 2013 12:36:14 +0900
Message-ID: <1384832174.26319.28.camel@kjgkr>
References: <001201cee4c8$de450360$9acf0a20$@samsung.com>
	<1384831096.26319.25.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vic7l-00023n-6f
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 03:37:13 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vic7i-0007rB-Sj for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 03:37:13 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWH00IK4RDO8FD0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 12:37:04 +0900 (KST)
In-reply-to: <1384831096.26319.25.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

I think we don't need to make two patches for this.
How about this?

>From 71c27f78e72d680edcd7b1c0917842343044653c Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Mon, 18 Nov 2013 17:16:17 +0900
Subject: [PATCH] f2fs: use sbi->write_mutex for write bios

This patch removes an unnecessary semaphore (i.e., sbi->bio_sem).
There is no reason to use the semaphore when f2fs submits read and write
IOs.
Instead, let's use a write mutex and cover the sbi->bio[] by the lock.

Change log from v1:
 o split write_mutex suggested by Chao Yu

Chao described,
"All DATA/NODE/META bio buffers in superblock is protected by
'sbi->write_mutex', but each bio buffer area is independent, So we
should split write_mutex to three for DATA/NODE/META."

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c    |  4 ----
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 13 +++++++++----
 fs/f2fs/super.c   |  6 +++++-
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 076a60c..5920639 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -383,8 +383,6 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct
page *page,
 
 	trace_f2fs_readpage(page, blk_addr, type);
 
-	down_read(&sbi->bio_sem);
-
 	/* Allocate a new bio */
 	bio = f2fs_bio_alloc(bdev, 1);
 
@@ -394,13 +392,11 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct
page *page,
 
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
index 6a49554..6e67f28 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -374,7 +374,7 @@ struct f2fs_sb_info {
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
 	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
-	struct rw_semaphore bio_sem;		/* IO semaphore */
+	struct mutex write_mutex[NR_PAGE_TYPE];	/* mutex for writing IOs */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dad5f1a..119af0b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -871,9 +871,14 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 
 void f2fs_submit_bio(struct f2fs_sb_info *sbi, enum page_type type,
bool sync)
 {
-	down_write(&sbi->bio_sem);
+	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+
+	if (!sbi->bio[btype])
+		return;
+
+	mutex_lock(&sbi->write_mutex[btype]);
 	do_submit_bio(sbi, type, sync);
-	up_write(&sbi->bio_sem);
+	mutex_unlock(&sbi->write_mutex[btype]);
 }
 
 static void submit_write_page(struct f2fs_sb_info *sbi, struct page
*page,
@@ -884,7 +889,7 @@ static void submit_write_page(struct f2fs_sb_info
*sbi, struct page *page,
 
 	verify_block_addr(sbi, blk_addr);
 
-	down_write(&sbi->bio_sem);
+	mutex_lock(&sbi->write_mutex[type]);
 
 	inc_page_count(sbi, F2FS_WRITEBACK);
 
@@ -919,7 +924,7 @@ retry:
 
 	sbi->last_block_in_bio[type] = blk_addr;
 
-	up_write(&sbi->bio_sem);
+	mutex_unlock(&sbi->write_mutex[type]);
 	trace_f2fs_submit_write_page(page, blk_addr, type);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a022412..e194578 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -820,6 +820,7 @@ static int f2fs_fill_super(struct super_block *sb,
void *data, int silent)
 	struct buffer_head *raw_super_buf;
 	struct inode *root;
 	long err = -EINVAL;
+	int i;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
@@ -876,7 +877,10 @@ static int f2fs_fill_super(struct super_block *sb,
void *data, int silent)
 	mutex_init(&sbi->node_write);
 	sbi->por_doing = false;
 	spin_lock_init(&sbi->stat_lock);
-	init_rwsem(&sbi->bio_sem);
+
+	for (i = 0; i < NR_PAGE_TYPE; i++)
+		mutex_init(&sbi->write_mutex[i]);
+
 	init_rwsem(&sbi->cp_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
-- 
1.8.4.474.g128a96c



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
