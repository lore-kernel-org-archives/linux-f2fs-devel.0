From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix calculating incorrect free size when
 update xattr in __f2fs_setxattr
Date: Tue, 29 Oct 2013 14:17:05 +0800
Message-ID: <001e01ced46e$b9f538f0$2ddfaad0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?J8y35q0n?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

During xattr updating, free size should be corrected to remainder free size
+ old entry size.
It can avoid ENOSPC error when we update old entry with the same size new
entry at fully filled xattr.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f685138..35eb478 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -520,7 +520,7 @@ static int __f2fs_setxattr(struct inode *inode, int
name_index,
 		 */
 		free = MIN_OFFSET(inode) - ((char *)last - (char
*)base_addr);
 		if (found)
-			free = free - ENTRY_SIZE(here);
+			free = free + ENTRY_SIZE(here);
 
 		if (free < newsize) {
 			error = -ENOSPC;
-- 
1.7.9.5

