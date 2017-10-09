From: Jan Kara <jack@suse.cz>
Subject: [PATCH 05/16] f2fs: Use pagevec_lookup_range_tag()
Date: Mon,  9 Oct 2017 17:13:48 +0200
Message-ID: <20171009151359.31984-6-jack@suse.cz>
References: <20171009151359.31984-1-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jack@suse.cz>) id 1e1Zl5-000884-2O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Oct 2017 15:14:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e1Zkz-000264-3R
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Oct 2017 15:14:18 +0000
In-Reply-To: <20171009151359.31984-1-jack@suse.cz>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Daniel Jordan <daniel.m.jordan@oracle.com>

We want only pages from given range in f2fs_write_cache_pages(). Use
pagevec_lookup_range_tag() instead of pagevec_lookup_tag() and remove
unnecessary code.

CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/data.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 36b535207c88..17d2c2997ddd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1669,8 +1669,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	while (!done && (index <= end)) {
 		int i;
 
-		nr_pages = pagevec_lookup_tag(&pvec, mapping, &index, tag,
-			      min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1);
+		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
+				tag, PAGEVEC_SIZE);
 		if (nr_pages == 0)
 			break;
 
@@ -1678,11 +1678,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
 
-			if (page->index > end) {
-				done = 1;
-				break;
-			}
-
 			done_index = page->index;
 retry_write:
 			lock_page(page);
-- 
2.12.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
