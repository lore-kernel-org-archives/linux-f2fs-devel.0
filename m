Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A887CA5FFF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCl4SWtyz0SQRQ4YsS/i4+ovkelP/6Ucq3bJ6MQTb/4=; b=eU3hwO1TorzRplxzf0W4zYFBL1
	2btR7XC0FPuJtqgKnC3odAnOxHLycBZHvPb7LH+qbqDWTkpgxCeyzqlhVsTPLnQslMY1k5R4bCIOq
	2omGH6RNvXET+vFMn+Y2DF9yG+k2tbOLlaNjMvL1j0dDJo2jSdS03/MQ4WVZxOuB8Sw8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yc-00067N-Mj;
	Tue, 06 Oct 2026 08:56:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yb-00067A-Bg
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rVp24MqqHiuT/y2pf5QFaoxVDpmr3Y/Sq6SL7jXJJYE=; b=drKAai/1DyNnH0FnD+YWaTv/Ag
 cyg8EDfwJfPggHvNpc9mMF+ky6zX2ASbaj+P3wDAmTnCSVgLj/7CBsRpmH47BnVyjVE4fQU9oL6eN
 FDrni/NPXp/uFiSqBCKCj7/9UMWncPbgtZmU5rL4m11C+jPGVKzLtf0zEIPd+aBsbvRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rVp24MqqHiuT/y2pf5QFaoxVDpmr3Y/Sq6SL7jXJJYE=; b=WnxCWexLgXU+RsJLEE8eZqormZ
 J7sh9H+EPlEqEvfUq4iECPE1bQj0IGea1wK82JkroUGH2zHeHg7OY8nMovpFoPNOa1LyRLho7w6Xh
 LBptLngJ5cUkeddmoYVRqXRwQiu6NQ2Royjc5mJa6qIKxpokcLVRou7bD3Ls1kOWrtfc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yZ-0000M6-PH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DA0343960
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D344E1F000FF;
 Tue,  6 Oct 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276998;
 bh=rVp24MqqHiuT/y2pf5QFaoxVDpmr3Y/Sq6SL7jXJJYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RT1dP/yEyVA0tpYfvgb3+liETzh9f+bN/rPzfkxA+u4R+PH2+8Vo0NVfLzwzD5zI+
 F2JT1zBq+RkJ0n8G06MeYPKi+H2a7988Cs4/nSanyaMDXXGb5jlIKOWwBOaZWg9gGV
 aDaqfWzLfMufAT1USqqThfXWXRmYHTu2frFMLuTKppdebxNcc2RJvcFmrxsJDEpKJB
 gZWD53IDjc9ZP0lyvhd5SonnZsdpMvvXxUZbS8ixGoAaxDpBAAn6TUjWgaottNbPyf
 fs0bc9bUNtDCD0q6br/lJXmB5KhX09Q2MtN6WZhhUTQ28N2Vxos+AV/QA+sLlcsfK9
 sZuVSeSyqcjrg==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:38 +0800
Message-ID: <819a40991baec14ff589da95f3e68af91c33fdf1.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yZ-0000M6-PH
Subject: [f2fs-dev] [PATCH 12/21] fstests: verify libblkid resolution of
 duplicate UUIDs
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

Verify how findmnt, df (libblkid) resolve device paths when multiple
block devices share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/903     | 71 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/903.out |  6 ++++
 2 files changed, 77 insertions(+)
 create mode 100644 tests/generic/903
 create mode 100644 tests/generic/903.out

diff --git a/tests/generic/903 b/tests/generic/903
new file mode 100644
index 000000000000..d8aeba691fd4
--- /dev/null
+++ b/tests/generic/903
@@ -0,0 +1,71 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 903
+# Check if the mountinfo based findmnt would resolve to the common uuid
+# as per the blkid (libblkid based).
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick mount tempfsid
+
+_require_test
+_require_loop
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	umount $mnt1 $mnt2 2>/dev/null
+	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
+}
+
+# Normalize pool devices and mount points names
+filter_pool()
+{
+	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
+	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
+}
+
+rm -rf $TEST_DIR/$seq 2>/dev/null
+mkdir -p $TEST_DIR/$seq
+# Setup base loop device and its clone
+devs=()
+_create_cloned_loop_devs devs
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Get the uuid from the source device
+fsuuid=$(blkid -s UUID -o value ${devs[0]})
+
+# Mount both identical UUID filesystems simultaneously
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[0]}" | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[1]}" | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+
+# Btrfs assigned a random uuid for the clone fs before the fix.
+# Cycle mounts and reverse the initialization (source and clone fs) order.
+echo "**** mount cycle ****"
+_unmount $mnt1
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+
+findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[0]}" | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[1]}" | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+
+_exit 0
diff --git a/tests/generic/903.out b/tests/generic/903.out
new file mode 100644
index 000000000000..7683506e1c94
--- /dev/null
+++ b/tests/generic/903.out
@@ -0,0 +1,6 @@
+QA output created by 903
+DEV1 MNT1 FSUUID
+DEV2 MNT2 FSUUID
+**** mount cycle ****
+DEV1 MNT1 FSUUID
+DEV2 MNT2 FSUUID
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
