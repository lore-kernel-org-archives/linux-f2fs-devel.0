From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: change segment to section in f2fs_ioc_gc_range
Date: Tue, 30 Oct 2018 20:37:55 +0800
Message-ID: <1540903075-62916-1-git-send-email-yunlong.song@huawei.com>
References: <1540391736-20714-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540391736-20714-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_ioc_gc_range skips blocks_per_seg each time, however, f2fs_gc moves
blocks of section each time, so fix it from segment to section.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 88b1246..f981b6c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2155,7 +2155,7 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	}
 
 	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
-	range.start += sbi->blocks_per_seg;
+	range.start += BLKS_PER_SEC(sbi);
 	if (range.start <= end)
 		goto do_more;
 out:
-- 
1.8.5.2
