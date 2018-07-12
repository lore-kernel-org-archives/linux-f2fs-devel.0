From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 3/5] f2fs: blk_finish_plug of submit_bio in lfs mode
Date: Thu, 12 Jul 2018 23:09:28 +0800
Message-ID: <1531408170-45758-4-git-send-email-yunlong.song@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Expand the blk_finish_plug action from blkzoned to normal lfs mode,
since plug will cause the out-of-order IO submission, which is not
friendly to flash in lfs mode.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 70813a4..f12151d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -263,7 +263,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		if (type != DATA && type != NODE)
 			goto submit_io;
 
-		if (f2fs_sb_has_blkzoned(sbi->sb) && current->plug)
+		if (test_opt(sbi, LFS) && current->plug)
 			blk_finish_plug(current->plug);
 
 		start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
-- 
1.8.5.2
