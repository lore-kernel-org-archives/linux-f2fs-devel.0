From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: remove dead code f2fs_check_acl
Date: Wed, 14 Sep 2016 03:00:02 +0800 (CST)
Message-ID: <79ce9102.1cb.15724eb9757.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1bjswJ-0003KB-LU
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Sep 2016 19:00:15 +0000
Received: from m15-63.126.com ([220.181.15.63])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bjswH-0001pm-VY for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Sep 2016 19:00:15 +0000
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

The macro f2fs_check_acl is defined but never used since
the initial commit, this patch removes the code that has
been dead for several years.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/acl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index b2334d1..2c68518 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -41,7 +41,6 @@ extern int f2fs_set_acl(struct inode *, struct posix_acl *, int);
 extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
 							struct page *);
 #else
-#define f2fs_check_acl	NULL
 #define f2fs_get_acl	NULL
 #define f2fs_set_acl	NULL
 
-- 
1.8.3.1
------------------------------------------------------------------------------
