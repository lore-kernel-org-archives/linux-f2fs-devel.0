From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH] f2fs: avoid duplicated permission check for "trusted." xattrs
Date: Thu, 19 Jul 2018 09:23:57 +0900
Message-ID: <20180719002357.9882-1-hyc.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

Because xattr_permission already checks CAP_SYS_ADMIN
capability, we don't need to check it.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 fs/f2fs/xattr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 708271871f94..4b34244dcc69 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -37,9 +37,6 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case F2FS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		break;
 	case F2FS_XATTR_INDEX_SECURITY:
 		break;
 	default:
@@ -62,9 +59,6 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case F2FS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		break;
 	case F2FS_XATTR_INDEX_SECURITY:
 		break;
 	default:
-- 
2.17.1
