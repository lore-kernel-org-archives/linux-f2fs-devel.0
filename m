From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/2] fsck.f2fs: support -p without argument
Date: Thu, 19 Jan 2017 11:03:41 +0800
Message-ID: <20170119030341.12636-2-shengyong1@huawei.com>
References: <20170119030341.12636-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cU3C0-0000QA-SQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 03:15:16 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cU3By-0005Gb-B2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 03:15:16 +0000
In-Reply-To: <20170119030341.12636-1-shengyong1@huawei.com>
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
Cc: k@vodka.home.kg, piotr.karbowski@gmail.com, linux-f2fs-devel@lists.sourceforge.net

This patch allows fsck run -p without argument. So we could use -p as
-p, -p0, and -p1. '-p' and '-p0' have the same meaning as '-a'.
'-p1' checks more meta data than '-a'.

Reported-by: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 64537cc..78d10fa 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -83,7 +83,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "ad:fp:t";
+		const char *option_string = "ad:fp::t";
 
 		c.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -97,11 +97,15 @@ void f2fs_parse_options(int argc, char *argv[])
 				 *  0: default level, the same as -a
 				 *  1: check meta
 				 */
-				c.preen_mode = atoi(optarg);
-				if (c.preen_mode < 0)
+				if (optarg == NULL) {
 					c.preen_mode = PREEN_MODE_0;
-				else if (c.preen_mode >= PREEN_MODE_MAX)
-					c.preen_mode = PREEN_MODE_MAX - 1;
+				} else {
+					c.preen_mode = atoi(optarg);
+					if (c.preen_mode < 0)
+						c.preen_mode = PREEN_MODE_0;
+					else if (c.preen_mode >= PREEN_MODE_MAX)
+						c.preen_mode = PREEN_MODE_MAX - 1;
+				}
 				if (c.preen_mode == PREEN_MODE_0)
 					c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption in "
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
