From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/7] defrag.f2fs: return error for no space case
Date: Wed,  2 Nov 2016 22:28:40 -0700
Message-ID: <20161103052846.72244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2Aa8-0005CC-SE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:28:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2Aa8-0005eP-0U
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:28:56 +0000
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

This returns error instead of assertion for resize.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/defrag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/defrag.c b/fsck/defrag.c
index 079e7a7..bea0293 100644
--- a/fsck/defrag.c
+++ b/fsck/defrag.c
@@ -78,8 +78,8 @@ int f2fs_defragment(struct f2fs_sb_info *sbi, u64 from, u64 len, u64 to, int lef
 			continue;
 
 		if (find_next_free_block(sbi, &target, left, se->type)) {
-			ASSERT_MSG("Not enough space to migrate blocks");
-			break;
+			MSG(0, "Not enough space to migrate blocks");
+			return -1;
 		}
 
 		if (migrate_block(sbi, idx, target)) {
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
