From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/7] resize.f2fs: fix wrong end_blkaddr
Date: Wed,  2 Nov 2016 22:28:41 -0700
Message-ID: <20161103052846.72244-2-jaegeuk@kernel.org>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2AaD-0005G6-8l
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2AaC-000259-Gs
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:01 +0000
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

The end_blkaddr should add main area segments.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/resize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 6a645e3..5dc73a8 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -563,8 +563,8 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 	old_main_blkaddr = get_sb(main_blkaddr);
 	new_main_blkaddr = get_newsb(main_blkaddr);
 	offset = new_main_blkaddr - old_main_blkaddr;
-	end_blkaddr = (get_sb(segment_count) << get_sb(log_blocks_per_seg)) +
-						get_sb(main_blkaddr);
+	end_blkaddr = (get_sb(segment_count_main) <<
+			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 
 	if (old_main_blkaddr > new_main_blkaddr) {
 		MSG(0, "\tError: Support resize to expand only\n");
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
