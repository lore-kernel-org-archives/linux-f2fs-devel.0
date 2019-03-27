From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 0/4 v2] Zoned block device support improvments
Date: Wed, 27 Mar 2019 16:54:06 +0900
Message-ID: <20190327075410.15784-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9824208ba=damien.lemoal@wdc.com>)
 id 1h93O6-0002FI-JN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 07:54:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h93O5-00F4ud-6p
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 07:54:18 +0000
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

The last 2 patches are improvements of zoned block device support,
with the last patch being the most important.

Damien Le Moal (4):
  f2fs-tools: Fix various compilation warnings
  f2fs-tools: Add f2fs_io to .gitignore
  f2fs-tools: Improve zoned model check
  f2fs-tools: Fix multi-device format with zoned devices

 .gitignore          |  1 +
 include/f2fs_fs.h   |  8 ++++----
 lib/libf2fs.c       | 10 +++++++---
 lib/libf2fs_zoned.c | 47 ++++++++++++++++++++++++++++++++-------------
 tools/f2fstat.c     |  2 +-
 5 files changed, 47 insertions(+), 21 deletions(-)

Changes from v1:
* Dropped patch 4 as further analysis shows no problems with HA drives
  handling
* Fixed patch 3 to correctly handle zoned_model == none cases
* Added comment in the last patch as suggested by Chao

-- 
2.20.1
