From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] Revert "mkfs.f2fs: 512 UTF-16 characters for
	label"
Date: Fri,  3 Apr 2015 16:00:37 -0700
Message-ID: <1428102037-26583-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YeAa1-0001ij-M6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 23:00:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YeAZz-0000Jy-SF for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Apr 2015 23:00:49 +0000
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

The mkfs.f2fs gets 512 characters, which will be recorded as UTF-16 characters.

This reverts commit fb5eef1d7e4060d9c5a913514c49b260c29d3ed2.
---
 mkfs/f2fs_format_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 43e5c03..9a96798 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -81,9 +81,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 			config.extension_list = strdup(optarg);
 			break;
 		case 'l':		/*v: volume label */
-			if (strlen(optarg) > 1024) {
+			if (strlen(optarg) > 512) {
 				MSG(0, "Error: Volume Label should be less than\
-						512 UTF-16 characters\n");
+						512 characters\n");
 				mkfs_usage();
 			}
 			config.vol_label = optarg;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
