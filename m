From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: clean up with f2fs_encrypted_inode()
Date: Tue, 17 Jul 2018 20:41:47 +0800
Message-ID: <20180717124149.32523-3-yuchao0@huawei.com>
References: <20180717124149.32523-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717124149.32523-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d55fa25fc2f1..3a31b4e6d2dc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1607,7 +1607,7 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int flags = fi->i_flags;
 
-	if (file_is_encrypt(inode))
+	if (f2fs_encrypted_inode(inode))
 		flags |= F2FS_ENCRYPT_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		flags |= F2FS_INLINE_DATA_FL;
-- 
2.18.0.rc1
