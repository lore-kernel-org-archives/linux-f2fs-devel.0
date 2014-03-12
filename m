From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/2] f2fs: remove unused PagePrivate
Date: Wed, 12 Mar 2014 11:27:12 +0900
Message-ID: <1394591233-14080-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WNYul-0006sF-3Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Mar 2014 02:29:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WNYui-0002Ae-UK
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Mar 2014 02:29:03 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2A00MCKXK44TA0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Mar 2014 11:28:52 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

In f2fs, pagecache page doesn't contain filesystem specific data, so
it's redundant. Let's remove it.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |    1 -
 fs/f2fs/data.c       |    2 --
 fs/f2fs/node.c       |    3 ---
 3 files changed, 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 911b6f9..1e03ca5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -590,7 +590,6 @@ void set_dirty_dir_page(struct inode *inode, struct page *page)
 		kmem_cache_free(inode_entry_slab, new);
 
 	inode_inc_dirty_dents(inode);
-	SetPagePrivate(page);
 	spin_unlock(&sbi->dir_inode_lock);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 101b4cd..acd0159 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1024,12 +1024,10 @@ static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
 	struct inode *inode = page->mapping->host;
 	if (PageDirty(page))
 		inode_dec_dirty_dents(inode);
-	ClearPagePrivate(page);
 }
 
 static int f2fs_release_data_page(struct page *page, gfp_t wait)
 {
-	ClearPagePrivate(page);
 	return 1;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e72b258..88e51c6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1237,7 +1237,6 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(sbi, F2FS_DIRTY_NODES);
-		SetPagePrivate(page);
 		return 1;
 	}
 	return 0;
@@ -1250,12 +1249,10 @@ static void f2fs_invalidate_node_page(struct page *page, unsigned int offset,
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	if (PageDirty(page))
 		dec_page_count(sbi, F2FS_DIRTY_NODES);
-	ClearPagePrivate(page);
 }
 
 static int f2fs_release_node_page(struct page *page, gfp_t wait)
 {
-	ClearPagePrivate(page);
 	return 1;
 }
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
