Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE341088E6C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdkF2Y70mXlV5nnyLErbn1SHPAT480WXvZ17Sm+Gy8M=; b=C7f9O8B5N50FNJR88UMqdkHQ8n
	SrwAdvaPEF1cQY9XDAPyAjucRFCIX9PzIoJSIbUfYNf/e+V9NqPiSigAuokPcg/gmRTfnpy5GF6Fo
	nNGedDGNKV9IjXfiqei0FiwoFQweNwQrcoaWcG2ym1jwAGRZnynTr8fL5zSzXgQA4HTo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w34C6-00021f-Hh;
	Thu, 19 Mar 2026 03:37:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zangyangyang66@gmail.com>) id 1w34Bx-00021C-DE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 03:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipsFlYVfOKCr6YOZKvfWrNWgXcDy5diQv/ooGkEria8=; b=UvmE0XJRYNZ/fRNZN6/j1Xm+2/
 5X7A57cle1R8IfIsi+YPuP+Intq3LtItvctW+NFe9SCgwLZNqcbY/7zSpPYJb7ZKvap0p9meFx83L
 Gd4uvU+C2GqIYxcMpG+QahA6MP9VeR8uTcmfCmEyjemBMy2OV7hNDPCZISE3kxy7JH6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ipsFlYVfOKCr6YOZKvfWrNWgXcDy5diQv/ooGkEria8=; b=gvzrxclWAy7jMLh+CdfzKfrzRc
 BpviqsSALLgYnitrvXIVsEPBYyxVysPZnvQPLSDMQMy9yOwMG6f8lY3VexEppDEgfDPPv+VNNaTOj
 DI0vHQbMAel+GPZi6pyQlxlJeEEecXs7gU7Jcvt7m9UgX+J7kp9K2sXm9fHqMtF8szWY=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w34Bx-0001ib-Oc for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 03:37:02 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35b9fb3f57eso239514a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Mar 2026 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773891416; x=1774496216; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipsFlYVfOKCr6YOZKvfWrNWgXcDy5diQv/ooGkEria8=;
 b=YuHuT09XCoHNf/kMzpc7/I5lGKA3uCtfbGKXoT1qZSgtuiHwelkb3PHKEXxgz2OWn3
 EH/zMGQBnUc8P0HsZMHJrXtZ4SFyfWS0o/G51fCeMXXzbu9mupPicFf5zuP3ZDsFxOA1
 TwG/MTtG9mbll7ytp/gEQbvon7ENHhRe4Q3ipaqBOK/nBfoDlkC1F/aeVj9OlhI7p/4f
 UZXlMNGk/cLv82Uw1dpE8HAi54vvf6d1/LMptZXA0ARlS7V+USe/47MucyFZmkZJTIsx
 fjesbUXmJK57qBBdA/pDpmUxrbUHXJB3EEsqRhSG62YPrcm65eOZRF5wpMWhNMS8SOC5
 AMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773891416; x=1774496216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ipsFlYVfOKCr6YOZKvfWrNWgXcDy5diQv/ooGkEria8=;
 b=OdG3zfvWaYlPUxQayKsrWLCtt6IWudDsdPxWcsRMXNBVJts/0W8dhwPD5UPy3w0bgs
 IIZMxiJP95wdYduXtH8EzRH9UowqCfWeZzV4XjPkFtwk5yTbwEqWTlN8UM4PNxNpVD6o
 Ali7Y+d2dQU6kIa15lXToNFJ1Cpa98RrqKrolDMap0auUgDZSGpyUmjG6yqRcd35VEXa
 OxRBib+umqOLs6AL/WEBZ0r9sRw0XsBnx9J2te1eTK/1AsdQ3VKDfXCJWeZn7g/5MpTw
 n6e5QgU1cvvhayNEyVGvqta0yaxeVhlq24SQ27Pk/X+Q0mvjaAUHNCxOZWRe6z3oP4Uf
 e/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWdr1FyRyP1kA7K9+MK34TweZELSDLFuVsEEIbZbHIjxDYR6FXZjGybfXuorDLA+KCQR1fojJW5xsXADTpHSbm@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw6ldyWd8VCfH0lKURUkivBFfuRfEDIV2v+tkgmwPw/Ngje57Y8
 zoeWGm1NYd8PHbZMkH7lbQjj/W5Qi78GgM1FOK3VHSM+r1QbxjutTqwaH2Xd2g==
