From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V2 0/3] f2fs: bug fix and improvement
Date: Sat, 16 Mar 2019 09:13:05 +0900
Message-ID: <20190316001308.18115-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9710b8926=damien.lemoal@wdc.com>)
 id 1h4wwy-0002qc-4d
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Mar 2019 00:13:20 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4www-004lWC-DD
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Mar 2019 00:13:20 +0000
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
Cc: linux-fsdevel@vger.kernel.org, Masato Suzuki <masato.suzuki@wdc.com>, Matias Bjorling <matias.bjorling@wdc.com>

Small patch series to:
* fix a bug with single zoned block device volume handling
* reduce memory usage when zoned block devices are used
* improve discard handling more multi-device volumes

Changes from V1:
* Fixed comment and commit message typos
* Added patch 3 to improve discard handling

Damien Le Moal (3):
  f2fs: Fix use of number of devices
  f2fs: Reduce zoned block device memory usage
  f2fs: improve discard handling with multi-device volumes

 fs/f2fs/data.c    | 17 +++++++++------
 fs/f2fs/f2fs.h    | 43 ++++++++++++++++++++++++++++----------
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      |  2 +-
 fs/f2fs/segment.c | 53 ++++++++++++++++++++++-------------------------
 fs/f2fs/super.c   | 13 +++++++-----
 6 files changed, 78 insertions(+), 52 deletions(-)

-- 
2.20.1
