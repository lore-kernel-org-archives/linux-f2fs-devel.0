From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/7] f2fs: avoid writing 0'th page in volatile
	writes
Date: Mon, 25 Apr 2016 17:06:55 -0700
Message-ID: <1461629220-16280-2-git-send-email-jaegeuk@kernel.org>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqWx-0002jV-Nu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqWw-0008SJ-1e
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:07 +0000
In-Reply-To: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
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

The first page of volatile writes usually contains a sort of header information
which will be used for recovery.
(e.g., journal header of sqlite)

If this is written without other journal data, user needs to handle the stale
journal information.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c29bcf4..e54489b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1177,8 +1177,10 @@ write:
 		goto redirty_out;
 	if (f2fs_is_drop_cache(inode))
 		goto out;
-	if (f2fs_is_volatile_file(inode) && !wbc->for_reclaim &&
-			available_free_memory(sbi, BASE_CHECK))
+	/* we should not write 0'th page having journal header */
+	if (f2fs_is_volatile_file(inode) && (!page->index ||
+			(!wbc->for_reclaim &&
+			available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
 	/* Dentry blocks are controlled by checkpoint */
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
