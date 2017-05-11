From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: split wio_mutex
Date: Thu, 11 May 2017 11:37:35 -0700
Message-ID: <20170511183735.GA8075@jaegeuk.local>
References: <20170508163322.8087-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d8sy8-0008Ai-5L
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 18:37:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d8sy7-0001H6-F4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 18:37:44 +0000
Content-Disposition: inline
In-Reply-To: <20170508163322.8087-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 05/09, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Split wio_mutex to adjust different temperature bio cache.

This can be rephrased like:

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 3 ++-
 fs/f2fs/segment.c | 4 ++--
 fs/f2fs/super.c   | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c6643783adff..fb710bfbe215 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -888,7 +888,8 @@ struct f2fs_sb_info {
 
 	/* for bio operations */
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
-	struct mutex wio_mutex[NODE + 1];	/* bio ordering for NODE/DATA */
+	struct mutex wio_mutex[NR_PAGE_TYPE - 1][NR_TEMP_TYPE];
+						/* bio ordering for NODE/DATA */
 	int write_io_size_bits;			/* Write IO size bits */
 	mempool_t *write_io_dummy;		/* Dummy pages */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index da4fd2c29e86..cc2edaf36e55 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2156,7 +2156,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	int err;
 
 	if (fio->type == NODE || fio->type == DATA)
-		mutex_lock(&fio->sbi->wio_mutex[fio->type]);
+		mutex_lock(&fio->sbi->wio_mutex[fio->type][fio->temp]);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 					&fio->new_blkaddr, sum, type);
@@ -2169,7 +2169,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	}
 
 	if (fio->type == NODE || fio->type == DATA)
-		mutex_unlock(&fio->sbi->wio_mutex[fio->type]);
+		mutex_unlock(&fio->sbi->wio_mutex[fio->type][fio->temp]);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fea563bff0c1..df19902282f2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1555,7 +1555,7 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 static void init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
-	int i;
+	int i, j;
 
 	sbi->log_sectors_per_block =
 		le32_to_cpu(raw_super->log_sectors_per_block);
@@ -1587,8 +1587,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
-	mutex_init(&sbi->wio_mutex[NODE]);
-	mutex_init(&sbi->wio_mutex[DATA]);
+	for (i = 0; i < NR_PAGE_TYPE - 1; i++)
+		for (j = HOT; j < NR_TEMP_TYPE; j++)
+			mutex_init(&sbi->wio_mutex[i][j]);
 	spin_lock_init(&sbi->cp_lock);
 }
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
