From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 0/5] f2fs: fix some bugs in lfs mode with large
 section
Date: Thu, 12 Jul 2018 23:09:25 +0800
Message-ID: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1fddEN-0005Jg-9h
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 15:10:07 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fddEL-006Vov-0M
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 15:10:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

f2fs has some bugs in section:segment > 1 and lfs mode, so fix them.

Yunlong Song (5):
  f2fs: do not set free of current section
  f2fs: clear the remaining prefree_map of the section
  f2fs: blk_finish_plug of submit_bio in lfs mode
  f2fs: disable small discard in lfs mode
  f2fs: do not __punch_discard_cmd in lfs mode

 fs/f2fs/data.c    |  2 +-
 fs/f2fs/segment.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/segment.h | 10 +++++-
 fs/f2fs/sysfs.c   |  4 +++
 4 files changed, 102 insertions(+), 12 deletions(-)

-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
