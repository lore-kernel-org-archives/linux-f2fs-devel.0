From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 4/5] f2fs: check return value of f2fs_readpage in
 find_data_page
Date: Thu, 28 Nov 2013 15:43:43 +0800
Message-ID: <003601ceec0d$bcc30330$36490990$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should return error if we do not get an updated page in find_date_page
when f2fs_readpage failed.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2d02cf3..85071d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -240,6 +240,9 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 
 	err = f2fs_readpage(sbi, page, dn.data_blkaddr,
 					sync ? READ_SYNC : READA);
+	if (err)
+		return ERR_PTR(err);
+
 	if (sync) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page)) {
-- 
1.7.9.5

