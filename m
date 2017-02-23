From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: clean up codes in f2fs_gc related with
 write_checkpoint
Date: Wed, 22 Feb 2017 20:51:27 -0800
Message-ID: <20170223045127.GB35356@jaegeuk.local>
References: <1487681028-19410-1-git-send-email-yunlong.song@huawei.com>
 <58AE4E69.1050104@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58AE4E69.1050104@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/23, Yunlong Song wrote:
> Ping...
> 
> Since has_not_enough_free_secs(sbi, 0, 0) must be true if has_not_enough_free_secs(sbi, sec_freed, 0) is true,
> write_checkpoint is sure to execute in both conditions, and segno is NULL_SEGNO in both conditions.

Looks good to me, but applied like below.

>From 49aea5513fd20d29dace9067de2e931d03ae2202 Mon Sep 17 00:00:00 2001
From: Yunlong Song <yunlong.song@huawei.com>
Date: Tue, 21 Feb 2017 20:43:48 +0800
Subject: [PATCH] f2fs: remove unnecessary condition check for write_checkpoint
 in f2fs_gc

Since has_not_enough_free_secs(sbi, 0, 0) must be true if has_not_enough_
free_secs(sbi, sec_freed, 0) is true, write_checkpoint is sure to execute in
both conditions.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 11416c7cb705..6c996e39b59a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -958,15 +958,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		 * enough free sections, we should flush dent/node blocks and do
 		 * garbage collections.
 		 */
-		if (dirty_segments(sbi) || prefree_segments(sbi)) {
-			ret = write_checkpoint(sbi, &cpc);
-			if (ret)
-				goto stop;
-		} else if (has_not_enough_free_secs(sbi, 0, 0)) {
-			ret = write_checkpoint(sbi, &cpc);
-			if (ret)
-				goto stop;
-		}
+		ret = write_checkpoint(sbi, &cpc);
+		if (ret)
+			goto stop;
 	} else if (gc_type == BG_GC && !background) {
 		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
 		goto stop;
-- 
2.11.0
