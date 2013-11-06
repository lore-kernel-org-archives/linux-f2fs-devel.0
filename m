From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: avoid to use a NULL point in
 destroy_segment_manager
Date: Wed, 06 Nov 2013 09:12:04 +0800
Message-ID: <000001ceda8d$5b185bd0$11491370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

A NULL point should avoid to be used in destroy_segment_manager after allocating memory fail for f2fs_sm_info.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3d4d5fc..ff363e6
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1744,6 +1744,8 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 void destroy_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_sm_info *sm_info = SM_I(sbi);
+	if (!sm_info)
+		return;
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
-- 
1.7.9.5
