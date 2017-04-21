From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 0/3] optimize IPU
Date: Fri, 21 Apr 2017 09:56:32 +0000
Message-ID: <20170421095635.101454-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1VJR-00069G-VF
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 09:57:13 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1VJP-0001tU-V3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 09:57:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

For IPU, there is no need to read dnode, these three patches are to fix this
issue.

patch 1): Reconstruct code in do_write_data_page, code logic stays unchanged,
patch 2): Under high-probability IPU scenario, we check extent_tree first
patch 3): Unlock dnode before IPU

Hou Pengyang (3):
  f2fs: reconstruct code to write a data page
  f2fs: lookup extent cache first under IPU scenario
  f2fs: unlock dnode before IPU

 fs/f2fs/data.c | 94 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 22 deletions(-)

-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
