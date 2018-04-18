From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: fix return value in f2fs_ioc_commit_atomic_write
Date: Wed, 18 Apr 2018 17:45:02 +0800
Message-ID: <20180418094505.98888-2-yuchao0@huawei.com>
References: <20180418094505.98888-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418094505.98888-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_ioc_commit_atomic_write, if file is volatile, return -EINVAL to
indicate that commit failure.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 408471bf4799..7c90ded5a431 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1726,8 +1726,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 
-	if (f2fs_is_volatile_file(inode))
+	if (f2fs_is_volatile_file(inode)) {
+		ret = -EINVAL;
 		goto err_out;
+	}
 
 	if (f2fs_is_atomic_file(inode)) {
 		ret = commit_inmem_pages(inode);
-- 
2.15.0.55.gc2ece9dc4de6
