From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/19] f2fs: fix not to check IS_ERR for null pointer
Date: Fri,  1 May 2015 17:48:28 -0700
Message-ID: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The acl can have null, error pointer, or valid pointer.
So, we should check its pointer existence too.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index c8f25f7..851ff98 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -190,7 +190,7 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 		acl = ERR_PTR(retval);
 	kfree(value);
 
-	if (!IS_ERR(acl))
+	if (!IS_ERR_OR_NULL(acl))
 		set_cached_acl(inode, type, acl);
 
 	return acl;
-- 
2.1.1
