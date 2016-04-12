From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: remove redundant condition check
Date: Tue, 12 Apr 2016 10:42:40 -0700
Message-ID: <1460482960-14227-5-git-send-email-jaegeuk@kernel.org>
References: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq2LE-0007KW-2z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq2LD-00079D-AH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:08 +0000
In-Reply-To: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
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

This patch resolves the redundant condition check reported by David.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/data.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0955312..b92782f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -211,7 +211,7 @@ void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
 	bool readahead = false;
 
 	page = find_get_page(META_MAPPING(sbi), index);
-	if (!page || (page && !PageUptodate(page)))
+	if (!page || !PageUptodate(page))
 		readahead = true;
 	f2fs_put_page(page, 0);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5dafb9c..c29bcf4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1496,7 +1496,7 @@ restart:
 		} else {
 			/* hole case */
 			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
-			if (err || (!err && dn.data_blkaddr == NULL_ADDR)) {
+			if (err || dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
 				f2fs_lock_op(sbi);
 				locked = true;
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
