From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: check segment type in __f2fs_replace_block
Date: Thu, 4 Jan 2018 11:48:25 +0800
Message-ID: <1515037705-23984-1-git-send-email-yunlong.song@huawei.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 890d483..e3bbabf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2719,6 +2719,8 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	se = get_seg_entry(sbi, segno);
 	type = se->type;
 
+	f2fs_bug_on(sbi, se->valid_blocks && IS_NODESEG(type));
+
 	down_write(&SM_I(sbi)->curseg_lock);
 
 	if (!recover_curseg) {
-- 
1.8.5.2
