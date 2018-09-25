From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 6/6] f2fs: mark inode dirty explicitly in recover_inode()
Date: Tue, 25 Sep 2018 15:36:03 +0800
Message-ID: <20180925073603.102125-6-yuchao0@huawei.com>
References: <20180925073603.102125-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925073603.102125-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Mark inode dirty explicitly in the end of recover_inode() to make sure
that all recoverable fields can be persisted later.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 5e68e31989c8..409be551ba03 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -280,6 +280,8 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	recover_inline_flags(inode, raw);
 
+	f2fs_mark_inode_dirty_sync(inode, true);
+
 	if (file_enc_name(inode))
 		name = "<encrypted>";
 	else
-- 
2.18.0.rc1
