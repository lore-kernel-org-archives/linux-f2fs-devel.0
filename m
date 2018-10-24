From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: only flush the single temp bio cache which owns the target page
Date: Wed, 24 Oct 2018 19:35:45 +0800
Message-ID: <1540380945-18114-1-git-send-email-yunlong.song@huawei.com>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, when f2fs finds which temp bio cache owns the target page,
it will flush all the three temp bio caches, but we only need to flush
one single bio cache indeed, which can help to keep bio merged.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 106f116..882e217 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -396,13 +396,17 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
 }
 
 static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
-				enum page_type type, enum temp_type temp)
+				struct inode *inode, struct page *page, nid_t ino,
+				enum page_type type, enum temp_type temp, bool force)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
 
 	down_write(&io->io_rwsem);
 
+	if (!force && !__has_merged_page(io, inode, page, ino))
+		goto out;
+
 	/* change META to META_FLUSH in the checkpoint procedure */
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
@@ -412,6 +416,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 	}
 	__submit_merged_bio(io);
+out:
 	up_write(&io->io_rwsem);
 }
 
@@ -426,7 +431,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
 
-		__f2fs_submit_merged_write(sbi, type, temp);
+		__f2fs_submit_merged_write(sbi, inode, page, ino, type, temp, force);
 
 		/* TODO: use HOT temp only for meta pages now. */
 		if (type >= META)
-- 
1.8.5.2
