From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH f2fs] f2fs: f2fs_write_cache_pages() can be static
Date: Tue, 14 Jul 2015 08:23:34 +0800
Message-ID: <20150714002334.GA610@lkp-sb04>
References: <201507140816.NqM3qfvR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507140816.NqM3qfvR%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: kbuild-all@01.org, Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1724986..ea13e3e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1133,7 +1133,7 @@ static int __f2fs_writepage(struct page *page, struct writeback_control *wbc,
  * The major change is making write step of cold data page separately from
  * warm/hot data page.
  */
-int f2fs_write_cache_pages(struct address_space *mapping,
+static int f2fs_write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
