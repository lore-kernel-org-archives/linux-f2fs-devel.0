From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: avoid gc in cp_error case
Date: Wed, 21 Sep 2016 20:54:57 -0700
Message-ID: <20160922035458.5002-3-jaegeuk@kernel.org>
References: <20160922035458.5002-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bmv70-0004b5-Ld
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 03:55:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmv6z-0005ZK-Uj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 03:55:50 +0000
In-Reply-To: <20160922035458.5002-1-jaegeuk@kernel.org>
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

Otherwise, we can hit
	f2fs_bug_on(sbi, !PageUptodate(sum_page));

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a9a3c9f..b9d6c42 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -847,7 +847,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	for (segno = start_segno; segno < end_segno; segno++) {
 
-		if (get_valid_blocks(sbi, segno, 1) == 0)
+		if (get_valid_blocks(sbi, segno, 1) == 0 ||
+					unlikely(f2fs_cp_error(sbi)))
 			goto next;
 
 		/* find segment summary of victim */
-- 
2.8.3


------------------------------------------------------------------------------
