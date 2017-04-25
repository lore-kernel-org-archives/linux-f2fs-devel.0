From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 0/4] optimize f2fs IPU v3
Date: Tue, 25 Apr 2017 12:45:11 +0000
Message-ID: <20170425124515.160446-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d2zqd-00008k-I2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:45:39 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d2zqc-0003vq-Lg
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:45:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

patch 1): Reconstruct code in do_write_data_page, code logic stays unchanged,
patch 2): f2fs: lookup extent cache first under IPU scenario
patch 3): Check IPU before cp to avoid IPU being blocked by cp
patch 3): Unlock dnode before IPU

Change log for v3: 
    - check IPU without f2fs_lock_op, to avoid IPU(fsync/fdatasync IPU) being blocked by long time cp

Hou Pengyang (4):
  f2fs: reconstruct code to write a data page
  f2fs: lookup extent cache first under IPU scenario
  f2fs: check IPU before cp to avoid IPU being blocked by cp
  f2fs: unlock dnode before IPU

 fs/f2fs/data.c    | 98 +++++++++++++++++++++++++++++++++++--------------------
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      |  2 ++
 fs/f2fs/segment.c |  2 ++
 fs/f2fs/segment.h |  2 +-
 5 files changed, 69 insertions(+), 37 deletions(-)

-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
