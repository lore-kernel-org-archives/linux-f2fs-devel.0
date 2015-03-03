From: Michael Lass <bevan@bi-co.net>
Subject: [PATCH] f2fstat: Fix option parsing
Date: Wed,  4 Mar 2015 00:42:17 +0100
Message-ID: <1425426137-4644-1-git-send-email-bevan@bi-co.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bevan@bi-co.net>) id 1YSwYj-000504-N0
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 23:49:05 +0000
Received: from voltaic.bi-co.net ([134.119.3.22])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YSwYg-00052q-QT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 23:49:05 +0000
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
Cc: Michael Lass <bevan@bi-co.net>

On systems using unsigned char as default (char)EOF != EOF.
Use int to store returned value of getopt to make it work on all platforms.

Signed-off-by: Michael Lass <bevan@bi-co.net>
---
 tools/f2fstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/f2fstat.c b/tools/f2fstat.c
index 8643797..7f485b0 100644
--- a/tools/f2fstat.c
+++ b/tools/f2fstat.c
@@ -191,7 +191,7 @@ void usage(void)
 
 void parse_option(int argc, char *argv[], struct options *opt)
 {
-	char option;
+	int option;
 	const char *option_string = "d:i:p:h";
 
 	while ((option = getopt(argc, argv, option_string)) != EOF) {
-- 
2.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
