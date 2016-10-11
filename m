From: Chao Yu <chao@kernel.org>
Subject: [PATCH 6/8] f2fs: be aware of extent beyond EOF in fiemap
Date: Tue, 11 Oct 2016 22:57:04 +0800
Message-ID: <20161011145706.5028-6-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyWo-00052u-Jx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWn-0001lh-PF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:38 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

f2fs can support fallocating blocks beyond file size without changing the
size, but ->fiemap of f2fs was restricted and can't detect these extents
fallocated past EOF, now relieve the restriction.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index edfd2de..983aa54e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -886,7 +886,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	struct buffer_head map_bh;
 	sector_t start_blk, last_blk;
 	pgoff_t next_pgofs;
-	loff_t isize;
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
 	int ret = 0;
@@ -903,13 +902,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	inode_lock(inode);
 
-	isize = i_size_read(inode);
-	if (start >= isize)
-		goto out;
-
-	if (start + len > isize)
-		len = isize - start;
-
 	if (logical_to_blk(inode, len) == 0)
 		len = blk_to_logical(inode, 1);
 
@@ -928,13 +920,11 @@ next:
 	/* HOLE */
 	if (!buffer_mapped(&map_bh)) {
 		start_blk = next_pgofs;
-		/* Go through holes util pass the EOF */
-		if (blk_to_logical(inode, start_blk) < isize)
+
+		if (blk_to_logical(inode, start_blk) < blk_to_logical(inode,
+					F2FS_I_SB(inode)->max_file_blocks))
 			goto prep_next;
-		/* Found a hole beyond isize means no more extents.
-		 * Note that the premise is that filesystems don't
-		 * punch holes beyond isize and keep size unchanged.
-		 */
+
 		flags |= FIEMAP_EXTENT_LAST;
 	}
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
