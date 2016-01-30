From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 0/4] do more check in sanity_check_nid and
	clean up
Date: Sat, 30 Jan 2016 09:16:35 +0000
Message-ID: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aPKQM-0005wB-J3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:02 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aPKQL-0008Ij-Nq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao2.yu@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

PATCH 1/4 cleans up get_{sb|cp} and set_{sb|cp} to integrate them into
get_val and set_val to avoid dumplicated definition of macro.

PATCH 3/4 and 4/4 check nat_entry->ino. If it is wrong, we drop
corresponding nodes.

thanks,
Sheng

Sheng Yong (4):
  f2fs-tools: simplify get_{sb|cp} and set_{sb|cp}
  f2fs-tools: fix endianness of on-disk check_sum in summary_footer
  fsck.f2fs: check ino of an used nat entry
  fsck.f2fs: check ino of an inode

 fsck/fsck.c        |  30 ++++---
 fsck/main.c        |   8 +-
 fsck/mount.c       | 146 ++++++++++++++++-----------------
 include/f2fs_fs.h  |  86 +++++++-------------
 mkfs/f2fs_format.c | 234 ++++++++++++++++++++++++++---------------------------
 5 files changed, 243 insertions(+), 261 deletions(-)

-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
