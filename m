From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 1/1] f2fs: release locks before return in f2fs_ioc_gc_range()
Date: Tue, 13 Mar 2018 19:42:50 +0800
Message-ID: <20180313114250.29211-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: sunqiuyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Qiuyang Sun <sunqiuyang@huawei.com>

Currently, we will leave the kernel with locks still held when the gc_range
is invalid. This patch fixes the bug.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c4c27e6..ee88058 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2059,8 +2059,10 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		return ret;
 
 	end = range.start + range.len;
-	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi))
-		return -EINVAL;
+	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
+		ret = -EINVAL;
+		goto out;
+	}
 do_more:
 	if (!range.sync) {
 		if (!mutex_trylock(&sbi->gc_mutex)) {
-- 
2.5.0
