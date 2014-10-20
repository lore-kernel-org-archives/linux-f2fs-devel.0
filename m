From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/09] f2fs: fix to call f2fs_unlock_op
Date: Sun, 19 Oct 2014 22:18:30 -0700
Message-ID: <1413782312-11631-7-git-send-email-jaegeuk@kernel.org>
References: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mm-0007mL-Qd
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:48 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Ml-0005Lt-WC for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:48 +0000
In-Reply-To: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes to call f2fs_unlock_op, which was missing before.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 456df07..80d9a04 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -494,7 +494,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	/* writepage can convert inline_data under get_donde_of_data */
 	if (f2fs_has_inline_data(inode)) {
 		f2fs_put_dnode(&dn);
-		goto done;
+		goto unlock_done;
 	}
 
 	count = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
@@ -510,6 +510,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	f2fs_put_dnode(&dn);
 free_next:
 	err = truncate_inode_blocks(inode, free_from);
+unlock_done:
 	if (lock)
 		f2fs_unlock_op(sbi);
 done:
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
