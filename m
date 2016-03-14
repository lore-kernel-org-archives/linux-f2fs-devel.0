From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] f2fs: add missing argument to f2fs_setxattr stub
Date: Tue, 15 Mar 2016 00:07:56 +0100
Message-ID: <1457996891-1968923-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <arnd@arndb.de>) id 1afbbG-0006XJ-5v
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 23:08:34 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1afbbF-00057a-2Q for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 23:08:34 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-f2fs-devel@lists.sourceforge.net

The f2fs_setxattr() prototype for CONFIG_F2FS_FS_XATTR=n has
been wrong for a long time, since 8ae8f1627f39 ("f2fs: support
xattr security labels"), but there have never been any callers,
so it did not matter.

Now, the function gets called from f2fs_ioc_keyctl(), which
causes a build failure:

fs/f2fs/file.c: In function 'f2fs_ioc_keyctl':
include/linux/stddef.h:7:14: error: passing argument 6 of 'f2fs_setxattr' makes integer from pointer without a cast [-Werror=int-conversion]
 #define NULL ((void *)0)
              ^
fs/f2fs/file.c:1599:27: note: in expansion of macro 'NULL'
     value, F2FS_KEY_SIZE, NULL, type);
                           ^
In file included from ../fs/f2fs/file.c:29:0:
fs/f2fs/xattr.h:129:19: note: expected 'int' but argument is of type 'void *'
 static inline int f2fs_setxattr(struct inode *inode, int index,
                   ^
fs/f2fs/file.c:1597:9: error: too many arguments to function 'f2fs_setxattr'
  return f2fs_setxattr(inode, F2FS_XATTR_INDEX_KEY,
         ^
In file included from ../fs/f2fs/file.c:29:0:
fs/f2fs/xattr.h:129:19: note: declared here
 static inline int f2fs_setxattr(struct inode *inode, int index,

Thsi changes the prototype of the empty stub function to match
that of the actual implementation. This will not make the key
management work when F2FS_FS_XATTR is disabled, but it gets it
to build at least.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1448eee67def ("f2fs: support access control via key management")
---
 fs/f2fs/xattr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index cb5282c9ce44..2f4908425d13 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -127,7 +127,8 @@ extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
 
 #define f2fs_xattr_handlers	NULL
 static inline int f2fs_setxattr(struct inode *inode, int index,
-		const char *name, const void *value, size_t size, int flags)
+		const char *name, const void *value, size_t size,
+		struct page *page, int flags)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.7.0


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
