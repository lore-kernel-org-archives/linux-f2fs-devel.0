From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 0/5] Zoned block device support improvments
Date: Mon, 18 Mar 2019 15:39:54 +0900
Message-ID: <20190318063959.21369-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=973cf3254=damien.lemoal@wdc.com>)
 id 1h5lwO-0006sB-F5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:08 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h5lwM-00AHPl-Ln
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:08 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

The first 2 patches of this series are not zoned block device specific
and fix compilation warnings and modify .gitignore file to handle
/tools/f2fs_io/f2fs_io.

The last 3 patches improvements of zoned block device support, with the
last patch 5 being the most important.

Damien Le Moal (5):
  f2fs-tools: Fix various compilation warnings
  f2fs-tools: Add f2fs_io to .gitignore
  f2fs-tools: Improve zoned model check
  f2fs-tools: Allow using host-aware devices as regular devices
  f2fs-tools: Fix multi-device format with zoned devices

 .gitignore          |  1 +
 include/f2fs_fs.h   |  8 +++----
 lib/libf2fs.c       | 53 +++++++++++++++++++++++++++++++--------------
 lib/libf2fs_zoned.c | 22 ++++++++++---------
 tools/f2fstat.c     |  2 +-
 5 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.20.1
