From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: make fault injection covering __submit_flush_wait()
Date: Tue, 19 Feb 2019 17:08:18 +0800
Message-ID: <20190219090818.9881-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch changes to allow failure of f2fs_bio_alloc() in
__submit_flush_wait(), which can simulate flush error in checkpoint()
for covering more error paths.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1334903b97f5..f454af871d5b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -561,9 +561,13 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 				struct block_device *bdev)
 {
-	struct bio *bio = f2fs_bio_alloc(sbi, 0, true);
+	struct bio *bio;
 	int ret;
 
+	bio = f2fs_bio_alloc(sbi, 0, false);
+	if (!bio)
+		return -ENOMEM;
+
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	bio_set_dev(bio, bdev);
 	ret = submit_bio_wait(bio);
-- 
2.18.0.rc1
