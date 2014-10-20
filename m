From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/09] f2fs: invalidate inmemory page
Date: Sun, 19 Oct 2014 22:18:25 -0700
Message-ID: <1413782312-11631-2-git-send-email-jaegeuk@kernel.org>
References: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mg-0007lb-8X
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:42 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Mf-0005Ld-EN for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:42 +0000
In-Reply-To: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
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

If user truncates file's data, we should truncate inmemory pages too.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  3 +++
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 84f20e9..5b80ada 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1116,6 +1116,9 @@ static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
 	if (offset % PAGE_CACHE_SIZE || length != PAGE_CACHE_SIZE)
 		return;
 
+	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
+		invalidate_inmem_page(inode, page);
+
 	if (PageDirty(page))
 		inode_dec_dirty_pages(inode);
 	ClearPagePrivate(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 28f24ea..d41d1b7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1297,6 +1297,7 @@ void destroy_node_manager_caches(void);
  * segment.c
  */
 void register_inmem_page(struct inode *, struct page *);
+void invalidate_inmem_page(struct inode *, struct page *);
 void commit_inmem_pages(struct inode *, bool);
 void f2fs_balance_fs(struct f2fs_sb_info *);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9d4a7ab..902c4c3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -203,6 +203,22 @@ retry:
 	mutex_unlock(&fi->inmem_lock);
 }
 
+void invalidate_inmem_page(struct inode *inode, struct page *page)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct inmem_pages *cur;
+
+	mutex_lock(&fi->inmem_lock);
+	cur = radix_tree_lookup(&fi->inmem_root, page->index);
+	if (cur) {
+		radix_tree_delete(&fi->inmem_root, cur->page->index);
+		f2fs_put_page(cur->page, 0);
+		list_del(&cur->list);
+		kmem_cache_free(inmem_entry_slab, cur);
+	}
+	mutex_unlock(&fi->inmem_lock);
+}
+
 void commit_inmem_pages(struct inode *inode, bool abort)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
