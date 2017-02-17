From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 2/2] f2fs: fix the case when there is no free segment to allocate for CURSEG_WARM_NODE
Date: Fri, 17 Feb 2017 20:53:07 +0800
Message-ID: <1487335987-32601-3-git-send-email-yunlong.song@huawei.com>
References: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com, miaoxie@huawei.com, zhouxiyu@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If the free segments are used up, then new_curseg will fail for
CURSEG_WARM_NODE, in this case, we should use change_curseg instead of
new_curseg.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index df2ff5c..32820cd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1564,8 +1564,6 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 
 	if (force)
 		new_curseg(sbi, type, true);
-	else if (type == CURSEG_WARM_NODE)
-		new_curseg(sbi, type, false);
 	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
 		new_curseg(sbi, type, false);
 	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
-- 
1.8.5.2
