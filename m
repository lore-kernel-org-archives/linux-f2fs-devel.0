From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: introduce __drop_inmem_page
Date: Tue, 21 Mar 2017 20:09:44 +0800
Message-ID: <20170321120945.76050-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqIcF-0003wJ-9A
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Mar 2017 12:10:19 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqIcD-0001uQ-Kk
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Mar 2017 12:10:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce a separated inner help __drop_inmem_page in order to:
a. enhance readability,
b. use INMEM_INVALIDATE for better tracing,
c. avoid useless loop.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c              |  2 +-
 fs/f2fs/f2fs.h              |  1 +
 fs/f2fs/segment.c           | 47 ++++++++++++++++++++++++++++++++++-----------
 include/trace/events/f2fs.h |  2 ++
 4 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f4b3006e3ecb..2d23c1f3d0f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1967,7 +1967,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 
 	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
-		drop_inmem_page(inode, page);
+		return drop_inmem_page(inode, page);
 
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 44c6c72d5e7d..82ddf5649d68 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -720,6 +720,7 @@ enum page_type {
 	META_FLUSH,
 	INMEM,		/* the below types are used by tracepoints only. */
 	INMEM_DROP,
+	INMEM_INVALIDATE,
 	INMEM_REVOKE,
 	IPU,
 	OPU,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3e8d08722151..0bf024f62330 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,7 +192,7 @@ void register_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_register_inmem_page(page, INMEM);
 }
 
-static int __revoke_inmem_pages(struct inode *inode, struct page *p,
+static int __revoke_inmem_pages(struct inode *inode,
 				struct list_head *head, bool drop, bool recover)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -205,10 +205,7 @@ static int __revoke_inmem_pages(struct inode *inode, struct page *p,
 		if (drop)
 			trace_f2fs_commit_inmem_page(page, INMEM_DROP);
 
-		if (!p)
-			lock_page(page);
-		else if (p != page)
-			continue;
+		lock_page(page);
 
 		if (recover) {
 			struct dnode_of_data dn;
@@ -232,7 +229,7 @@ static int __revoke_inmem_pages(struct inode *inode, struct page *p,
 			ClearPageUptodate(page);
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
-		f2fs_put_page(page, p ? 0 : 1);
+		f2fs_put_page(page, 1);
 
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
@@ -246,19 +243,47 @@ void drop_inmem_pages(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	mutex_lock(&fi->inmem_lock);
-	__revoke_inmem_pages(inode, NULL, &fi->inmem_pages, true, false);
+	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 	stat_dec_atomic_write(inode);
 }
 
+void __drop_inmem_page(struct inode *inode, struct page *page)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct list_head *head = &F2FS_I(inode)->inmem_pages;
+	struct inmem_pages *cur;
+
+	f2fs_bug_on(sbi, !IS_ATOMIC_WRITTEN_PAGE(page));
+
+	list_for_each_entry(cur, head, list) {
+		if (cur->page == page)
+			goto drop;
+	}
+
+	f2fs_bug_on(sbi, 1);
+	return;
+drop:
+	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
+
+	ClearPageUptodate(page);
+	set_page_private(page, 0);
+	ClearPagePrivate(page);
+	f2fs_put_page(page, 0);
+
+	list_del(&cur->list);
+	kmem_cache_free(inmem_entry_slab, cur);
+	dec_page_count(sbi, F2FS_INMEM_PAGES);
+}
+
 void drop_inmem_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	mutex_lock(&fi->inmem_lock);
-	__revoke_inmem_pages(inode, page, &fi->inmem_pages, true, false);
+	__drop_inmem_page(inode, page);
 	mutex_unlock(&fi->inmem_lock);
 }
 
@@ -312,7 +337,7 @@ static int __commit_inmem_pages(struct inode *inode,
 							DATA, WRITE);
 
 	if (!err)
-		__revoke_inmem_pages(inode, NULL, revoke_list, false, false);
+		__revoke_inmem_pages(inode, revoke_list, false, false);
 
 	return err;
 }
@@ -342,13 +367,13 @@ int commit_inmem_pages(struct inode *inode)
 		 * recovery or rewrite & commit last transaction. For other
 		 * error number, revoking was done by filesystem itself.
 		 */
-		ret = __revoke_inmem_pages(inode, NULL, &revoke_list,
+		ret = __revoke_inmem_pages(inode, &revoke_list,
 							false, true);
 		if (ret)
 			err = ret;
 
 		/* drop all uncommitted pages */
-		__revoke_inmem_pages(inode, NULL, &fi->inmem_pages,
+		__revoke_inmem_pages(inode, &fi->inmem_pages,
 							true, false);
 	}
 	mutex_unlock(&fi->inmem_lock);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 16fcd192e257..1714c75822de 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -15,6 +15,7 @@ TRACE_DEFINE_ENUM(META);
 TRACE_DEFINE_ENUM(META_FLUSH);
 TRACE_DEFINE_ENUM(INMEM);
 TRACE_DEFINE_ENUM(INMEM_DROP);
+TRACE_DEFINE_ENUM(INMEM_INVALIDATE);
 TRACE_DEFINE_ENUM(INMEM_REVOKE);
 TRACE_DEFINE_ENUM(IPU);
 TRACE_DEFINE_ENUM(OPU);
@@ -52,6 +53,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ META_FLUSH,	"META_FLUSH" },				\
 		{ INMEM,	"INMEM" },				\
 		{ INMEM_DROP,	"INMEM_DROP" },				\
+		{ INMEM_INVALIDATE,	"INMEM_INVALIDATE" },		\
 		{ INMEM_REVOKE,	"INMEM_REVOKE" },			\
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
