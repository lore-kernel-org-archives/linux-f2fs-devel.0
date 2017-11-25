From: "LiFan" <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: remove an excess variable
Date: Sat, 25 Nov 2017 11:46:18 +0800
Message-ID: <000101d365a0$18250b50$486f21f0$@samsung.com>
References: <CGME20171125034720epcas5p3c538fec0b4669db7a0e36fc80851aa3d@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <yuchao0@huawei.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Remove the variable page_idx which no one would miss.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0781ed..1a93333 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1198,7 +1198,6 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			unsigned nr_pages)
 {
 	struct bio *bio = NULL;
-	unsigned page_idx;
 	sector_t last_block_in_bio = 0;
 	struct inode *inode = mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
@@ -1215,8 +1214,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_flags = 0;
 	map.m_next_pgofs = NULL;
 
-	for (page_idx = 0; nr_pages; page_idx++, nr_pages--) {
-
+	for (; nr_pages; nr_pages--) {
 		if (pages) {
 			page = list_last_entry(pages, struct page, lru);
 
-- 
2.7.4
