From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to clear CP_TRIMMED_FLAG
Date: Wed, 31 Jan 2018 09:30:34 +0800
Message-ID: <20180131013034.107225-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Once CP_TRIMMED_FLAG is set, after a reboot, we will never issue discard
before LBA becomes invalid again, fix it by clearing the flag in
checkpoint without CP_TRIMMED reason.

Fixes: 1f43e2ad7bff ("f2fs: introduce CP_TRIMMED_FLAG to avoid unneeded discard")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 998fe1d0213b..65becae99b84 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1166,6 +1166,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
 
 	if (cpc->reason & CP_UMOUNT)
 		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
-- 
2.15.0.55.gc2ece9dc4de6
