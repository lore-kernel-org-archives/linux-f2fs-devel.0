From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 1/5] f2fs: do not set free of current section
Date: Thu, 12 Jul 2018 23:09:26 +0800
Message-ID: <1531408170-45758-2-git-send-email-yunlong.song@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
example, if segment 1 is just used and allocate new segment 2, and the
blocks of segment 1 is invalidated, at this time, the previous code will
use __set_test_and_free to free the free_secmap and free_sections++,
this is not correct since it is still a current section, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b5bd328..5049551 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -448,6 +448,8 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
 
+		if (IS_CURSEC(sbi, secno))
+			goto skip_free;
 		next = find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >= start_segno + sbi->segs_per_sec) {
@@ -455,6 +457,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 				free_i->free_sections++;
 		}
 	}
+skip_free:
 	spin_unlock(&free_i->segmap_lock);
 }
 
-- 
1.8.5.2
