From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: fix get_blocktype_secs bug when segs_per_sec is larger than 1
Date: Tue, 30 Oct 2018 20:46:33 +0800
Message-ID: <1540903593-65539-1-git-send-email-yunlong.song@huawei.com>
References: <1540902495-60197-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540902495-60197-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_need_SSR uses get_blocktype_secs to calculate needed dirty
sections, however, for the case segs_per_sec > 1, when needed segs are
smaller than segs_per_sec, it will just return 0, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 56204a8..ef41ea2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1842,7 +1842,7 @@ static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
 	unsigned int segs = (get_pages(sbi, block_type) + pages_per_sec - 1) >>
 						sbi->log_blocks_per_seg;
 
-	return segs / sbi->segs_per_sec;
+	return (segs + sbi->segs_per_sec - 1) / sbi->segs_per_sec;
 }
 
 static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
-- 
1.8.5.2
