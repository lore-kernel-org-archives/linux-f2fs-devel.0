From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: check inject_rate validity during configuring
Date: Fri, 4 Jan 2019 17:39:53 +0800
Message-ID: <20190104093953.127286-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Type of inject_rate is unsigned int, let's check new value's
validity during configuring.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 0575edbe3ed6..02d4012a9183 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -222,6 +222,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
 		return -EINVAL;
+	if (a->struct_type == FAULT_INFO_RATE && t >= UINT_MAX)
+		return -EINVAL;
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-- 
2.18.0.rc1
