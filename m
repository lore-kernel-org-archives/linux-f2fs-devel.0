From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: add a case of no need to read a page
	in write begin
Date: Fri, 16 Dec 2016 20:07:19 +0800
Message-ID: <20161216120719.3565-2-heyunlei@huawei.com>
References: <20161216120719.3565-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cHrJF-0001Cu-BT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Dec 2016 12:08:21 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cHrJC-0002hs-BK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Dec 2016 12:08:21 +0000
In-Reply-To: <20161216120719.3565-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

If the range we write cover the whole valid data
in the last page, we do not need to read it.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b90fb01..d9f7339 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1715,6 +1715,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	if (len == PAGE_SIZE || PageUptodate(page))
 		return 0;
 
+	if (!(pos % PAGE_SHIFT) && (pos + len) > i_size_read(inode))
+		return 0;
+
 	if (blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_SIZE);
 		SetPageUptodate(page);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
