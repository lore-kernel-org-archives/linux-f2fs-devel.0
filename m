From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid to issue redundant discard commands
Date: Mon, 27 Feb 2017 13:43:55 -0800
Message-ID: <20170227214355.8405-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ciT5R-0000u4-Vp
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 21:44:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ciT5Q-0001En-2J
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 21:44:05 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>, stable@vger.kernel.org

If segs_per_sec is over 1 like under SMR, previously f2fs issues discard
commands redundantly on the same section, since we didn't move end position
for the previous discard command.

E.g.,

                       start  end
                         |    |
      prefree_bitmap = [01111100111100]

And, after issue discard for this section,
                             end      start
                              |        |
      prefree_bitmap = [01111100111100]

Select this section again by searching from (end + 1),
                             start  end
                                |   |
      prefree_bitmap = [01111100111100]

Fixes: 36abef4e796d38 ("f2fs: introduce mode=lfs mount option")
Cc: <stable@vger.kernel.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9006d8ed6f52..4bd7a8b19332 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1036,6 +1036,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start = start_segno + sbi->segs_per_sec;
 		if (start < end)
 			goto next;
+		else
+			end = start - 1;
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
