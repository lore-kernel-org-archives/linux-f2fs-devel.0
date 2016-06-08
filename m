From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/7] f2fs: avoid reverse IO order for NODE and
	DATA
Date: Wed,  8 Jun 2016 10:24:39 -0700
Message-ID: <20160608172444.60371-2-jaegeuk@kernel.org>
References: <20160608172444.60371-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bAhDs-0004hA-TJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bAhDs-0005NJ-68
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:56 +0000
In-Reply-To: <20160608172444.60371-1-jaegeuk@kernel.org>
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

There is a data race between allocate_data_block() and f2fs_sbumit_page_mbio(),
which incur unnecessary reversed bio submission.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 6 ++++++
 fs/f2fs/super.c   | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d1702ee..b35b68b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -786,6 +786,7 @@ struct f2fs_sb_info {
 	/* for bio operations */
 	struct f2fs_bio_info read_io;			/* for read bios */
 	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
+	struct mutex wio_mutex[NODE + 1];	/* bio ordering for NODE/DATA */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9011bffd..7b58bfb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1399,11 +1399,17 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
 	int type = __get_segment_type(fio->page, fio->type);
 
+	if (fio->type == NODE || fio->type == DATA)
+		mutex_lock(&fio->sbi->wio_mutex[fio->type]);
+
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 					&fio->new_blkaddr, sum, type);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_mbio(fio);
+
+	if (fio->type == NODE || fio->type == DATA)
+		mutex_unlock(&fio->sbi->wio_mutex[fio->type]);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 94bb87d..dc66f16 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1436,6 +1436,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
+	mutex_init(&sbi->wio_mutex[NODE]);
+	mutex_init(&sbi->wio_mutex[DATA]);
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	memcpy(sbi->key_prefix, F2FS_KEY_DESC_PREFIX,
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
