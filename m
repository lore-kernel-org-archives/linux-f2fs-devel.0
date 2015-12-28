From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: use i_size_read to get i_size
Date: Mon, 28 Dec 2015 15:31:36 -0800
Message-ID: <1451345497-65784-2-git-send-email-jaegeuk@kernel.org>
References: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aDhGU-00079c-Qx
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 23:31:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aDhGU-00043F-4D for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 23:31:46 +0000
In-Reply-To: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
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

We need to use i_size_read() to get inode->i_size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f34f42a..8a89810 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1386,10 +1386,11 @@ skip_write:
 static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
+	loff_t i_size = i_size_read(inode);
 
-	if (to > inode->i_size) {
-		truncate_pagecache(inode, inode->i_size);
-		truncate_blocks(inode, inode->i_size, true);
+	if (to > i_size) {
+		truncate_pagecache(inode, i_size);
+		truncate_blocks(inode, i_size, true);
 	}
 }
 
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
