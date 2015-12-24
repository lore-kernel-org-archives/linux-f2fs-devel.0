From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/5] f2fs: report readonly status in ->fsync
Date: Thu, 24 Dec 2015 18:07:25 +0800
Message-ID: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Report readonly status of filesystem during fsync.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2d87a3c..a60d088 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -197,7 +197,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	};
 
 	if (unlikely(f2fs_readonly(inode->i_sb)))
-		return 0;
+		return -EROFS;
 
 	trace_f2fs_sync_file_enter(inode);
 
-- 
2.6.3
