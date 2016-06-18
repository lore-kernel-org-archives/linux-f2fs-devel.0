From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: avoid latency-critical readahead of
	node pages
Date: Fri, 17 Jun 2016 18:03:46 -0700
Message-ID: <20160618010346.17794-3-jaegeuk@kernel.org>
References: <20160618010346.17794-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bE4g2-0003so-BR
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Jun 2016 01:03:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bE4g1-0000Tx-Gy
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Jun 2016 01:03:58 +0000
In-Reply-To: <20160618010346.17794-1-jaegeuk@kernel.org>
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

The f2fs_map_blocks is very related to the performance, so let's avoid any
latency to read ahead node pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 fs/f2fs/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0832528..ba4963f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -652,7 +652,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
+	int mode = create ? ALLOC_NODE : LOOKUP_NODE;
 	pgoff_t pgofs, end_offset, end;
 	int err = 0, ofs = 1;
 	unsigned int ofs_in_node, last_ofs_in_node;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1f78fb..4e220ba 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -356,7 +356,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 	for (; data_ofs < isize; data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, pgofs, LOOKUP_NODE_RA);
+		err = get_dnode_of_data(&dn, pgofs, LOOKUP_NODE);
 		if (err && err != -ENOENT) {
 			goto fail;
 		} else if (err == -ENOENT) {
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://sdm.link/zohomanageengine
