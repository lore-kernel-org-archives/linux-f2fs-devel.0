From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/13] f2fs: fix the initial inode page for
	recovery
Date: Tue, 12 Aug 2014 12:49:17 -0700
Message-ID: <1407872967-26423-3-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4Z-0007Oz-3k
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:31 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4T-0007Lw-RR for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:31 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

If a new inode page is needed for recover_dentry, we should assing i_inline
as zero.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1f33299..093d799 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1651,6 +1651,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	dst->i_blocks = cpu_to_le64(1);
 	dst->i_links = cpu_to_le32(1);
 	dst->i_xattr_nid = 0;
+	dst->i_inline = src->i_inline & F2FS_INLINE_XATTR;
 
 	new_ni = old_ni;
 	new_ni.ino = ino;
@@ -1659,6 +1660,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 		WARN_ON(1);
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 	inc_valid_inode_count(sbi);
+	set_page_dirty(ipage);
 	f2fs_put_page(ipage, 1);
 	return 0;
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
