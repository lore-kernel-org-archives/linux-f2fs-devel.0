Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0FC28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 07:23:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsGRT-0001l2-5h;
	Wed, 12 Mar 2025 07:23:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsGRQ-0001kd-Sy
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 07:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lwRswnMYHofXWcMbUGKuPRpMkhL1Y50T3ZKTC37yco=; b=TnTCEzQCxgVlYdDrV+Nn7Y2t9+
 OKoEJJlbUH3gzkNKuYfEHlDu1CVqUMHXO0QJ8oEJCKPOEj9CKBLqU6IQ0K+tS/JAa4c8JX05QDgik
 XyAna5LMBfssHZhjfwF3MOMswypWjbweVT9/NZWHCR+NppYoPv39wBfwk9mBY7KuE0OE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7lwRswnMYHofXWcMbUGKuPRpMkhL1Y50T3ZKTC37yco=; b=mzowB4WxSVMEbKIXvNV8VNVf1h
 +palddn5KKdegMmTrSl0oMrAPnMAyDPpYNduTFCFeq2Ea+JsY3SZqGDeCkPLOqth2fZSqCa0hIw4/
 8+KGdckQHoZYFswkaeuPLGr6LA1d++/VEakWuQulJgW4TuDKa0fJToIjdSRERAaajyYA=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsGRH-0005Ab-0e for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 07:23:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5BD1CA46DBC;
 Wed, 12 Mar 2025 07:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0559EC4CEED;
 Wed, 12 Mar 2025 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741764208;
 bh=cd+rCG/ipnPKChVuIm09pBZmrpsxF9olOrDqMKmbeGw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EOuPcy6zA+By6MHxZD982Mg752TlPJh1k5LYgMd3aoyUUKjzZBSVupzrul+LNvRdM
 GdQP6CksiTpeh8r0NRxyrI7O/UHdpzsfd/vrswST+yS4YFoD0m02iS6JSrzYa73sbW
 H8skeVykcE03j5Eu+ag+GMQPYJ4MznaabZwDrkMSEiJO47ZVuE5lRzYF3cKX/MqTqb
 80mLbs9kBW/cLEXGNv79+9eLavJOZulav/363tXRBbru7CoLlAQt9KTde7xo4SyHSv
 YZCVf7TLQ2qOj3FYtbEygT5gd//nAycryuMXllbBCaYcTKyNAPVWJf8Ai2eaJzEcIC
 ao4o/EWlLs9ww==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Wed, 12 Mar 2025 15:23:07 +0800
Message-ID: <20250312072309.3989074-4-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312072309.3989074-1-chao@kernel.org>
References: <20250312072309.3989074-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tsGRH-0005Ab-0e
Subject: [f2fs-dev] [PATCH v4 4/6] common/rc: use -f for mkfs.f2fs by default
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, mkfs will fail due to there is an existing filesystem
in the image.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no changes
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ca755055..23b642f4 100644
--- a/common/rc
+++ b/common/rc
@@ -993,7 +993,7 @@ _scratch_mkfs()
 		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
 		;;
 	f2fs)
-		mkfs_cmd="$MKFS_F2FS_PROG"
+		mkfs_cmd="$MKFS_F2FS_PROG -f"
 		mkfs_filter="cat"
 		;;
 	ocfs2)
@@ -1336,7 +1336,7 @@ _try_scratch_mkfs_sized()
 	f2fs)
 		# mkfs.f2fs requires # of sectors as an input for the size
 		local sector_size=`blockdev --getss $SCRATCH_DEV`
-		$MKFS_F2FS_PROG $MKFS_OPTIONS "$@" $SCRATCH_DEV `expr $fssize / $sector_size`
+		$MKFS_F2FS_PROG -f $MKFS_OPTIONS "$@" $SCRATCH_DEV `expr $fssize / $sector_size`
 		;;
 	tmpfs)
 		local free_mem=`_free_memory_bytes`
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
