Return-Path: <SRS0=qvT3=WI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FECBC433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Aug 2019 22:52:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF8D206A2;
	Mon, 12 Aug 2019 22:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="mocD3Be9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="F4R+edLs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doFSVmaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF8D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hxJAx-0007kO-UB; Mon, 12 Aug 2019 22:52:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hxJAx-0007kI-76
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Aug 2019 22:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EsBRCgj8xPiNfwQEIamFghoZjfLPK/XhqQqGeJWjv1U=; b=mocD3Be9IStz+jWa6+yBcfbHWE
 d60p51KNHT/7VEsrTNmK6bbOAmYXx0Olp+EZjy4WlibJrDKTvPjm9H2P5b+XLgRW5lu08YAHdmOhw
 /Ad8S+Kdg7q8tMobKBSfsX17nXrMs7aW2BH2NwlX7rP0sFkaCGqkDF4AqwClXXHbeybM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EsBRCgj8xPiNfwQEIamFghoZjfLPK/XhqQqGeJWjv1U=; b=F
 4R+edLsMrB7x9euVQUOeVF77QDOulXT7rLb38c9Hw9mO8aFbrP8lJjhgdCRBblUYuGDRsT5hMk6Z+
 pP8cPO3W5sUJoB5VtRHi0qmC6ap7G0r2Vps87spLDd+nUqd4qnB47e7zsYoZXSOo/cdee4vKX+94t
 ycxn4ZLmev1fnQIk=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hxJAw-001Ynt-1K
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Aug 2019 22:52:27 +0000
Received: by mail-pg1-f177.google.com with SMTP id n9so43991520pgc.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Aug 2019 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EsBRCgj8xPiNfwQEIamFghoZjfLPK/XhqQqGeJWjv1U=;
 b=doFSVmaLg7naxQOABaXVuu6dl0hZk4eoajvQ9OsInydXu+g8Pb3dGaL0bcqUjk9RTO
 hgKYj62fF3c15lGwZ5dySNNA+RtMFFhhLrkNZI1HEg2lkY2zPuQRbSykiIhXb0V5bm2T
 yesn2CETqddWmg5fe/SHXCWHGrU7YrzpGJHwloduluR+rWyaOBaPbtTrAAzxC/rOWD+d
 IASmfSkvJT1U0wOF+HtmkftczVrn7dhBCa6v5TcmLUaXI6z9BgRpjDCHPpfcwilqRMvg
 lmE2+ay8r089b66HTJsXWEiqimQzUn5qoh9e7LLCqpqo7+8boGrpfYPgiMD0jpZ/Ajnl
 pwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EsBRCgj8xPiNfwQEIamFghoZjfLPK/XhqQqGeJWjv1U=;
 b=J1EXd/+SFP41Wiq63kFQAjfiDS2cHXgn9PWRg4MbkGaFUM2w5qKw9yxx7CrUKbMf4v
 7XeV9K6nUPoDjRMg7VuSDufycfxNnO9YhYiwex2DPQ2Y4QiaMxs0EGI4cTdfzRfLPULz
 2H80pytKh9G7mTuLIsIe3RREMhVWbPoP+eHIsTnnLNWJNQlfox4xjJylXoAXRH9ATffi
 RckkV7a06NtOxsJ72YMKBEJ8MhLtRV1lB6BGzfzW8MwrXIkfUl+xuCqdHZ6zXSfw4eLf
 +Gu8jLMr4z9eO7wfZxzdZHVa49W/LWVoif3LTJHafMOtQ1lXcZcMrdoxz5MG2856rWgW
 F/YA==
X-Gm-Message-State: APjAAAVUOf5W2ETLyUPwuTlJjYo00SUlb3MtnOo/kT1ptUFQMSpO4ldE
 HVLE7zXLPymZoOISDJ56D5tFBrHLCT1Azw==
X-Google-Smtp-Source: APXvYqwGcphskT8FTlv6+2263Y3GJEAFR4v9Re6lfDBTXTo9OicBDgGOLe+2qKu+q1xFa4ETs1ynRA==
X-Received: by 2002:a17:90a:aa98:: with SMTP id
 l24mr451879pjq.64.1565650339737; 
 Mon, 12 Aug 2019 15:52:19 -0700 (PDT)
Received: from localhost.localdomain ([165.246.149.139])
 by smtp.gmail.com with ESMTPSA id 5sm45698246pgh.93.2019.08.12.15.52.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 15:52:19 -0700 (PDT)
From: Park Ju Hyung <qkrwngud825@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 13 Aug 2019 07:52:10 +0900
Message-Id: <20190812225211.1737-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1hxJAw-001Ynt-1K
Subject: [f2fs-dev] [PATCH 1/2] mkfs.f2fs: add "zip" to cold data types
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A lot of Linux users have big, cold "zip" files.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9402619..37d82c3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -66,6 +66,7 @@ const char *media_ext_lists[] = {
 	"webp",
 
 	/* archives */
+	"zip",
 	"jar",
 	"deb",
 	"iso",
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
