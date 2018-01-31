From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: allow -p without value
Date: Tue, 30 Jan 2018 17:26:07 -0800
Message-ID: <20180131012607.85117-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eghAG-00015M-1b
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 01:26:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eghAF-0007Ox-8w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 01:26:15 +0000
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

This patch allows -p without value.

Suggested-by: Pavol Cupka <pavol.cupka@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index f35d01d..804f71a 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -184,13 +184,13 @@ void f2fs_parse_options(int argc, char *argv[])
 				 *  0: default level, the same as -a
 				 *  1: check meta
 				 */
-				if (optarg[0] == '-') {
+				if (optarg[0] == '-' || !is_digits(optarg) ||
+							optind == argc) {
+					MSG(0, "Info: Use default preen mode\n");
 					c.preen_mode = PREEN_MODE_0;
+					c.auto_fix = 1;
 					optind--;
 					break;
-				} else if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
-					break;
 				}
 				c.preen_mode = atoi(optarg);
 				if (c.preen_mode < 0)
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
