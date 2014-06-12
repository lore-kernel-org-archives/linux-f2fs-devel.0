From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: avoid to truncate non-updated page
 partially
Date: Thu, 12 Jun 2014 13:31:50 +0800
Message-ID: <000201cf85ff$c0715040$4153f0c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WuxdG-0003wn-Lh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 05:33:02 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WuxdD-0005sK-65
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 05:33:02 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7100EMGJEPRK30@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 14:32:49 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

After we call find_data_page in truncate_partial_data_page, we could not
guarantee this page is updated or not as error may occurred in lower layer.

We'd better check status of the page to avoid this no updated page be
writebacked to device.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9c49c59..fc569ca 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -380,13 +380,15 @@ static void truncate_partial_data_page(struct inode *inode, u64 from)
 		return;
 
 	lock_page(page);
-	if (unlikely(page->mapping != inode->i_mapping)) {
-		f2fs_put_page(page, 1);
-		return;
-	}
+	if (unlikely(!PageUptodate(page) ||
+			page->mapping != inode->i_mapping))
+		goto out;
+
 	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
 	set_page_dirty(page);
+
+out:
 	f2fs_put_page(page, 1);
 }
 
-- 
1.7.9.5



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
