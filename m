From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 12/13] f2fs: fix to set FI_UPDATE_WRITE correctly
Date: Mon, 15 Apr 2019 15:30:53 +0800
Message-ID: <20190415073054.2577-4-yuchao0@huawei.com>
References: <20190415073054.2577-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415073054.2577-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to set FI_UPDATE_WRITE only if in-place IO was issued.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ee5c7962b0f3..f6191b5a0e48 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1879,9 +1879,10 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 									true);
 			if (PageWriteback(page))
 				end_page_writeback(page);
+		} else {
+			set_inode_flag(inode, FI_UPDATE_WRITE);
 		}
 		trace_f2fs_do_write_data_page(fio->page, IPU);
-		set_inode_flag(inode, FI_UPDATE_WRITE);
 		return err;
 	}
 
-- 
2.18.0.rc1
