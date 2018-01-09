From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: [PATCH] f2fs: correct removexattr behavior for null
 valued extended attribute
Date: Tue, 09 Jan 2018 09:22:57 +0900
Message-ID: <1515457377-20597-1-git-send-email-daeho.jeong@samsung.com>
References: <CGME20180109002241epcas1p46c06112eb4a2beef7ca377cbfe3b6e33@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daeho.jeong@samsung.com>) id 1eYhgq-0002f9-99
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 00:22:52 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYhgn-0007l4-S0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 00:22:52 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20180109002242epoutp03ced7bcd065fffa4dbad774621aecaa0c~H-HEj2IUc2324923249epoutp03D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Jan 2018 00:22:42 +0000 (GMT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Youngjin Gil <youngjin.gil@samsung.com>

__vfs_removexattr() transfers "NULL" value to the setxattr handler of
the f2fs filesystem in order to remove the extended attribute. But,
__f2fs_setxattr() just ignores the removal request when the value of
the extended attribute is already NULL. We have to remove the extended
attribute itself even if the value of that is already NULL.

Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
Tested-by: Hobin Woo <hobin.woo@samsung.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ec8961e..2776618 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -598,7 +598,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			goto exit;
 		}
 
-		if (f2fs_xattr_value_same(here, value, size))
+		if (value && f2fs_xattr_value_same(here, value, size))
 			goto exit;
 	} else if ((flags & XATTR_REPLACE)) {
 		error = -ENODATA;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
