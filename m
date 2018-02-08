From: Chao Yu <chao@kernel.org>
Subject: [PATCH] mkfs.f2fs: fix to handle endianness in
 f2fs_write_check_point_pack
Date: Thu,  8 Feb 2018 23:17:11 +0800
Message-ID: <20180208151711.3331-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ejnwz-0000Vn-VW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Feb 2018 15:17:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejnwy-0001pi-8I
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Feb 2018 15:17:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch fixes to handle missing endianness in f2fs_write_check_point_pack.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 93e9fea..4c3df96 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -783,7 +783,7 @@ static int f2fs_write_check_point_pack(void)
 
 		for (j = 0; j < QUOTA_DATA(qtype); j++) {
 			(sum_entry + off + j)->nid = sb->qf_ino[qtype];
-			(sum_entry + off + j)->ofs_in_node = j;
+			(sum_entry + off + j)->ofs_in_node = cpu_to_le16(j);
 		}
 		off += QUOTA_DATA(qtype);
 	}
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
