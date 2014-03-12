From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2] f2fs: call set_dirty_dir_page if inode is
	directory.
Date: Wed, 12 Mar 2014 11:27:13 +0900
Message-ID: <1394591233-14080-2-git-send-email-cm224.lee@samsung.com>
References: <1394591233-14080-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WNYul-0006sM-WC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Mar 2014 02:29:04 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WNYuk-0002uR-1Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Mar 2014 02:29:03 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2A004QZXK5RQA0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Mar 2014 11:28:53 +0900 (KST)
In-reply-to: <1394591233-14080-1-git-send-email-cm224.lee@samsung.com>
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

It's more legible and efficient to call set_dirty_dir_page only if
inode->i_mode is directory before calling it.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |    3 ---
 fs/f2fs/data.c       |    3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1e03ca5..cc61962 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -578,9 +578,6 @@ void set_dirty_dir_page(struct inode *inode, struct page *page)
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct dir_inode_entry *new;
 
-	if (!S_ISDIR(inode->i_mode))
-		return;
-
 	new = f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
 	new->inode = inode;
 	INIT_LIST_HEAD(&new->list);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index acd0159..ecfa674 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1043,7 +1043,8 @@ static int f2fs_set_data_page_dirty(struct page *page)
 
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
-		set_dirty_dir_page(inode, page);
+		if (S_ISDIR(inode->i_mode))
+			set_dirty_dir_page(inode, page);
 		return 1;
 	}
 	return 0;
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
