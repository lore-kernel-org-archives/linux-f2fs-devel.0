From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: handle bug cases by letting fsck.f2fs
	initiate
Date: Tue,  2 Sep 2014 22:02:33 -0700
Message-ID: <1409720554-72925-5-git-send-email-jaegeuk@kernel.org>
References: <1409720554-72925-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XP2iX-0005QA-Dn
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:02:49 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XP2iW-0002YQ-OW for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:02:49 +0000
In-Reply-To: <1409720554-72925-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds to handle corner buggy cases for fsck.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 46586d3..853c8f5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -317,6 +317,10 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		struct seg_entry *sentry = get_seg_entry(sbi, segno);
 		enum dirty_type t = sentry->type;
 
+		if (unlikely(t >= DIRTY)) {
+			f2fs_bug_on(sbi, 1);
+			return;
+		}
 		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t]))
 			dirty_i->nr_dirty[t]++;
 	}
@@ -1745,8 +1749,12 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 			break;
 		offset = segno + 1;
 		valid_blocks = get_valid_blocks(sbi, segno, 0);
-		if (valid_blocks >= sbi->blocks_per_seg || !valid_blocks)
+		if (valid_blocks == sbi->blocks_per_seg || !valid_blocks)
 			continue;
+		if (valid_blocks > sbi->blocks_per_seg) {
+			f2fs_bug_on(sbi, 1);
+			continue;
+		}
 		mutex_lock(&dirty_i->seglist_lock);
 		__locate_dirty_segment(sbi, segno, DIRTY);
 		mutex_unlock(&dirty_i->seglist_lock);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
