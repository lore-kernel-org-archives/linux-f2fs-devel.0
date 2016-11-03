From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] f2fs-tools: fix end block addres when
	finding free block
Date: Wed,  2 Nov 2016 22:28:42 -0700
Message-ID: <20161103052846.72244-3-jaegeuk@kernel.org>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2AaG-0007AV-GO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2AaF-0005eY-Ng
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:04 +0000
In-Reply-To: <20161103052846.72244-1-jaegeuk@kernel.org>
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

This patch fixes wrong end_blkaddr condition for free block allocation.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 47bb529..879dd52 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1547,16 +1547,18 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 
 int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 {
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct seg_entry *se;
 	u32 segno;
 	u64 offset;
 	int not_enough = 0;
+	u64 end_blkaddr = (get_sb(segment_count_main) <<
+			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 
 	if (get_free_segments(sbi) <= SM_I(sbi)->reserved_segments + 1)
 		not_enough = 1;
 
-	while (*to >= SM_I(sbi)->main_blkaddr &&
-			*to < F2FS_RAW_SUPER(sbi)->block_count) {
+	while (*to >= SM_I(sbi)->main_blkaddr && *to < end_blkaddr) {
 		segno = GET_SEGNO(sbi, *to);
 		offset = OFFSET_IN_SEG(sbi, *to);
 
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
