From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: clean up codes in get_ssr_segment
Date: Wed, 22 Feb 2017 16:59:15 -0800
Message-ID: <20170223005915.GG4003@jaegeuk.local>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
 <20170223004114.GF4003@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170223004114.GF4003@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/22, Jaegeuk Kim wrote:
> Hi Yunlong,
> 
> This is NOT clean-up. What's your point here?

I guess you wanted to do like this.

>From 8d344ac45890dd95c5734fd29a19a7c19364c327 Mon Sep 17 00:00:00 2001
From: Yunlong Song <yunlong.song@huawei.com>
Date: Wed, 22 Feb 2017 20:50:49 +0800
Subject: [PATCH] f2fs: do SSR for data when there is enough free space

In allocate_segment_by_default(), need_SSR() already detected it's time to do
SSR. So, let's try to find victims for data segments more aggressively in time.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d01ee7b94702..c27dab43c42f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1541,7 +1541,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
 
-	if (IS_NODESEG(type) || !has_not_enough_free_secs(sbi, 0, 0))
+	if (IS_NODESEG(type))
 		return v_ops->get_victim(sbi,
 				&(curseg)->next_segno, BG_GC, type, SSR);
 
-- 
2.11.0
