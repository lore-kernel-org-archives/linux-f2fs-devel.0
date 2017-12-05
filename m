From: "LiFan" <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: use unlikely for release case
Date: Tue, 5 Dec 2017 16:38:01 +0800
Message-ID: <000c01d36da4$7a9efbe0$6fdcf3a0$@samsung.com>
References: <CGME20171205083900epcas5p3da0ba06455bf7f17ffacd0b25328aca3@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <yuchao0@huawei.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since the variable release is only nonzero when another unlikely
case occurs, use unlikely() on it seems logical.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 71fbba96..0f01af0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1594,7 +1594,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	}
 	spin_unlock(&sbi->stat_lock);
 
-	if (release)
+	if (unlikely(release))
 		dquot_release_reservation_block(inode, release);
 	f2fs_i_blocks_write(inode, *count, true, true);
 	return 0;
-- 
2.7.4
