From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to account IO correctly
Date: Mon, 22 Oct 2018 09:12:51 +0800
Message-ID: <20181022011251.70020-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Below race can cause reversed reference on dirty count, fix it by
relocating __submit_bio() and inc_page_count().

Thread A				Thread B
- f2fs_inplace_write_data
 - f2fs_submit_page_bio
  - __submit_bio
					- f2fs_write_end_io
					 - dec_page_count
  - inc_page_count

Cc: <stable@vger.kernel.org>
Fixes: d1b3e72d5490 ("f2fs: submit bio of in-place-update pages")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- split into two parts, fix previous bug in this part, merge another
part into other related patch.
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ef6f1f01eda..83b1983094bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -462,10 +462,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	}
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
-	__submit_bio(fio->sbi, bio, fio->type);
-
 	if (!is_read_io(fio->op))
 		inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
+
+	__submit_bio(fio->sbi, bio, fio->type);
 	return 0;
 }
 
-- 
2.18.0.rc1
