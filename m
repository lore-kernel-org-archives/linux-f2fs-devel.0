From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to account preflush command for noflush_merge mode
Date: Wed, 24 Oct 2018 17:24:10 +0800
Message-ID: <20181024092410.127957-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we only account preflush command for flush_merge mode,
so for noflush_merge mode, we can not know in-flight preflush
command count, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d0cc6330dd61..9f388098d174 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -666,7 +666,9 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 		return 0;
 
 	if (!test_opt(sbi, FLUSH_MERGE)) {
+		atomic_inc(&fcc->issing_flush);
 		ret = submit_flush_wait(sbi, ino);
+		atomic_dec(&fcc->issing_flush);
 		atomic_inc(&fcc->issued_flush);
 		return ret;
 	}
-- 
2.18.0.rc1
