From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 3/5] f2fs: clear_bit the SSR selected section in the victim_secmap
Date: Mon, 23 Jul 2018 22:10:20 +0800
Message-ID: <1532355022-163029-4-git-send-email-yunlong.song@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

SSR uses get_victim to select ssr segment to allocate data blocks, which
makes the previous result of victim_secmap inaccurately, so we would
better clear the bit of the section in the victim_secmap.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 705d419..0e7a265 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -394,7 +394,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 				set_bit(secno, dirty_i->victim_secmap);
 				sbi->cur_bg_victim_sec = secno;
 			}
-		}
+		} else
+			clear_bit(secno, dirty_i->victim_secmap);
 		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 
 		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
-- 
1.8.5.2
