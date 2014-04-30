From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 4/4] f2fs: decrease the lock granularity during
	write_begin
Date: Wed, 30 Apr 2014 11:33:43 +0900
Message-ID: <1398825223-23062-4-git-send-email-jaegeuk.kim@samsung.com>
References: <1398825223-23062-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WfKNU-0007bn-5m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 02:36:08 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WfKNS-00062A-Ba
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 02:36:08 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4T00LCFOJY3OD0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 11:35:58 +0900 (KST)
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

This patch reduces the lock granularity during write_begin.
When the system is under memory pressure, it would be better to reduce
the locking time for the data pages.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 91ff104..a7bb98f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -909,6 +909,10 @@ repeat:
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
 		return -ENOMEM;
+
+	/* to avoid latency during memory pressure */
+	unlock_page(page);
+
 	*pagep = page;
 
 	if (f2fs_has_inline_data(inode) && (pos + len) <= MAX_INLINE_DATA)
@@ -920,10 +924,18 @@ repeat:
 	f2fs_unlock_op(sbi);
 
 	if (err) {
-		f2fs_put_page(page, 1);
+		f2fs_put_page(page, 0);
 		return err;
 	}
 inline_data:
+	lock_page(page);
+	if (unlikely(page->mapping != mapping)) {
+		f2fs_put_page(page, 1);
+		goto repeat;
+	}
+
+	f2fs_wait_on_page_writeback(page, DATA);
+
 	if ((len == PAGE_CACHE_SIZE) || PageUptodate(page))
 		return 0;
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
