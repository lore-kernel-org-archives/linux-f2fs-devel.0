From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs:  fix a bug of inheriting default ACL from parent
Date: Sat, 24 Jan 2015 17:06:25 +0800
Message-ID: <54C36091.4000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Introduced by a6dda0e63e97122ce9e0ba04367e37cca28315fa
"f2fs: use generic posix ACL infrastructure".

When testing default acl, gets in recent kernel (3.19.0-rc5),
# setfacl -dm g:root:rwx test/
# getfacl test/
# file: test/
# owner: root
# group: root
user::rwx
group::r-x
other::r-x
default:user::rwx
default:group::r-x
default:group:root:rwx
default:mask::rwx
default:other::r-x

# cd test/
# mkdir testdir
]# getfacl testdir/
# file: testdir/
# owner: root
# group: root
user::rwx
group::rwx
                // missing an acl "group:root:rwx" inherited from parent
other::r-x
default:user::rwx
default:group::r-x
default:group:root:rwx
default:mask::rwx
default:other::r-x

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 1ccb26b..b0b23578 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -396,7 +396,7 @@ int f2fs_init_acl(struct inode *inode, struct inode 
*dir, struct page *ipage,
 		posix_acl_release(default_acl);
 	}
 	if (acl) {
-		if (error)
+		if (!error)
 			error = __f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl,
 					       ipage);
 		posix_acl_release(acl);
-- 
2.1.0

