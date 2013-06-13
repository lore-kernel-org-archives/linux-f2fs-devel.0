From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH 0/3] some optimization & code cleanup
Date: Thu, 13 Jun 2013 16:59:26 +0800
Message-ID: <1371113969-946-1-git-send-email-haicheng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, Haicheng Li <haicheng.lee@gmail.com>, Haicheng Li <haicheng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fix some issues found by code review.

Haicheng Li (3):
  f2fs: remove unnecessary parameter "offset" from __add_sum_entry()
  f2fs: make locate_dirty_segment() as static
  f2fs: optimize do_write_data_page()

 fs/f2fs/data.c    |    5 +++--
 fs/f2fs/f2fs.h    |    1 -
 fs/f2fs/segment.c |   12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.7.9.5
