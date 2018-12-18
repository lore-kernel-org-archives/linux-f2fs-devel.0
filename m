From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to dirty inode synchronously
Date: Tue, 18 Dec 2018 19:20:17 +0800
Message-ID: <20181218112017.80555-2-yuchao0@huawei.com>
References: <20181218112017.80555-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218112017.80555-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If user change inode's i_flags via ioctl, let's add it into global
dirty list, so that checkpoint can guarantee its persistence before
fsync, it can make checkpoint keeping strong consistency.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca9bdbb8651b..7bf28be811ab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1685,7 +1685,7 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 
 	inode->i_ctime = current_time(inode);
 	f2fs_set_inode_flags(inode);
-	f2fs_mark_inode_dirty_sync(inode, false);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
 
-- 
2.18.0.rc1
