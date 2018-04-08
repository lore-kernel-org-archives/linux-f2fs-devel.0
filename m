From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] mkfs.f2fs: introduce new option V to show version
Date: Sun, 8 Apr 2018 10:15:06 +0800
Message-ID: <20180408021506.26500-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1f4zrm-0001Y9-7d
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 02:15:38 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f4zrh-009UOY-Ad
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 02:15:38 +0000
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
Cc: ebiggers@google.com, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new option -V to show the version of mkfs.f2fs
and exit after that.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 mkfs/f2fs_format_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 3c70513..3520882 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -58,6 +58,7 @@ static void mkfs_usage()
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
 	MSG(0, "  -w wanted sector size\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
+	MSG(0, "  -V print the version number and exit\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
@@ -136,7 +137,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:fw:";
+	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:fw:V";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -209,6 +210,10 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'w':
 			c.wanted_sector_size = atoi(optarg);
 			break;
+		case 'V':
+			MSG(0, "mkfs.f2fs %s (%s)\n",
+					F2FS_TOOLS_VERSION, F2FS_TOOLS_DATE);
+			exit(0);
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
 			mkfs_usage();
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
