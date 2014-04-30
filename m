From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/4] f2fs: no need to wait on page writebck to
	meta pages
Date: Wed, 30 Apr 2014 11:33:42 +0900
Message-ID: <1398825223-23062-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1398825223-23062-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WfKNV-0005wK-NO
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 02:36:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WfKNU-0001qm-G4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 02:36:09 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4T00604OJWUF80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 11:35:56 +0900 (KST)
In-reply-to: <1398825223-23062-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch removes grab_cache_page_write_begin for meta pages.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1346ce9..b6f6ead 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -33,11 +33,14 @@ struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page = NULL;
 repeat:
-	page = grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
+	page = grab_cache_page(mapping, index);
 	if (!page) {
 		cond_resched();
 		goto repeat;
 	}
+	/* meta pages should not be under writeback */
+	if (PageWriteback(page))
+		WARN_ON(1);
 
 	SetPageUptodate(page);
 	return page;
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
