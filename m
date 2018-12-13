From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: remove redundant comment of unused wio_mutex
Date: Thu, 13 Dec 2018 17:43:11 +0800
Message-ID: <1544694191-131872-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit 089842de ("f2fs: remove codes of unused wio_mutex") removes codes
of unused wio_mutex, but missing the comment, so delete it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7cec897..03e7b37 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1175,7 +1175,6 @@ struct f2fs_sb_info {
 
 	/* for bio operations */
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
-						/* bio ordering for NODE/DATA */
 	/* keep migration IO order for LFS mode */
 	struct rw_semaphore io_order_lock;
 	mempool_t *write_io_dummy;		/* Dummy pages */
-- 
1.8.5.2
