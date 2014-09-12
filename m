From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH] f2fs: Use nm_i->next_scan_nid as default for
	next_free_nid
Date: Fri, 12 Sep 2014 20:19:48 +0800
Message-ID: <1410524388-26544-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XSPpa-0007UZ-GF
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Sep 2014 12:20:02 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XSPpZ-0005y1-EP for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Sep 2014 12:20:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Huang Ying <ying.huang@intel.com>, huang.ying.caritas@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Now, if there is no free nid in nm_i->free_nid_list, 0 may be saved
into next_free_nid of checkpoint, this may cause useless scanning for
next mount.  nm_i->next_scan_nid should be a better default value than
0.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---
 fs/f2fs/checkpoint.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -802,7 +802,8 @@ static void do_checkpoint(struct f2fs_sb
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
-	nid_t last_nid = 0;
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	nid_t last_nid = nm_i->next_scan_nid;
 	block_t start_blk;
 	struct page *cp_page;
 	unsigned int data_sum_blocks, orphan_blocks;

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
