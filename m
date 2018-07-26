From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 2/3] mkfs.f2fs: Fixed typos in several printed
 messages.
Date: Thu, 26 Jul 2018 18:02:02 -0400
Message-ID: <0B31334F-7114-4C65-B79F-3BD8D12BAD3E@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1fj75Y-0003Ae-7R
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 18:03:40 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1fj75W-0006gx-Or
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 18:03:40 +0000
Received: from public-124-74.nat.utoronto.ca ([138.51.124.74]
 helo=[100.64.222.179])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1fioKg-0004Wo-Cw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 18:02:02 -0400
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

Fixed typos in several printed messages.

---
 mkfs/f2fs_format.c      | 18 +++++++++---------
 mkfs/f2fs_format_main.c |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 491a9da..d844563 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -586,19 +586,19 @@ static int f2fs_write_check_point_pack(void)
 
 	cp = calloc(F2FS_BLKSIZE, 1);
 	if (cp == NULL) {
-		MSG(1, "\tError: Calloc Failed for f2fs_checkpoint!!!\n");
+		MSG(1, "\tError: Calloc failed for f2fs_checkpoint!!!\n");
 		return ret;
 	}
 
 	sum = calloc(F2FS_BLKSIZE, 1);
 	if (sum == NULL) {
-		MSG(1, "\tError: Calloc Failed for summay_node!!!\n");
+		MSG(1, "\tError: Calloc failed for summary_node!!!\n");
 		goto free_cp;
 	}
 
 	sum_compact = calloc(F2FS_BLKSIZE, 1);
 	if (sum_compact == NULL) {
-		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
+		MSG(1, "\tError: Calloc failed for summary buffer!!!\n");
 		goto free_sum;
 	}
 	sum_compact_p = sum_compact;
@@ -608,13 +608,13 @@ static int f2fs_write_check_point_pack(void)
 						F2FS_BLKSIZE - 1);
 	nat_bits = calloc(F2FS_BLKSIZE, nat_bits_blocks);
 	if (nat_bits == NULL) {
-		MSG(1, "\tError: Calloc Failed for nat bits buffer!!!\n");
+		MSG(1, "\tError: Calloc failed for nat bits buffer!!!\n");
 		goto free_sum_compact;
 	}
 
 	cp_payload = calloc(F2FS_BLKSIZE, 1);
 	if (cp_payload == NULL) {
-		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
+		MSG(1, "\tError: Calloc failed for cp_payload!!!\n");
 		goto free_nat_bits;
 	}
 
@@ -920,7 +920,7 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* cp page 1 of check point pack 2
-	 * Initiatialize other checkpoint pack with version zero
+	 * Initialize other checkpoint pack with version zero
 	 */
 	cp->checkpoint_ver = 0;
 
@@ -1634,13 +1634,13 @@ int f2fs_format_device(void)
 
 	err = f2fs_init_sit_area();
 	if (err < 0) {
-		MSG(0, "\tError: Failed to Initialise the SIT AREA!!!\n");
+		MSG(0, "\tError: Failed to initialise the SIT AREA!!!\n");
 		goto exit;
 	}
 
 	err = f2fs_init_nat_area();
 	if (err < 0) {
-		MSG(0, "\tError: Failed to Initialise the NAT AREA!!!\n");
+		MSG(0, "\tError: Failed to initialise the NAT AREA!!!\n");
 		goto exit;
 	}
 
@@ -1658,7 +1658,7 @@ int f2fs_format_device(void)
 
 	err = f2fs_write_super_block();
 	if (err < 0) {
-		MSG(0, "\tError: Failed to write the Super Block!!!\n");
+		MSG(0, "\tError: Failed to write the super block!!!\n");
 		goto exit;
 	}
 exit:
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 449a0ed..0024393 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -193,22 +193,22 @@ static void f2fs_parse_options(int argc, char *argv[])
 
 	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR))) {
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
-			MSG(0, "\tInfo: project quota feature should always been"
+			MSG(0, "\tInfo: project quota feature should always be "
 				"enabled with extra attr feature\n");
 			exit(1);
 		}
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
-			MSG(0, "\tInfo: inode checksum feature should always been"
+			MSG(0, "\tInfo: inode checksum feature should always be "
 				"enabled with extra attr feature\n");
 			exit(1);
 		}
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
-			MSG(0, "\tInfo: flexible inline xattr feature should always been"
+			MSG(0, "\tInfo: flexible inline xattr feature should always be "
 				"enabled with extra attr feature\n");
 			exit(1);
 		}
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
-			MSG(0, "\tInfo: inode crtime feature should always been"
+			MSG(0, "\tInfo: inode crtime feature should always be "
 				"enabled with extra attr feature\n");
 			exit(1);
 		}
-- 
2.7.4

Kind regards,
Stathis Maneas


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
