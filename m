From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: check node page again in write end io
Date: Wed, 10 Jan 2018 16:37:23 +0800
Message-ID: <1515573443-22939-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eZC6c-0000Pd-6f
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 08:51:30 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZC6a-0004JZ-S1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 08:51:30 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

Check node page again in write end io in case of
data corruption during inflght IO.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 72d5d36..d9246a8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -114,6 +114,11 @@ static void f2fs_write_end_io(struct bio *bio)
 			if (type == F2FS_WB_CP_DATA)
 				f2fs_stop_checkpoint(sbi, true);
 		}
+
+		if (page->mapping == NODE_MAPPING(sbi) &&
+					page->index != nid_of_node(page))
+			f2fs_bug_on(sbi, 1);
+
 		dec_page_count(sbi, type);
 		clear_cold_data(page);
 		end_page_writeback(page);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
