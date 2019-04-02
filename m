From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 0/3 v3] Zoned block device support improvments
Date: Tue,  2 Apr 2019 11:44:52 +0900
Message-ID: <20190402024455.2236-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=988617210=damien.lemoal@wdc.com>)
 id 1hB9Q8-0001oH-CU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hB9Q6-00Ath5-7z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:04 +0000
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
/tools/f2fs_io/f2fs_io (note: patch 1 already applied upstream, not
resending).

The last 2 patches are improvements of zoned block device support,
with the last patch being the most important.

Damien Le Moal (3):
  f2fs-tools: Improve zoned model check
  f2fs-tools: Fix multi-device format with zoned devices
  f2fs-tools: Allow using host-aware devices as regular devices

 include/f2fs_fs.h   |  2 +-
 lib/libf2fs.c       | 64 ++++++++++++++++++++++++++++++++++++---------
 lib/libf2fs_zoned.c | 47 ++++++++++++++++++++++++---------
 3 files changed, 86 insertions(+), 27 deletions(-)

Changes from v2:
* Not resending patch 1 as it is applied upstream
* Fixed space indentation in patch 3 -> use tabs

Changes from v1:
* Dropped patch 4 as further analysis shows no problems with HA drives
  handling
* Fixed patch 3 to correctly handle zoned_model == none cases
* Added comment in the last patch as suggested by Chao

-- 
2.20.1
