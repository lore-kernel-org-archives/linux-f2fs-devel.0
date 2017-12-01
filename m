From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs-tools: allow multiple prog names
Date: Thu, 30 Nov 2017 21:51:55 -0800
Message-ID: <20171201055157.72846-4-jaegeuk@kernel.org>
References: <20171201055157.72846-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKeFH-0003I3-On
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKeFH-0004B2-4H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:19 +0000
In-Reply-To: <20171201055157.72846-1-jaegeuk@kernel.org>
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

This patch allows different prog names like fsck_f2fs, sload_f2fs, etc for
android.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 9d9cc0c..ba247d4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -113,7 +113,15 @@ void f2fs_parse_options(int argc, char *argv[])
 	int option = 0;
 	char *prog = basename(argv[0]);
 	int err = NOERROR;
+#ifdef WITH_ANDROID
+	int i;
 
+	/* Allow prog names (e.g, sload_f2fs, fsck_f2fs, etc) */
+	for (i = 0; i < strlen(prog); i++) {
+		if (prog[i] == '_')
+			prog[i] = '.';
+	}
+#endif
 	if (argc < 2) {
 		MSG(0, "\tError: Device not specified\n");
 		error_out(prog);
-- 
2.15.0.403.gc27cc4dac6-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
