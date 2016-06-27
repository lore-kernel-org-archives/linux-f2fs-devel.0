From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: remove unnecessary goto statement
Date: Tue, 28 Jun 2016 07:27:59 +0800 (CST)
Message-ID: <76d0a86c.637.1559430e066.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1bHfwr-0003IY-QH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jun 2016 23:28:14 +0000
Received: from m15-43.126.com ([220.181.15.43])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bHfwp-00048U-VF for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jun 2016 23:28:13 +0000
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

When base_addr is NULL, there is no need to call kzfree,
it should return -ENOMEM directly. Additionally, it is
better to initialize variable 'error' with 0.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 5564e0f..e530254 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -447,7 +447,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	int found, newsize;
 	size_t len;
 	__u32 new_hsize;
-	int error = -ENOMEM;
+	int error = 0;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -465,7 +465,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 
 	base_addr = read_all_xattrs(inode, ipage);
 	if (!base_addr)
-		goto exit;
+		return -ENOMEM;
 
 	/* find entry with wanted name. */
 	here = __find_xattr(base_addr, index, len, name);
-- 
1.8.3.1
------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
