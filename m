From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH V3 2/2] mkfs.f2fs: skip extension name that is
	too long
Date: Mon, 30 Nov 2015 10:41:07 +0000
Message-ID: <1448880067-9629-2-git-send-email-shengyong1@huawei.com>
References: <1448880067-9629-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1a3EdF-0001NJ-CA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Nov 2015 02:56:01 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a3EdC-0006rL-SH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Nov 2015 02:56:01 +0000
In-Reply-To: <1448880067-9629-1-git-send-email-shengyong1@huawei.com>
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

From: Chao Yu <chao2.yu@samsung.com>

The length of extension name has a limit of 8 bytes. If an extension
exceeds the limitation, it will not be added to the extension_list.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 mkfs/f2fs_format.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a29d7ef..212df60 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -157,8 +157,13 @@ static void configure_extension_list(void)
 	ue = strtok(ext_str, ", ");
 	while (ue != NULL) {
 		name_len = strlen(ue);
+		if (name_len >= 8) {
+			MSG(0, "\tWarn: Extension name (%s) is too long\n", ue);
+			goto next;
+		}
 		if (!is_extension_exist(ue))
 			memcpy(sb.extension_list[i++], ue, name_len);
+next:
 		ue = strtok(NULL, ", ");
 		if (i >= F2FS_MAX_EXTENSION)
 			break;
-- 
1.9.1


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741551&iu=/4140
