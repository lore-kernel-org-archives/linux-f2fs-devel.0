From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: write node pages if checkpoint is not
	doing
Date: Sat,  8 Nov 2014 23:36:08 -0800
Message-ID: <1415518569-20626-4-git-send-email-jaegeuk@kernel.org>
References: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XnN2t-0005CK-1E
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Nov 2014 07:36:23 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XnN2s-0008Tu-BO for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Nov 2014 07:36:23 +0000
In-Reply-To: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
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

It needs to write node pages if checkpoint is not doing in order to avoid
memory pressure.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4ea2c47..6f514fb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1314,10 +1314,12 @@ static int f2fs_write_node_page(struct page *page,
 		return 0;
 	}
 
-	if (wbc->for_reclaim)
-		goto redirty_out;
-
-	down_read(&sbi->node_write);
+	if (wbc->for_reclaim) {
+		if (!down_read_trylock(&sbi->node_write))
+			goto redirty_out;
+	} else {
+		down_read(&sbi->node_write);
+	}
 	set_page_writeback(page);
 	write_node_page(sbi, page, &fio, nid, ni.blk_addr, &new_addr);
 	set_node_addr(sbi, &ni, new_addr, is_fsync_dnode(page));
-- 
2.1.1


------------------------------------------------------------------------------
