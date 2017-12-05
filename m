From: "LiFan" <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: release reserved blocks for quota
Date: Tue, 5 Dec 2017 15:52:06 +0800
Message-ID: <000b01d36d9e$199ee360$4cdcaa20$@samsung.com>
References: <CGME20171205075320epcas5p3c146367a8d57d8b4617085982b195e40@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <yuchao0@huawei.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


Quota has been modified during inc_valid_block_count(), but not in
truncate process. This patch adds it.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/f2fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 82f1dc3..71fbba96 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1619,7 +1619,9 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
 					sbi->current_reserved_blocks + count);
 	spin_unlock(&sbi->stat_lock);
+
 	f2fs_i_blocks_write(inode, count, false, true);
+	dquot_release_reservation_block(inode, count);
 }
 
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
-- 
2.7.4
