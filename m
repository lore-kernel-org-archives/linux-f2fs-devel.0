From: Changman Lee <cm224.lee@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: Add description for fsck.f2fs and dump.f2fs
Date: Thu, 04 Jul 2013 17:12:47 +0900
Message-ID: <1372925567-5574-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1UuegR-0008Be-6N
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Jul 2013 08:14:31 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UuegP-0002WG-5M for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Jul 2013 08:14:31 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MPE00EDAK6YDWK0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Jul 2013 17:14:20 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

This patch adds some description on fsck.f2fs and dump.f2fs which is
recently merged into f2fs-tools.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 Documentation/filesystems/f2fs.txt |   43 ++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index bd3c56c..f67a2ac 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -18,8 +18,8 @@ according to its internal geometry or flash memory management scheme, namely FTL
 F2FS and its tools support various parameters not only for configuring on-disk
 layout, but also for selecting allocation and cleaning algorithms.
 
-The file system formatting tool, "mkfs.f2fs", is available from the following
-git tree:
+The following git tree provides the file system formatting tool (mkfs.f2fs),
+a consistency checking tool (fsck.f2fs), and a debugging tool (dump.f2fs).
 >> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git
 
 For reporting bugs and sending patches, please use the following mailing list:
@@ -144,8 +144,12 @@ USAGE
  # mkfs.f2fs -l label /dev/block_device
  # mount -t f2fs /dev/block_device /mnt/f2fs
 
-Format options
---------------
+mkfs.f2fs
+---------
+The mkfs.f2fs is for the use of formatting a partition as the f2fs filesystem,
+which builds a basic on-disk layout.
+
+The options consist of:
 -l [label]   : Give a volume label, up to 512 unicode name.
 -a [0 or 1]  : Split start location of each area for heap-based allocation.
                1 is set by default, which performs this.
@@ -159,6 +163,37 @@ Format options
 -t [0 or 1]  : Disable discard command or not.
                1 is set by default, which conducts discard.
 
+fsck.f2fs
+---------
+The fsck.f2fs is a tool to check the consistency of an f2fs-formatted
+partition, which examines whether the filesystem metadata and user-made data
+are cross-referenced correctly or not.
+Note that, initial version of the tool does not fix any inconsistency.
+
+The options consist of:
+  -d debug level [default:0]
+
+dump.f2fs
+---------
+The dump.f2fs shows the information of specific inode and dumps SSA and SIT to
+file. Each file is dump_ssa and dump_sit.
+
+The dump.f2fs is used to debug on-disk data structures of the f2fs filesystem.
+It shows on-disk inode information reconized by a given inode number, and is
+able to dump all the SSA and SIT entries into predefined files, ./dump_ssa and
+./dump_sit respectively.
+
+The options consist of:
+  -d debug level [default:0]
+  -i inode no (hex)
+  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]
+  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]
+
+Examples:
+# dump.f2fs -i [ino] /dev/sdx
+# dump.f2fs -s 0~-1 /dev/sdx (SIT dump)
+# dump.f2fs -a 0~-1 /dev/sdx (SSA dump)
+
 ================================================================================
 DESIGN
 ================================================================================
-- 
1.7.9.5


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
