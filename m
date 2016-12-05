From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: call sync_fs when f2fs is idle
Date: Mon,  5 Dec 2016 11:43:45 -0800
Message-ID: <20161205194345.55114-2-jaegeuk@kernel.org>
References: <20161205194345.55114-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cDzB7-0002uR-90
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Dec 2016 19:43:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cDzB5-0002r2-Hp
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Dec 2016 19:43:57 +0000
In-Reply-To: <20161205194345.55114-1-jaegeuk@kernel.org>
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

The sync_fs in f2fs_balance_fs_bg must avoid interrupting current user requests.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d5141a06b9a3..8affc5621181 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -383,12 +383,15 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		build_free_nids(sbi, false);
 
+	if (!is_idle(sbi))
+		return;
+
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
-			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
+			f2fs_time_over(sbi, CP_TIME)) {
 		if (test_opt(sbi, DATA_FLUSH)) {
 			struct blk_plug plug;
 
-- 
2.11.0


------------------------------------------------------------------------------
