From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] defrag.f2fs: fix not to allocate current segment
Date: Tue, 15 Dec 2015 18:17:36 -0800
Message-ID: <1450232256-71059-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a91f1-0001ud-Aw
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 02:17:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a91f0-0004Ys-8T for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 02:17:47 +0000
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

This patch fixes allocating wrong segment which has zero data but is registered
as a current segment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index d34c704..8418dcc 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1383,11 +1383,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 
 		se = get_seg_entry(sbi, segno);
 
-		if (se->valid_blocks == sbi->blocks_per_seg)
+		if (se->valid_blocks == sbi->blocks_per_seg ||
+				IS_CUR_SEGNO(sbi, segno, type))
 			goto next;
 
-		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec) &&
-					!IS_CUR_SEGNO(sbi, segno, type)) {
+		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec)) {
 			struct seg_entry *se2;
 			int i;
 
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
