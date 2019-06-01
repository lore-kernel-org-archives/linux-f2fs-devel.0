From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 042/141] f2fs: fix to do checksum even if inode page is uptodate
Date: Sat,  1 Jun 2019 09:20:18 -0400
Message-ID: <20190601132158.25821-42-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit b42b179bda9ff11075a6fc2bac4d9e400513679a ]

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203221

- Overview
When mounting the attached crafted image and running program, this error is reported.

The image is intentionally fuzzed from a normal f2fs image for testing and I enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_07.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out

- Messages
 kernel BUG at fs/f2fs/node.c:1279!
 RIP: 0010:read_node_page+0xcf/0xf0
 Call Trace:
  __get_node_page+0x6b/0x2f0
  f2fs_iget+0x8f/0xdf0
  f2fs_lookup+0x136/0x320
  __lookup_slow+0x92/0x140
  lookup_slow+0x30/0x50
  walk_component+0x1c1/0x350
  path_lookupat+0x62/0x200
  filename_lookup+0xb3/0x1a0
  do_fchmodat+0x3e/0xa0
  __x64_sys_chmod+0x12/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

On below paths, we can have opportunity to readahead inode page
- gc_node_segment -> f2fs_ra_node_page
- gc_data_segment -> f2fs_ra_node_page
- f2fs_fill_dentries -> f2fs_ra_node_page

Unlike synchronized read, on readahead path, we can set page uptodate
before verifying page's checksum, then read_node_page() will trigger
kernel panic once it encounters a uptodated page w/ incorrect checksum.

So considering readahead scenario, we have to do checksum each time
when loading inode page even if it is uptodated.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 4 ++--
 fs/f2fs/node.c  | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fae9570e6860e..0f31df01e36c6 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -179,8 +179,8 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 
 	if (provided != calculated)
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"checksum invalid, ino = %x, %x vs. %x",
-			ino_of_node(page), provided, calculated);
+			"checksum invalid, nid = %lu, ino_of_node = %x, %x vs. %x",
+			page->index, ino_of_node(page), provided, calculated);
 
 	return provided == calculated;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 34c3f732601c3..e2d9edad758cd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1282,9 +1282,10 @@ static int read_node_page(struct page *page, int op_flags)
 	int err;
 
 	if (PageUptodate(page)) {
-#ifdef CONFIG_F2FS_CHECK_FS
-		f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
-#endif
+		if (!f2fs_inode_chksum_verify(sbi, page)) {
+			ClearPageUptodate(page);
+			return -EBADMSG;
+		}
 		return LOCKED_PAGE;
 	}
 
-- 
2.20.1
