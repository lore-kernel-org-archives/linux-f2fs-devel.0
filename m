From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH V3 2/2] mkfs.f2fs: avoid dumplicate extensions
Date: Sat, 28 Nov 2015 11:07:44 +0800
Message-ID: <56591A80.8030709@huawei.com>
References: <1448705988-29484-1-git-send-email-shengyong1@huawei.com>
	<1448705988-29484-2-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1a2VsC-0006oC-0D
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 03:08:28 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a2Vs8-0006Wt-Kr
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 03:08:27 +0000
In-Reply-To: <1448705988-29484-2-git-send-email-shengyong1@huawei.com>
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
is already in the list.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 mkfs/f2fs_format.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 176bdea..0a621ae 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -118,6 +118,21 @@ const char *media_ext_lists[] = {
 	NULL
 };

+static bool is_extension_exist(const char *name, const int len)
+{
+	int i, ret;
+
+	for (i = 0; i < F2FS_MAX_EXTENSION; i++) {
+		char *ext = (char *) sb.extension_list[i];
+		ret = strcmp(ext, name);
+
+		if (ret == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
 static void configure_extension_list(void)
 {
 	const char **extlist = media_ext_lists;
@@ -143,8 +158,14 @@ static void configure_extension_list(void)
 	/* add user ext list */
 	ue = strtok(ext_str, ",");
 	while (ue != NULL) {
+		strtrim(&ue);
 		name_len = strlen(ue);
-		memcpy(sb.extension_list[i++], ue, name_len);
+		if (name_len > 7) {
+			MSG(0, "\tError: Extension '%s' too long\n", ue);
+			exit(1);
+		}
+		if (!is_extension_exist(ue, name_len))
+			memcpy(sb.extension_list[i++], ue, name_len);
 		ue = strtok(NULL, ",");
 		if (i >= F2FS_MAX_EXTENSION)
 			break;
-- 
1.9.1



------------------------------------------------------------------------------
