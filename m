From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: show elapsed time of full scan
Date: Wed, 22 May 2019 12:41:41 -0700
Message-ID: <20190522194141.91216-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hTX7V-0004JC-II
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 May 2019 19:41:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hTX7U-000J9A-H6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 May 2019 19:41:49 +0000
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

This patch introduces the elapsed time of fsck.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index d844820..9aca024 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -18,6 +18,7 @@
 #include "fsck.h"
 #include <libgen.h>
 #include <ctype.h>
+#include <time.h>
 #include <getopt.h>
 #include "quotaio.h"
 
@@ -745,6 +746,7 @@ int main(int argc, char **argv)
 {
 	struct f2fs_sb_info *sbi;
 	int ret = 0;
+	clock_t start = clock();
 
 	f2fs_init_configuration();
 
@@ -853,7 +855,7 @@ retry:
 	if (ret < 0)
 		return ret;
 
-	printf("\nDone.\n");
+	printf("\nDone: %lf secs\n", (clock() - start) / (double)CLOCKS_PER_SEC);
 	return 0;
 
 out_err:
-- 
2.19.0.605.g01d371f741-goog