X-Gm-Gg: ATEYQzxbc1bnwJ2gnlnN1Is4QwjRdRcpzZgTMgJT1u/MyBYlZxps7ArdpFGl9gOi8wz
 Wui8hR+Ql6Vm/T/nvQ+iYFyhvAUQrOGEB9vmMFcRLuoJBoMKBBhgf+m68TXxlPPrddGTQysFzVc
 /FciBD/dB2Jnpl7T95dosfwluYTd6kt7zAm2Z5rGSXggfq9eMhbTl4t2jMg5Aa3/ezV7QemUb0c
 821uay3tTfEbGG251OCYbAmnH22PMOE/wEeZizVh5tjEn/BzZQwOgisHavlfZTTjl/UyU2518Tt
 T4OHiBNNmw31B2ccFGkPP+vorSmpoEUqWpRtODXUyQ/Ergz5Gu4chAtvTqnEKkNmJfPC2KRLG+l
 TuotLEnJZ+Ggu1qRThPT456H89VVX+kBVpc6mZvr/sXXSG+fYHG0onHY4BDdUQFcBO1zO8CXM3K
 8u+sQP43tzaG+5YDbJYpCydQ/LN1Q68pk=
X-Received: by 2002:a17:90b:4fd0:b0:35b:952c:43c8 with SMTP id
 98e67ed59e1d1-35bb9e4f933mr5047549a91.8.1773891416015; 
 Wed, 18 Mar 2026 20:36:56 -0700 (PDT)
Received: from zyy.mioffice.cn ([2408:8607:1b00:8:de2a:6d3a:185:22cf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bbabae770sm1994294a91.1.2026.03.18.20.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 20:36:55 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: zlang@kernel.org
Date: Thu, 19 Mar 2026 11:35:19 +0800
Message-ID: <20260319033519.3954784-2-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
References: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1w34Bx-0001ib-Oc
Subject: [f2fs-dev] [PATCH 2/2] f2fs/024: add testcase to check resize
 corrupting root inode
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Yangyang Zang <zangyangyang1@xiaomi.com>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a regression test to check whether the f2fs root inode
is corrupted after the resize operation.
During the resize operation, SSA data blocks are migrated and
zeroed. This process may incorrectly zero out the main area
blocks, leading to root inode corruption.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 tests/f2fs/024     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/f2fs/024.out |  7 +++++++
 2 files changed, 46 insertions(+)
 create mode 100644 tests/f2fs/024
 create mode 100644 tests/f2fs/024.out

diff --git a/tests/f2fs/024 b/tests/f2fs/024
new file mode 100644
index 000000000000..1ca7ee27c18b
--- /dev/null
+++ b/tests/f2fs/024
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Yangyang Zang.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/024
+#
+# This test case tries to check whether resize.f2fs can correctly
+# zero out ssa blocks without corrupting the main area blocks.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_git_commit f2fs-tools xxxxxxxxxxxx \
+	"resize.f2fs: fix to avoid zeroing main area blocks in migrate_ssa()"
+
+# magic size
+target_fs_size=$((2*1024*1024*1024+4*1024*1204))
+
+_require_scratch_size_nocheck $(($target_fs_size/1024))
+_require_command "$F2FS_RESIZE_PROG" resize.f2fs
+_require_command "$DUMP_F2FS_PROG" dump.f2fs
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+_scratch_mkfs_sized $((512*1024*1024)) "" "-g android" >> $seqres.full
+
+sector_size=$(blockdev --getss $SCRATCH_DEV)
+target_sectors=$(($target_fs_size/$sector_size))
+
+$F2FS_RESIZE_PROG -F $SCRATCH_DEV -t $target_sectors >> $seqres.full 2>&1 || \
+        $F2FS_RESIZE_PROG $SCRATCH_DEV -t $target_sectors >> $seqres.full 2>&1 || \
+        _fail "resize fs failed"
+
+echo n | $DUMP_F2FS_PROG -d 1 -i 3 $SCRATCH_DEV | grep "dump_node:" | sed 's/^\[[^]]*\] //'
+_scratch_mount
+
+status=0
+exit
diff --git a/tests/f2fs/024.out b/tests/f2fs/024.out
new file mode 100644
index 000000000000..a7a553f0681b
--- /dev/null
+++ b/tests/f2fs/024.out
@@ -0,0 +1,7 @@
+QA output created by 024
+Node ID               [0x3]
+nat_entry.block_addr  [0x1a00]
+nat_entry.version     [0x0]
+nat_entry.ino         [0x3]
+node_blk.footer.ino [0x3]
+node_blk.footer.nid [0x3]
-- 
2.43.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
