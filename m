Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0400D5B144
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Oct 2024 20:10:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5W3x-00037h-Nu;
	Mon, 28 Oct 2024 20:10:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1t5W3w-00037a-WB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 20:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kdxh3C7cyLc+pvMOkJsZtEXg7OSNH08UiCM146DnUPc=; b=kvU3SBVZUMWqdhnREofUIJNPVE
 RFVGEZW7Rrh3ZB5vdG/TggF0TxXlU+DojbQ+XZNYooAghdaDDf0e/kTwRmu10IkFf8M8+13GOqLGk
 NgwGXgG3M02Ls1uiWOh61dSi8/QnXzJHn2qnoSKWxHKd9J7RNmiJ3ehtUiFKrdf1glMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kdxh3C7cyLc+pvMOkJsZtEXg7OSNH08UiCM146DnUPc=; b=A
 LLe3zeymkLpIeMrPuDDeF0WY3aC5hWyHRD0u2lSflVTN44RfoKKnshxiks2fCWRXcgeAVitgI57ib
 ne7cvQ36Uqdhjmc1534Msh9P9bT7Q5+DJymvrY46lD3ZnIE0tbIW2VyZotZzkUiOUZit+6Ea1Iz7b
 S73QVY3eWlp+W9jM=;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t5W3w-0005uz-CM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 20:10:04 +0000
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-20ca7fc4484so31960465ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Oct 2024 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730146199; x=1730750999; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kdxh3C7cyLc+pvMOkJsZtEXg7OSNH08UiCM146DnUPc=;
 b=NMQI19hV1hO5I95TzEuA9kWbhbx7igyIvhAy0wwXtUkM4XaCKeptaGRXGa4+xs1CIm
 rFiSACooO1aNYmKMXI7LpZemPgO0GMcWfpS3rJCgjJPgigcbzhAId7ihxPd1Pu0CWf7/
 o3N0QJeFP4zaKotd7rKkawqFMiRORsgfnwnTvIW2BsHprHLuQTelo3OekhdUSfGImtji
 M1PfIO3o+1cBfJ5IPo7PEwfEfF9U6pFNZ+ej35qgWhfItTwJXPP6KHeXmWeUNod4qtuI
 dP4wfBho2Vdn3F3urzqhQkStaF2LjohbeI1gvyYd9fAsIZ7MgOiv1cFO9aSyh8u2RrU1
 pNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730146199; x=1730750999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdxh3C7cyLc+pvMOkJsZtEXg7OSNH08UiCM146DnUPc=;
 b=w0eGXwGIcige2Yfbj/Xo6BwobTX0QxM5RhY742mkP+Ws4yLB6W0CZ8dK2GBbTyqT3g
 JHIKscIXHJH9UdNAJxiO7m5s9bun81JN2cbiibFX/3PSUCnyTfcsPtKgDr3Mo+joaBql
 YoYZA0R1DUFmxyNEn23j9om9Ka9fv2eLWXp8sHpT+Z2dp/nPtUiAOGtC3l3J+21+1ESl
 8oXNa4zVgk6v6FqcOgSnC4ztF3O5IhD6u3/ccFDyd+7dOKPLHSeSxFcrd/Y6tllSb0TL
 XOK0WArjldgo/1Cle9RBblGqgUrHtbw3TrW0u7tv7BUJb9xBn8qDRS1mgDM/J2JKBzwN
 zjmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWToOmx14NTC5osU/1l/w426LaqK1WTzMTRCT+0thex6ZmCvdJyWcIqgiSMiiPt02tC8qeC5wjTiI8hTrSI1R0k@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5aP/CG1Y4+VTwraYZkj/V1bbkn7txDVeKmiu/VMRYc+GXD3UJ
 G1xb/I+AP+IMBt3Dl0Ps77FLWBpEThjhEDFQyDRdx+Ptfjslh6PEK8Ft4Q==
X-Google-Smtp-Source: AGHT+IGvOzliQHg8CJitZU7twZ1PNCTkEB32SQQP4x7dg+RdjIdVn/0eVAfWDcJv+3iAIOTyz8JsXA==
X-Received: by 2002:a17:903:984:b0:210:e75e:4649 with SMTP id
 d9443c01a7336-210e75e4c87mr23161535ad.17.1730146198561; 
 Mon, 28 Oct 2024 13:09:58 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:863d:c76e:f6eb:44ae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc045259sm53628055ad.266.2024.10.28.13.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 13:09:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 28 Oct 2024 13:09:53 -0700
Message-ID: <20241028200953.2010714-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
MIME-Version: 1.0
X-Headers-End: 1t5W3w-0005uz-CM
Subject: [f2fs-dev] [PATCH] f2fs: try to allocate sections from zoned area
 except file pinning
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

We don't need to allocate blocks sequentially out of the section
boundary. Instead of that, try to allocate sections from zoned area as
many as possible, since conventional area should be used for file
pinning.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1766254279d2..1d7d8744c32f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2711,7 +2711,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
 			segno = 0;
 		else
-			segno = max(first_zoned_segno(sbi), *newseg);
+			segno = first_zoned_segno(sbi);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
 #endif
-- 
2.47.0.163.g1226f6d8fa-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
