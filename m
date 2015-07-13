From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/4] f2fs: warm up cold page after mmaped write
Date: Mon, 13 Jul 2015 17:43:19 +0800
Message-ID: <007f01d0bd50$720a37d0$561ea770$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZEaHS-0007hr-HC
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 09:44:10 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZEaHQ-0005ul-LY
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 09:44:10 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NRF032OJ71DIC10@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 18:44:01 +0900 (KST)
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

With cost-benifit method, background gc will consider old section with
fewer valid blocks as candidate victim, these old blocks in section will
be treated as cold data, and laterly will be moved into cold segment.

But if the gcing page is attached by user through buffered or mmaped
write, we should reset the page as non-cold one, because this page may
have more opportunity for further updating.

So fix to add clearing code for the missed 'mmap' case.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 55e8e4b..f69bcd6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -86,6 +86,8 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 mapped:
 	/* fill the page */
 	f2fs_wait_on_page_writeback(page, DATA);
+	/* if gced page is attached, don't write to cold segment */
+	clear_cold_data(page);
 out:
 	sb_end_pagefault(inode->i_sb);
 	return block_page_mkwrite_return(err);
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
