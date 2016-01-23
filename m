From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: remove needless condition check
Date: Sat, 23 Jan 2016 12:16:44 -0800
Message-ID: <1453580206-61937-2-git-send-email-jaegeuk@kernel.org>
References: <1453580206-61937-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aN4cM-00027g-2a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 20:17:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aN4cL-0004wv-Ek for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 20:17:06 +0000
In-Reply-To: <1453580206-61937-1-git-send-email-jaegeuk@kernel.org>
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

This patch removes needless condition variable.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b118055..9a8edeb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1477,13 +1477,9 @@ restart:
 		if (f2fs_lookup_extent_cache(inode, index, &ei)) {
 			dn.data_blkaddr = ei.blk + index - ei.fofs;
 		} else {
-			bool restart = false;
-
 			/* hole case */
 			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
-			if (err || (!err && dn.data_blkaddr == NULL_ADDR))
-				restart = true;
-			if (restart) {
+			if (err || (!err && dn.data_blkaddr == NULL_ADDR)) {
 				f2fs_put_dnode(&dn);
 				f2fs_lock_op(sbi);
 				locked = true;
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
