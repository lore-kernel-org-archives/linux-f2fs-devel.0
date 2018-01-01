From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: add reserved blocks for root user
Date: Sun, 31 Dec 2017 17:24:53 -0800
Message-ID: <20180101012453.GB77496@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171228021919.29397-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eVoqc-0006Xa-6S
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jan 2018 01:25:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eVoqZ-0006X4-UO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jan 2018 01:25:02 +0000
Content-Disposition: inline
In-Reply-To: <20171228021919.29397-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We can give another chance to write user data, which can resolve
generic/441.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - skip stop_checkpoint for normal user data

 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9fab6186f28..45f65a5b9871 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -111,7 +111,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		if (unlikely(bio->bi_status)) {
 			mapping_set_error(page->mapping, -EIO);
-			f2fs_stop_checkpoint(sbi, true);
+			if (type == F2FS_WB_CP_DATA)
+				f2fs_stop_checkpoint(sbi, true);
 		}
 		dec_page_count(sbi, type);
 		clear_cold_data(page);
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
