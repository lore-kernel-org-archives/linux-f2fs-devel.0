Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3F8CDB466
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YEn/Kzdxt0oSOlC592L3CbcIEW1vBII5yVYwWCiWCY0=; b=JI3Sznz10bUbKegNoK+3ZAUZzr
	GehJ4bMr3MjKaZ0gpNT1xRk59cEe/sgqgzO3bdBtvaWf9kyyWqDouPH1D29A5GV8bkkAfO5wDLq17
	XerWDySm8Wlc0PfhcAFOrM6R6VVkN0W1Gd8MYhVbf7nS77RL/ujPdjRXWhjlbJFTOT5s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbU2h-0003Uq-Dt;
	Mon, 22 Jun 2026 02:05:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbU2Z-0003S1-2n
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 02:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lu5iU7fBtv4Chc3ojEDmb6o6SqWI3VKMJzPc8hK6LqQ=; b=LKw2o7f73aXjbGuH1wweas/tv9
 3fSt6Gja3eetpuB0KEZNYFiV1FS6yyGEYyoPVVDWRrLr3KOgKd48xOt4H1C+xnqZ4txB5UzznPgwG
 kShRqwJAqht9/1dhCYWYrzcpTf8h5ow3Hjw1KT+Ygugwp5V0PzyxOB9UKWHFb67LDE5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lu5iU7fBtv4Chc3ojEDmb6o6SqWI3VKMJzPc8hK6LqQ=; b=f
 Bq45Ral4bl/vFVM6kfwdoLL5Pm3FU1p41QsE5Kk+gnfOnqx87gIOzxRzYmEH//i+OiTA2WAsnofNW
 +jfOcVkElYYMQ6u1eP03+zOMpIICZOi2roAyN7ezI38j9V1kjSqu/fXTj23KhRLniSEMh+yLdjRMh
 yRe+o+7ZB9YfAw0A=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbU2Y-0004bZ-M5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 02:05:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFBC64172E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 02:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE8A1F000E9;
 Mon, 22 Jun 2026 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782093924;
 bh=Lu5iU7fBtv4Chc3ojEDmb6o6SqWI3VKMJzPc8hK6LqQ=;
 h=From:To:Cc:Subject:Date;
 b=LR8Y8W7zFK6TydC2zO+xSIFnWFpzqSY3NZMRh4jT2TxVMn7+CeeSBijiFkjomLgsU
 jfD2Y5smk22rkUClGwQ1fNlj2J+oe+e58WhFP7hcwZLkFX04SjyCUG+Tdom7GlKSYB
 +octpONMW4v4NQy6flDiL4tFGgMQDhKY8LwlHWfKsgLPJYldim5zkf5pvZl3tn1Bel
 KdqpqBL21dxGXQHidvkercGf4uYT6SkX2dJqa+ExIxh0E0nuaOhaCDPxweLHFGBY9H
 hq2iQMizIg8fykZaJptiikBVegwJQ6ivopLs6Kv1lzE2+3qsUC2NS+CE6HX75xXt4T
 VIw0u1eB182yg==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon, 22 Jun 2026 02:05:16 +0000
Message-ID: <20260622020516.2372277-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
MIME-Version: 1.0
X-Headers-End: 1wbU2Y-0004bZ-M5
Subject: [f2fs-dev] [PATCH v2] common/f2fs: introduce
 _require_f2fs_io_command
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Update existing f2fs testcases to utilize the new
_require_f2fs_io_command() helper for verifying required f2fs_io
subcommands instead of basic executable checks or open coding.

Suggested-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2: add Suggested-by tag of Zorro
 common/f2fs    | 16 ++++++++++++++++
 tests/f2fs/003 |  1 +
 tests/f2fs/004 |  1 +
 tests/f2fs/007 |  1 +
 tests/f2fs/009 |  1 +
 tests/f2fs/010 |  2 +-
 tests/f2fs/011 |  2 +-
 tests/f2fs/012 |  2 +-
 tests/f2fs/013 |  2 +-
 tests/f2fs/025 |  2 +-
 10 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/common/f2fs b/common/f2fs
index 82d3102ea..025d29a76 100644
--- a/common/f2fs
+++ b/common/f2fs
@@ -96,3 +96,19 @@ _require_inject_f2fs_command()
 	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
 		_notrun "--$metaarea --mb $member support is missing"
 }
