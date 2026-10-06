Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F21ACA6002
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuQ1oM0k4RyTL7UjsO5Deys1L1n8h1+G9fje0F50LCA=; b=Gb2GRQoNREYK9u5BL+jnq3eAQ3
	DpY79mRqOqLxzIBfKnxKsCvm6W/fFZzSxxBpi9rBVnnq6glFxBnw/fmoyLvWhI/GFS60NMA5nmJO2
	o+gLkV9f30SK+53rHj4dBWHG+Dz61rWs1HlFvOgf2JgjjBkitGtJtodJR6yAFpBnsSxE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yk-0002C4-0A;
	Tue, 06 Oct 2026 08:56:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yg-0002BT-LS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHu7gDlAiTv8ITMcBiXQcO0crJQVWjNEEBbX8nVsW9s=; b=k6vatHKXpZfRSWJcXhqyZZl2FJ
 VNqS6Ht9Nb8Q1mSEKTfHMJfCFByVyKhxVgFkDYS7qewG+xFAIERmTVcVERgq2Nh5F+NxKHGzMs3wS
 /P3C7C/Dc7xlyZDeUZHpIvB0KTeNRPCRAfAclSvzyT0sbZpbNBkoUMynC7R+29lq5oZ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HHu7gDlAiTv8ITMcBiXQcO0crJQVWjNEEBbX8nVsW9s=; b=gcdvbU6YNIkRlG6OK0A8z2lEKw
 lMWFrmI+p4BhvvJH7kbMhC0szzWKPTTUbzxqJg+9lMU2odr1VDuYqgITwpSmY98nr8hDWZ/22uMqN
 C+/gElO88LyrBYYgzDgYfmnmrhnqbmaFFpcFGJI3h8b6juscmSqlEfrCS1H7E9rFbtYc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0ye-0000MY-A6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B537C6022C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8E71F000FF;
 Tue,  6 Oct 2026 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277002;
 bh=HHu7gDlAiTv8ITMcBiXQcO0crJQVWjNEEBbX8nVsW9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f/9yXFvPzboRx+4x8PtFUM7NKtNwOdbevO5JKvZLRhE/Ylv/FumlgU4e7e+uH1SPj
 Vgw5FvschVG2G0lxuBT/2LfghxDpdKWFQUEoChcs5h5nkXJA0cXYXR9rZQuVMo6SDs
 8C7tAEDYpIxCn9v9UKGTiywnaM7CdkfTJR9tEczoLek5+HzVjnQeBL+/jIpsXmSvPs
 R/iyzAtbQJvUA1MI8YGymZWSin4InbsuZjabwf84UeWxzP20u0J2GIiriRePOZ1qeB
 rt1WmuoG/0HKd+/cO7Arn5suVX7AWgzY+LfqgHOzecO7iH6sk8hDki2lg8p3iZYxrZ
 C+X72jFfgrXkg==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:40 +0800
Message-ID: <ed4b48e156ccad10cff02f17ece3c624cc9dd749.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0ye-0000MY-A6
Subject: [f2fs-dev] [PATCH 14/21] fstests: verify IMA isolation on cloned
 filesystems
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

Add testcase to verify IMA measurement isolation when multiple devices
share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/904     | 113 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/904.out |  10 ++++
 2 files changed, 123 insertions(+)
 create mode 100644 tests/generic/904
 create mode 100644 tests/generic/904.out

diff --git a/tests/generic/904 b/tests/generic/904
new file mode 100644
index 000000000000..d8412d0bc402
--- /dev/null
+++ b/tests/generic/904
@@ -0,0 +1,113 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 904
+# Verify IMA isolation on cloned filesystems:
+# . Mount two devices sharing the same FSUUID (cloned).
+# . Apply an IMA policy to measure files based on that FSUUID.
+# . Create unique files on each mount point to trigger measurements.
+# . Confirm the IMA log correctly attributes events to the respective mounts.
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest tempfsid
+
+_require_test
+_require_loop
+_require_security_ima
+
+_fixed_by_fs_commit btrfs df84f6c77377 \
+	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
+_fixed_by_fs_commit btrfs c2a74ed0494c \
+	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
+_fixed_by_fs_commit btrfs 72de4807ba84 \
+	"btrfs: derive f_fsid with dev_t only when temp_fsid is active"
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	_unmount $mnt1 2>/dev/null
+	_unmount $mnt2 2>/dev/null
+	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
+}
+
+# Normalize device names and mount points
+filter_pool()
+{
+	sed -e "s|${devs[0]}|DEV1|g" -e "s|$mnt1|MNT1|g" \
+	    -e "s|${devs[1]}|DEV2|g" -e "s|$mnt2|MNT2|g" | _filter_spaces
+}
+
+# Core helper to set IMA policy and check measurement logs
+do_ima()
+{
+	local ima_policy="/sys/kernel/security/ima/policy"
+	local ima_log="/sys/kernel/security/ima/ascii_runtime_measurements"
+	local fsuuid
+	local mnt=$1
+	local enable=$2
+
+	# Since the in-memory IMA audit log is only cleared upon reboot,
+	# use unique random filenames to avoid log collisions.
+	local foofile=$(mktemp --dry-run foobar_XXXXX)
+
+	echo $mnt $enable | filter_pool
+
+	fsuuid=$(blkid -s UUID -o value ${devs[0]})
+
+	# Load IMA policy to measure file access specifically for this
+	# filesystem UUID.
+	if [[ $enable -eq 1 ]]; then
+		echo "measure func=FILE_CHECK fsuuid=$fsuuid" > "$ima_policy" || \
+			_fail "Policy rejected"
+	fi
+
+	# Create a file to trigger measurement and verify its entry in
+	# the IMA log.
+	echo "test_data" > $mnt/$foofile
+
+	# IMA log extract
+	grep $foofile "$ima_log" | awk '{ print $5 }' | filter_pool | \
+						sed "s/$foofile/FOOBAR_FILE/"
+
+	echo "dbg: $mnt $fsuuid $foofile" >> $seqres.full
+	tail -1 "$ima_log" >> $seqres.full
+	echo >> $seqres.full
+}
+
+# Core helper to set IMA policy and check measurement logs
+
+rm -rf $TEST_DIR/$seq 2>/dev/null
+mkdir -p $TEST_DIR/$seq
+
+# Initialize loop base and cloned instances
+devs=()
+_create_cloned_loop_devs devs
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Concurrently mount both clones
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+#  IMA response on baseline and clone configuration
+do_ima $mnt1 1
+do_ima $mnt2 0
+
+# Cycle mount on the second device.
+echo mount cycle
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+do_ima $mnt1 0
+do_ima $mnt2 0
+
+_exit 0
diff --git a/tests/generic/904.out b/tests/generic/904.out
new file mode 100644
index 000000000000..22340f236a45
--- /dev/null
+++ b/tests/generic/904.out
@@ -0,0 +1,10 @@
+QA output created by 904
+MNT1 1
+MNT1/FOOBAR_FILE
+MNT2 0
+MNT2/FOOBAR_FILE
+mount cycle
+MNT1 0
+MNT1/FOOBAR_FILE
+MNT2 0
+MNT2/FOOBAR_FILE
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
