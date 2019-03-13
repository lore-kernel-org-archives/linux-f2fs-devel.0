From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set pin_file under CAP_SYS_ADMIN
Date: Wed, 13 Mar 2019 16:16:19 -0700
Message-ID: <20190313231619.31453-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Android uses pin_file for uncrypt during OTA, and that should be managed by
CAP_SYS_ADMIN only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 807a97ad2430..012815d816e6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2873,8 +2873,8 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 
 	if (get_user(pin, (__u32 __user *)arg))
 		return -EFAULT;
-- 
2.19.0.605.g01d371f741-goog
