Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CACC531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjGPdXoLS8DdtrXm12P0bLSkRii3FV9FVqblf6DQAto=; b=IP2Jcu92ADJaQoEMgOBuAf+Eos
	h+2DNAY5IY0yjFuqNX2qpOdHWfj/LaZpqMnKA+B3DKvdMX2P4Du8CoYMSOBWluuuw90iaYUgJwMnJ
	CxNLGrCylHkmoqSBy5HUsAHMaOSNAMR8ulIHJndz5Yh5gaGUMhuVCDvW03pFHtadL3gI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHxy-0002UX-6D;
	Fri, 24 Jul 2026 15:37:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnHxx-0002UR-5H
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2sIIGyJlotQuWLddAjykyOR6DKOtmu1fwVZ8uKAmoa8=; b=hXoLiBLuYzd/qjCr442WN3QoZm
 ZMuhbMDbkwHP8LGgez6WwW2j9BV9a046+9+SsaZ3HxX2OZRf4aqC0u6scnb4LtdRQ5oVUVs6mbdUP
 AIBGbQTxejZxk7Onim1A4+zm9Z2VmpE1QwfZWfOSPEbJ75PaBro6X/WbCJ+13sk8qsU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2sIIGyJlotQuWLddAjykyOR6DKOtmu1fwVZ8uKAmoa8=; b=TGvcROp8ANMCUdSb1nE5tqQAX+
 hcjkC7suhTlC3+vlbdhvZRwvYz8YUXQr0ZtECTWk6ij9XM/IaeTK84RaWUSFi1fzP1QTqq6HfCReL
 U0NhriELBcbXCWtpQQP7c6aLnpamJnQCbjMfzUetzGMtYmIU3DNcBfgFfh9S3N7DLh80=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHxt-0007ob-Dj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:37:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 346A07B84D;
 Fri, 24 Jul 2026 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sIIGyJlotQuWLddAjykyOR6DKOtmu1fwVZ8uKAmoa8=;
 b=oZDI5i5ewo7agjBb4HfFP5q1BxmxpEs7he3EjQiMdEok87VxNFOuCECwTUtKilrqspbJqm
 9G1odPaZFxqb/c8plzFIS6e0JpGNUGwBY+THE43PjqcTaAYSewmqLg8Op5JwCx6kSqt30K
 8Qijeu0PtD2AX8k1PXA7PcZmuAG0aEA=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=oZDI5i5e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sIIGyJlotQuWLddAjykyOR6DKOtmu1fwVZ8uKAmoa8=;
 b=oZDI5i5ewo7agjBb4HfFP5q1BxmxpEs7he3EjQiMdEok87VxNFOuCECwTUtKilrqspbJqm
 9G1odPaZFxqb/c8plzFIS6e0JpGNUGwBY+THE43PjqcTaAYSewmqLg8Op5JwCx6kSqt30K
 8Qijeu0PtD2AX8k1PXA7PcZmuAG0aEA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97C26779BA;
 Fri, 24 Jul 2026 13:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cNb0FLtpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:47 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:23 +0200
Message-ID: <20260724133328.1837318-8-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL8xi6x1pj1uf48mqopq9zr7qb)];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 346A07B84D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Headers-End: 1wnHxt-0007ob-Dj
Subject: [f2fs-dev] [PATCH 07/12] btrfs: test snapshotting encrypted subvol
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
From: Daniel Vacek via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Vacek <neelx@suse.com>
Cc: hch@infradead.org, Daniel Vacek <neelx@suse.com>, djwong@kernel.org,
 zlang@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 linux-fscrypt@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Make sure that snapshots of encrypted data are readable and writeable.

Test deliberately high-numbered to not conflict.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 tests/btrfs/614     |  73 +++++++++++++++++++++++++++++
 tests/btrfs/614.out | 111 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100755 tests/btrfs/614
 create mode 100644 tests/btrfs/614.out

diff --git a/tests/btrfs/614 b/tests/btrfs/614
new file mode 100755
index 00000000..840c3b8d
--- /dev/null
+++ b/tests/btrfs/614
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 614
+#
+# Try taking a snapshot of an encrypted subvolume. Make sure the snapshot is
+# still readable. Rewrite part of the subvol with the same data; make sure it's
+# still readable.
+#
+. ./common/preamble
+_begin_fstest auto encrypt
+
+# Import common functions.
+. ./common/encrypt
+. ./common/filter
+
+_require_test
+_require_scratch
+_require_scratch_encryption -v 2
+_require_command "$KEYCTL_PROG" keyctl
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+udir=$SCRATCH_MNT/reference
+dir=$SCRATCH_MNT/subvol
+dir2=$SCRATCH_MNT/subvol2
+$BTRFS_UTIL_PROG subvolume create $dir >> $seqres.full
+mkdir $udir
+
+_set_encpolicy $dir $TEST_KEY_IDENTIFIER
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+
+# get files with lots of extents by using backwards writes.
+for j in `seq 0 50`; do
+	for i in `seq 20 -1 1`; do
+		$XFS_IO_PROG -f -d -c "pwrite $(($i * 4096)) 4096" \
+		$dir/foo-$j >> $seqres.full | _filter_xfs_io
+		$XFS_IO_PROG -f -d -c "pwrite $(($i * 4096)) 4096" \
+		$udir/foo-$j >> $seqres.full | _filter_xfs_io
+	done
+done
+
+$BTRFS_UTIL_PROG subvolume snapshot $dir $dir2 | _filter_scratch
+
+_scratch_remount
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+sleep 30
+echo "Diffing $dir and $dir2"
+diff $dir $dir2
+
+echo "Rewriting $dir2 partly"
+# rewrite half of each file in the snapshot
+for j in `seq 0 50`; do
+	for i in `seq 10 -1 1`; do
+		$XFS_IO_PROG -f -d -c "pwrite $(($i * 4096)) 4096" \
+		$dir2/foo-$j >> $seqres.full | _filter_xfs_io
+	done
+done
+
+echo "Diffing $dir and $dir2"
+diff $dir $dir2
+
+echo "Dropping key and diffing"
+_rm_enckey $SCRATCH_MNT $TEST_KEY_IDENTIFIER
+diff $dir $dir2 |& _filter_scratch | _filter_nokey_filenames
+
+$BTRFS_UTIL_PROG subvolume delete $dir > /dev/null 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/614.out b/tests/btrfs/614.out
new file mode 100644
index 00000000..bd95b67a
--- /dev/null
+++ b/tests/btrfs/614.out
@@ -0,0 +1,111 @@
+QA output created by 614
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+Create snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol2'
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+Diffing /mnt/scratch/subvol and /mnt/scratch/subvol2
+Rewriting /mnt/scratch/subvol2 partly
+Diffing /mnt/scratch/subvol and /mnt/scratch/subvol2
+Dropping key and diffing
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
+NOKEY_NAME: NOKEY_NAME/NOKEY_NAME/NOKEY_NAME: NOKEY_NAME NOKEY_NAME NOKEY_NAME NOKEY_NAME
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
