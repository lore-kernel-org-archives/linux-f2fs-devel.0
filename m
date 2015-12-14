From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: write only the pages in range during
 defragment
Date: Mon, 14 Dec 2015 13:34:00 +0800
Message-ID: <004a01d13631$1f332d00$5d998700$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1a8LmZ-0008SC-JA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 05:34:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8LmX-0004WM-JA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 05:34:47 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZC00AYD24T2S00@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 14:34:37 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

@lend of filemap_write_and_wait_range is supposed to be a "offset
in bytes where the range ends (inclusive)". Subtract 1 to avoid 
writing an extra page.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 294e715..5fac4f2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1686,7 +1686,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,

        /* writeback all dirty pages in the range */
        err = filemap_write_and_wait_range(inode->i_mapping, range->start,
-                                               range->start + range->len);
+                                               range->start + range->len - 1);
        if (err)
                goto out;

-- 
1.7.9.5


------------------------------------------------------------------------------
