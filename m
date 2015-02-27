From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: check its block allocation to avoid
	producing wrong dirty pages
Date: Fri, 27 Feb 2015 11:21:05 -0800
Message-ID: <1425064865-74602-2-git-send-email-jaegeuk@kernel.org>
References: <1425064865-74602-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YRQTO-00028I-Lu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 19:21:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YRQTN-0006jn-Ki for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 19:21:18 +0000
In-Reply-To: <1425064865-74602-1-git-send-email-jaegeuk@kernel.org>
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

If a page is cached but its block was deallocated, we don't need to make
the page dirty again by gc and truncate_partial_data_page.

In that case, it needs to check its block allocation all the time instead
of giving up-to-date page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 62e31b2..389fda7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -813,11 +813,19 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 		.rw = sync ? READ_SYNC : READA,
 	};
 
+	/*
+	 * If sync is false, it needs to check its block allocation.
+	 * This is need and triggered by two flows:
+	 *   gc and truncate_partial_data_page.
+	 */
+	if (!sync)
+		goto search;
+
 	page = find_get_page(mapping, index);
 	if (page && PageUptodate(page))
 		return page;
 	f2fs_put_page(page, 0);
-
+search:
 	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
 		dn.data_blkaddr = ei.blk + index - ei.fofs;
 		goto got_it;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
