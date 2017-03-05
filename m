From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH v3 1/2] mkfs.f2fs: clearfiy the help message and
	manpages
Date: Sun, 5 Mar 2017 21:04:46 +0800
Message-ID: <5f6d317d-c0b7-e6ed-6758-458924b8c028@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ckVqR-00013P-Kn
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 05 Mar 2017 13:05:03 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ckVqQ-00088s-I9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 05 Mar 2017 13:05:03 +0000
Received: by mail-it0-f65.google.com with SMTP id 68so6897028itg.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 05 Mar 2017 05:05:02 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Add some missing options in manpages, also order those options.

v3, add the missing update of SYNOPSIS

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 man/mkfs.f2fs.8         | 67 ++++++++++++++++++++++++++++++++++++-------------
 mkfs/f2fs_format_main.c |  6 ++---
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index bdb9755..3ae9f3a 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -16,28 +16,42 @@ mkfs.f2fs \- create an F2FS file system
 .I device
 ]
 [
+.B \-d
+.I debugging-level
+]
+[
+.B \-e
+.I extension-list
+]
+[
 .B \-l
 .I volume-label
 ]
 [
+.B \-m
+]
+[
 .B \-o
 .I overprovision-ratio-percentage
 ]
 [
-.B \-s
-.I #-of-segments-per-section
+.B \-O
+.I feature-list
 ]
 [
-.B \-z
-.I #-of-sections-per-zone
+.B \-q
 ]
 [
-.B \-e
-.I extenstion-list
+.B \-s
+.I #-of-segments-per-section
 ]
 [
-.B \-d
-.I debugging-level
+.B \-t
+.I nodiscard/discard
+]
+[
+.B \-z
+.I #-of-sections-per-zone
 ]
 .I device
 .I [sectors]
@@ -63,34 +77,51 @@ The default value is 1.
 Build f2fs with this device additionally, so that user can see all
 the devices as one big volume.
 .TP
+.BI \-d " debug-level"
+Specify the level of debugging options.
+The default number is 0, which shows basic debugging messages.
+.TP
+.BI \-e " extension-list"
+Specify a file extension list in order f2fs to treat them as cold files.
+The data of files having those extensions will be stored to the cold log.
+The default list includes most of multimedia file extensions such as jpg, gif,
+mpeg, mkv, and so on.
+.TP
 .BI \-l " volume-label"
 Specify the volume label to the partition mounted as F2FS.
 .TP
+.BI \-m
+Specify f2fs filesystem to supports the block zoned feature.
+Without it, the filesystem isn't supports the feature.
+.TP
 .BI \-o " overprovision-ratio-percentage"
 Specify the percentage over the volume size for overprovision area. This area
 is hidden to users, and utilized by F2FS cleaner. If not specified, the best
 number will be assigned automatically accoring to the partition size.
 .TP
+.BI \-O " feature-list"
+Specify a feature list in order f2fs filesystem will supports.
+e.g "encrypt" and so on.
+.TP
+.BI \-q
+Quiet mode.
+With it, mkfs.f2fs does not show any messages include the basic messages.
+.TP
 .BI \-s " #-of-segments-per-section"
 Specify the number of segments per section. A section consists of
 multiple consecutive segments, and is the unit of garbage collection.
 The default number is 1, which means one segment is assigned to a section.
 .TP
+.BI \-t " nodiscard/discard"
+Specify 1 or 0 to enable/disable discard policy.
+If the value is equal to 1, discard policy is enabled, otherwise is disable.
+The default value is 1.
+.TP
 .BI \-z " #-of-sections-per-zone"
 Specify the number of sections per zone. A zone consists of multiple sections.
 F2FS allocates segments for active logs with separated zones as much as possible.
 The default number is 1, which means a zone consists of one section.
 .TP
-.BI \-e " extension-list"
-Specify a file extension list in order f2fs to treat them as cold files.
-The data of files having those extensions will be stored to the cold log.
-The default list includes most of multimedia file extensions such as jpg, gif,
-mpeg, mkv, and so on.
-.TP
-.BI \-d " debug-level"
-Specify the level of debugging options.
-The default number is 0, which shows basic debugging messages.
-.TP
 .SH AUTHOR
 This version of
 .B mkfs.f2fs
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 5bb1faf..0ac87ed 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -32,13 +32,13 @@ static void mkfs_usage()
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -l label\n");
+	MSG(0, "  -m support zoned block device [default:0]\n");
 	MSG(0, "  -o overprovision ratio [default:5]\n");
-	MSG(0, "  -O set feature\n");
+	MSG(0, "  -O [feature list] e.g. \"encrypt\"\n");
 	MSG(0, "  -q quiet mode\n");
 	MSG(0, "  -s # of segments per section [default:1]\n");
-	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
-	MSG(0, "  -m support zoned block device [default:0]\n");
+	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
