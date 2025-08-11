Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D0FCA0EC1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Aug 2025 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZiTFZS0KoGA8X+Nk3R61Ff9Ol1rfQlu055IGdrNeA4=; b=mvSKWARuQfugm6IIUrNmD40c8x
	QwCgKgdQRzO45VI07pBzHmB2kQfI6mndtkt8vhuo0n+kao8UvI+TckoZkUyT60WXZ8iUX4naCj2Zs
	aEaeC3YRsA4IPxPgjk6STKAwXWCoRzOGVIk8SJK9zAx1VGhZAdEbCEHpkW0cheIfLtmk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ulP5Q-0008BE-8P;
	Mon, 11 Aug 2025 09:45:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ulP5O-0008Ad-PX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 09:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YvNGa/+i8Ohmb/T6vpZ7vHS4hyhpFFf1OLF0yLGYVo8=; b=lV0mdLaNJnGkOXfiLjYrvk+iYY
 KTi1CbUCCd+H35reT+J9o4TGl4beJC19pOHkDbZJydDe+tfhfki+Si3TrSkIy5d0lq1JXrEg+F8RF
 vdemVtj4zTwweJWtAhsZFkUMbIXzj9mMK1epeNUMpKC5UDm7KqKUVNuh9LFQq+EDqqJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YvNGa/+i8Ohmb/T6vpZ7vHS4hyhpFFf1OLF0yLGYVo8=; b=SPSWim7aXhERpPYFZ8BQ6IvUnF
 m6tZ6k+8VZLSVcTHd8qewzPV0f5gCjmitXiEwB6W6VkiyRk5xh7LQiGZFEsm1VR3tA61lFGwK2gt1
 3i5OO61LUjVTJCcbmgUBf9fv9/4+RYhQMlu23EegLYTs1i/e2X9Pp/rtaNzBfV34HEmU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ulP58-0001zi-Pf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 09:44:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 07DF65C5F80
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Aug 2025 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E76BC4CEED;
 Mon, 11 Aug 2025 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754905471;
 bh=LKcb1574o+3PoXZ7MKHkrqJSJnJcs5pnN0cceyo12IE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AXoZ88IFZJesgEgXhZJao5GyQtO1veDMVXUjly/qVnnXTvdoi8UqIhjtcqEavmTWM
 fSn3V1cyjY0n3hWQwbyrrLwm88yIP0heb6dnLjfzihzGfoNfcGEFoc4TSynTnUHvlA
 Vq2fh64Ou3bKsiPTGdL92SzQRf/LDxf74bY0N+x7cwtV4YWLrRB8ytexL38YLMfitz
 2NKYTXe7V6fSlCdB+sjh9XBAm3GWKypecWLcpx7zdoMRTeK6mpghqvO9ogmqevSNyX
 gqwCnIQJvyYA4r3M/QmmWy1LNb22HqOdeAwH+iYRMSrJflfNS1PTiaVVsyvgRtb5qU
 ZfyDEtXHu/RmA==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon, 11 Aug 2025 17:44:15 +0800
Message-ID: <20250811094415.1053545-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250811094415.1053545-1-chao@kernel.org>
References: <20250811094415.1053545-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ulP58-0001zi-Pf
Subject: [f2fs-dev] [PATCH 3/3] f2fs/020: do sanity check on i_xattr_nid
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a regression test:
1. create directory
2. add a new xattr entry to create xattr node
3. use inject.f2fs to inject nid of xattr node w/ ino in a file
4. check whether f2fs kernel module will detect and report such
   corruption in the file

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/020.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/f2fs/020
 create mode 100644 tests/f2fs/020.out

diff --git a/tests/f2fs/020 b/tests/f2fs/020
new file mode 100755
index 00000000..a6a08c8f
--- /dev/null
+++ b/tests/f2fs/020
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/020
+#
+# This is a regression test:
+# 1. create directory
+# 2. add a new xattr entry to create xattr node
+# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
+# 4. check whether f2fs kernel module will detect and report such
+#    corruption in the file
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_cleanup()
+{
+	_scratch_mkfs >> $seqres.full
+}
+
+_fixed_by_kernel_commit 061cf3a84bde \
+	"f2fs: fix to do sanity check on ino and xnid"
+
+export MKFS_OPTIONS=""
+_require_scratch
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+testdir=$SCRATCH_MNT/testdir
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o user_xattr,noinline_xattr"
+
+mkdir $testdir
+# add a new xattr entry to create xattr node
+setfattr -n user.abc -v 123 $testdir
+
+_scratch_unmount
+
+# inject i_xattr_nid w/ nid of inode node
+$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
+
+_scratch_mount
+mkdir $testdir/dir >> $seqres.full 2>&1
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
new file mode 100644
index 00000000..20d7944e
--- /dev/null
+++ b/tests/f2fs/020.out
@@ -0,0 +1,2 @@
+QA output created by 020
+Silence is golden
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
