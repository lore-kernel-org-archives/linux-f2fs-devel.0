From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 0/5] f2fs: some minor fix and clean up
Date: Fri, 07 Mar 2014 18:43:16 +0800
Message-ID: <5319A2C4.7040404@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WLsNu-0002pF-64
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 10:52:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLsNs-0001Gv-Ej for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 10:52:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>


Gu Zheng (5):
  f2fs: update start nid once each circle
  f2fs: remove the unused ctor argument of f2fs_kmem_cache_create()
  f2fs: format segment_info's show for better legibility
  f2fs: optimize restore_node_summary slightly
  f2fs: add a wait queue to avoid unnecessary build_free_nid

 fs/f2fs/checkpoint.c |    4 +-
 fs/f2fs/f2fs.h       |    5 ++-
 fs/f2fs/gc.c         |    2 +-
 fs/f2fs/node.c       |   64 ++++++++++++++++++++++++++++----------------------
 fs/f2fs/recovery.c   |    2 +-
 fs/f2fs/segment.c    |    9 ++++--
 fs/f2fs/super.c      |    9 ++++---
 7 files changed, 54 insertions(+), 41 deletions(-)

-- 
1.7.7


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
