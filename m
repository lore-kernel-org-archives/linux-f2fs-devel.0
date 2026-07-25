Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE042C531F9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pz2FiiridfLH7WNz0hfj8PNZ6VcnoTlMpeiJpkkyi1Y=; b=liXc54tfltY5Fbz8wunFtcb5dW
	xoKsKZNk3oFKHF2NIpXdjJb+G9jP2FffeffhyZOe1LoGEJ6sjg2KgP3j0DUQZo60LHGQIt8cpX6Pz
	bE+x4mKElqadApb3HE763rgunm/WuSkT3nEOqOrAL9LO8fgDBsCV3o3odXmAwKMFR5GQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzZ-0001Hd-Vf;
	Sat, 25 Jul 2026 07:40:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWzY-0001HS-Uq
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FlMooRTilgvQvegAyzunPUeluQcmMfXOWpgMO7eWB0Y=; b=c51+kcf1Ems6fWlD3LvuDO/DaE
 l7y4eD7SR1gU7wFHWFtJeAnIhqaFSc0DZ44joKVC2sFh/vTTfYyJBQTNkuLGX12qgYqZA7Z4hwsJW
 JHHU696ZZ6rdCt8Xrq41wbEFhUGmUxeLS4JJWOFnn06RtPRdpthulFfkAHS3yg4P6zb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FlMooRTilgvQvegAyzunPUeluQcmMfXOWpgMO7eWB0Y=; b=G5Z8djEMwxlnPgACz2dA44ldhy
 pgdL0RBFLTXN8jy9NL1NePYv07fcp5nrXwvrJ7cB6SkvBxNq2jANyky0NxSO29CI5X5F5H1n/+Mjm
 0wTcK4sY5XKD8gc64BQuflCRRSKHbJm/5i/8J8Io/wJPycqM2/TgdC9L1ghHAwGcJUZI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWzV-0001dD-5T for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:40:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD24B4122F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7212B1F00A3A;
 Sat, 25 Jul 2026 07:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965207;
 bh=FlMooRTilgvQvegAyzunPUeluQcmMfXOWpgMO7eWB0Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CziLR9Q894ixDY6m4AiwjzjfAPdNDQyM45pp2t66QcHiZMxedbTf4QgI4L5y7uvd2
 8KNj+rA1vYblSiAyXI2k/tOEukrjYtAuKS/pd+MRrOYXW3qMMaHcLvPVk/KEBmfn+2
 nLVPWQGr5luTvdwBmqL9yXsyIfVSy6NYmDklRHN4z6GgG96eBjvzmNXLm8/zlm3dfm
 f0Ijriyb1PVPG9g6Xq4Oru6VhQioGauhLkLQexIiRZGiuyRW0flchNtWkfnDQgQc39
 kirirB7OQ2m8us7RLXdWx4A71qreZy/2yZAU0WeoAI0Rht3pJJFtTgPGUrnTu1kmBy
 Vl0VILDnsK6ug==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:07 +0800
Message-ID: <e2ba3b5cf7e17bf87e7e832222d72bcbf8b904f8.1784949155.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWzV-0001dD-5T
Subject: [f2fs-dev] [PATCH v8 10/13] fstests: verify IMA isolation on cloned
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
Cc: zlang@kernel.org, djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add testcase to verify IMA measurement isolation when multiple devices
share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/804     | 108 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/804.out |  10 ++++
 2 files changed, 118 insertions(+)
 create mode 100644 tests/generic/804
 create mode 100644 tests/generic/804.out

diff --git a/tests/generic/804 b/tests/generic/804
new file mode 100644
index 000000000000..ced32e6d79dd
--- /dev/null
+++ b/tests/generic/804
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 804
+# Verify IMA isolation on cloned filesystems:
+# . Mount two devices sharing the same FSUUID (cloned).
+# . Apply an IMA policy to measure files based on that FSUUID.
+# . Create unique files on each mount point to trigger measurements.
+# . Confirm the IMA log correctly attributes events to the respective mounts.
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick clone
+
+_require_test
+_require_block_device $TEST_DEV
+_require_loop
+
+_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
+	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
+_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
+	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	_unmount $mnt1 2>/dev/null
+	_unmount $mnt2 2>/dev/null
+	_loop_image_destroy "${devs[@]}" 2> /dev/null
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
+	[ -w "$ima_policy" ] || _notrun "IMA policy not writable"
+
+	fsuuid=$(blkid -s UUID -o value ${devs[0]})
+
+	# Load IMA policy to measure file access specifically for this
+	# filesystem UUID.
+	if [[ $enable -eq 1 ]]; then
+		echo "measure func=FILE_CHECK fsuuid=$fsuuid" > "$ima_policy" || \
+			_notrun "Policy rejected"
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
+	cat $ima_log | tail -1 >> $seqres.full
+	echo >> $seqres.full
+}
+
+# Initialize loop base and cloned instances
+devs=()
+_loop_image_create_clone devs
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Concurrently mount both clones
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+#  IMA response on baseline and clone configuration
+do_ima $mnt1 1
+do_ima $mnt2 0
+
+# Cycle mount on the second device.
+echo mount cycle
+_unmount $mnt2
+_mount $mount_opts ${devs[1]} $mnt2 || _fail "Failed to mount dev2"
+
+do_ima $mnt1 0
+do_ima $mnt2 0
+
+status=0
+exit
diff --git a/tests/generic/804.out b/tests/generic/804.out
new file mode 100644
index 000000000000..9804181d6c17
--- /dev/null
+++ b/tests/generic/804.out
@@ -0,0 +1,10 @@
+QA output created by 804
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
