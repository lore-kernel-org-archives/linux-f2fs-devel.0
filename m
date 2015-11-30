From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH V3 1/2] mkfs.f2fs: avoid dumplicate extensions
Date: Mon, 30 Nov 2015 10:41:06 +0000
Message-ID: <1448880067-9629-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1a3EdE-00076F-Ly
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Nov 2015 02:56:00 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a3EdB-0004Ce-Bb
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Nov 2015 02:56:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Before copying an user specified extension to extension_list, check if it
is already in the list. User specified extensions are delimitted by token
either ',' or ' '.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 mkfs/f2fs_format.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 176bdea..a29d7ef 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -118,6 +118,19 @@ const char *media_ext_lists[] = {
 	NULL
 };
 
+static bool is_extension_exist(const char *name)
+{
+	int i;
+
+	for (i = 0; i < F2FS_MAX_EXTENSION; i++) {
+		char *ext = (char *)sb.extension_list[i];
+		if (!strcmp(ext, name))
+			return 1;
+	}
+
+	return 0;
+}
+
 static void configure_extension_list(void)
 {
 	const char **extlist = media_ext_lists;
@@ -141,11 +154,12 @@ static void configure_extension_list(void)
 		return;
 
 	/* add user ext list */
-	ue = strtok(ext_str, ",");
+	ue = strtok(ext_str, ", ");
 	while (ue != NULL) {
 		name_len = strlen(ue);
-		memcpy(sb.extension_list[i++], ue, name_len);
-		ue = strtok(NULL, ",");
+		if (!is_extension_exist(ue))
+			memcpy(sb.extension_list[i++], ue, name_len);
+		ue = strtok(NULL, ", ");
 		if (i >= F2FS_MAX_EXTENSION)
 			break;
 	}
-- 
1.9.1


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741551&iu=/4140
