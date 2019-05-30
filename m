From: Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v3 2/4] f2fs: Fix root reserved on remount
Date: Wed, 29 May 2019 17:49:04 -0700
Message-ID: <20190530004906.261170-3-drosen@google.com>
References: <20190530004906.261170-1-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530004906.261170-1-drosen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On a remount, you can currently set root reserved if it was not
previously set. This can cause an underflow if reserved has been set to
a very high value, since then root reserved + current reserved could be
greater than user_block_count. inc_valid_block_count later subtracts out
these values from user_block_count, causing an underflow.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 912e2619d581b..359fd68509d16 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -213,7 +213,8 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 
 static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 {
-	block_t limit = (sbi->user_block_count << 1) / 1000;
+	block_t limit = min((sbi->user_block_count << 1) / 1000,
+			sbi->user_block_count - sbi->reserved_blocks);
 
 	/* limit is 0.2% */
 	if (test_opt(sbi, RESERVE_ROOT) &&
-- 
2.22.0.rc1.257.g3120a18244-goog
