From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/7] f2fs: avoid needless lock for node pages
	when fsyncing a file
Date: Mon, 25 Apr 2016 17:06:54 -0700
Message-ID: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqWw-0003VT-F2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqWu-0007oq-PP
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:06 +0000
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

When fsync is called, sync_node_pages finds a proper direct node pages to flush.
But, it locks unrelated direct node pages together unnecessarily.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 095fc2c..cccee50 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1272,10 +1272,14 @@ next_step:
 			 * we should not skip writing node pages.
 			 */
 lock_node:
-			if (ino && ino_of_node(page) == ino)
-				lock_page(page);
-			else if (!trylock_page(page))
+			if (ino) {
+				if (ino_of_node(page) == ino)
+					lock_page(page);
+				else
+					continue;
+			} else if (!trylock_page(page)) {
 				continue;
+			}
 
 			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 continue_unlock:
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
