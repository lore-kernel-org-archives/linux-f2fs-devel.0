From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: count dirty inodes to flush node pages
	during checkpoint
Date: Mon, 17 Oct 2016 14:56:43 -0700
Message-ID: <20161017215645.435-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bwFzH-0001Rm-VP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Oct 2016 22:02:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bwFzG-0003ej-3d
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Oct 2016 22:02:27 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If there are a lot of dirty inodes, we need to flush all of them when doing
checkpoint. So, we need to count this for enough free space.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index fecb856..a6efb5c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -471,11 +471,12 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
 
 	if (test_opt(sbi, LFS))
 		return false;
 
-	return free_sections(sbi) <= (node_secs + 2 * dent_secs +
+	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
 						reserved_sections(sbi) + 1);
 }
 
@@ -484,6 +485,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
 
 	node_secs += get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
 
@@ -491,7 +493,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 		return false;
 
 	return (free_sections(sbi) + freed) <=
-		(node_secs + 2 * dent_secs + reserved_sections(sbi) + needed);
+		(node_secs + 2 * dent_secs + imeta_secs +
+		reserved_sections(sbi) + needed);
 }
 
 static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
