From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix to allow node segment for GC by ioctl
 path
Date: Fri, 23 Nov 2018 10:42:22 +0530
Message-ID: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1gQ3lm-0003MT-Tg
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Nov 2018 05:12:46 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gQ3ll-00Db68-G1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Nov 2018 05:12:46 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Allow node type segments also to be GC'd via f2fs ioctls
F2FS_IOC_GARBAGE_COLLECT and F2FS_IOC_GARBAGE_COLLECT_RANGE.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241f..e4689c6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	p.min_cost = get_max_cost(sbi, &p);
 
 	if (*result != NULL_SEGNO) {
-		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
-			get_valid_blocks(sbi, *result, false) &&
+		if (get_valid_blocks(sbi, *result, false) &&
 			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
 			p.min_segno = *result;
 		goto out;
@@ -404,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		}
 		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 
+	}
+out:
+	if (p.min_segno != NULL_SEGNO)
 		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
 				sbi->cur_victim_sec,
 				prefree_segments(sbi), free_segments(sbi));
-	}
-out:
 	mutex_unlock(&dirty_i->seglist_lock);
 
 	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
