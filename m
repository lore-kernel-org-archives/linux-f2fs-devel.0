From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: add some tracepoints to debug volatile
	and atomic writes
Date: Wed, 18 Mar 2015 11:18:21 -0700
Message-ID: <1426702701-7757-2-git-send-email-jaegeuk@kernel.org>
References: <1426702701-7757-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YYIY7-0002Sv-Od
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Mar 2015 18:18:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YYIY6-0005bU-KA for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Mar 2015 18:18:35 +0000
In-Reply-To: <1426702701-7757-1-git-send-email-jaegeuk@kernel.org>
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c              |  2 ++
 fs/f2fs/f2fs.h              |  4 ++++
 fs/f2fs/segment.c           |  4 ++++
 include/trace/events/f2fs.h | 27 ++++++++++++++++++++++++++-
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 486113d..241b987 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1287,9 +1287,11 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
 			need_inplace_update(inode))) {
 		rewrite_data_page(page, fio);
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
+		trace_f2fs_do_write_data_page(page, IPU);
 	} else {
 		write_data_page(page, &dn, fio);
 		f2fs_update_extent_cache(&dn);
+		trace_f2fs_do_write_data_page(page, OPU);
 		set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 		if (page->index == 0)
 			set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fec8acc..7d4e3fc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -547,6 +547,10 @@ enum page_type {
 	META,
 	NR_PAGE_TYPE,
 	META_FLUSH,
+	INMEM,		/* the below types are used by tracepoints only. */
+	INMEM_DROP,
+	IPU,
+	OPU,
 };
 
 struct f2fs_io_info {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eafaf72..f939660 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -205,6 +205,8 @@ retry:
 	list_add_tail(&new->list, &fi->inmem_pages);
 	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
 	mutex_unlock(&fi->inmem_lock);
+
+	trace_f2fs_register_inmem_page(page, INMEM);
 }
 
 void commit_inmem_pages(struct inode *inode, bool abort)
@@ -238,11 +240,13 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 				f2fs_wait_on_page_writeback(cur->page, DATA);
 				if (clear_page_dirty_for_io(cur->page))
 					inode_dec_dirty_pages(inode);
+				trace_f2fs_commit_inmem_page(cur->page, INMEM);
 				do_write_data_page(cur->page, &fio);
 				submit_bio = true;
 			}
 			f2fs_put_page(cur->page, 1);
 		} else {
+			trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
 			put_page(cur->page);
 		}
 		radix_tree_delete(&fi->inmem_root, cur->page->index);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 09a56dc..75724bd 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -14,7 +14,11 @@
 		{ NODE,		"NODE" },				\
 		{ DATA,		"DATA" },				\
 		{ META,		"META" },				\
-		{ META_FLUSH,	"META_FLUSH" })
+		{ META_FLUSH,	"META_FLUSH" },				\
+		{ INMEM,	"INMEM" },				\
+		{ INMEM_DROP,	"INMEM_DROP" },				\
+		{ IPU,		"IN-PLACE" },				\
+		{ OPU,		"OUT-OF-PLACE" })
 
 #define F2FS_BIO_MASK(t)	(t & (READA | WRITE_FLUSH_FUA))
 #define F2FS_BIO_EXTRA_MASK(t)	(t & (REQ_META | REQ_PRIO))
@@ -854,6 +858,13 @@ DEFINE_EVENT(f2fs__page, f2fs_writepage,
 	TP_ARGS(page, type)
 );
 
+DEFINE_EVENT(f2fs__page, f2fs_do_write_data_page,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type)
+);
+
 DEFINE_EVENT(f2fs__page, f2fs_readpage,
 
 	TP_PROTO(struct page *page, int type),
@@ -875,6 +886,20 @@ DEFINE_EVENT(f2fs__page, f2fs_vm_page_mkwrite,
 	TP_ARGS(page, type)
 );
 
+DEFINE_EVENT(f2fs__page, f2fs_register_inmem_page,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type)
+);
+
+DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type)
+);
+
 TRACE_EVENT(f2fs_writepages,
 
 	TP_PROTO(struct inode *inode, struct writeback_control *wbc, int type),
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
