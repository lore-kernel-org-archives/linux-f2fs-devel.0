From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs: skip to check the block address of
	node page
Date: Wed,  6 Jul 2016 09:06:30 -0700
Message-ID: <20160706160632.78272-4-jaegeuk@kernel.org>
References: <20160706160632.78272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bKpLZ-0004rk-N5
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bKpLZ-000165-2y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:45 +0000
In-Reply-To: <20160706160632.78272-1-jaegeuk@kernel.org>
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

If the node page is up-to-date, it should be alive.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ca1bb3c..9d994b9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1080,6 +1080,9 @@ static int read_node_page(struct page *page, int rw)
 		.encrypted_page = NULL,
 	};
 
+	if (PageUptodate(page))
+		return LOCKED_PAGE;
+
 	get_node_info(sbi, page->index, &ni);
 
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
@@ -1087,9 +1090,6 @@ static int read_node_page(struct page *page, int rw)
 		return -ENOENT;
 	}
 
-	if (PageUptodate(page))
-		return LOCKED_PAGE;
-
 	fio.new_blkaddr = fio.old_blkaddr = ni.blk_addr;
 	return f2fs_submit_page_bio(&fio);
 }
-- 
2.8.3


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
