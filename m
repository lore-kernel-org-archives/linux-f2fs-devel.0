From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: clear page uptodate when dropping cache
	for atomic write
Date: Fri, 13 Nov 2015 18:27:35 +0800
Message-ID: <029801d11dfe$049a3a10$0dceae30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZxBam-0000aD-6r
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Nov 2015 10:28:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZxBak-0001ZG-Ci
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Nov 2015 10:28:28 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NXR00Y1W136EGB0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Nov 2015 19:28:19 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We should clear uptodate flag for all pages atomic written when we drop
them, otherwise before these cached pages were reclaimed or invalidated
eventually, we will see invalid data when hitting them again.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f77b325..23759fb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -257,6 +257,7 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 				submit_bio = true;
 			}
 		} else {
+			ClearPageUptodate(cur->page);
 			trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
 		}
 		set_page_private(cur->page, 0);
-- 
2.6.3



------------------------------------------------------------------------------
