From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: add -y for generic fsck
Date: Thu, 28 Dec 2017 18:00:18 -0800
Message-ID: <20171229020018.60350-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eUjyE-0005ZG-4A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 02:00:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eUjyD-0001Uz-CP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 02:00:26 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

-y is same as -f, which fixes any corruption all the time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index db5c413..f35d01d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -57,6 +57,7 @@ void fsck_usage()
 	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -t show directory tree\n");
 	MSG(0, "  -q preserve quota limits\n");
+	MSG(0, "  -y fix all the time\n");
 	MSG(0, "  --dry-run do not really fix corruptions\n");
 	exit(1);
 }
@@ -159,7 +160,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	}
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":ad:fp:q:St";
+		const char *option_string = ":ad:fp:q:Sty";
 		int opt = 0;
 		struct option long_opt[] = {
 			{"dry-run", no_argument, 0, 1},
@@ -213,6 +214,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
 				break;
 			case 'f':
+			case 'y':
 				c.fix_on = 1;
 				MSG(0, "Info: Force to fix corruption\n");
 				break;
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
