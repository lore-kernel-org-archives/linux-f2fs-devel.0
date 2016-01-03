From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] Revert "f2fs: check the node block address
	of newly allocated nid"
Date: Sat,  2 Jan 2016 17:26:06 -0800
Message-ID: <1451784366-14261-3-git-send-email-jaegeuk@kernel.org>
References: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aFXR9-0004fB-9w
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jan 2016 01:26:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aFXR8-0007Ye-Et for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jan 2016 01:26:23 +0000
In-Reply-To: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
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

Original issue is fixed by:

  f2fs: cover more area with nat_tree_lock

This reverts commit 24928634f81b1592e83b37dcd89ed45c28f12feb.
---
 fs/f2fs/node.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4dab09f..6d5f548 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1602,8 +1602,6 @@ retry:
 
 	/* We should not use stale free nids created by build_free_nids */
 	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
-		struct node_info ni;
-
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		list_for_each_entry(i, &nm_i->free_nid_list, list)
 			if (i->state == NID_NEW)
@@ -1614,13 +1612,6 @@ retry:
 		i->state = NID_ALLOC;
 		nm_i->fcnt--;
 		spin_unlock(&nm_i->free_nid_list_lock);
-
-		/* check nid is allocated already */
-		get_node_info(sbi, *nid, &ni);
-		if (ni.blk_addr != NULL_ADDR) {
-			alloc_nid_done(sbi, *nid);
-			goto retry;
-		}
 		return true;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
-- 
2.6.3


------------------------------------------------------------------------------
