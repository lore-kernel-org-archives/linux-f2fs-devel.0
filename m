Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A81C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCkH6m5KrbNY4P81duQuw2gEeL/fM/FJ40hpVprll5M=; b=OJOnP6evyLPoQh9Tv1tIHB6/Ag
	q3NyOz48lNTYdcza6Y6fPrR3Wee+BECdVuWv+30sZe8ex5UY/lfOIxqAK/CmDOfiSKM+pSML8k5xE
	VO/ncf0BnnuDyOeDaKhobyP0JGQC0yiA5wVcZPLmCdW62lBPdTwSqeqMEOqZw43dewXU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHmD-00068e-8e;
	Fri, 24 Jul 2026 15:25:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnHmC-00068X-70
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dDkj4/XaZCB/3RGw6WFW1ZhjB+XY1FzxG2VHfm9q1zw=; b=J4kZ0srAejhP3r9J5DOV5S943k
 ywDfZCkj0ru5YG8QmXK/hTBrDgqyV1JAVh5EO2Zh8Z8Vy32/QkHzoWP5BMOv/o7fa/jiA4hcAhvjF
 G3sWZDTzLZZVlYv+llrO61VmBftZuAMwBaQ2JWiA20HPc9Wg1Tb3nBytxRu41wAgY+vU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dDkj4/XaZCB/3RGw6WFW1ZhjB+XY1FzxG2VHfm9q1zw=; b=l9kCBjku0f5jBWepUi9wSwW4y0
 GqM4LOADdwGxwHeiCF3TAnk8ntEqFfGJ0EO15vUVvGYIB1WRT7G+snTpk95NMJFr7xYFkmPVcGI9x
 gW63ZdVp7ySRcDJsqhmySICn0Vb7ItXrYssYeawb3oOd2Dd5pryWqXjqaIWOCT3g1pkY=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHmB-0007Mh-81 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:25:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 426FF3F58;
 Fri, 24 Jul 2026 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDkj4/XaZCB/3RGw6WFW1ZhjB+XY1FzxG2VHfm9q1zw=;
 b=dvrScDRFg7hbmYFkkSATulRQNReIBu8GNs0Pu/CuOutAsHzIIjm0hoCU5C3Jy7kgxa4UdC
 2luPawCAxuWOkeFbf72NW4lu+yH/6zQvsGN2xW8VJ8y3lEIkTAKJW3essZISgWp6pzWaPf
 aHpxBN/s5kCz0oY7VFa3Bvjj12CSQ/k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDkj4/XaZCB/3RGw6WFW1ZhjB+XY1FzxG2VHfm9q1zw=;
 b=dvrScDRFg7hbmYFkkSATulRQNReIBu8GNs0Pu/CuOutAsHzIIjm0hoCU5C3Jy7kgxa4UdC
 2luPawCAxuWOkeFbf72NW4lu+yH/6zQvsGN2xW8VJ8y3lEIkTAKJW3essZISgWp6pzWaPf
 aHpxBN/s5kCz0oY7VFa3Bvjj12CSQ/k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3A18779BA;
 Fri, 24 Jul 2026 13:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6FkaHLppY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:46 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:22 +0200
Message-ID: <20260724133328.1837318-7-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Headers-End: 1wnHmB-0007Mh-81
Subject: [f2fs-dev] [PATCH 06/12] btrfs: add simple test of reflink of
 encrypted data
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

Make sure that we succeed at reflinking encrypted data.

Test deliberately numbered with a high number so it won't conflict with
tests between now and merge.

v1:
    An array overflow bug in btrfs_check_encrypted_read_bio() was hidden
    during fscrypt v6 32/43 patch development until the file size was
    extended to more than 144k (16k + 64k + >64k a.k.a. BTRFS_MAX_BLOCKSIZE
    - it was 33k before).
    We simply needed more pages in the game to run out of the array.

    Even-though the bug was fixed in v7, it may be useful to keep this
    test checking, just to be sure nothing similar happens in the future.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 tests/btrfs/613     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/613.out | 13 +++++++++++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/btrfs/613
 create mode 100644 tests/btrfs/613.out

diff --git a/tests/btrfs/613 b/tests/btrfs/613
new file mode 100755
index 00000000..fddb9243
--- /dev/null
+++ b/tests/btrfs/613
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 613
+#
+# Check if reflinking one encrypted file on btrfs succeeds.
+#
+. ./common/preamble
+_begin_fstest auto encrypt
+
+# Import common functions.
+. ./common/encrypt
+. ./common/filter
+. ./common/reflink
+
+_require_test
+_require_scratch
+_require_cp_reflink
+_require_scratch_encryption -v 2
+_require_command "$KEYCTL_PROG" keyctl
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+dir=$SCRATCH_MNT/dir
+mkdir $dir
+_set_encpolicy $dir $TEST_KEY_IDENTIFIER
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+echo "Creating and reflinking a file"
+$XFS_IO_PROG -t -f -c "pwrite 0 145k" $dir/test > /dev/null
+cp --reflink=always $dir/test $dir/test2
+
+echo "Can't reflink encrypted and unencrypted"
+cp --reflink=always $dir/test $SCRATCH_MNT/fail |& _filter_scratch
+
+echo "Diffing the file and its copy"
+diff $dir/test $dir/test2
+
+echo "Verifying the files are reflinked"
+_verify_reflink $dir/test $dir/test2
+
+echo "Diffing the files after remount"
+_scratch_cycle_mount
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+diff $dir/test $dir/test2
+
+echo "Diffing the files after key remove"
+_rm_enckey $SCRATCH_MNT $TEST_KEY_IDENTIFIER
+diff $dir/test $dir/test2 |& _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/613.out b/tests/btrfs/613.out
new file mode 100644
index 00000000..4895d6dd
--- /dev/null
+++ b/tests/btrfs/613.out
@@ -0,0 +1,13 @@
+QA output created by 613
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+Creating and reflinking a file
+Can't reflink encrypted and unencrypted
+cp: failed to clone 'SCRATCH_MNT/fail' from 'SCRATCH_MNT/dir/test': Invalid argument
+Diffing the file and its copy
+Verifying the files are reflinked
+Diffing the files after remount
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+Diffing the files after key remove
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+diff: SCRATCH_MNT/dir/test: No such file or directory
+diff: SCRATCH_MNT/dir/test2: No such file or directory
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
