From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] dump.f2fs: allow dump data on mounted image
Date: Sun, 30 Sep 2018 16:26:13 +0800
Message-ID: <20180930082613.106905-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g6X3o-0005jc-BC
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Sep 2018 08:26:40 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g6X3m-009VsO-4J
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Sep 2018 08:26:40 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

xfstests assumes it's allow to dump data on mounted image, for example,
some common functions call dumpe2fs on mounted ext[2|3|4] image to check
feature lists. To adapt such requirement, let's follow that rule in
dump.f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index e20f31ca09e4..675c603b1a76 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -744,7 +744,7 @@ int main(int argc, char **argv)
 
 	f2fs_parse_options(argc, argv);
 
-	if (f2fs_devs_are_umounted() < 0) {
+	if (c.func != DUMP && f2fs_devs_are_umounted() < 0) {
 		if (errno == EBUSY)
 			return -1;
 		if (!c.ro || c.func == DEFRAG) {
-- 
2.18.0.rc1
