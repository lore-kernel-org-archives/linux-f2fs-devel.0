From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] libf2fs: fix to detect stat() failure
Date: Mon, 10 Dec 2018 18:13:33 +0800
Message-ID: <20181210101333.111826-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gWIaA-0008Qq-HQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 10:14:34 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWIZq-009xqQ-4A
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 10:14:34 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

stat() can fail due to a lot of reasons, let f2fs_dev_is_umounted()
detect such error and handle it correctly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 lib/libf2fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index c692bf2da635..6a1040feff32 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -713,7 +713,14 @@ int f2fs_dev_is_umounted(char *path)
 	st_buf = malloc(sizeof(struct stat));
 	ASSERT(st_buf);
 
-	if (stat(path, st_buf) == 0 && S_ISBLK(st_buf->st_mode)) {
+	ret = stat(path, st_buf);
+	if (ret) {
+		MSG(0, "\tError: stat %s failed!\n", path);
+		free(st_buf);
+		return -1;
+	}
+
+	if (S_ISBLK(st_buf->st_mode)) {
 		int fd = open(path, O_RDONLY | O_EXCL);
 
 		if (fd >= 0) {
-- 
2.18.0.rc1
