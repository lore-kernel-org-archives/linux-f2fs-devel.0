From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs-tools: do not ignore *.rej in git
Date: Wed, 30 May 2018 15:10:49 +0800
Message-ID: <1527664249-147982-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When using git apply --reject to resolve the conflicts, we should better
see all the *.rej clear, or we will miss merging some *.rej patches.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 3f04e85..391c528 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,7 +11,6 @@
 *.mod.c
 *.lst
 *.orig
-*.rej
 
 CVS
 !.gitignore
-- 
1.8.5.2
