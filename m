From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: remove corrupted data indices in
	direct node blocks
Date: Wed, 25 Feb 2015 13:46:54 -0800
Message-ID: <1424900814-54046-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YQjnO-0000UT-Uh
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 21:47:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQjnN-00022q-PS for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 21:47:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Previously, only data blocks locating in its inode block could be fixed.
This patch investigates direct node blocks to fix indices too.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 9d6fc42..1b27ae0 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -556,6 +556,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 {
 	int idx, ret;
 	u32 child_cnt = 0, child_files = 0;
+	int need_fix = 0;
 
 	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
 		if (le32_to_cpu(node_blk->dn.addr[idx]) == 0x0)
@@ -565,8 +566,17 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			&child_cnt, &child_files,
 			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version);
-		if (!ret)
+		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
+		} else if (config.fix_on) {
+			node_blk->dn.addr[idx] = 0;
+			need_fix = 1;
+			FIX_MSG("[0x%x] dn.addr[%d] = 0", nid, idx);
+		}
+	}
+	if (need_fix) {
+		ret = dev_write_block(node_blk, ni->blk_addr);
+		ASSERT(ret >= 0);
 	}
 	return 0;
 }
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
