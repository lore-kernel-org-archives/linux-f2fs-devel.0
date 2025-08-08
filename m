Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027B2C87FD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hpJz33eSvhyUMgcI5djXNRqHIQF3Cx63+pr/fXQ8hOI=; b=bO4JTx/6Xw58W+P3kGmH7M6rYX
	uj74MvwP6Avvbkjom337OC3sc3rqxGDZv6oLm1Oogg6bZJW0yp/pdTHxc2dlrw7mlUL9sVAs6CU+5
	zepCreV5OZZnFk0BEcCbJ+87zogvoJWVVCVhv9HVZrLdUFJjMdgiToUHstW2b9aWIysk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ukI3z-0001z1-6W;
	Fri, 08 Aug 2025 08:02:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ukI3x-0001yI-Nc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Aug 2025 08:02:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CoDEKky8ymuLgngP18Mj2HHoF73gHq1SJxDEitpsEMw=; b=UcPQUSYaYIT5wHRqAYAcJANtFX
 kbovWxV31uKgcoZF11FkRbiwnRU0MsRZlBLGrDCRoCLjIqplVcX6gVZX6sxr42ZnXmaCtbZZ6XpsW
 U4ox4HDwXHloF4tvCKvRIqhiZJwYG+fzn49+WNoHf8p8tIo2pPZJlmxeHgOsWbH1ZkmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CoDEKky8ymuLgngP18Mj2HHoF73gHq1SJxDEitpsEMw=; b=J
 REOLIT+P7weVHPqjXbncMAqLWfGmsa3RrN7C5/exZn9vw2zBe79h6j8sQUfiOTt+SntLaBBzQf/EQ
 1M6pWAW8dkXrqDISRqKPM/qnCiQV5KWBwjzOy035Nx5KN0ARQ5yNbkCv0JD1eiFSV08n6G7k7drLt
 uGWNKpjRKLExFzkE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ukI3x-0003LG-9U for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Aug 2025 08:02:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E0E8D5C5A5F;
 Fri,  8 Aug 2025 08:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F295C4CEED;
 Fri,  8 Aug 2025 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754640167;
 bh=wVvoXIsLPKZCemckHCxMR2iU0Y0WAvi6H54PITfVnvY=;
 h=From:To:Cc:Subject:Date:From;
 b=ufAJ/AnwGA7992KOKnCg9JdDYrt3IzChGn7yXZEWfM2FncRfLMq0VYHJhLBSPZ7nl
 aGUER6ML8Iyqk7PfF/2JmYkLh7uI80eb8v1RTfOZeFdrdeLvg/c8p010MEzEi6oDYF
 R7gz+6yusmTunqMIJ+wstI9H5HeS9j38OmGtebVLb4c47yxC+XOREWp2cG9LWfP4La
 RFDyDUBbINM/WQkZFCRN5VY9JLsvo5uQqywVL6Ea5DVRKLAKDOwoIfJPALTXKOHigD
 EXSgAyvsC/8BzuLdvbZavCkRkbRnxh1qnSknnT59oE3vxw6NzTWrglf1HuP+LmuY7x
 IKfC9YtCEEv8A==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Fri,  8 Aug 2025 14:58:03 +0800
Message-Id: <20250808065803.17298-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1ukI3x-0003LG-9U
Subject: [f2fs-dev] [PATCH] f2fs/012: adapt lookup_mode=x mount option
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

w/ below change [1], f2fs will enable lookup_mode=perf by default, it
will change f2fs dirent lookup method from linear based lookup to hash
based lookup.

So that, f2fs will ignore sb.s_encoding_flags by default, which is not
compatible w/ f2fs/012 testcase, in where it will control lookup method
by configuring this flag w/ fsck.f2fs.

To avoid failure of f2fs/012, let's check whether f2fs has supported
"lookup_mode=auto" mount option, mount w/ the option if it can,
otherwise, don't.

[1] https://lore.kernel.org/linux-f2fs-devel/20250805065228.1473089-1-chullee@google.com

Cc: Daniel Lee <chullee@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/012 | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/f2fs/012 b/tests/f2fs/012
index b3df9a8f..15fc8f0c 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -22,6 +22,15 @@ _require_scratch_nocheck
 _require_command "$F2FS_IO_PROG" f2fs_io
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
 
+#check whether f2fs supports "lookup_mode=x" mount option
+mntopt=""
+_scratch_mkfs -O casefold -C utf8 >> $seqres.full
+_try_scratch_mount "-o lookup_mode=auto"
+if [ $? == 0 ]; then
+	mntopt="-o lookup_mode=auto"
+	_scratch_unmount
+fi
+
 check_lookup()
 {
 	local nolinear_lookup=$1
@@ -30,7 +39,7 @@ check_lookup()
 	local redheart=$dir/$'\u2764\ufe0f'
 
 	_scratch_mkfs -O casefold -C utf8 >> $seqres.full
-	_scratch_mount
+	_scratch_mount $mntopt
 
 	mkdir $dir
 	$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
@@ -52,7 +61,7 @@ check_lookup()
 
 	$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
 
-	_scratch_mount
+	_scratch_mount $mntopt
 	if [ $nolinear_lookup == "1" ]; then
 		[ -f $redheart ] && _fail "red heart file should not exist"
 	else
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
