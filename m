From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.11 091/114] f2fs: Make flush bios explicitely
	sync
Date: Thu, 18 May 2017 12:46:41 +0200
Message-ID: <20170518103618.509876959@linuxfoundation.org>
References: <20170518103604.736737251@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gregkh@linuxfoundation.org>) id 1dBJ36-0003Pa-Iu
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 May 2017 10:52:52 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dBJ33-00036A-DW
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 May 2017 10:52:52 +0000
In-Reply-To: <20170518103604.736737251@linuxfoundation.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>

4.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 3adc5fcb7edf5f8dfe8d37dcb50ba6b30077c905 upstream.

Commit b685d3d65ac7 "block: treat REQ_FUA and REQ_PREFLUSH as
synchronous" removed REQ_SYNC flag from WRITE_{FUA|PREFLUSH|...}
definitions.  generic_make_request_checks() however strips REQ_FUA and
REQ_PREFLUSH flags from a bio when the storage doesn't report volatile
write cache and thus write effectively becomes asynchronous which can
lead to performance regressions.

Fix the problem by making sure all bios which are synchronous are
properly marked with REQ_SYNC.

Fixes: b685d3d65ac791406e0dfd8779cc9b3707fea5a3
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/data.c    |    2 +-
 fs/f2fs/segment.c |    2 +-
 fs/f2fs/super.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -309,7 +309,7 @@ static void __f2fs_submit_merged_bio(str
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
 		io->fio.op = REQ_OP_WRITE;
-		io->fio.op_flags = REQ_META | REQ_PRIO;
+		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
 		if (!test_opt(sbi, NOBARRIER))
 			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 	}
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -416,7 +416,7 @@ static int __submit_flush_wait(struct bl
 	struct bio *bio = f2fs_bio_alloc(0);
 	int ret;
 
-	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	bio->bi_bdev = bdev;
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1307,7 +1307,7 @@ static int __f2fs_commit_super(struct bu
 	unlock_buffer(bh);
 
 	/* it's rare case, we can do fua all the time */
-	return __sync_dirty_buffer(bh, REQ_PREFLUSH | REQ_FUA);
+	return __sync_dirty_buffer(bh, REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
 }
 
 static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
