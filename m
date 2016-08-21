From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: check return value of write_checkpoint during fstrim
Date: Sun, 21 Aug 2016 23:21:29 +0800
Message-ID: <1471792891-2388-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

During fstrim, if one of multiple write_checkpoint failed, break off and
return error number to caller.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a394012..020767c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1303,6 +1303,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		mutex_lock(&sbi->gc_mutex);
 		err = write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
+		if (err)
+			break;
 	}
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
-- 
2.7.2
