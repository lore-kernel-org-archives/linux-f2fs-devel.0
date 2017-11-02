From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 6/9] fsck.f2fs: introduce new option
 --dry-run
Date: Thu, 2 Nov 2017 11:56:09 +0800
Message-ID: <20171102035612.217263-7-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cL-0007FU-S5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:33 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eA6cK-00047j-87
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:33 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

With --dry-run enabled, fsck.f2fs will do all checks and "fixes" except
that all fixes will not be written to storage at last.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/main.c       | 14 +++++++++++++-
 include/f2fs_fs.h |  1 +
 lib/libf2fs.c     |  1 +
 lib/libf2fs_io.c  |  3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 93037e1..baa8efc 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -18,6 +18,7 @@
 #include "fsck.h"
 #include <libgen.h>
 #include <ctype.h>
+#include <getopt.h>
 
 struct f2fs_fsck gfsck;
 
@@ -30,6 +31,7 @@ void fsck_usage()
 	MSG(0, "  -f check/fix entire partition\n");
 	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
 	MSG(0, "  -t show directory tree\n");
+	MSG(0, "  --dry-run do not really fix corruptions\n");
 	exit(1);
 }
 
@@ -117,10 +119,20 @@ void f2fs_parse_options(int argc, char *argv[])
 
 	if (!strcmp("fsck.f2fs", prog)) {
 		const char *option_string = ":ad:fp:t";
+		int opt = 0;
+		struct option long_opt[] = {
+			{"dry-run", no_argument, 0, 1},
+			{0, 0, 0, 0}
+		};
 
 		c.func = FSCK;
-		while ((option = getopt(argc, argv, option_string)) != EOF) {
+		while ((option = getopt_long(argc, argv, option_string,
+						long_opt, &opt)) != EOF) {
 			switch (option) {
+			case 1:
+				c.dry_run = 1;
+				MSG(0, "Info: Dry run\n");
+				break;
 			case 'a':
 				c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index e1e299d..64a796d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -300,6 +300,7 @@ struct f2fs_configuration {
 	int trimmed;
 	int func;
 	void *private;
+	int dry_run;
 	int fix_on;
 	int bug_on;
 	int auto_fix;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 69f5ccc..259bd17 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -598,6 +598,7 @@ void f2fs_init_configuration(void)
 	c.trimmed = 0;
 	c.ro = 0;
 	c.kd = -1;
+	c.dry_run = 0;
 }
 
 static int is_mounted(const char *mpt, const char *device)
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 50ff171..8a79672 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -129,6 +129,9 @@ int dev_write(void *buf, __u64 offset, size_t len)
 {
 	int fd;
 
+	if (c.dry_run)
+		return 0;
+
 	if (c.sparse_mode)
 		return dev_write_sparse(buf, offset, len);
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
