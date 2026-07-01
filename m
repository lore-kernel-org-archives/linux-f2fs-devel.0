Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0C4C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S3hlHusCMgWfbnwyov02U3bHKMtVPwNVwRCJpNdmk+g=; b=BDPiTNxFfazGNERRRD1BFieqrd
	FbKP4WyiVuWeOVEsA8PGIUrxpMS48jnbABolQvVm2k6LRFYvgEPV1f0tmQCHAtcfBk0DsCTRupH7l
	qWze8h7kA9qNyImY40nfaP6u4oOqAFFPfkAtHjPUEiPlKKj9Dr+qwoTTL+GmBjiWo6eE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1werFt-0000CJ-K3;
	Wed, 01 Jul 2026 09:29:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zangyangyang66@gmail.com>) id 1werFp-0000CC-A4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 09:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fiEJTQ9UnI1xMGqwQ/IfyTxcMFgj+hgnb23PhNRQzlU=; b=AaE7rNuzQXPFGZEDBhertiZokS
 3IKFueo7zE2R3N/BxfjiVchc9eCmRvAnlJdwicKblKZcut6ciRvsirUV7wRDJk1VULWmSvShkIC4u
 MkwwEDn+4TRc7Jen6L3X3xEAlpGuTO6NSBl7/DdHkZKGStumw1+V0V4IrZm/DghJ69YE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fiEJTQ9UnI1xMGqwQ/IfyTxcMFgj+hgnb23PhNRQzlU=; b=J
 iQnoHUkmWJaee3JNc5jQ/yCL6WwvtDIvSBXIHmomPBWVgGitw5d8eBE0rAM7kJlJl4eG/RjVkD51j
 1i4JukpgpwK+c9FhOWeZK0JiH5DOYYlP/u50cq7pfNienpsqNs4Q9473gvHorHSFFudqEFLTpr3Do
 NuB1LrtV6pkAOSTQ=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1werFm-0006YS-42 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 09:29:13 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-847921eed4aso383940b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782898140; x=1783502940; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fiEJTQ9UnI1xMGqwQ/IfyTxcMFgj+hgnb23PhNRQzlU=;
 b=dTQWbQqC1CZJcU/+Mbj6e2yebBVLBT6HsbHHqm5kSJRz3MZtgFS1APLFW0ucpI3iQM
 23ha3TMdbE9r9QstIMxSMQrIM4CBfDUPhu032JM7K7ZoumsqtamXdbNzJqXMfukpgtiD
 tlaiYdCaxbkzHn/ewJaU41lh70GlaF+JrE/jVcPmP2MKM6z2ZcX2CQejCUpEBciozsJh
 G8j32MER568VVzI6GGVh/zep/b5xc/ZrQQGBuanXkxCY4AGZuENi8gZ3/OJDuZ+XoqGv
 AGx3U9/kkAEsusCT2YZn2lV6qCufBgorujbLWWNE/FBE2/fUIfh4JqGDtGyIJyPicVJT
 mAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782898140; x=1783502940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiEJTQ9UnI1xMGqwQ/IfyTxcMFgj+hgnb23PhNRQzlU=;
 b=cPBwSJ9SbNpDaaucy1xhiG1bB0QDNpAOB4KJOqZ8LqUA1NH0z6koWB5zEj4qpbCI8i
 6agDdJlhDPw0J3RHjomLKS2eSdL9mFdSueuKj0d/SVJiC92zx2+PAAxstCC5vy/OrJfX
 c+ssWMNi2VX9WFHHn4N+BpLPInZbvbIs81EywVbbwcbS1IyKe3klavhWfvq5YS4leXon
 9emBKs9nE8S/Kd11U3nnDqcxpz/zfakmLprbnGIvAH6wFtO8muyzLt6FXhg66/YQQzuD
 Q6CDMuz5Q+rpcGEtJ+Bo9ZC+bOrQdtxtanXyect4f6wCItVoadoL3bMRM2lg3/zMgRDv
 uyPg==
X-Gm-Message-State: AOJu0YzBtOrtdyoUFBTQuoPqKhqWeRthvbHJZJ3yJnu++SpoLCFJ6Qiz
 4+sGiz3qMpz4ZwvsNLmOvFK2gkQc/yv41a/rd+QrE6CJm6TMj7ptHkkL
X-Gm-Gg: AfdE7cmJKpIk9WPtKcwbxQbhkz94ddy2MFsnCTK2sxXe73kL7U1wKKGW/aYtx2LH4MW
 u7MKx8wq1UNcmQjqMwYiXljOnkoOzUmEiLWyV8wmsxhmRJ5N5BWI26rpWbk9kddnONEiPiYqs5N
 L9hSPvtb6LqnCfTgziBZVABno/LdW4EeUuduz6Z2A7CxsNeqkcQ/Gx130ffDRkPUeOjHuDMeBO3
 PclkcElnGGm/EGnXiBh/j7zMq7A92qswCEnOeR+teos0oqqcvZhErp8Q0wFgG0dN2pjdSGn99nr
 971KDV4aqub+FYZnP1J1ngoAPU5oWjcESwWPuiAoNoCphZ2c3JTFDI9UUGnMSxkAgAbuKXU3MzV
 5Z/4vWDQ5Y56FF4H5fhR3jyq1gRcwzpL2oFngHNnjHBIsYJZFscV+8QjK/blA+qmf+Tmt90kh7r
 EyFBbIM8Cvfbt+qz1JoGsu1AAXHoIF8qBwOCvPWWcEtT8GNofwi6iW
X-Received: by 2002:a05:6a00:4146:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-847c4fc3340mr3390b3a.1.1782898139981; 
 Wed, 01 Jul 2026 02:28:59 -0700 (PDT)
Received: from zyy-OptiPlex-7080.mioffice.cn
 ([2408:8607:1b00:8:e680:ef51:fd6d:24b9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847a0329c22sm3624832b3a.40.2026.07.01.02.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:28:59 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed,  1 Jul 2026 17:28:49 +0800
Message-ID: <20260701092850.1247010-1-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1werFm-0006YS-42
Subject: [f2fs-dev] [PATCH 1/2] fsck.f2fs: fix meta readahead after
 non-contiguous blocks
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
Cc: Yangyang Zang <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When the current block is not contiguous with the in-progress readahead
range, f2fs_ra_meta_pages() issues the pending range but keeps the old
start block and length.

As a result, the current block is not included in any readahead range,
and subsequent non-contiguous blocks keep reissuing the stale range
instead of starting a new one.

Reset start_blk and len after issuing the pending range so readahead can
continue from the current block.

Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 fsck/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 2f4e6c92bf6c..ea171a4c97c5 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -901,6 +901,8 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		} else {
 			dev_readahead(start_blk << F2FS_BLKSIZE_BITS,
 						len << F2FS_BLKSIZE_BITS);
+			start_blk = blkaddr;
+			len = 1;
 		}
 	}
 out:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
