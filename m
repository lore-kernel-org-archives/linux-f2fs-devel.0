From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: Return the errno to the caller to avoid using a wrong page
Date: Thu, 26 May 2016 12:38:31 +0800
Message-ID: <1464237511-2181-1-git-send-email-yunlong.song@huawei.com>
References: <1464181261-3980-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464181261-3980-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com
Cc: bintian.wang@huawei.com, houpengyang@huawei.com, heyunlei@huawei.com, liushuoran@huawei.com, shiguojun@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit aaf9607516ed38825268515ef4d773289a44f429 ("f2fs: check node page
contents all the time") pointed out that "sometimes it was reported that
its contents was missing", so it checks the page's mapping and contents.
When "nid != nid_of_node(page)", ERR_PTR(-EIO) will be returned to the
caller. However, commit e1c51b9f1df2f9efc2ec11488717e40cd12015f9 ("f2fs:
clean up node page updating flow") moves "nid != nid_of_node(page)" test
to "f2fs_bug_on(sbi, nid != nid_of_node(page))", this will return a
wrong page to the caller when F2FS_CHECK_FS is off when "sometimes it
was reported that its contents was missing" happens.

This patch restores to check node page contents all the time, and
returns the errno to make the caller known something is wrong and avoid
to use the page. This patch also moves f2fs_bug_on to its proper location.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/node.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1f21aae..eee56aa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1149,16 +1149,21 @@ repeat:
 
 	lock_page(page);
 
-	if (unlikely(!PageUptodate(page))) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
-	}
+	if (unlikely(!PageUptodate(page)))
+		goto out_err;
+
 	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
 page_hit:
-	f2fs_bug_on(sbi, nid != nid_of_node(page));
+	if(nid != nid_of_node(page)) {
+		f2fs_bug_on(sbi, 1);
+		ClearPageUptodate(page);
+out_err:
+		f2fs_put_page(page, 1);
+		return ERR_PTR(-EIO);
+	}
 	return page;
 }
 
-- 
1.8.5.2
