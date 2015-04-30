From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: don not re-lookup nat cache with same nid
Date: Thu, 30 Apr 2015 18:35:50 +0800
Message-ID: <025901d08331$87a9e940$96fdbbc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In set_node_addr, we try to lookup cached nat entry of inode and then
set flag in it.

But previously in this function, we have already grabbed nat entry with
current node id, if the node id is the same as the one of inode, we
do not need to lookup it in cache again.

So this patch adds condition judgment for reducing unneeded lookup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1676c7a..7a6d99f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -312,7 +312,8 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	__set_nat_cache_dirty(nm_i, e);
 
 	/* update fsync_mark if its inode nat entry is still alive */
-	e = __lookup_nat_cache(nm_i, ni->ino);
+	if (ni->nid != ni->ino)
+		e = __lookup_nat_cache(nm_i, ni->ino);
 	if (e) {
 		if (fsync_done && ni->nid == ni->ino)
 			set_nat_flag(e, HAS_FSYNCED_INODE, true);
-- 
2.3.3
