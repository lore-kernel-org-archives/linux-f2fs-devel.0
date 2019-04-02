From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: add comment for conditional compilation statement
Date: Tue, 2 Apr 2019 18:52:20 +0800
Message-ID: <20190402105222.28374-3-yuchao0@huawei.com>
References: <20190402105222.28374-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402105222.28374-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit af033b2aa8a8 ("f2fs: guarantee journalled quota data by checkpoint")
added function is_journalled_quota() in f2fs.h, but it located outside of
_LINUX_F2FS_H macro coverage, it has been fixed with commit 0af725fcb77a
("f2fs: fix wrong #endif").

But anyway, in order to avoid making same mistake latter, let's add single
line comment to notice which #if the last #endif is corresponding to.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 24e7f0e6aab7..79810f12b8c0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3672,4 +3672,5 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 	return false;
 }
 
-#endif
+#endif /* _LINUX_F2FS_H */
+
-- 
2.18.0.rc1
