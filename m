From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: enhance multi-threads performance
Date: Tue, 17 Mar 2015 09:57:40 -0700
Message-ID: <1426611461-690-3-git-send-email-jaegeuk@kernel.org>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YXuoW-0007X6-9v
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Mar 2015 16:57:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXuoV-0002cC-F7 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Mar 2015 16:57:56 +0000
In-Reply-To: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
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

Previously, f2fs_write_data_pages has a mutex, sbi->writepages, to serialize
data writes to maximize write bandwidth, while sacrificing multi-threads
performance.
Practically, however, multi-threads environment is much more important for
users. So this patch tries to remove the mutex.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  | 7 -------
 fs/f2fs/f2fs.h  | 1 -
 fs/f2fs/super.c | 1 -
 3 files changed, 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cefaa67..1a3d86a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1396,7 +1396,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	bool locked = false;
 	int ret;
 	long diff;
 
@@ -1417,13 +1416,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	diff = nr_pages_to_write(sbi, DATA, wbc);
 
-	if (!S_ISDIR(inode->i_mode)) {
-		mutex_lock(&sbi->writepages);
-		locked = true;
-	}
 	ret = write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
-	if (locked)
-		mutex_unlock(&sbi->writepages);
 
 	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c1ad404..f2909c6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -604,7 +604,6 @@ struct f2fs_sb_info {
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
-	struct mutex writepages;		/* mutex for writepages() */
 	wait_queue_head_t cp_wait;
 
 	struct inode_management im[MAX_INO_ENTRY];      /* manage inode cache */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0b8a2d8..c9f4aef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1027,7 +1027,6 @@ try_onemore:
 	sbi->raw_super = raw_super;
 	sbi->raw_super_buf = raw_super_buf;
 	mutex_init(&sbi->gc_mutex);
-	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
