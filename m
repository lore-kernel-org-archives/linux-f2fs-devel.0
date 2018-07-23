From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 0/5] f2fs: fix and improve for victim_secmap
Date: Mon, 23 Jul 2018 22:10:17 +0800
Message-ID: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

There are some fixes and improvements for using with victim_secmap.

Yunlong Song (5):
  f2fs: clear victim_secmap when section has full valid blocks
  f2fs: add cur_victim_sec for BG_GC to avoid skipping BG_GC victim
  f2fs: clear_bit the SSR selected section in the victim_secmap
  f2fs: let BG_GC check every dirty segments and gc over a threshold
  f2fs: add proc entry to show victim_secmap bitmap

 fs/f2fs/f2fs.h              |  5 ++++-
 fs/f2fs/gc.c                | 39 ++++++++++++++++++++++++++++++---------
 fs/f2fs/segment.c           |  4 +++-
 fs/f2fs/segment.h           | 12 +++++++++++-
 fs/f2fs/super.c             |  3 ++-
 fs/f2fs/sysfs.c             | 25 +++++++++++++++++++++++++
 include/trace/events/f2fs.h | 18 ++++++++++++------
 7 files changed, 87 insertions(+), 19 deletions(-)

-- 
1.8.5.2
