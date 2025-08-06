Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97098C87FD3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Aug 2025 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ScvmmaaqabwPuapci2A48TVJW7jjnOzedSX1uQnCAss=; b=IMRo8HDYRKrrZP+5A+TbpffODA
	+7sBD4XZ93X3xEtOwe6D/MhTeR71CtBJkJvlebGRaaGAiRrGu6ktHt4TTUwv7NlgXqYE/0hFA2pS+
	gQpmhDX9+OxuabPRmzSrG6XA8fcA0+2v2FiNY+oVyOrGuRuJ8MCzFrM+vJbjPErtjtuM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ujdKP-0005PZ-1t;
	Wed, 06 Aug 2025 12:33:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <masonzhang.linuxer@gmail.com>) id 1ujdKJ-0005P2-Hv
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Aug 2025 12:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CHIu6G28Pk4SOSDxdrkK1OQmPtaJttmCNLhq9tiQ5Do=; b=mxDNyQGV0EC8Qa/zaq9DhGBADz
 l3dPeEAd/QIDo3G/icP2nUsG0W7UKOcgzuw3EL+82rjunuRVheLoVVKX3SWmG/v6DlyjBs4DqhKcO
 ngMKAh8WV/JwlxA2WbAjgJfASGiWAY/5ffB/qEVNkjFskl4zkbAjmhhMSj0pT3lgYid0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CHIu6G28Pk4SOSDxdrkK1OQmPtaJttmCNLhq9tiQ5Do=; b=c
 WffRrVmAElLJEZQ3HytryP64s2ka58RAffTnUqNR330+Lj0Pd2pnm/XfD/zWXkdb4TKikOBUjQ++A
 tkgZIwqhWGcvYEVecKOXCwQq6g1ZwWU1Iw8di130DalU5Y+BmNkez1vNtdAir/AVZVZhoI22+tNSt
 4zU5V5Gv0zPUjfhY=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ujdKK-0004HQ-1S for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Aug 2025 12:33:04 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-76bed310fa1so3388965b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 06 Aug 2025 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754483573; x=1755088373; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CHIu6G28Pk4SOSDxdrkK1OQmPtaJttmCNLhq9tiQ5Do=;
 b=iF+AUbaKmYM4fpI9BszZ8Y1KW+vlR9bbGyijr+C+qI00A3PJonAO1SsLgQhuFAIpWy
 q/SytynaNI9RX5eW6Pwyy8U2Bdtm8PHpqcWUPyLlv+DFpoK2GpB/CKlwgFnmKVIrzzJs
 ARuuQM5KrZsSpn9L9dMOItItHytbpptOaZSa+i3WVGKvvKKNSqxmIPDb7wHZf2cXLYfn
 1XMEwhVngZSoWm/inxyI2Y04NgL0buN9uZtySCbAMxwSUidIMm8+Uoxz/C/pf5u8ehdE
 wLuMuRDlWJ5xtH4KgaIdMSalDSmSSF0GsIo8N0H91/blkljeRo1bV4OGiKFSYdmUkJBw
 EUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754483573; x=1755088373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHIu6G28Pk4SOSDxdrkK1OQmPtaJttmCNLhq9tiQ5Do=;
 b=XYd9WKdtg5F3Kh1VDvI2dlImBpuy3b+aZTSnby75Cod/TC9pvtuAv5/iu3TESk8B7v
 EkS0wtCd2sRzA/VHQwqMgsDR1ghkYTSpGsxSRdLOgh1joodSxZHATlERZhRzrMg8zpTa
 l4o/IIJ8EaU4VMaDqoCCWf+6p2IOeiHHbS6LocKCEeehN5yCWg5BXOOpyi46FAfG4dJe
 rQvuyvP5bdgVOLidcXUGuJkjX4mecTnQWg1tN5U9HgrzEupmoTnmr+WyRcLxFCL5XqEi
 E5qSZc8TIa3HO3rNS9mR0zWYd+gFTSeRxKIQKnVdYZcgiZD2HtPex3cacE83Jajny1CY
 0j3Q==
X-Gm-Message-State: AOJu0YxhRu/1TrDpJEReXeJ//+7UFbT0bPt2q6dFHy9PRtXGFpNRXshX
 YJuKlJp5yxC5qP7v5XbCFvPgF0acVqeqVVGPIeBrMeaXbsmWUdGrQUM9HKN2g8Zmwl0=
X-Gm-Gg: ASbGncsUpErMZR6dUlaAFR0JAo2YC5veTPeYyDv3l8ny85q/NUK/bAV/lzajncB+uW5
 TsblvVJP+B3F1Te1atCttOzBbeEi5GKd1ebDQXU3zul5ofR5aw6WPuh+RQrAL86Menl69CBHILP
 4MmLSzEzfFLwIPLKEqKYhFMqlCC7pNXhwzg2jBM/Vm6INRQSf0dmvNDvQ1BIPSPEJHd/L0S++2F
 dYUIDshpr9zgTEgCN06G+9u5qdfOllMBUtY3T6kEjGn+m3biHmhnwnxNchQP3R5h98qTvShXKAD
 tROb2Uv0EPhDNgR6oP7YFKSDRQjniDaiotzhHESk3a6990qnz8dnNRCMvwzbUYqo7tJkQhJdIuG
 BZW3cwCY0stgF61R7QPDvLlbzDWG3JXU=
X-Google-Smtp-Source: AGHT+IEuyhH9Ap2y5cyWh/2VBI+sP2iOnNJmD/qT0hpDjCW5rg7drATMI2KtDBa5ttCnjW1bOkPpfA==
X-Received: by 2002:a05:6a20:9392:b0:240:203d:42a with SMTP id
 adf61e73a8af0-240330c2bafmr3531003637.21.1754483573210; 
 Wed, 06 Aug 2025 05:32:53 -0700 (PDT)
Received: from localhost ([61.152.201.176])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b422bb1133fsm13619878a12.56.2025.08.06.05.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 05:32:52 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Date: Wed,  6 Aug 2025 20:32:36 +0800
Message-ID: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Headers-End: 1ujdKK-0004HQ-1S
Subject: [f2fs-dev] [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This fix combines the space check for data_blocks and dent_blocks when
verifying HOT_DATA segment capacity, preventing potential insufficient
space issues during checkpoint.

Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db619fd2f51a..d8dae0049b6a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 				get_ckpt_valid_blocks(sbi, segno, true);
 	}
 
-	if (dent_blocks > left_blocks)
+	if (dent_blocks + data_blocks > left_blocks)
 		return false;
 	return true;
 }
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
