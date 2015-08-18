From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: check the node block address of newly allocated nid
Date: Tue, 18 Aug 2015 01:46:29 -0700
Message-ID: <1439887589-35190-5-git-send-email-jaegeuk@kernel.org>
References: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a routine which checks the block address of newly allocated nid.
If an nid has already allocated by other thread due to subtle data races, it
will result in filesystem corruption.
So, it needs to check whether its block address was already allocated or not
in prior to nid allocation as the last chance.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3cc32b8..6bef5a2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1573,6 +1573,8 @@ retry:
 
 	/* We should not use stale free nids created by build_free_nids */
 	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
+		struct node_info ni;
+
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		list_for_each_entry(i, &nm_i->free_nid_list, list)
 			if (i->state == NID_NEW)
@@ -1583,6 +1585,13 @@ retry:
 		i->state = NID_ALLOC;
 		nm_i->fcnt--;
 		spin_unlock(&nm_i->free_nid_list_lock);
+
+		/* check nid is allocated already */
+		get_node_info(sbi, *nid, &ni);
+		if (ni.blk_addr != NULL_ADDR) {
+			alloc_nid_done(sbi, *nid);
+			goto retry;
+		}
 		return true;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
-- 
2.1.1
