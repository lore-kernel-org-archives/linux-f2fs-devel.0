From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: fix bad prefetchw of NULL page
Date: Mon, 13 Mar 2017 16:35:13 +0800
Message-ID: <f8424bb9-e8e7-9ce3-2557-97354938090e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cnLS3-0001GH-Fv
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 08:35:35 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cnLS1-00032h-Do
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 08:35:35 +0000
Received: by mail-it0-f67.google.com with SMTP id r141so5307664ita.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 13 Mar 2017 01:35:33 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

For f2fs_read_data_pages, the f2fs_mpage_readpages gets "page == NULL",
so that, the prefetchw(&page->flags) is operated on NULL.

Fixes: f1e8866016 ("f2fs: expose f2fs_mpage_readpages")
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1375fef..2ab5ca0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1150,9 +1150,10 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 
 	for (page_idx = 0; nr_pages; page_idx++, nr_pages--) {
 
-		prefetchw(&page->flags);
 		if (pages) {
 			page = list_last_entry(pages, struct page, lru);
+
+			prefetchw(&page->flags);
 			list_del(&page->lru);
 			if (add_to_page_cache_lru(page, mapping,
 						  page->index,
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
