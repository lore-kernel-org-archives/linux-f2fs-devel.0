From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: avoid to return incorrect errno of
 read_normal_summaries
Date: Mon, 17 Mar 2014 16:36:24 +0800
Message-ID: <000201cf41bc$250d00e0$6f2702a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should return error number of read_normal_summaries instead of -EINVAL when
read_normal_summaries failed.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b3f8431..6c5a4f0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1186,6 +1186,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 {
 	int type = CURSEG_HOT_DATA;
+	int err;
 
 	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG)) {
 		/* restore for compacted data summary */
@@ -1194,9 +1195,12 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 		type = CURSEG_HOT_NODE;
 	}
 
-	for (; type <= CURSEG_COLD_NODE; type++)
-		if (read_normal_summaries(sbi, type))
-			return -EINVAL;
+	for (; type <= CURSEG_COLD_NODE; type++) {
+		err = read_normal_summaries(sbi, type);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5
