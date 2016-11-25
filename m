From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFT PATCH 1/2] fsck.f2fs: remove duplicated header files
Date: Fri, 25 Nov 2016 22:49:56 +0800
Message-ID: <58384F94.7010206@huawei.com>
References: <56969233.20161125013035@vodka.home.kg>
	<583792A0.2080209@huawei.com>
	<601891109.20161125115102@vodka.home.kg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cAHpr-0006O8-SR
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 14:50:43 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cAHpp-0004nm-JE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 14:50:43 +0000
In-Reply-To: <601891109.20161125115102@vodka.home.kg>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: k@vodka.home.kg, linux-f2fs-devel@lists.sourceforge.net, "jaegeuk@kernel.org >> Jaegeuk Kim" <jaegeuk@kernel.org>

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/f2fs.h  | 2 --
 fsck/xattr.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index fbb878a..1a0723c 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -19,8 +19,6 @@
 #include <string.h>
 #include <errno.h>
 #include <mntent.h>
-#include <linux/types.h>
-#include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
diff --git a/fsck/xattr.h b/fsck/xattr.h
index 3ca9133..b414629 100644
--- a/fsck/xattr.h
+++ b/fsck/xattr.h
@@ -16,7 +16,6 @@
 #ifndef _XATTR_H_
 #define _XATTR_H_

-#include <f2fs_fs.h>
 #include "f2fs.h"

 struct f2fs_xattr_header {
-- 
2.10.2


------------------------------------------------------------------------------
