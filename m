From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: restrict write IO alignment condition
Date: Fri, 10 Mar 2017 17:38:04 +0800
Message-ID: <20170310093804.35928-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cmH0Q-0003y2-II
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:38:38 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cmH0P-00016Q-8g
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:38:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We should only align start offset of bio with defined IO_SIZE for below
conditions:
a. write IOs
b. Out-place-update
c. non-meta page

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1375fef11146..3e6b0cc5e36a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -395,7 +395,9 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-		if ((fio->type == DATA || fio->type == NODE) &&
+		if (!is_read && (fio->type == DATA || fio->type == NODE) &&
+				bio_page->mapping != META_MAPPING(sbi) &&
+				fio->new_blkaddr != fio->old_blkaddr &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			err = -EAGAIN;
 			if (!is_read)
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
