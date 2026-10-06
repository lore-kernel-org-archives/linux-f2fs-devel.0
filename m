Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68246CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KjdQxw5pztma1hwtOU4K6L8ZixiCpK/WGrquqrNNK78=; b=JtYRR2M5BaptvgcFwMAEmBOPis
	wDD3INgMFZSbaTWoMyQ9J7pL3O4FkgEowOUiGNNASxRartiwKqMgcaAIJscZqVy2V+1DLYCgBMGfN
	PAr9dd2+JnBiKBSid+LOYA1gUdrBei9RHN/lT04YxP2m07SnfEYf5ORAp+UtMkKri17c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0ya-0007eF-D5;
	Tue, 06 Oct 2026 08:56:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yY-0007e8-Rp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BtTskWMnfIlp4MDEJfOPivbfPFh+CkjY5SPbGpSoyFU=; b=GZMPJe0n4Y8BJr89QByH0nTmP/
 sYWGK4Xj6veZo4XcQzUmln1QHwXoQfMJqYia5srd3epC+dnsLUMgyV3B5L2gT8rQwDwwqq2EJSyxo
 8DZXU/AqZyMgoMu0v6Jf87wBHe8Sm0g/LkU2tMdDiZGIpWH2dxq21ASVI9k4sZsBOHuU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BtTskWMnfIlp4MDEJfOPivbfPFh+CkjY5SPbGpSoyFU=; b=DwHOCLakUxSAM4ELK1bteDKA20
 iPAAnDtbNZblDZ8j1uD28TmWEcdUR+mneTuFAa6pkxRs7xJMqNIcpQMgjzDrAuM7NzIa6moPmY2u4
 G+8nIKuiqNL1az8DZYhE7/ALNLdrOp5lm2/dvbp9vAxVS6jLZXshguixi59taXjQ9M3g=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yY-00025I-6q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3F5960234
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4CD1F00899;
 Tue,  6 Oct 2026 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276996;
 bh=BtTskWMnfIlp4MDEJfOPivbfPFh+CkjY5SPbGpSoyFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O/g4Pjl6C6+Op5R0+aOrTDFV5mjokxIgK0TPliBpUwdiKVfLlNjvD41gKfbnx5jSg
 39kfG4Qd2WXRB2q0bPptmMK1Q0Ru/DX4ct4F8uXUrbptpKaKv3WHSKnTCQdtCnXkeg
 MROgu8p46WhcswpABF74ot412084KaYwrq5COIu84aZAVHR0PaXBHCkvJ30evl6f/z
 mmMnrL14MSB44jNvOfSxGD+x+xALpQQedrHYM6gPpoPYSwc4LU8kL40KE8HPVfPD1w
 h33AB+UHeezbVjxEPU/+Pd8scnm0aBFgf0x29OkDnHMyDloMrLzkeBsFHiSC9Rz7Df
 DR4SCbnB52i9Q==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:37 +0800
Message-ID: <98450cf50f0b962f4b6c2b0a16ec10c47362bccd.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yY-00025I-6q
Subject: [f2fs-dev] [PATCH 11/21] fstests: verify statfs f_fsid is derived
 from the filesystem UUID
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

On btrfs and ext4, statfs f_fsid is computed from the filesystem UUID,
so a filesystem created with a known UUID must always report the same
f_fsid. Userspace relies on this, for example fanotify and file handle
users that identify a filesystem across mounts.

Guards against f_fsid changing across kernel versions, which would break
userspace that relies on it.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/902     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/generic/902.out |  2 ++
 2 files changed, 40 insertions(+)
 create mode 100644 tests/generic/902
 create mode 100644 tests/generic/902.out

diff --git a/tests/generic/902 b/tests/generic/902
new file mode 100644
index 000000000000..44dd685a887b
--- /dev/null
+++ b/tests/generic/902
@@ -0,0 +1,38 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 902
+#
+# Verify that statfs f_fsid is derived from the filesystem UUID.
+# Create a filesystem with a fixed UUID, mount it, and check that f_fsid
+# matches the expected value. Applies only to filesystems that derive
+# f_fsid from the UUID (btrfs, ext4).
+
+. ./common/preamble
+
+_begin_fstest auto quick
+
+_require_scratch
+_require_uuid_based_fsid
+
+_fixed_by_fs_commit btrfs 72de4807ba84 \
+	"btrfs: derive f_fsid with dev_t only when temp_fsid is active"
+
+_scratch_mkfs_uuid >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+_scratch_mount
+
+blkid $SCRATCH_DEV >> $seqres.full
+f_fsid=$(stat -f -c "%i" $SCRATCH_MNT)
+expected=$(_scratch_expected_fsid)
+
+echo "f_fsid=$f_fsid expected=$expected" >> $seqres.full
+
+[[ $f_fsid == "$expected" ]] || _fail "f_fsid mismatch"
+
+_scratch_unmount
+
+echo "Silence is golden"
+
+_exit 0
diff --git a/tests/generic/902.out b/tests/generic/902.out
new file mode 100644
index 000000000000..e20395365cb5
--- /dev/null
+++ b/tests/generic/902.out
@@ -0,0 +1,2 @@
+QA output created by 902
+Silence is golden
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
