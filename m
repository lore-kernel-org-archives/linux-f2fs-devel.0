From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: reuse nids more aggressively
Date: Tue, 18 Aug 2015 01:46:25 -0700
Message-ID: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we can reuse nids as many as possible, we can mitigate producing obsolete
node pages in the page cache.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6e10c2a..3cc32b8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -306,6 +306,10 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	if (nat_get_blkaddr(e) != NEW_ADDR && new_blkaddr == NULL_ADDR) {
 		unsigned char version = nat_get_version(e);
 		nat_set_version(e, inc_node_version(version));
+
+		/* in order to reuse the nid */
+		if (nm_i->next_scan_nid > ni->nid)
+			nm_i->next_scan_nid = ni->nid;
 	}
 
 	/* change address */
-- 
2.1.1

