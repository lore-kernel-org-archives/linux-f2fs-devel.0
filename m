From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: avoid potential deadlock in f2fs_move_file_range
Date: Thu, 4 Aug 2016 20:13:03 +0800
Message-ID: <20160804121303.62766-2-yuchao0@huawei.com>
References: <20160804121303.62766-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804121303.62766-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Thread A			Thread B
- inode_lock fileA
				- inode_lock fileB
				 - inode_lock fileA
 - inode_lock fileB

We may encounter above potential deadlock during moving file range in
concurrent scenario. This patch fixes the issue by using inode_trylock
instead.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 409f0ec..ebf2703 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2169,8 +2169,12 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 		return -EOPNOTSUPP;
 
 	inode_lock(src);
-	if (src != dst)
-		inode_lock(dst);
+	if (src != dst) {
+		if (!inode_trylock(dst)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
@@ -2228,6 +2232,7 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 out_unlock:
 	if (src != dst)
 		inode_unlock(dst);
+out:
 	inode_unlock(src);
 	return ret;
 }
-- 
2.8.2.311.gee88674
