From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/11] f2fs: fix wrong condition for unlikely
Date: Fri, 25 Jul 2014 15:47:22 -0700
Message-ID: <1406328445-63707-8-git-send-email-jaegeuk@kernel.org>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XAoIu-0000Qv-TQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:32 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAoIu-0003CV-6O for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:32 +0000
In-Reply-To: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes the wrongly used unlikely condition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 42a16c1..36b0d47 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -932,7 +932,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	/* Here, we only have one bio having CP pack */
 	sync_meta_pages(sbi, META_FLUSH, LONG_MAX);
 
-	if (unlikely(!is_set_ckpt_flags(ckpt, CP_ERROR_FLAG))) {
+	if (!is_set_ckpt_flags(ckpt, CP_ERROR_FLAG)) {
 		clear_prefree_segments(sbi);
 		release_dirty_inode(sbi);
 		F2FS_RESET_SB_DIRT(sbi);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
