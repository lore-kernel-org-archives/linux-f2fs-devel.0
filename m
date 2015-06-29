From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/12] f2fs: update on-disk extents even under
	extent_cache
Date: Mon, 29 Jun 2015 11:39:30 -0700
Message-ID: <1435603176-63219-6-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dye-0002no-3J
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyd-0004fz-B3 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:20 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
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

Previously, f2fs_update_extent_cache() updates in-memory extent_cache all the
time, and then finally preserves its up-to-date extent into on-disk one during
f2fs_evict_inode.

But, in the following scenario:

1. mount
2. open & write an extent X
3. f2fs_evict_inode; on-disk extent is X
4. open & update the extent X with Y
5. sync; trigger checkpoint
6. power-cut

after power-on, f2fs should serve extent Y, but we have an on-disk extent X.

This causes a failure on xfstests/311.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dd62228..1e6609b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -899,9 +899,9 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
 
+	/* we should call update_extent_info() to update on-disk extent */
 	if (test_opt(F2FS_I_SB(dn->inode), EXTENT_CACHE))
-		return f2fs_update_extent_tree(dn->inode, fofs,
-							dn->data_blkaddr);
+		f2fs_update_extent_tree(dn->inode, fofs, dn->data_blkaddr);
 
 	if (update_extent_info(dn->inode, fofs, dn->data_blkaddr))
 		sync_inode_page(dn);
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
