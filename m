From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: restrict write IO alignment condition
Date: Mon, 13 Mar 2017 21:02:16 +0800
Message-ID: <20170313130216.108395-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cnPd3-0003vq-R2
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 13:03:13 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cnPd2-0007oa-5Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 13:03:13 +0000
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
a. mode=lfs mount option
b. write IOs
c. Out-place-update
d. non-meta pages

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1375fef11146..53fe79c70406 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -190,6 +190,9 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
 
+		if (!test_opt(sbi, LFS))
+			goto submit_io;
+
 		if (type != DATA && type != NODE)
 			goto submit_io;
 
@@ -395,11 +398,12 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-		if ((fio->type == DATA || fio->type == NODE) &&
+		if (test_opt(sbi, LFS) &&
+			!is_read && (fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			err = -EAGAIN;
-			if (!is_read)
-				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
+			f2fs_bug_on(sbi, fio->new_blkaddr == fio->old_blkaddr);
+			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
 			goto out_fail;
 		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
