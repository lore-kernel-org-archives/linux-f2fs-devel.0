From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: flush_dcache_page for inline data
Date: Tue, 28 Oct 2014 22:05:51 -0700
Message-ID: <1414559153-92771-2-git-send-email-jaegeuk@kernel.org>
References: <1414559153-92771-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XjLSN-0006iq-6T
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Oct 2014 05:06:03 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XjLSL-0004EM-Dl for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Oct 2014 05:06:03 +0000
In-Reply-To: <1414559153-92771-1-git-send-email-jaegeuk@kernel.org>
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

When reading inline data, we should call flush_dcache_page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d9daf76..d6677d6 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -57,6 +57,7 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	src_addr = inline_data_addr(ipage);
 	dst_addr = kmap_atomic(page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
+	flush_dcache_page(page);
 	kunmap_atomic(dst_addr);
 	f2fs_put_page(ipage, 1);
 out:
-- 
2.1.1


------------------------------------------------------------------------------
