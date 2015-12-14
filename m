From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] mkfs.f2fs: fix to calculate left space of
 checkpoint page correctly
Date: Mon, 14 Dec 2015 18:06:59 +0800
Message-ID: <006001d13657$41c7c1c0$c5574540$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8Q2t-0007xN-KJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 10:07:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8Q2r-0004HC-Lu
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 10:07:55 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZC029IYESKYPE0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 19:07:36 +0900 (KST)
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
Cc: linux-f2fs-devel@lists.sourceforge.net

We reserved one segment for NAT region at least, so when formatting
fs, calculated maximum size of left space in CP page should be:
CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64 (size of
reserved NAT bitmap).

Fix the incorrect calculated size to avoid potential overflow bug here.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c4b17de..a2f33f9 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -220,7 +220,7 @@ static int f2fs_prepare_super_block(void)
 	 * When sit is too large, we should expand cp area. It requires more pages for cp.
 	 */
 	if (max_sit_bitmap_size >
-			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
+			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)) {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
 		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	} else {
-- 
2.6.3



------------------------------------------------------------------------------
