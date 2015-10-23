From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: support a preen mode
Date: Fri, 23 Oct 2015 14:05:40 -0700
Message-ID: <1445634340-17915-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZpjYS-0004an-4N
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Oct 2015 21:07:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZpjYR-0007dw-9c for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Oct 2015 21:07:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Generic fsck uses -p, preen mode, and fsck.f2fs can support it as -a for now.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index b5ad46e..844ee8a 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -20,6 +20,7 @@ void fsck_usage()
 	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
+	MSG(0, "  -p preen mode [default is same as -a]\n");
 	MSG(0, "  -t show directory tree [-d -1]\n");
 	exit(1);
 }
@@ -43,12 +44,13 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "ad:ft";
+		const char *option_string = "ad:fpt";
 
 		config.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
 			case 'a':
+			case 'p':
 				config.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
 				break;
-- 
2.1.1


------------------------------------------------------------------------------
