From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to account IO correctly for cgroup writeback
Date: Mon, 22 Oct 2018 23:24:28 +0800
Message-ID: <20181022152428.9292-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Now, we have supported cgroup writeback, it depends on correctly IO
account of specified filesystem.

But in commit d1b3e72d5490 ("f2fs: submit bio of in-place-update pages"),
we split write paths from f2fs_submit_page_mbio() to two:
- f2fs_submit_page_bio() for IPU path
- f2fs_submit_page_bio() for OPU path

But still we account write IO only in f2fs_submit_page_mbio(), result in
incorrect IO account, fix it by adding missing IO account in IPU path.

Fixes: d1b3e72d5490 ("f2fs: submit bio of in-place-update pages")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c6618eee4650..2dea5777597f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -478,6 +478,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 		bio_put(bio);
 		return -EFAULT;
 	}
+
+	if (fio->io_wbc && !is_read_io(fio->op))
+		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
-- 
2.18.0
