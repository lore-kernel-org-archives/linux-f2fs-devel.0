From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: introduce f2fs_flush_merged_bios for
	cleanup
Date: Wed, 24 Feb 2016 17:17:55 +0800
Message-ID: <00e501d16ee4$5cd5cf50$16816df0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aYVb3-0001cz-1M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Feb 2016 09:19:01 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aYVb1-0000CI-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Feb 2016 09:19:01 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3102BYFOJ2RA80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Feb 2016 18:18:47 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Add a new helper f2fs_flush_merged_bios to clean up redundant codes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 4 +---
 fs/f2fs/data.c       | 7 +++++++
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/super.c      | 7 ++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2bac8a1..64bbd06 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1141,9 +1141,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
 
-	f2fs_submit_merged_bio(sbi, DATA, WRITE);
-	f2fs_submit_merged_bio(sbi, NODE, WRITE);
-	f2fs_submit_merged_bio(sbi, META, WRITE);
+	f2fs_flush_merged_bios(sbi);
 
 	/*
 	 * update checkpoint pack index
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 060c5f7..e5c762b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -200,6 +200,13 @@ void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
 		__f2fs_submit_merged_bio(sbi, inode, page, ino, type, rw);
 }
 
+void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi)
+{
+	f2fs_submit_merged_bio(sbi, DATA, WRITE);
+	f2fs_submit_merged_bio(sbi, NODE, WRITE);
+	f2fs_submit_merged_bio(sbi, META, WRITE);
+}
+
 /*
  * Fill the locked page with data located in the block address.
  * Return unlocked page.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6e88a66..0d25430 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1873,6 +1873,7 @@ void destroy_checkpoint_caches(void);
 void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
 void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
 				struct page *, nid_t, enum page_type, int);
+void f2fs_flush_merged_bios(struct f2fs_sb_info *);
 int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 10a32cf..7b62016 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -575,11 +575,8 @@ static void f2fs_put_super(struct super_block *sb)
 	mutex_unlock(&sbi->umount_mutex);
 
 	/* our cp_error case, we can wait for any writeback page */
-	if (get_pages(sbi, F2FS_WRITEBACK)) {
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
-		f2fs_submit_merged_bio(sbi, META, WRITE);
-	}
+	if (get_pages(sbi, F2FS_WRITEBACK))
+		f2fs_flush_merged_bios(sbi);
 
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
