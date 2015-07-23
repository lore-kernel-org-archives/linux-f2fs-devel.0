From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: initialize both two copies of NAT and SIT
	area
Date: Thu, 23 Jul 2015 09:43:04 +0800
Message-ID: <1437615784-16194-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZI5Wu-00038s-Ow
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jul 2015 01:42:36 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZI5Wo-0003WQ-GR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jul 2015 01:42:36 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

In the process of formatting, we zero out only one copy of NAT and
SIT area, but we use both of them when the filesystem is sucessfully
mounted. So I change the code to initialize both of two copies in mkfs.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 mkfs/f2fs_format.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f879bca..b2b3549 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -389,7 +389,7 @@ static int f2fs_init_sit_area(void)
 	sit_seg_addr *= blk_size;
 
 	DBG(1, "\tFilling sit area at offset 0x%08"PRIx64"\n", sit_seg_addr);
-	for (index = 0; index < (get_sb(segment_count_sit) / 2); index++) {
+	for (index = 0; index < get_sb(segment_count_sit); index++) {
 		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
 			MSG(1, "\tError: While zeroing out the sit area \
 					on disk!!!\n");
@@ -423,14 +423,14 @@ static int f2fs_init_nat_area(void)
 	nat_seg_addr *= blk_size;
 
 	DBG(1, "\tFilling nat area at offset 0x%08"PRIx64"\n", nat_seg_addr);
-	for (index = 0; index < get_sb(segment_count_nat) / 2; index++) {
+	for (index = 0; index < get_sb(segment_count_nat); index++) {
 		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
 			MSG(1, "\tError: While zeroing out the nat area \
 					on disk!!!\n");
 			free(nat_buf);
 			return -1;
 		}
-		nat_seg_addr = nat_seg_addr + (2 * seg_size);
+		nat_seg_addr = nat_seg_addr + seg_size;
 	}
 
 	free(nat_buf);
-- 
1.9.1


------------------------------------------------------------------------------
