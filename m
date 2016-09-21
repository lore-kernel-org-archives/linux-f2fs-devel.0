From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] mkfs.f2fs: do not need strdup for parse_feature
Date: Wed, 21 Sep 2016 18:09:18 +0800
Message-ID: <1474452558-6490-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yunlong.song@huawei.com>) id 1bmeJO-0007IZ-0g
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 09:59:30 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bmeJJ-0003Yq-2y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 09:59:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

strdup is useless here, with no free op with its return value.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 mkfs/f2fs_format_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8a7b604..40ccdc7 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -60,7 +60,7 @@ static void f2fs_show_info()
 	MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
 }
 
-static void parse_feature(char *features)
+static void parse_feature(const char *features)
 {
 	if (!strcmp(features, "encrypt")) {
 		config.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
@@ -104,7 +104,7 @@ static void f2fs_parse_options(int argc, char *argv[])
 			config.overprovision = atof(optarg);
 			break;
 		case 'O':
-			parse_feature(strdup(optarg));
+			parse_feature(optarg);
 			break;
 		case 's':
 			config.segs_per_sec = atoi(optarg);
-- 
1.8.5.2


------------------------------------------------------------------------------
