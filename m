From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: recover some i_inline flags
Date: Fri, 19 Jan 2018 20:26:43 -0800
Message-ID: <20180120042643.20717-2-jaegeuk@kernel.org>
References: <20180120042643.20717-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eckk0-0006Qf-Kj
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 04:26:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eckjz-0000zF-RS
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 04:26:52 +0000
In-Reply-To: <20180120042643.20717-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This fixes lost i_inline flags during roll-forward.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index cbeef73bc4dd..2354f1e05e19 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -211,6 +211,15 @@ static void recover_inode(struct inode *inode, struct page *page)
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 
+	if (raw->i_inline & F2FS_PIN_FILE)
+		set_inode_flag(inode, FI_PIN_FILE);
+	if (raw->i_inline & F2FS_DATA_EXIST)
+		set_inode_flag(inode, FI_DATA_EXIST);
+	else
+		clear_inode_flag(inode, FI_DATA_EXIST);
+	if (!(raw->i_inline & F2FS_INLINE_DOTS))
+		clear_inode_flag(inode, FI_INLINE_DOTS);
+
 	if (file_enc_name(inode))
 		name = "<encrypted>";
 	else
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
