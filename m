From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a mount fail for wrong next_scan_nid
Date: Wed, 26 Apr 2017 15:56:52 +0800
Message-ID: <20170426075652.4249-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1d3Hka-00013t-Q2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 07:52:36 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3HkZ-0002zi-EW
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 07:52:36 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

-write_checkpoint
   -do_checkpoint
      -next_free_nid    <--- something wrong with next free nid

-f2fs_fill_super
   -build_node_manager
      -build_free_nids
          -get_current_nat_page
             -__get_meta_page   <--- attempt to access beyond end of device

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b99e318..98351a4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1955,6 +1955,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 	int i = 0;
 	nid_t nid = nm_i->next_scan_nid;
 
+	if (unlikely(nid >= nm_i->max_nid))
+		nid = 0;
+
 	/* Enough entries */
 	if (nm_i->nid_cnt[FREE_NID_LIST] >= NAT_ENTRY_PER_BLOCK)
 		return;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
