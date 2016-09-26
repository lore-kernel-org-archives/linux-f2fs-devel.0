From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: do fault injection initialization in
	default_options
Date: Mon, 26 Sep 2016 19:45:05 +0800
Message-ID: <20160926114506.20974-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1boULt-0000B9-OK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 11:45:41 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1boULn-0006jB-G2
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 11:45:41 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Do fault injection initialization in default_options to keep consistent
with other default option configurating.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4d5911b..aa35e60 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -364,10 +364,6 @@ static int parse_options(struct super_block *sb, char *options)
 	char *p, *name;
 	int arg = 0;
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	f2fs_build_fault_attr(sbi, 0);
-#endif
-
 	if (!options)
 		return 0;
 
@@ -991,6 +987,10 @@ static void default_options(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 	set_opt(sbi, POSIX_ACL);
 #endif
+
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	f2fs_build_fault_attr(sbi, 0);
+#endif
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
