From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce __check_sit_bitmap
Date: Fri, 30 Jun 2017 10:06:22 +0800
Message-ID: <20170630020622.115789-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dQlKh-0001JE-91
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jun 2017 02:06:55 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dQlKc-0001Js-VS
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jun 2017 02:06:55 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

After we introduce discard thread, discard command can be issued
concurrently with data allocating, this patch adds new function to
heck sit bitmap to ensure that userdata was invalid in which on-going
discard command covered.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4f35635d9f41..1cf9859d62ce 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -763,6 +763,33 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	bio_put(bio);
 }
 
+void __check_sit_bitmap(struct f2fs_sb_info *sbi,
+				block_t start, block_t end)
+{
+#ifdef CONFIG_F2FS_CHECK_FS
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct seg_entry *sentry;
+	unsigned int segno;
+	block_t blk = start;
+	unsigned long offset, size, max_blocks = sbi->blocks_per_seg;
+	unsigned long *map;
+
+	mutex_lock(&sit_i->sentry_lock);
+	while (blk < end) {
+		segno = GET_SEGNO(sbi, blk);
+		sentry = get_seg_entry(sbi, segno);
+		offset = GET_BLKOFF_FROM_SEG0(sbi, blk);
+
+		size = min((unsigned long)(end - blk), max_blocks);
+		map = (unsigned long *)(sentry->cur_valid_map);
+		offset = __find_rev_next_bit(map, size, offset);
+		f2fs_bug_on(sbi, offset != size);
+		blk += size;
+	}
+	mutex_unlock(&sit_i->sentry_lock);
+#endif
+}
+
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 				struct discard_cmd *dc)
@@ -790,6 +817,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			bio->bi_opf |= REQ_SYNC;
 			submit_bio(bio);
 			list_move_tail(&dc->list, &dcc->wait_list);
+			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
 		}
 	} else {
 		__remove_discard_cmd(sbi, dc);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
