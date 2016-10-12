From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong sum_page pointer in f2fs_gc
Date: Wed, 12 Oct 2016 16:23:04 -0700
Message-ID: <20161012232304.6667-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1buSrl-00032A-0c
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 23:23:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1buSrk-0003m9-10
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 23:23:16 +0000
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

This patch fixes using a wrong pointer for sum_page in f2fs_gc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e48142f..9c18917 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -854,16 +854,16 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	for (segno = start_segno; segno < end_segno; segno++) {
 
-		if (get_valid_blocks(sbi, segno, 1) == 0 ||
-					unlikely(f2fs_cp_error(sbi)))
-			goto next;
-
 		/* find segment summary of victim */
 		sum_page = find_get_page(META_MAPPING(sbi),
 					GET_SUM_BLOCK(sbi, segno));
-		f2fs_bug_on(sbi, !PageUptodate(sum_page));
 		f2fs_put_page(sum_page, 0);
 
+		if (get_valid_blocks(sbi, segno, 1) == 0 ||
+				!PageUptodate(sum_page) ||
+				unlikely(f2fs_cp_error(sbi)))
+			goto next;
+
 		sum = page_address(sum_page);
 		f2fs_bug_on(sbi, type != GET_SUM_TYPE((&sum->footer)));
 
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
