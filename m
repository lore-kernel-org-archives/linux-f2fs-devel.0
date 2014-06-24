From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/4] f2fs: remove the redundant validation check of acl
Date: Tue, 24 Jun 2014 18:18:14 +0800
Message-ID: <53A95066.3090401@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?B?7J207LC966eM?= <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

>From the userspace side, VFS layer does the check; and from the
kernel side(xx_init_acl), the acl is get/cloned from the parent dir's,
which is credible. So remove the redundant validation check of acl
here.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/acl.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index dbe2141..83b9b5a 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -203,12 +203,6 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	size_t size = 0;
 	int error;
 
-	if (acl) {
-		error = posix_acl_valid(acl);
-		if (error < 0)
-			return error;
-	}
-
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
-- 
1.7.7

