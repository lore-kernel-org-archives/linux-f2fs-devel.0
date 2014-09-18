From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: use more free segments until SSR is
	activated
Date: Wed, 17 Sep 2014 22:53:57 -0700
Message-ID: <1411019637-2381-3-git-send-email-jaegeuk@kernel.org>
References: <1411019637-2381-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XUUfQ-0003FL-EV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 05:54:08 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUUfP-0004TH-LO for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 05:54:08 +0000
In-Reply-To: <1411019637-2381-1-git-send-email-jaegeuk@kernel.org>
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

Previously, f2fs activates SSR if the # of free segments reaches to the # of
overprovisioned segments.
In this case, SSR starts to use dirty segments only, so that the overprovisoned
space cannot be selected for new data.
This means that we have no chance to utilizae the overprovisioned space at all.

This patch fixes that by allowing LFS allocations until the # of free segments
reaches to the last threshold, reserved space.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d317b61..a0e9207 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -437,8 +437,9 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
 
 static inline bool need_SSR(struct f2fs_sb_info *sbi)
 {
-	return (prefree_segments(sbi) / sbi->segs_per_sec)
-			+ free_sections(sbi) < overprovision_sections(sbi);
+	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
+	return (prefree_segments(sbi) / sbi->segs_per_sec) +
+		free_sections(sbi) < (reserved_sections(sbi) + node_secs);
 }
 
 static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
