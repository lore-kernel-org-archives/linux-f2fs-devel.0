From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: split IO error injection according to RW
Date: Wed, 12 Sep 2018 09:22:29 +0800
Message-ID: <20180912012229.64936-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to support injecting error for write IO, this can simulate
IO error like fail_make_request or dm_flakey does.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt |  3 ++-
 fs/f2fs/data.c                     | 10 ++++++++--
 fs/f2fs/f2fs.h                     |  3 ++-
 fs/f2fs/super.c                    |  3 ++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e5edd29687b5..bde3e91e5372 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -172,9 +172,10 @@ fault_type=%d          Support configuring fault injection type, should be
                        FAULT_DIR_DEPTH		0x000000100
                        FAULT_EVICT_INODE	0x000000200
                        FAULT_TRUNCATE		0x000000400
-                       FAULT_IO			0x000000800
+                       FAULT_READ_IO		0x000000800
                        FAULT_CHECKPOINT		0x000001000
                        FAULT_DISCARD		0x000002000
+                       FAULT_WRITE_IO		0x000004000
 mode=%s                Control block allocation mode which supports "adaptive"
                        and "lfs". In "lfs" mode, there should be no random
                        writes towards main area.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a2a0777a25a..35ec30e69bfe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -123,8 +123,9 @@ static bool f2fs_bio_post_read_required(struct bio *bio)
 
 static void f2fs_read_end_io(struct bio *bio)
 {
-	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)), FAULT_IO)) {
-		f2fs_show_injection_info(FAULT_IO);
+	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)),
+						FAULT_READ_IO)) {
+		f2fs_show_injection_info(FAULT_READ_IO);
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
@@ -145,6 +146,11 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	int i;
 
+	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
+		f2fs_show_injection_info(FAULT_WRITE_IO);
+		bio->bi_status = BLK_STS_IOERR;
+	}
+
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1f9e6171a581..8c8ce6b8f45a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -50,9 +50,10 @@ enum {
 	FAULT_DIR_DEPTH,
 	FAULT_EVICT_INODE,
 	FAULT_TRUNCATE,
-	FAULT_IO,
+	FAULT_READ_IO,
 	FAULT_CHECKPOINT,
 	FAULT_DISCARD,
+	FAULT_WRITE_IO,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 73f2cd3a2b39..968cb6ced1e9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -50,9 +50,10 @@ char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 	[FAULT_EVICT_INODE]	= "evict_inode fail",
 	[FAULT_TRUNCATE]	= "truncate fail",
-	[FAULT_IO]		= "IO error",
+	[FAULT_READ_IO]		= "read IO error",
 	[FAULT_CHECKPOINT]	= "checkpoint error",
 	[FAULT_DISCARD]		= "discard error",
+	[FAULT_WRITE_IO]	= "write IO error",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-- 
2.18.0.rc1
