Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7A8CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjIY8DCB/7Gtqenu3f3VTWs4hPJtvAPt3sUvUblDQsM=; b=Up3d68JleQCB3uPrU8QNR9iXwI
	fVif1SGVna8bJg6V3lrZYe2noXoO8vN0YvwnYgDc7bMv1Vcs+1AO5q9pHYyyiVYAey3elSRoFK69E
	uj/rhxKr1oTAr9KG1wovpnPomY9vMUUGR/iwd3S2G0WMyvsThkEiQ8JeEO9xUINdhIKA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yd-0002Aj-LJ;
	Tue, 06 Oct 2026 08:56:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yb-0002AO-IU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sIQ1rBSTohGKXCssWuhmCPutMCMuff7MWW945lTxsCQ=; b=ZAmWVk6vxWyjZQKFRCFA4AYEb7
 YroPhJKDYpx9IFrKlXkUQnEUY+yudE1mq5/YA0FX1adKBYOqif3vZVwzY9xGHSfLRdS/SkPJXzI5O
 cKTp822xNzSGlPLKs/d7Z97qak9PJ06dUJJWupZDdfPXhiMyfLwLnWlti97CRhzXvnEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sIQ1rBSTohGKXCssWuhmCPutMCMuff7MWW945lTxsCQ=; b=HbBPEnTNyuvFbzMVZUfxB4KrpX
 XanY77r46Km2OONWpVfFG6nZcblD0qR4HRGXh0fOXJq+R5BD/XIe79RVWOhoxby9FHgwyCOVvxAGi
 A5B9jMVcVMKiaLLBHJuA46RMJo4PKQZAcZ0fTkadhUfoYG+vjrsyaf+ptki9b4kexLUg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0ya-00025I-UP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB9CC6053A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46111F00893;
 Tue,  6 Oct 2026 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277004;
 bh=sIQ1rBSTohGKXCssWuhmCPutMCMuff7MWW945lTxsCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kFwbTMmccrcK+qbRkaf3Cm2yz7SPrmNjIBrSlbQu7E+WDg01E+mwChy7YsjJJokV8
 AiSFhi2Yl53Tf7RfmLQ4+v5bhs8r9EcWZqyryBcQggBs/KZGJSY9jfsnOBUg7mrTmf
 0g5NXKwSA+eL64uxzxwo/S0C07qt5E6/gGNGC/khsAbQKz2dCxUoCxj8lnSaICMNHI
 2fch3B1H6QOiyQ9Oet+2XtbodvuasAIZ3TjDH9qwLi4MWQPMdfbJdpvnZbBtsDHzTT
 01KcZIpChC+DWAqo46rDzsoeokeBGxW9XVYznrNS6goHj19VoAnF/rlFSi1BwI5IbV
 qVIPU0JqYEgyQ==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:41 +0800
Message-ID: <40f9fa47341946da9edbe10498c3d8d789ce202f.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0ya-00025I-UP
Subject: [f2fs-dev] [PATCH 15/21] fstests: verify exportfs file handles on
 cloned filesystems
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

Ensure that exportfs can correctly decode file handles on a cloned
filesystem across a mount cycle, by file handles generated on a
cloned device remain valid after mount cycle.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/905     | 79 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/905.out |  2 ++
 2 files changed, 81 insertions(+)
 create mode 100644 tests/generic/905
 create mode 100644 tests/generic/905.out

diff --git a/tests/generic/905 b/tests/generic/905
new file mode 100644
index 000000000000..d69c613110db
--- /dev/null
+++ b/tests/generic/905
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 905
+# Verify that file handles encoded on a cloned filesystem remain valid and
+# resolvable via open_by_handle across a mount cycle and mount order swap.
+
+. ./common/preamble
+
+_begin_fstest auto quick exportfs tempfsid
+
+_require_test
+_require_exportfs
+_require_loop
+_require_test_program "open_by_handle"
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
+# Create test dir and test files, encode file handles and store to tmp file
+create_test_files()
+{
+	rm -rf $testdir
+	mkdir -p $testdir
+	$here/src/open_by_handle -cwp -o $tmp.handles_file $testdir $NUMFILES
+}
+
+# Attempt to read and decode the saved file handles on the targeted mount point.
+test_file_handles()
+{
+	local opt=$1
+	local when=$2
+
+	echo test_file_handles after $when
+	$here/src/open_by_handle $opt -i $tmp.handles_file $mnt2 $NUMFILES
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
+# Mount both identical UUID filesystems simultaneously
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+NUMFILES=1
+testdir=$mnt2/testdir
+
+# Decode file handles of files/dir after cycle mount
+create_test_files
+
+# Cycle mounts and reverse initialization sequence to check if
+# file handle lookups are okay
+_unmount $mnt1
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+
+# Verify file handles can still be resolved post-mount-cycle
+test_file_handles -rp "cycle mount"
+
+_exit 0
diff --git a/tests/generic/905.out b/tests/generic/905.out
new file mode 100644
index 000000000000..234f5ec35863
--- /dev/null
+++ b/tests/generic/905.out
@@ -0,0 +1,2 @@
+QA output created by 905
+test_file_handles after cycle mount
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
