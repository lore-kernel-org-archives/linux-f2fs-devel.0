Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16FFCA6004
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ItOJqnTf8pEpEE/o9lB+bh3PYWRTtiVOkPGhm7/JZbc=; b=kb52W8XBDnAr3M5FvfNEJbHgM2
	U68RL1KzepdeOWZZ03zCI/sjExm85+8VdFLEyiIFr2KaDdnShWxxqVxtDwWaExafGVNbaoVPL/Vxl
	0S6/dTjiieSkxZj4iXkinWiop1OsAAq3xihfATlXlvQDAPLLDSP2Qo7CRT0brVmWvjUo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yk-0007gX-9z;
	Tue, 06 Oct 2026 08:56:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yj-0007gR-Ns
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KMVJ5/rbPwetobXP5bW8aSzZHunC22MDIMSqptUPW6o=; b=NDnfydliBOgqEMyBzqDRWuPUuo
 +ywjsv4D/VcDGdq/rtxTXlIGtLhdFUgYJdu2xE4lArTLXHdWXIJ2VckZw3sqZv1qOSBV0+lCw4sdA
 wnIne3jZxYQnhdbz21yCOvJWiktXS9GW3sTrWUSJuvWK5WHQqE8I4xTzjsxVZDkveCck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KMVJ5/rbPwetobXP5bW8aSzZHunC22MDIMSqptUPW6o=; b=hEniA8E2ce+aSsP1Lqh7XxM73w
 5Hz+FRzUeJZ6o8dWQ1HxTSAndplUQufTuXUb8oN79cSK/rzqo/70NHmHoB9GfRDImz53L6jTCQ7tv
 KtjIoTa9nT7r8dqvBWmjtKRz+pMJSf+RWBRNwn/dEyzFd0jaT/zrzILaawonteKlvyaw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yj-0000MY-1m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6AFC601F6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9CD1F00893;
 Tue,  6 Oct 2026 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277012;
 bh=KMVJ5/rbPwetobXP5bW8aSzZHunC22MDIMSqptUPW6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T1PFB9DZHqDZ4jjZxwsqM3Y7RqUwwYmFuXEH6G1+gkmUvpgTgN450HotgQbz47R9r
 eZXwhFoLiZQV4mwCbtI2nI7pnJ+hjvG18iKnxr3xg10ONA23GrQXFR+R+CdsHO1cT2
 l3sV2sqTrbK9L5wJ2rNkiS3iZXLkkeTwxhkcqhXuYMIx4YgUtWpRSIv+QHoeQvJAuR
 GRNVBdkT6zD6zByBn3zE+kjUOoNc2QAz2w1exnGXSdhUWRSPPNMIsNkrBtL4djJARu
 frDQv9FF0Av41Cj2teNd0TRIVf2Pgkp+XFiOfX+qMVW5UtWvy2yEnqgdvpFvh1PNiB
 zG5lPTm4v41dw==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:45 +0800
Message-ID: <7c2209a7384968d252763bfd35289f776ebdd1af.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yj-0000MY-1m
Subject: [f2fs-dev] [PATCH 19/21] fstests: generic/744: use new helper
 _require_clone_mount()
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Replace _require_duplicate_fsid() with the newly introduced
_require_clone_mount() helper to verify kernel support for mounting
cloned block devices with duplicate UUIDs.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc         | 14 --------------
 tests/generic/744 |  8 ++++----
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/common/rc b/common/rc
index 7feeec04a500..58e4c234b0f4 100644
--- a/common/rc
+++ b/common/rc
@@ -6235,20 +6235,6 @@ _random_file() {
 	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
 }
 
-_require_duplicate_fsid()
-{
-	case "$FSTYP" in
-	"btrfs")
-		_require_btrfs_fs_feature temp_fsid
-		;;
-	"ext4")
-		;;
-	*)
-		_notrun "$FSTYP does not support duplicate fsid"
-		;;
-	esac
-}
-
 # Can we find a program in the $PATH?
 _have_program() {
 	command -v "$1" &>/dev/null
diff --git a/tests/generic/744 b/tests/generic/744
index cda10e0f66ba..330d86ce826a 100755
--- a/tests/generic/744
+++ b/tests/generic/744
@@ -25,8 +25,7 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# Modify as appropriate.
-_require_duplicate_fsid
+_require_clone_mount
 _require_test
 _require_block_device $TEST_DEV
 _require_test_reflink
@@ -66,11 +65,12 @@ loop_dev2=$(_create_loop_device "$loop_file2")
 clone_filesystem ${loop_dev1} ${loop_dev2}
 
 # Mounting original device
-_mount $loop_dev1 $mnt1
+_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev1 $mnt1
 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
 
 # Mounting cloned device
-_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev2 $mnt2 \
+					|| _fail "mount of cloned device failed"
 
 # cp reflink across two different filesystems must fail
 _cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
