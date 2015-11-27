From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH] mkfs.f2fs: avoid dumplicate extension
Date: Fri, 27 Nov 2015 16:55:12 +0000
Message-ID: <1448643312-28861-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1a2F2f-0001EG-6P
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Nov 2015 09:10:09 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a2F2b-0000eV-Kn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Nov 2015 09:10:09 +0000
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

Before copying user specified extension to extension_list, check if it is
already in the list.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 mkfs/f2fs_format.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 176bdea..b7ea19f 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -118,6 +118,26 @@ const char *media_ext_lists[] = {
 	NULL
 };
 
+static int extension_exist(const char *name, const int len)
+{
+	const char **extlist = media_ext_lists;
+	int name_len, min_len;
+	int ret;
+
+
+	while (*extlist) {
+		name_len = strlen(*extlist);
+		min_len = name_len < len ? name_len : len;
+		ret = strncmp(*extlist, name, min_len);
+
+		if (ret == 0 && name_len == len)
+			return 1;
+		extlist++;
+	}
+
+	return 0;
+}
+
 static void configure_extension_list(void)
 {
 	const char **extlist = media_ext_lists;
@@ -144,7 +164,8 @@ static void configure_extension_list(void)
 	ue = strtok(ext_str, ",");
 	while (ue != NULL) {
 		name_len = strlen(ue);
-		memcpy(sb.extension_list[i++], ue, name_len);
+		if (!extension_exist(ue, name_len))
+			memcpy(sb.extension_list[i++], ue, name_len);
 		ue = strtok(NULL, ",");
 		if (i >= F2FS_MAX_EXTENSION)
 			break;
-- 
1.9.1


------------------------------------------------------------------------------
