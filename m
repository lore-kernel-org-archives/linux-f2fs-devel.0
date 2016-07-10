From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: return proper error code
Date: Mon, 11 Jul 2016 07:20:36 +0800 (CST)
Message-ID: <74f6ce4.4fb.155d71ccc53.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1bMO2A-0003dx-DV
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Jul 2016 23:21:12 +0000
Received: from m15-62.126.com ([220.181.15.62])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bMO27-0004US-Vr for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Jul 2016 23:21:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When the length of file name is more than F2FS_NAME_LEN,
it should return -ENAMETOOLONG.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 28a5023..b225062 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -364,7 +364,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 
 	len = strlen(name);
 	if (len > F2FS_NAME_LEN)
-		return -ERANGE;
+		return -ENAMETOOLONG;
 
 	base_addr = read_all_xattrs(inode, ipage);
 	if (!base_addr)
@@ -458,7 +458,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	len = strlen(name);
 
 	if (len > F2FS_NAME_LEN)
-		return -ERANGE;
+		return -ENAMETOOLONG;
 
 	if (size > MAX_VALUE_LEN(inode))
 		return -E2BIG;
-- 
1.8.3.1
------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