+
+# Check that f2fs_io supports specific subcommand(s)
+_require_f2fs_io_command()
+{
+	_require_command "$F2FS_IO_PROG" f2fs_io
+
+	if [ -z "$1" ]; then
+		echo "Usage: _require_f2fs_io_command command..." 1>&2
+		_exit 1
+	fi
+
+	for command in "$@"; do
+		$F2FS_IO_PROG help | awk '{print $1}' | grep -qw "$command" || \
+			_notrun "f2fs_io $command support is missing"
+	done
+}
diff --git a/tests/f2fs/003 b/tests/f2fs/003
index fbb08a3e9..94885904c 100755
--- a/tests/f2fs/003
+++ b/tests/f2fs/003
@@ -30,6 +30,7 @@ _fixed_by_kernel_commit b40a2b003709 \
 
 _require_scratch
 _require_xfs_io_command "fpunch"
+_require_f2fs_io_command "write" "gc"
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount >> $seqres.full
diff --git a/tests/f2fs/004 b/tests/f2fs/004
index ac824c437..0592e23c4 100755
--- a/tests/f2fs/004
+++ b/tests/f2fs/004
@@ -30,6 +30,7 @@ _fixed_by_kernel_commit b2c160f4f3cf \
 
 _require_scratch
 _require_odirect
+_require_f2fs_io_command "write"
 _scratch_mkfs >> $seqres.full
 _scratch_mount >> $seqres.full
 
diff --git a/tests/f2fs/007 b/tests/f2fs/007
index 37388433e..e45b6cea9 100755
--- a/tests/f2fs/007
+++ b/tests/f2fs/007
@@ -15,6 +15,7 @@ _fixed_by_kernel_commit 26413ce18e85 \
         "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
 
 _require_scratch
+_require_f2fs_io_command "compress" "get_cblocks" "release_cblocks" "reserve_cblocks" "decompress"
 testfile_prefix=$SCRATCH_MNT/testfile
 fio_config=$tmp.fio
 
diff --git a/tests/f2fs/009 b/tests/f2fs/009
index 39a4bad3d..afb3bc98f 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -15,6 +15,7 @@ _require_scratch
 _require_scratch_shutdown
 _require_inject_f2fs_command node i_links
 _require_command "$(type -P socket)" socket
+_require_f2fs_io_command "write"
 
 _fixed_by_git_commit f2fs-tools 958cd6e \
 	"fsck.f2fs: support to repair corrupted i_links"
diff --git a/tests/f2fs/010 b/tests/f2fs/010
index 50e378177..b8899dedc 100755
--- a/tests/f2fs/010
+++ b/tests/f2fs/010
@@ -30,7 +30,7 @@ _fixed_by_kernel_commit 03511e936916 \
 	"f2fs: fix inconsistent dirty state of atomic file"
 
 _require_scratch
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "write"
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount >> $seqres.full
diff --git a/tests/f2fs/011 b/tests/f2fs/011
index 07c94d8c9..aa939c9e7 100755
--- a/tests/f2fs/011
+++ b/tests/f2fs/011
@@ -27,7 +27,7 @@ _fixed_by_kernel_commit f7f8932ca6bb \
 	"f2fs: fix to avoid running out of free segments"
 
 _require_scratch
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "pinfile"
 
 _scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
 _scratch_mount -o checkpoint=disable:10%
diff --git a/tests/f2fs/012 b/tests/f2fs/012
index 53d54bf6b..15b0e5055 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -19,7 +19,7 @@ _fixed_by_kernel_commit 91b587ba79e1 \
 
 export LC_ALL=C.UTF-8
 _require_scratch_nocheck
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "setflags"
 _require_inject_f2fs_command dent d_hash
 
 #check whether f2fs supports "lookup_mode=x" mount option
diff --git a/tests/f2fs/013 b/tests/f2fs/013
index 80ed2702b..086a5b4bb 100755
--- a/tests/f2fs/013
+++ b/tests/f2fs/013
@@ -19,7 +19,7 @@
 . ./common/preamble
 _begin_fstest auto quick
 _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "write" "fsync"
 
 _cleanup()
 {
diff --git a/tests/f2fs/025 b/tests/f2fs/025
index 807f18f23..6fc18d989 100755
--- a/tests/f2fs/025
+++ b/tests/f2fs/025
@@ -20,7 +20,7 @@ _require_scratch
 _require_scratch_shutdown
 _require_xfs_io_command "pwrite"
 _require_xfs_io_command "truncate"
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command gc_urgent
 _require_fs_sysfs_attr $TEST_DEV gc_urgent
 _require_check_dmesg
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
