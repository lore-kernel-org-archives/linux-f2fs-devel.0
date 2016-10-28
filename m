From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 0/9] f2fs: Zoned block device support
Date: Fri, 28 Oct 2016 17:44:58 +0900
Message-ID: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This series completes support for zoned block devices in f2fs. The core zoned
block device support was added to Jens linux-block tree, branch for-4.10/block.
(Please note that patch 1/9 is not specific to this series)

The core part of the zoned block device support was already implemented
by Jaegeuk with the addition of the "lfs" mode and atomic block allocation
and BIO issuing fixes. The patches in this series build on top of this
support, adding fixes for section discard and mount options checks.

Whereas older prototype ZBC support patch sets mapped discard to the reset
write pointer command for zoned block devices, the patches merged in Jens
for-4.10/block do not and a zone reset must be done with the function
blkdev_reset_zones. So in f2fs, the function f2fs_issue_discard is modified
to execute this function when the section to discard is stored in a sequential
zone. For sections stored in conventional zones, the regular discard operation
is used if the drive supports it.

This means that the zone type of each section is needed for discard. To avoid
a costly report zones execution before each section discard, the type of all
zones of the device is cached in the super block information. This cache is
initialized at mount time and does not need any update as the zone type of
zoned block devices is fixed.

For convenience and debugging, tracing of zone reset events is also added
similarly to the traces for regular discard events.

v2:
* Fixed compilation error when CONFIG_BLK_DEV_ZONED is disabled

Damien Le Moal (9):
  f2fs: Add missing break in switch-case
  f2fs: Use generic zoned block device terminology
  f2fs: Check zoned block feature for host-managed zoned block devices
  f2fs: Suppress discard warning message for zoned block devices
  f2fs: Always enable discard for zoned blocks devices
  f2fs: Do not allow adaptive mode for host-managed zoned block devices
  f2fs: Cache zoned block devices zone type
  f2fs: Reset sequential zones on zoned block devices
  f2fs: Trace reset zone events

 fs/f2fs/data.c              |   2 +-
 fs/f2fs/f2fs.h              |  38 +++++++++++----
 fs/f2fs/segment.c           |  66 +++++++++++++++++++++++----
 fs/f2fs/super.c             | 109 +++++++++++++++++++++++++++++++++++++++++++-
 include/trace/events/f2fs.h |  21 +++++++++
 5 files changed, 215 insertions(+), 21 deletions(-)

-- 
2.7.4

