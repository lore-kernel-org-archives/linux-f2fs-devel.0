From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] fsck.f2fs: skip block count fix when i_links
	is fixed
Date: Thu, 26 Mar 2015 17:03:08 -0700
Message-ID: <1427414589-66956-5-git-send-email-jaegeuk@kernel.org>
References: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHkI-0005fb-9H
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHkH-0006oc-Fn for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:30 +0000
In-Reply-To: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
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

If i_links is wrong, we should not check block count, since it doesn't count
correctly which results in changing the block count to 1.

This patch fixes that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8cfea56..97bf6ce 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -440,7 +440,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 						"i_links= 0x%x -> 0x%x",
 						nid, i_links, i_links + 1);
 				}
-				goto check;
+				goto skip_blkcnt_fix;
 			}
 			/* No need to go deep into the node */
 			return;
@@ -550,6 +550,18 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 check:
+	if (i_blocks != *blk_cnt) {
+		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
+				"but has %u blocks",
+				nid, i_blocks, *blk_cnt);
+		if (config.fix_on) {
+			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
+			need_fix = 1;
+			FIX_MSG("[0x%x] i_blocks=0x%08"PRIx64" -> 0x%x",
+					nid, i_blocks, *blk_cnt);
+		}
+	}
+skip_blkcnt_fix:
 	if (ftype == F2FS_FT_DIR)
 		DBG(1, "Directory Inode: 0x%x [%s] depth: %d has %d files\n\n",
 				le32_to_cpu(node_blk->footer.ino),
@@ -562,17 +574,6 @@ check:
 				node_blk->i.i_name,
 				(u32)i_blocks);
 
-	if (i_blocks != *blk_cnt) {
-		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
-				"but has %u blocks",
-				nid, i_blocks, *blk_cnt);
-		if (config.fix_on) {
-			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
-			need_fix = 1;
-			FIX_MSG("[0x%x] i_blocks=0x%08"PRIx64" -> 0x%x",
-					nid, i_blocks, *blk_cnt);
-		}
-	}
 	if (ftype == F2FS_FT_DIR && i_links != child_cnt) {
 		ASSERT_MSG("ino: 0x%x has i_links: %u but real links: %u",
 				nid, i_links, child_cnt);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
