From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/6] f2fs: use current_sit_addr to replace the
	open code
Date: Mon, 20 Oct 2014 17:45:49 +0800
Message-ID: <1413798353-27811-2-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1XgA0P-0002fV-1f
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:16:01 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgA0N-0002aK-Sf
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:16:00 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id C77681794D8E
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:02:48 +0900 (JST)
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [10.0.237.143])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3CD923EE15D
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:02:42 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C540AC05F2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:02:41 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EEF661DB8037
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:02:36 +0900 (JST)
In-Reply-To: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/segment.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 923cb76..6fb7446 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1524,17 +1524,7 @@ int lookup_journal_in_cursum(struct f2fs_summary_block *sum, int type,
 static struct page *get_current_sit_page(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
-	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int offset = SIT_BLOCK_OFFSET(segno);
-	block_t blk_addr = sit_i->sit_base_addr + offset;
-
-	check_seg_range(sbi, segno);
-
-	/* calculate sit block address */
-	if (f2fs_test_bit(offset, sit_i->sit_bitmap))
-		blk_addr += sit_i->sit_blocks;
-
-	return get_meta_page(sbi, blk_addr);
+	return get_meta_page(sbi, current_sit_addr(sbi, segno));
 }
 
 static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
-- 
1.7.7


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
