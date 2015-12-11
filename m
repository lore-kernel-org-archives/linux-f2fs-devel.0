From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: clean up node page updating flow
Date: Fri, 11 Dec 2015 16:08:22 +0800
Message-ID: <03ba01d133eb$331a2e60$994e8b20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If read_node_page return LOCKED_PAGE, in its caller it's better a) skip
unneeded 'Update' flag and mapping info verfication; b) check nid value
stored in footer structure of node page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7bcbc6e..d842b19 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1063,12 +1063,13 @@ repeat:
 	if (err < 0) {
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
-	} else if (err != LOCKED_PAGE) {
-		lock_page(page);
+	} else if (err == LOCKED_PAGE) {
+		goto page_hit;
 	}
 
-	if (unlikely(!PageUptodate(page) || nid != nid_of_node(page))) {
-		ClearPageUptodate(page);
+	lock_page(page);
+
+	if (unlikely(!PageUptodate(page))) {
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
@@ -1076,6 +1077,8 @@ repeat:
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
+page_hit:
+	f2fs_bug_on(sbi, nid != nid_of_node(page));
 	return page;
 }
 
@@ -1114,24 +1117,25 @@ repeat:
 	end = start + MAX_RA_NODE;
 	end = min(end, NIDS_PER_BLOCK);
 	for (i = start + 1; i < end; i++) {
-		nid = get_nid(parent, i, false);
-		if (!nid)
+		nid_t tnid = get_nid(parent, i, false);
+		if (!tnid)
 			continue;
-		ra_node_page(sbi, nid);
+		ra_node_page(sbi, tnid);
 	}
 
 	blk_finish_plug(&plug);
 
 	lock_page(page);
+	if (unlikely(!PageUptodate(page))) {
+		f2fs_put_page(page, 1);
+		return ERR_PTR(-EIO);
+	}
 	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
 page_hit:
-	if (unlikely(!PageUptodate(page))) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
-	}
+	f2fs_bug_on(sbi, nid != nid_of_node(page));
 	return page;
 }
 
-- 
2.6.3
