From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH 1/4] fsck.f2fs: free cp_page_1 in
	validate_checkpoint
Date: Thu, 29 Sep 2016 18:38:34 +0800
Message-ID: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1bpYxN-0005UJ-N6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:49 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYxM-0005SM-SM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Free cp_page_1 in validate_checkpoint to avoid memory leak.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 3be60bb..e390b26 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -494,7 +494,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 	/* Read the 1st cp block in this CP pack */
 	cp_page_1 = malloc(PAGE_SIZE);
 	if (dev_read_block(cp_page_1, cp_addr) < 0)
-		return NULL;
+		goto invalid_cp1;
 
 	cp = (struct f2fs_checkpoint *)cp_page_1;
 	crc_offset = get_cp(checksum_offset);
-- 
2.7.4


------------------------------------------------------------------------------
