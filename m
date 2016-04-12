From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: use PGP_LOCK to check its truncation
Date: Tue, 12 Apr 2016 10:42:36 -0700
Message-ID: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq2L4-0004SG-Iz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:42:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq2L3-00051e-M3
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:42:58 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Previously, after trylock_page is succeeded, it doesn't check its mapping.
In order to fix that, we can just give PGP_LOCK to pagecache_get_page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1a33de9..ade221c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1202,13 +1202,10 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	if (!inode)
 		return;
 
-	page = pagecache_get_page(inode->i_mapping, 0, FGP_NOWAIT, 0);
+	page = pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
 	if (!page)
 		goto iput_out;
 
-	if (!trylock_page(page))
-		goto release_out;
-
 	if (!PageUptodate(page))
 		goto page_out;
 
@@ -1223,9 +1220,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	else
 		set_page_dirty(page);
 page_out:
-	unlock_page(page);
-release_out:
-	f2fs_put_page(page, 0);
+	f2fs_put_page(page, 1);
 iput_out:
 	iput(inode);
 }
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
