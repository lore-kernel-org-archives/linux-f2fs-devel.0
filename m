From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: no need to scan nat bitmap if it's not
 enable
Date: Thu, 7 Sep 2017 10:55:25 +0800
Message-ID: <1504752925-12330-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1dpnCC-0004St-3Q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Sep 2017 03:09:36 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dpnCA-0006yN-Ip
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Sep 2017 03:09:36 +0000
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
Cc: heyunlei@huawei.com, morgan.wang@huawei.com

Now, nat bitmap will get lost after sudden power off,
when we build free nids, it's better to judge nat bitmap
enable or not before scan nat bitmap.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fca8783..482f424 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1937,6 +1937,9 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	struct f2fs_journal *journal = curseg->journal;
 	unsigned int i, idx;
 
+	if (!enabled_nat_bits(sbi, NULL))
+		return;
+
 	down_read(&nm_i->nat_tree_lock);
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
