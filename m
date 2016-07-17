From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: avoid memory allocation failure due to
	a long length
Date: Sat, 16 Jul 2016 23:24:25 -0700
Message-ID: <20160717062427.56718-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bOfVF-0006ya-20
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 17 Jul 2016 06:24:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bOfVE-0003zl-7j
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 17 Jul 2016 06:24:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We need to avoid ENOMEM due to unexpected long length.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 17b3059..3573b07 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1039,33 +1039,43 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 
 static int __exchange_data_block(struct inode *src_inode,
 			struct inode *dst_inode, pgoff_t src, pgoff_t dst,
-			int len, bool full)
+			pgoff_t len, bool full)
 {
 	block_t *src_blkaddr;
 	int *do_replace;
+	pgoff_t olen;
 	int ret;
 
-	src_blkaddr = f2fs_kvzalloc(sizeof(block_t) * len, GFP_KERNEL);
-	if (!src_blkaddr)
-		return -ENOMEM;
+	while (len) {
+		olen = min((pgoff_t)4 * ADDRS_PER_BLOCK, len);
 
-	do_replace = f2fs_kvzalloc(sizeof(int) * len, GFP_KERNEL);
-	if (!do_replace) {
-		kvfree(src_blkaddr);
-		return -ENOMEM;
-	}
+		src_blkaddr = f2fs_kvzalloc(sizeof(block_t) * olen, GFP_KERNEL);
+		if (!src_blkaddr)
+			return -ENOMEM;
 
-	ret = __read_out_blkaddrs(src_inode, src_blkaddr, do_replace, src, len);
-	if (ret)
-		goto roll_back;
+		do_replace = f2fs_kvzalloc(sizeof(int) * olen, GFP_KERNEL);
+		if (!do_replace) {
+			kvfree(src_blkaddr);
+			return -ENOMEM;
+		}
 
-	ret = __clone_blkaddrs(src_inode, dst_inode, src_blkaddr,
-					do_replace, src, dst, len, full);
-	if (ret)
-		goto roll_back;
+		ret = __read_out_blkaddrs(src_inode, src_blkaddr,
+					do_replace, src, olen);
+		if (ret)
+			goto roll_back;
 
-	kvfree(src_blkaddr);
-	kvfree(do_replace);
+		ret = __clone_blkaddrs(src_inode, dst_inode, src_blkaddr,
+					do_replace, src, dst, olen, full);
+		if (ret)
+			goto roll_back;
+
+		src += olen;
+		dst += olen;
+		len -= olen;
+
+		kvfree(src_blkaddr);
+		kvfree(do_replace);
+	}
 	return 0;
 
 roll_back:
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
