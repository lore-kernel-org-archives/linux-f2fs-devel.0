From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH 2/2] test-appliance: add 'encrypt'
 config for f2fs
Date: Thu, 19 Apr 2018 13:50:20 -0700
Message-ID: <20180419205020.16868-2-ebiggers3@gmail.com>
References: <20180419205020.16868-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers3@gmail.com>) id 1f9GXJ-00048W-M6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 20:52:09 +0000
Received: from mail-pl0-f66.google.com ([209.85.160.66])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f9GXI-00603n-2b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 20:52:09 +0000
Received: by mail-pl0-f66.google.com with SMTP id e7-v6so3945527plt.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Apr 2018 13:52:07 -0700 (PDT)
In-Reply-To: <20180419205020.16868-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Allow testing f2fs using the test_dummy_encryption mount option,
available with f2fs in kernel 4.17 and later.  E.g.,

    gce-xfstests -c f2fs/encrypt -g auto

This is the f2fs equivalent of ext4/encrypt.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/files/root/fs/f2fs/cfg/all.list   |  1 +
 .../test-appliance/files/root/fs/f2fs/cfg/encrypt    |  5 +++++
 .../test-appliance/files/root/fs/f2fs/config         | 12 ++++++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
index 4ad96d5..bc796ff 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
@@ -1 +1,2 @@
 default
+encrypt
diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt
new file mode 100644
index 0000000..0e4e8ab
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt
@@ -0,0 +1,5 @@
+SIZE=small
+export MKFS_OPTIONS="-O encrypt"
+export F2FS_MOUNT_OPTIONS="test_dummy_encryption"
+REQUIRE_FEATURE=encryption
+TESTNAME="F2FS encryption"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 94c402b..3857d5d 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -33,6 +33,18 @@ function setup_mount_opts()
     if test -n "$MNTOPTS" ; then
 	F2FS_MOUNT_OPTIONS+="${F2FS_MOUNT_OPTIONS:+,}$MNTOPTS"
     fi
+    if echo ",$F2FS_MOUNT_OPTIONS," | grep -q ',test_dummy_encryption,'; then
+	local mode='\x00\x00\x00\x00'
+	local raw="$(printf ""\\\\x%02x"" $(seq 0 63))"
+	if lscpu | grep "Byte Order" | grep -q Little ; then
+	    local size='\x40\x00\x00\x00'
+	else
+	    local size='\x00\x00\x00\x40'
+	fi
+	local key="${mode}${raw}${size}"
+	keyctl new_session >& /dev/null
+	echo -n -e "${key}" | keyctl padd logon fscrypt:4242424242424242 @s >& /dev/null
+    fi
     export F2FS_MOUNT_OPTIONS="${F2FS_MOUNT_OPTIONS:+-o }$F2FS_MOUNT_OPTIONS"
 }
 
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
