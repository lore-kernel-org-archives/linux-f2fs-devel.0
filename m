From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to detect failure of dquot_initialize
Date: Sat, 21 Apr 2018 17:53:52 +0800
Message-ID: <20180421095352.15175-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

dquot_initialize() can fail due to any exception inside quota subsystem,
f2fs needs to be aware of it, and return correct return value to caller.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a94531671217..5d710f7f2684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2581,7 +2581,9 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	}
 	f2fs_put_page(ipage, 1);
 
-	dquot_initialize(inode);
+	err = dquot_initialize(inode);
+	if (err)
+		goto out_unlock;
 
 	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
 	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-- 
2.15.0.55.gc2ece9dc4de6
