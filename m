From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs-tools: fix is_set_ckpt_flags for correct bool value
Date: Sun, 10 Sep 2017 19:15:29 +0800
Message-ID: <1505042129-41945-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If flag bit to check is in 0xFFFFFF00, then the return value will be false,
this is not correct, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 871cffc..de03512 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -276,7 +276,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 {
 	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
-	return ckpt_flags & f;
+	return ckpt_flags & f ? 1 : 0;
 }
 
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
-- 
1.8.5.2
