From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: check node id earily when readahead NAT page
Date: Tue, 05 Jan 2016 16:51:33 +0800
Message-ID: <009e01d14796$5f09a870$1d1cf950$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add node id check in ra_node_page and get_node_page_ra like get_node_page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6d5f548..c1ddf3d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1041,6 +1041,10 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	struct page *apage;
 	int err;
 
+	if (!nid)
+		return;
+	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
+
 	apage = find_get_page(NODE_MAPPING(sbi), nid);
 	if (apage && PageUptodate(apage)) {
 		f2fs_put_page(apage, 0);
@@ -1108,6 +1112,7 @@ struct page *get_node_page_ra(struct page *parent, int start)
 	nid = get_nid(parent, start, false);
 	if (!nid)
 		return ERR_PTR(-ENOENT);
+	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
 repeat:
 	page = grab_cache_page(NODE_MAPPING(sbi), nid);
 	if (!page)
@@ -1127,9 +1132,9 @@ repeat:
 	end = start + MAX_RA_NODE;
 	end = min(end, NIDS_PER_BLOCK);
 	for (i = start + 1; i < end; i++) {
-		nid_t tnid = get_nid(parent, i, false);
-		if (!tnid)
-			continue;
+		nid_t tnid;
+
+		tnid = get_nid(parent, i, false);
 		ra_node_page(sbi, tnid);
 	}
 
-- 
2.6.3
