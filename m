From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] f2fs: remove the unused stat_lock
Date: Fri, 11 Jul 2014 18:35:44 +0800
Message-ID: <1405074944-18283-2-git-send-email-guz.fnst@cn.fujitsu.com>
References: <N>
 <1405074944-18283-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1X5YbQ-0001lK-3Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Jul 2014 11:02:56 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X5YbO-0000F2-HI
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Jul 2014 11:02:56 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 7A257150373F
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:49:51 +0900 (JST)
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [10.0.237.131])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D5AB53EE1DD
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:49:44 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id DE4AEAC0ABA
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:49:43 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (s00.gw.nic.fujitsu.com [133.161.11.15])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 908481DB8032
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:49:43 +0900 (JST)
In-Reply-To: <1405074944-18283-1-git-send-email-guz.fnst@cn.fujitsu.com>
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
 fs/f2fs/f2fs.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae3b4ac..8f507d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1298,7 +1298,6 @@ bool space_for_roll_forward(struct f2fs_sb_info *);
 struct f2fs_stat_info {
 	struct list_head stat_list;
 	struct f2fs_sb_info *sbi;
-	struct mutex stat_lock;
 	int all_area_segs, sit_area_segs, nat_area_segs, ssa_area_segs;
 	int main_area_segs, main_area_sections, main_area_zones;
 	int hit_ext, total_ext;
-- 
1.7.7


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
