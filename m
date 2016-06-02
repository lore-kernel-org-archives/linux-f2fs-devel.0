From: kbuild test robot <fengguang.wu@intel.com>
Subject: [f2fs:dev-test 6/21] fs/f2fs/checkpoint.c:887:2-3:
	Unneeded semicolon
Date: Thu, 2 Jun 2016 10:25:57 +0800
Message-ID: <201606021055.CQP21puy%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1b8IHV-0006Jc-59
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jun 2016 02:22:45 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1b8IHU-0000NN-CJ for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jun 2016 02:22:45 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs dev-test
head:   c3ff4c22ae1f52ebfb3ca4dc53926822108c53bb
commit: dcccc741c3d1f60f38e5041b6a38aa4e8c5163bc [6/21] f2fs: flush inode metadata when checkpoint is doing


coccinelle warnings: (new ones prefixed by >>)

>> fs/f2fs/checkpoint.c:887:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
