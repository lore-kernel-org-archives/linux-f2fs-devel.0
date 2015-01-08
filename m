From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH f2fs] f2fs: pids_lock can be static
Date: Fri, 9 Jan 2015 03:38:38 +0800
Message-ID: <20150108193838.GA28080@snb>
References: <201501090312.wCG4mLHp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201501090312.wCG4mLHp%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kbuild-all@01.org, Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

fs/f2fs/trace.c:19:12: sparse: symbol 'pids_lock' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 92fa38a..517dfe5 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -16,7 +16,7 @@
 #include "trace.h"
 
 RADIX_TREE(pids, GFP_ATOMIC);
-spinlock_t pids_lock;
+static spinlock_t pids_lock;
 struct last_io_info last_io;
 
 static inline void __print_last_io(void)
