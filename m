Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D167C531F9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nvhviGuylWYZYLy49/mAVkb4B1I+2kq7AD92XA1VVtQ=; b=S5Hwnxvh5P9FgTvnDXtm81Wwq2
	M7pePSpGDZH++ce6etGAjqcoNhFKE8pFIHuZam3WjMHsw4Y7oZqoZXgx/fAnztyMgV4QMBMdF5CR7
	LfajWl2Lqnpsh5c1qIncmq9OR+q5CLfA3bP19Lt3nXQemZAQlIaHi91TnySFYcYVGsE0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzk-0003Az-7s;
	Sat, 25 Jul 2026 07:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWzi-0003AZ-R9
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qcH4sN23EYZsX+hkptHPBiYMtvNCnMjEtuTUDDaOdLg=; b=PUd2XowkCSrjBIRiLP8riz3qHJ
 3AgcNl5QYFCnZ1fD0R8raX/wUQYgfjLs/K8rqS3Zed9MMsqsXx00UX3QlRKtKkFq7s075LMxHrFc5
 QdZIGZtTfg+VEv5ib0MvKt3f2mMJDETXz3jDDZ2rrPWbDOkGAtWPxTaUXsr0rn+UfQ7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qcH4sN23EYZsX+hkptHPBiYMtvNCnMjEtuTUDDaOdLg=; b=FwOP3bEmBazHPYtv3BSN++dY/5
 OoiNKLI/v3wka96THqgnM8rAjQkb1OQmdGf8lXm6hiZGWzK9T7WJruyHnzv29QsUWFozR16DGBF58
 BcCLmTegJmIYE5pHTe3qGPjaPrwL8vTbUDqvlumrp8Or9Cdpcv+4o2RYYRzlk8SttUSs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWzm-0002HZ-Mp for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:40:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC563419CF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C36B1F000E9;
 Sat, 25 Jul 2026 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965221;
 bh=qcH4sN23EYZsX+hkptHPBiYMtvNCnMjEtuTUDDaOdLg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=almUkf+iQVK3XYMIc2kTxamUlbqr+NsfVj7RhpotbB4faZozskIyQO3/IHe+HLVaQ
 LwYC4/tYSnPEQWp2K8PsMn764/lPZJc1j7/64nAaGV5bW6bBVf/KWEuPkhcnThHTh9
 G84vI4HOC/d/OcdYC0TjjWDaF0y59pwYDqZduYG0Z2rUzGDj7k/KYAphQWAQQu/07/
 VA7vf5qx6C9wGYvZjAirlGcuI9iIaDPmIO9u8O24VvzgTM7EN2HfFyKrVjbwzsaBIz
 F6rJjzwzhMGBjVZiPSCxyF9vJbOXoMOKoIQPHWpxdrk/WipoevFZmZyYTrvehsZ0nE
 sy06HekvfB6eQ==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:10 +0800
Message-ID: <905a961a3bb2ec345285f056053e3016ad3bef6e.1784949155.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWzm-0002HZ-Mp
Subject: [f2fs-dev] [PATCH v8 13/13] fstests: test UUID consistency for
 clones with metadata_uuid
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

Btrfs and xfs uses the metadata_uuid superblock feature to change the
on-disk UUID without rewriting every block header. This patch adds a
sanity check to ensure UUID consistency when a filesystem with
metadata_uuid enabled is cloned.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/806     | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/806.out |  6 ++++
 2 files changed, 80 insertions(+)
 create mode 100644 tests/generic/806
 create mode 100644 tests/generic/806.out

diff --git a/tests/generic/806 b/tests/generic/806
new file mode 100644
index 000000000000..6d3166491006
--- /dev/null
+++ b/tests/generic/806
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 806
+#
+# Verify that the cloned filesystem UUID remains consistent, even when the
+# `metadata_uuid` feature is enabled.
+#
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick mount clone
+
+_require_test
+_require_block_device $TEST_DEV
+_require_loop
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	umount $mnt1 $mnt2 2>/dev/null
+	_loop_image_destroy "${devs[@]}" 2> /dev/null
+}
+
+filter_pool()
+{
+	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
+	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
+}
+
+# Create base loop device and its clone, applying the metadata_uuid tuning
+# callback to the base filesystem before the copy occurs.
+devs=()
+_loop_image_create_clone devs _change_metadata_uuid
+mkdir -p $TEST_DIR/$seq
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Get the uuid from the source device
+fsuuid=$(blkid -s UUID -o value ${devs[0]})
+
+# Mount both clone and baseline
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
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
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+
+findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+
+status=0
+exit
diff --git a/tests/generic/806.out b/tests/generic/806.out
new file mode 100644
index 000000000000..918f422ecddf
--- /dev/null
+++ b/tests/generic/806.out
@@ -0,0 +1,6 @@
+QA output created by 806
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
