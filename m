From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: set page private for inmemory pages
	for truncation
Date: Sat,  6 Dec 2014 11:55:37 -0800
Message-ID: <1417895739-15251-3-git-send-email-jaegeuk@kernel.org>
References: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XxLSL-0001ku-On
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Dec 2014 19:55:53 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XxLSK-0007ZF-2U for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Dec 2014 19:55:53 +0000
In-Reply-To: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
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

The inmemory pages should be handled by invalidate_page since it needs to be
released int the truncation path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c79d67e..3ebcf96 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -180,6 +180,8 @@ void register_inmem_page(struct inode *inode, struct page *page)
 	struct inmem_pages *new;
 	int err;
 
+	SetPagePrivate(page);
+
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
 	/* add atomic page indices to the list */
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
