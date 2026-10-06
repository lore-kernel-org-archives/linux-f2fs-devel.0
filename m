Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2B0CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvkJUKI7vCzAd6lgGzhh2V/slLb68zX8SuFkOjs8/eg=; b=EOsgkmC+sRT51iIBTkk6Ujhgsu
	z6Uqo5FEr3LFIZygQq2A7Nki2I+MBRlNc0eFCVT24U4YzZyW48PfBXPR0Thtu+tUf/j84exsNLSdK
	V7/VXoB8bv217X6Kchc/o5pj/bf+IGyPkd+y4kxsJca+w7VNiAdAeocE5jXO9147Z+Z8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yq-0006qp-0s;
	Tue, 06 Oct 2026 08:56:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yo-0006qa-UO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s6TOi4hloUS6fWBXA3KoXCNe28odAO0qsI89LPeuYF4=; b=Tllu6pTAqpJ8CqcjKXbFZ80Dnz
 z1/3ZmU9UNhCIzh9qmAe1FeqpiVUqTXoWmukfgrklKIbPJNkHAECSGRbZM08w6fpgOCEIPTzJN3nE
 VC8+JIHK/qDtt9crwnApFxHDBbg436EAswqCGJoftSFt6HO0acdydPAzSW7PUG5OVoT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s6TOi4hloUS6fWBXA3KoXCNe28odAO0qsI89LPeuYF4=; b=beuxixhVa2S2ULXrNO9xW6vVhc
 S1FFrYGOrRmtNkOt7Gw310Kf3msoWjTqg65U1QtI/ShDngvW8cn4LHFInjePwnBvvsrhOj9I6CTeQ
 /uR1VyDSet+NixP8uahHMJ2Ms0PpAf12XqyY+j5us/cwnWdFwaeUqDQtuZGOGdwoBeQs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yl-0000MY-2a for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC5FE6053A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120771F000FF;
 Tue,  6 Oct 2026 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277014;
 bh=s6TOi4hloUS6fWBXA3KoXCNe28odAO0qsI89LPeuYF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Sy+mIFxGm13eA1H/WQ2KdX6NCOD8jVFbUHew2ENO3s8p89XZeGeh8Ca+nurQ8GchM
 0fus/I1JZ+urMmdF4fBBQTIEU4Q6ixc3YMwgxpJj2ZpyMRLBZgjubtywiR3g0azEk0
 1lNXN2qbzONmF/z0rnaH7snRD8uVwGWlYqz+N9F6rmScN07FxeicIQ4XnLO+3g1vLd
 Ak0dxQemRO7mV7VWcfnmcDz4xz5QUwRe6qpqFXrp33nTc8VTgKH0WNaXI3FL0PydxR
 +UvVKmUT1swVlpP/3IYPMyeHwnd6PomSVn7pqSNd7YuaUW8pnak1KPllf3YHAQWHiL
 8jF+GIkSPKmVw==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:46 +0800
Message-ID: <2d0903ee55156a1a384f95b6e54ce2bacf0c9a77.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yl-0000MY-2a
Subject: [f2fs-dev] [PATCH 20/21] fstests: generic/744: migrate to
 _create_cloned_loop_devs()
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

Switch generic/744 to use the common _create_cloned_loop_devs() helper
to format, modify, and clone the underlying loop devices, avoiding
open-coded clone setup and teardown logic.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/744 | 70 ++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/tests/generic/744 b/tests/generic/744
index 330d86ce826a..c522d6f46713 100755
--- a/tests/generic/744
+++ b/tests/generic/744
@@ -10,71 +10,55 @@
 . ./common/preamble
 _begin_fstest auto clone volume tempfsid
 
-_cleanup()
-{
-	cd /
-	rm -r -f $tmp.*
-
-	_unmount $mnt2 &> /dev/null
-	_unmount $mnt1 &> /dev/null
-	[ -b "$loop_dev2" ] && _destroy_loop_device $loop_dev2
-	[ -b "$loop_dev1" ] && _destroy_loop_device $loop_dev1
-	[ -n "$seq" ] && rm -rf $TEST_DIR/$seq
-}
-
 . ./common/filter
 . ./common/reflink
 
-_require_clone_mount
 _require_test
 _require_block_device $TEST_DEV
 _require_test_reflink
 _require_cp_reflink
 _require_loop
 
-clone_filesystem()
+_cleanup()
 {
-	local dev1=$1
-	local dev2=$2
-
-	_mkfs_dev $dev1
-
-	_mount $dev1 $mnt1
-	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
-	_unmount $mnt1
+	cd /
+	rm -r -f $tmp.*
 
-	# device dump of $dev1 to $dev2
-	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
+	_unmount $mnt2 &> /dev/null
+	_unmount $mnt1 &> /dev/null
+	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
 }
 
-[ -n "$seq" ] && rm -rf $TEST_DIR/$seq
-mkdir $TEST_DIR/$seq
+add_foo()
+{
+	local orig_dev="$1"
+	local temp_mnt="$TEST_DIR/$seq/temp_mnt"
+
+	mkdir -p $temp_mnt
+	_mount $(_common_dev_mount_options) $(_clone_mount_options) $orig_dev $temp_mnt
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $temp_mnt/foo >> $seqres.full
+	$XFS_IO_PROG -c 'fsync' $temp_mnt/foo
+	_unmount $temp_mnt
+}
 
+rm -rf $TEST_DIR/$seq 2>/dev/null
+mkdir -p $TEST_DIR/$seq
+# Setup base loop device and its clone
+devs=()
+_create_cloned_loop_devs devs add_foo
 mnt1=$TEST_DIR/$seq/mnt1
 mnt2=$TEST_DIR/$seq/mnt2
-mkdir -p $mnt1 $mnt2
-
-loop_file1="$TEST_DIR/$seq/image1"
-truncate -s 300m "$loop_file1"
-loop_dev1=$(_create_loop_device "$loop_file1")
-
-loop_file2="$TEST_DIR/$seq/image2"
-truncate -s 300m "$loop_file2"
-loop_dev2=$(_create_loop_device "$loop_file2")
-
-clone_filesystem ${loop_dev1} ${loop_dev2}
+mkdir -p $mnt1
+mkdir -p $mnt2
 
 # Mounting original device
-_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev1 $mnt1
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1
 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
-
 # Mounting cloned device
-_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev2 $mnt2 \
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 \
 					|| _fail "mount of cloned device failed"
 
 # cp reflink across two different filesystems must fail
 _cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
 
-# success, all done
-status=0
-exit
+_exit 0
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
