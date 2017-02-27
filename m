From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/3] f2fs: fix a memleak issue
Date: Mon, 27 Feb 2017 13:02:57 +0000
Message-ID: <20170227130259.19987-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ciKxk-0002e8-CU
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:03:36 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciKxg-0002Vv-PA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:03:36 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

[fix: ae75f0ca76 f2fs: introduce free nid bitmap]
Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/node.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6d43095..353c01d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2650,8 +2650,11 @@ int init_free_nid_cache(struct f2fs_sb_info *sbi)
 
 	nm_i->nat_block_bitmap = f2fs_kvzalloc(nm_i->nat_blocks / 8,
 								GFP_KERNEL);
-	if (!nm_i->nat_block_bitmap)
+	if (!nm_i->nat_block_bitmap) {
+		kvfree(nm_i->free_nid_bitmap);
 		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
