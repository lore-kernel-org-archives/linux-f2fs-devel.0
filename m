From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 1/3] mkfs.f2fs: Missing error check statement
 while allocating memory to write the super block.
Date: Thu, 26 Jul 2018 18:01:58 -0400
Message-ID: <602FCFCA-C2CF-4BFA-B689-37822AEE5393@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1fj75U-00039x-D4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 18:03:36 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1fj75S-0006gx-QW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 18:03:36 +0000
Received: from public-124-74.nat.utoronto.ca ([138.51.124.74]
 helo=[100.64.222.179])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1fioKc-0004Wo-L3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 18:01:58 -0400
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Added a missing error check statement while allocating memory to write the super block.

---
 mkfs/f2fs_format.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 1a2deae..491a9da 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -975,6 +975,10 @@ static int f2fs_write_super_block(void)
 	u_int8_t *zero_buff;
 
 	zero_buff = calloc(F2FS_BLKSIZE, 1);
+	if (!zero_buff) {
+		MSG(1, "\tError: Calloc Failed for f2fs_write_super_block!!!\n");
+		return -1;
+	}
 
 	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
-- 
2.7.4

Kind regards,
Stathis Maneas


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
