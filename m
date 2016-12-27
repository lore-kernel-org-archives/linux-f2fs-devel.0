From: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v1 44/54] f2fs: convert to
	bio_for_each_segment_all_sp()
Date: Wed, 28 Dec 2016 00:04:53 +0800
Message-ID: <1482854706-14128-13-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tom.leiming@gmail.com>) id 1cLuGv-0002qY-8z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Dec 2016 16:06:41 +0000
Received: from mail-pf0-f196.google.com ([209.85.192.196])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cLuGu-0004Nx-36
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Dec 2016 16:06:41 +0000
Received: by mail-pf0-f196.google.com with SMTP id i88so18317149pfk.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 27 Dec 2016 08:06:40 -0800 (PST)
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <tom.leiming@gmail.com>, "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/f2fs/data.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5d1a192e1c3c..d48b2057c2ee 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -53,6 +53,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	/*
@@ -72,7 +73,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		}
 	}
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_error) {
@@ -92,8 +93,9 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
@@ -206,6 +208,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (!io->bio)
 		return false;
@@ -213,7 +216,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	if (!inode && !page && !ino)
 		return true;
 
-	bio_for_each_segment_all(bvec, io->bio, i) {
+	bio_for_each_segment_all_sp(bvec, io->bio, i, bia) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
