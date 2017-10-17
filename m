From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] f2fs: use extra parenthesis around assignment/condition
Date: Tue, 17 Oct 2017 11:07:12 +0200
Message-ID: <20171017090721.1393677-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Chao Yu <yuchao0@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>, Kinglong Mee <kinglongmee@gmail.com>, Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

gcc warns that writing a while() loop with an assignment as the condition
looks suspiciously like a comparison, and suggests a workaround:

fs/f2fs/checkpoint.c: In function 'sync_meta_pages':
fs/f2fs/checkpoint.c:321:9: error: suggest parentheses around assignment used as truth value [-Werror=parentheses]
  while (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,

This seems reasonable, so let's do that.

Fixes: 4aba7297f4a5 ("f2fs: simplify page iteration loops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The warning is from mmotm. Andrew, please fold this fix into the
patch that caused the warning, unless there are objections.
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/node.c       | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3ed9dcbf70ae..6124f8710dc3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -318,8 +318,8 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 
 	blk_start_plug(&plug);
 
-	while (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-				PAGECACHE_TAG_DIRTY)) {
+	while ((nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+				PAGECACHE_TAG_DIRTY))) {
 		int i;
 
 		for (i = 0; i < nr_pages; i++) {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d4ceb9ebfe92..d6e4df0bb622 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1285,8 +1285,8 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 	pagevec_init(&pvec, 0);
 	index = 0;
 
-	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY)) {
+	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY))) {
 		int i;
 
 		for (i = 0; i < nr_pages; i++) {
@@ -1439,8 +1439,8 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	pagevec_init(&pvec, 0);
 	index = 0;
 
-	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY)) {
+	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY))) {
 		int i;
 
 		for (i = 0; i < nr_pages; i++) {
@@ -1552,8 +1552,8 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 next_step:
 	index = 0;
 
-	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY)) {
+	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY))) {
 		int i;
 
 		for (i = 0; i < nr_pages; i++) {
@@ -1650,8 +1650,8 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 
 	pagevec_init(&pvec, 0);
 
-	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_WRITEBACK)) {
+	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_WRITEBACK))) {
 		int i;
 
 		for (i = 0; i < nr_pages; i++) {
-- 
2.9.0
