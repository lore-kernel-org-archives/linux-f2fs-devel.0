From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] Revert "f2fs: put allocate_segment after
	refresh_sit_entry"
Date: Wed,  5 Apr 2017 11:02:01 -0700
Message-ID: <20170405180201.4021-2-jaegeuk@kernel.org>
References: <20170405180201.4021-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cvpG0-0000z9-O9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 18:02:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cvpFz-0007cK-Uz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 18:02:12 +0000
In-Reply-To: <20170405180201.4021-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "# v4 . 10+" <stable@vger.kernel.org>

This reverts commit 3436c4bdb30de421d46f58c9174669fbcfd40ce0.

This makes a leak to register dirty segments. I reproduced the issue by
modified postmark which injects a lot of file create/delete/update and
finally triggers huge number of SSR allocations.

Cc: <stable@vger.kernel.org> # v4.10+
[Jaegeuk Kim: Change missing incorrect comment]
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eedbed62947f..ed81fa5d64bf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1893,15 +1893,14 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	stat_inc_block_count(sbi, curseg);
 
+	if (!__has_curseg_space(sbi, type))
+		sit_i->s_ops->allocate_segment(sbi, type, false);
 	/*
-	 * SIT information should be updated before segment allocation,
-	 * since SSR needs latest valid block information.
+	 * SIT information should be updated after segment allocation,
+	 * since we need to keep dirty segments precisely under SSR.
 	 */
 	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
 
-	if (!__has_curseg_space(sbi, type))
-		sit_i->s_ops->allocate_segment(sbi, type, false);
-
 	mutex_unlock(&sit_i->sentry_lock);
 
 	if (page && IS_NODESEG(type))
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
