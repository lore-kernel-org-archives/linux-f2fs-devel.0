From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: flush dirty data for bmap
Date: Mon, 19 Oct 2015 11:48:40 -0700
Message-ID: <1445280521-25973-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZoFUL-0002oO-Sq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:48:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZoFUK-0000Yy-Fv for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:48:53 +0000
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

Users expect bmap will give allocated block addresses.
Let's play likewise ext4.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77dfc9e..b052e7c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1667,12 +1667,13 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 
-	/* we don't need to use inline_data strictly */
-	if (f2fs_has_inline_data(inode)) {
-		int err = f2fs_convert_inline_inode(inode);
-		if (err)
-			return err;
-	}
+	if (f2fs_has_inline_data(inode))
+		return 0;
+
+	/* make sure allocating whole blocks */
+	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		filemap_write_and_wait(mapping);
+
 	return generic_block_bmap(mapping, block, get_data_block_bmap);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
