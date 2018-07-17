From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: clean up with f2fs_is_{atomic,volatile}_file()
Date: Tue, 17 Jul 2018 20:41:48 +0800
Message-ID: <20180717124149.32523-4-yuchao0@huawei.com>
References: <20180717124149.32523-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717124149.32523-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0adab2ec5c5e..92b1bedfe85e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2766,8 +2766,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
-				is_inode_flag_set(inode, FI_ATOMIC_FILE) ||
-				is_inode_flag_set(inode, FI_VOLATILE_FILE))
+				f2fs_is_atomic_file(inode) ||
+				f2fs_is_volatile_file(inode))
 			return CURSEG_HOT_DATA;
 		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
-- 
2.18.0.rc1
