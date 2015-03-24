From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] mkfs.f2fs: 512 UTF-16 characters for label
Date: Tue, 24 Mar 2015 00:37:04 -0700
Message-ID: <1427182624-40539-2-git-send-email-jaegeuk@kernel.org>
References: <1427182624-40539-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YaJOk-0005do-8p
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 07:37:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YaJOj-0002d0-8o for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 07:37:14 +0000
In-Reply-To: <1427182624-40539-1-git-send-email-jaegeuk@kernel.org>
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

We can use 512 UTF-16 characters for label.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 9a96798..43e5c03 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -81,9 +81,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 			config.extension_list = strdup(optarg);
 			break;
 		case 'l':		/*v: volume label */
-			if (strlen(optarg) > 512) {
+			if (strlen(optarg) > 1024) {
 				MSG(0, "Error: Volume Label should be less than\
-						512 characters\n");
+						512 UTF-16 characters\n");
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
