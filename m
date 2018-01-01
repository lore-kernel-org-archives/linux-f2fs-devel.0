From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev v2] [PATCH 1/2] f2fs: stop checkpoint only from fault
 injection
Date: Sun, 31 Dec 2017 17:31:06 -0800
Message-ID: <20180101013106.GB81647@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171229020056.60558-1-jaegeuk@kernel.org>
 <665883a3-f065-e531-0730-c41b227df589@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <665883a3-f065-e531-0730-c41b227df589@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

We can give another chance to write user data, which can resolve
generic/441.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - skip stop_checkpoint for user data writes

 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9fab6186f28..45f65a5b9871 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -111,7 +111,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		if (unlikely(bio->bi_status)) {
 			mapping_set_error(page->mapping, -EIO);
-			f2fs_stop_checkpoint(sbi, true);
+			if (type == F2FS_WB_CP_DATA)
+				f2fs_stop_checkpoint(sbi, true);
 		}
 		dec_page_count(sbi, type);
 		clear_cold_data(page);
-- 
2.15.0.531.g2ccb3012c9-goog
