From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH v2] common/config: support f2fs-tools v1.9 and
 later
Date: Mon,  9 Apr 2018 11:55:39 -0700
Message-ID: <20180409185539.183689-1-ebiggers@google.com>
Reply-To: Eric Biggers <ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@google.com>) id 1f5byl-0007QF-PK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 18:57:23 +0000
Received: from mail-pl0-f66.google.com ([209.85.160.66])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f5byk-005ijw-7E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 18:57:23 +0000
Received: by mail-pl0-f66.google.com with SMTP id e22-v6so3981464plj.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Apr 2018 11:57:22 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net

Pass the -f option to mkfs.f2fs when it appears to support it.  This is
required by f2fs-tools v1.9 and later in order to format the filesystem
even when an existing filesystem is detected.  But earlier versions did
not accept this option.

mkfs.f2fs doesn't yet have an option to print its version number.  So,
to detect a new enough version we grep for -f in the help output.  This
also works for mkfs.btrfs, so we switch that over to the same method
rather than grepping for "force overwrite" in the binary.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: switch to grepping for -f in the help output

 common/config | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/config b/common/config
index 20f0e5f3..cc318069 100644
--- a/common/config
+++ b/common/config
@@ -94,11 +94,16 @@ set_prog_path()
 	type -P $1
 }
 
-# Handle mkfs.btrfs which does (or does not) require -f to overwrite
-set_btrfs_mkfs_prog_path_with_opts()
+# Handle mkfs.$fstyp which does (or does not) require -f to overwrite
+set_mkfs_prog_path_with_opts()
 {
-	p=`set_prog_path mkfs.btrfs`
-	if [ "$p" != "" ] && grep -q 'force overwrite' $p; then
+	local fstyp=$1
+	local p=`set_prog_path mkfs.$fstyp`
+
+	# Note: mkfs.f2fs doesn't support the --help option yet, but it doesn't
+	# matter since it also prints the help when an invalid option is given.
+	if [ "$p" != "" ] && \
+		$p --help |& grep -q "[[:space:]]-f[[:space:]|]"; then
 		echo "$p -f"
 	else
 		echo $p
@@ -223,8 +228,8 @@ case "$HOSTOS" in
         export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
         export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
-        export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
-        export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
+        export MKFS_BTRFS_PROG="`set_mkfs_prog_path_with_opts btrfs`"
+        export MKFS_F2FS_PROG="`set_mkfs_prog_path_with_opts f2fs`"
         export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
