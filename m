Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E8CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=loLShRerdiIkH38G2PMNXxfqiT8Mh+KUHILyutpzdhI=; b=C07S2VdfNZo9vfy9eMSYjKLL+q
	XxDEc5UppV/mq0H0w8ot2beXFnHGzV6HZAwvaNODLyy2kZT80Fnp7JZmMCiSEq6z01/cuEDAP2nol
	3yKXxC804krbnczsKjUXidWpT3cbWebsN7bUGTSOfH97EVRFkWqu2ekG3s5rL2pdWqvs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yp-00069M-CI;
	Tue, 06 Oct 2026 08:56:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yn-00068u-UM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n6YiOGHdD1eF0PETDafh7ZLbd8RCK1qUeembi0JxOTc=; b=RyHcab4cI+rLDzuQR4DgEcMbdy
 iTx2NJN2XAaDZE9FgM/aI5CyaV72n3MkXHAhmRCYZ2GumQRMX+1QhLXV0Dl9MCNoJBs7IOWpuMLLG
 vM8m7CvNDfZG/IMAtASSuZXitcVHPdMRyBAteh8iSeGPkOcgwmc9cwULWDSTPSnowIaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n6YiOGHdD1eF0PETDafh7ZLbd8RCK1qUeembi0JxOTc=; b=TgMaa6aOKsblNNuxBxs5DWTjbu
 D9y+Z2890E1IqmUOYFQpMv2oJAtffMi0iwcK4lnD+JIoUA3W0JzYKj39yG7uTaZ1NdkFthq9Es7dc
 Jes3UZiKtEHfouMhSj5w+bit/gXvML/Yv34wDEkQ7GP8aeMA7ezpYHFx2gL3qtUsM+n4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0ym-0000Mr-Cz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFBE4602A8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE91F000FF;
 Tue,  6 Oct 2026 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277010;
 bh=n6YiOGHdD1eF0PETDafh7ZLbd8RCK1qUeembi0JxOTc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oUJxlXtk1C4pP/LVHMt645aW935v/OeN9WvSxdbGDOuYh/2XqoTOMvF7/nNpJ1Hly
 PrahsQQ4YgxlgREqcxTo3fWgEdo0GauF3JMrPtYeUFfaMi+OkZmm9C9EB2G4eUanFb
 mdUSfohxaTHkVckwUNGBXGZVgM99O7PM6Ybt5tZz3y4yW80LYCrhtGnaerjkphzzeC
 NOeiLoFRSLsVZBUhdL+Yr9TcTsnHeZ72HNMVREdMYgxQ71P5XYqxK6gjO6oXgBjmMT
 6CN6lJpRJ7DUOzsV4GYv+vo68uS4IgPMAdUIOzQ4Sv+PEFCiozKAH0vZz9OyHeCmeE
 rbzr3LD98GHJQ==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:44 +0800
Message-ID: <97ba190c96d3fa545404d2c2f489d34f8f9466e9.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0ym-0000Mr-Cz
Subject: [f2fs-dev] [PATCH 18/21] fstests: test UUID consistency for clones
 with metadata_uuid
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

Btrfs and xfs uses the metadata_uuid superblock feature to change the
on-disk UUID without rewriting every block header. This patch adds a
sanity check to ensure UUID consistency when a filesystem with
metadata_uuid enabled is cloned.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/906     | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/906.out |  6 ++++
 2 files changed, 80 insertions(+)
 create mode 100644 tests/generic/906
 create mode 100644 tests/generic/906.out

diff --git a/tests/generic/906 b/tests/generic/906
new file mode 100644
index 000000000000..99516f18aa39
--- /dev/null
+++ b/tests/generic/906
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 906
+#
+# Verify that the cloned filesystem UUID remains consistent, even when the
+# `metadata_uuid` feature is enabled.
+#
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick mount tempfsid
+
+_require_test
+_require_loop
+_require_metadata_uuid
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	umount $mnt1 $mnt2 2>/dev/null
+	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
+}
+
+filter_pool()
+{
+	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
+	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
+}
+
+rm -rf $TEST_DIR/$seq 2>/dev/null
+mkdir -p $TEST_DIR/$seq
+# Create base loop device and its clone, applying the metadata_uuid tuning
+# callback to the base filesystem before the copy occurs.
+devs=()
+_create_cloned_loop_devs devs _change_metadata_uuid
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Get the uuid from the source device
+fsuuid=$(blkid -s UUID -o value ${devs[0]})
+
+# Mount both clone and baseline
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+
+# Cycle mounts and reverse the initialization order to ensure UUID tracking
+# doesn't mismatch or flip when metadata_uuid optimization is active.
+echo "**** mount cycle ****"
+_unmount $mnt1
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+
+findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+
+_exit 0
diff --git a/tests/generic/906.out b/tests/generic/906.out
new file mode 100644
index 000000000000..b484c86d8e7f
--- /dev/null
+++ b/tests/generic/906.out
@@ -0,0 +1,6 @@
+QA output created by 906
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
