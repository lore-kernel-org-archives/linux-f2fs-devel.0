From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 12/17] fsck.f2fs: corrupted orphan inode will be
	removed
Date: Fri, 29 Aug 2014 17:28:59 -0700
Message-ID: <1409358544-54740-12-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYB-0005SM-O3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:51 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYB-0001ku-2M for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:51 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2a47b4c..914dcb9 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -712,10 +712,8 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 			DBG(1, "[%3d] ino [0x%x]\n", i, ino);
 			blk_cnt = 1;
-			ret = fsck_chk_node_blk(sbi, NULL, ino,
+			fsck_chk_node_blk(sbi, NULL, ino,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt);
-			if (ret == -EINVAL)
-				printf("TODO: nothing?\n");
 		}
 		memset(orphan_blk, 0, BLOCK_SZ);
 	}
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
