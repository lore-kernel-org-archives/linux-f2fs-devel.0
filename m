Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC41CD98F0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMLtPr3pTtxmYs2zUjN3Iy09BmN9FvwiLj94EzRSexc=; b=YOesO9LHKun+rezgnJGR01ENCt
	qLCS9jeu+bLRWxXUgEbkrb9Kd3msRY+ny/pPUivsnhUpgA52tDrG+05gmX1PSv7nq5cYM/8nB2ONk
	yMpC+bfodEY/UYY5V36uQt1GfQSZRR2ecipzGYJcOd7shs4snp21VgoUMQ4VZPHwCJyY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZoL5-0008HH-WB;
	Wed, 17 Jun 2026 11:21:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wZoKd-0008FV-EY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=59hR12Fh7OpPXrpLzZyElHGF/zwJFzn0kyHqlK4pJZk=; b=HmeiDRPB5cNsxJxjuVDE1pvF8W
 f7GALtomjEd7b+qTzmKhAU0s3XbRaHXVFOr/nJcj3A3rF4xs/6kZTwQWq2CYAxgvKIlZesOaL6q4Z
 BJssXkt+LzUFP54Il1OXNdd4LAuVzBV6DgYkFx7YAQu8GDPuUtrE3Q81p5sgGhrnoqFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=59hR12Fh7OpPXrpLzZyElHGF/zwJFzn0kyHqlK4pJZk=; b=RYNFuarp/+uIiF9fO1vIK3/7hc
 MfMwk6SejCDaYaSeRiE4VkvUmW1fqeBTapZo74UOzgH7Bof7PSEPKB86Su4QY0skiaSdoIzmv7E2V
 RR80nADLEPoAbXhWeack/snyD7nJSC5U7hmyZOZE1mYd1ciSPShf8DBYkbb/nWn1qRqs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZoKb-0002OC-1J for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEF9E60121;
 Wed, 17 Jun 2026 11:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC511F00A3A;
 Wed, 17 Jun 2026 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695266;
 bh=59hR12Fh7OpPXrpLzZyElHGF/zwJFzn0kyHqlK4pJZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lUkHrQA+YONO3oj4BSOoZBmQZ1gR3OizoXOhJk32IOEr9/M76A8rLHIT7mCWg3uGS
 ZJVSN8P0Q3sxeYmOpZCXL9PT9DeLA4JJhpytQ++q7xZDUiM7fU/GzM8DgGbSc8morg
 s+jO7l+sNwAD5tmKDkrVMO+02NrogchtShJCp6bt2SW6honqI9hcPlPgG67owuhXLr
 E/GS2Bth9kUhHLlMxjAIy6ZlR1Wk+5Geiz9td6Ne/+e2ykuLn9m5unxSDOwiaqMrk8
 SzeT92yc07Hocc0UC6+0l9X9GABxxsiyL5UVyd/e6f0SAImico/pDdhm9XBjFBsIGx
 aOkZHK+LmjOdw==
To: fstests@vger.kernel.org
Date: Wed, 17 Jun 2026 19:20:34 +0800
Message-ID: <1cedecd48612d912c7501ab1f88be1c70c4aa1b2.1781694879.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781694879.git.asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZoKb-0002OC-1J
Subject: [f2fs-dev] [PATCH v7 07/11] fstests: verify libblkid resolution of
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
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Verify how findmnt, df (libblkid) resolve device paths when multiple
block devices share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/803     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/803.out |  6 ++++
 2 files changed, 78 insertions(+)
 create mode 100644 tests/generic/803
 create mode 100644 tests/generic/803.out

diff --git a/tests/generic/803 b/tests/generic/803
new file mode 100644
index 000000000000..77901592366c
--- /dev/null
+++ b/tests/generic/803
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 803
+# Check if the mountinfo based findmnt would resolve to the common uuid
+# as per the blkid (libblkid based).
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
+# Normalize pool devices and mount points names
+filter_pool()
+{
+	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
+	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
+}
+
+# Setup base loop device and its clone
+devs=()
+_loop_image_create_clone devs
+mkdir -p $TEST_DIR/$seq
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Get the uuid from the source device
+fsuuid=$(blkid -s UUID -o value ${devs[0]})
+
+# Mount both identical UUID filesystems simultaneously
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
+# Btrfs assigned a random uuid for the clone fs before the fix.
+# Cycle mounts and reverse the initialization (source and clone fs) order.
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
diff --git a/tests/generic/803.out b/tests/generic/803.out
new file mode 100644
index 000000000000..3a130c662430
--- /dev/null
+++ b/tests/generic/803.out
@@ -0,0 +1,6 @@
+QA output created by 803
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
