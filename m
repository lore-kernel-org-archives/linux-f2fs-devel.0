From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2 v2] f2fs: add a case of no need to read a
	page in write begin
Date: Tue, 20 Dec 2016 11:11:35 +0800
Message-ID: <20161220031135.18754-2-heyunlei@huawei.com>
References: <20161220031135.18754-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cJAmk-0006NZ-5b
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Dec 2016 03:08:14 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cJAmg-0005u9-EB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Dec 2016 03:08:14 +0000
In-Reply-To: <20161220031135.18754-1-heyunlei@huawei.com>
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

If the range we write cover the whole valid data in the last page,
we do not need to read it.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ac2625..303873f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1715,6 +1715,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	if (len == PAGE_SIZE || PageUptodate(page))
 		return 0;
 
+	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode))
+		return 0;
+
 	if (blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_SIZE);
 		SetPageUptodate(page);
@@ -1768,7 +1771,7 @@ static int f2fs_write_end(struct file *file,
 	 * let generic_perform_write() try to copy data again through copied=0.
 	 */
 	if (!PageUptodate(page)) {
-		if (unlikely(copied != PAGE_SIZE))
+		if (unlikely(copied != len))
 			copied = 0;
 		else
 			SetPageUptodate(page);
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel
