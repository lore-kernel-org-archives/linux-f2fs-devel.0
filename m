From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: skip if inline_data was converted already
Date: Tue, 19 Aug 2014 09:53:43 -0700
Message-ID: <1408467223-69823-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XJmfT-00026e-1C
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 16:53:55 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XJmfS-0006IZ-8z for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 16:53:54 +0000
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

This patch checks inline_data one more time under the inode page lock whether
its inline_data is converted or not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4d1f39f..3e8ecdf 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -68,7 +68,7 @@ out:
 
 static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 {
-	int err;
+	int err = 0;
 	struct page *ipage;
 	struct dnode_of_data dn;
 	void *src_addr, *dst_addr;
@@ -86,6 +86,10 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 		goto out;
 	}
 
+	/* someone else converted inline_data already */
+	if (!f2fs_has_inline_data(inode))
+		goto out;
+
 	/*
 	 * i_addr[0] is not used for inline data,
 	 * so reserving new block will not destroy inline data
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
