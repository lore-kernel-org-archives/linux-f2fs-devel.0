From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs-tools: create sparse file first before
 stat
Date: Thu, 15 Nov 2018 22:06:03 -0800
Message-ID: <20181116060603.51965-2-jaegeuk@kernel.org>
References: <20181116060603.51965-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gNXGg-0008Ic-EO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Nov 2018 06:06:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gNXGe-00AbhO-Nb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Nov 2018 06:06:14 +0000
In-Reply-To: <20181116060603.51965-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We must create a sparse file first before calling stat().

Fixes: eb9d8037ed3b ("f2fs-tools: avoid mounting f2fs if tools already open the device")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index bf2830d..a1a5c02 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -793,17 +793,24 @@ int get_device_info(int i)
 #endif
 	struct device_info *dev = c.devices + i;
 
+	if (c.sparse_mode) {
+		fd = open(dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
+		if (fd < 0) {
+			MSG(0, "\tError: Failed to open a sparse file!\n");
+			return -1;
+		}
+	}
+
 	stat_buf = malloc(sizeof(struct stat));
 	ASSERT(stat_buf);
-	if (stat(dev->path, stat_buf) < 0 ) {
-		MSG(0, "\tError: Failed to get the device stat!\n");
-		free(stat_buf);
-		return -1;
-	}
 
-	if (c.sparse_mode) {
-		fd = open(dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
-	} else {
+	if (!c.sparse_mode) {
+		if (stat(dev->path, stat_buf) < 0 ) {
+			MSG(0, "\tError: Failed to get the device stat!\n");
+			free(stat_buf);
+			return -1;
+		}
+
 		if (S_ISBLK(stat_buf->st_mode))
 			fd = open(dev->path, O_RDWR | O_EXCL);
 		else
-- 
2.19.0.605.g01d371f741-goog
