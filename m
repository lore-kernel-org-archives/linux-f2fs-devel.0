From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 12/12] f2fs: remove writepages lock
Date: Tue, 24 May 2016 17:03:38 -0700
Message-ID: <1464134619-37015-12-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIz-00055O-3B
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIy-0006wE-AH
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:09 +0000
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch removes writepages lock.
We can improve multi-threading performance.

tiobench, 32 threads, 4KB write per fsync on SSD
Before: 25.88 MB/s
After: 28.03 MB/s

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  | 7 -------
 fs/f2fs/f2fs.h  | 1 -
 fs/f2fs/super.c | 1 -
 3 files changed, 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 287582e..7132b02 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1443,7 +1443,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	bool locked = false;
 	int ret;
 	long diff;
 
@@ -1472,14 +1471,8 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	diff = nr_pages_to_write(sbi, DATA, wbc);
 
-	if (!S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_ALL) {
-		mutex_lock(&sbi->writepages);
-		locked = true;
-	}
 	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
 	f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0, DATA, WRITE);
-	if (locked)
-		mutex_unlock(&sbi->writepages);
 
 	remove_dirty_inode(inode);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97cd3c8..b622df4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -770,7 +770,6 @@ struct f2fs_sb_info {
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
-	struct mutex writepages;		/* mutex for writepages() */
 	wait_queue_head_t cp_wait;
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
 	long interval_time[MAX_TIME];		/* to store thresholds */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5696dff..52cb390 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1615,7 +1615,6 @@ try_onemore:
 	sbi->raw_super = raw_super;
 	sbi->valid_super_block = valid_super_block;
 	mutex_init(&sbi->gc_mutex);
-	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
 
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
