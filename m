From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] resize.f2fs: correct the max segno in
	migrate_main
Date: Mon, 28 Nov 2016 14:37:03 +0800
Message-ID: <1480315023-7787-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1cBFml-0003Vk-Gf
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Nov 2016 06:51:31 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cBFmj-0001LB-Ez
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Nov 2016 06:51:31 +0000
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

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/resize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 46aa30e..ba7bb88 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -143,7 +143,7 @@ static void migrate_main(struct f2fs_sb_info *sbi,
 
 	ASSERT(raw != NULL);
 
-	for (i = TOTAL_SEGS(sbi); i >= 0; i--) {
+	for (i = TOTAL_SEGS(sbi) - 1; i >= 0; i--) {
 		se = get_seg_entry(sbi, i);
 		if (!se->valid_blocks)
 			continue;
-- 
2.7.4


------------------------------------------------------------------------------
