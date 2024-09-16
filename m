Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68086C3ABB2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 19:20:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqHGy-0007Xs-4i;
	Mon, 16 Sep 2024 19:20:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1sqHGw-0007Xf-TX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 19:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=; b=cI/erKy04Ktao44DIeb3ycc9kv
 ai8eEKptO/gWW3rx7xfjBW12X9WHWUeMnOp7mDn3v0aamZUfZVberSmiOLLAuon7ErSRW76uD6MtY
 tAnTk9jLQNEbVKdXm6N+MLMgP+GFe+oRg3M0BpD16WJdPIcbqOdIiD2OWCUwMxdSzOvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=; b=A
 FJjSaWHvuYvC8YPr2zYlqleOH/zXmzb3xqg09Y4Dg7GWKsDr1v4uIuL8s2OKmglGg+K6laDYqtzsH
 Oenrrx/LP30lPwebsgWCyheAyG4H7o1Ir7DNk6KqlDA/9zp3i0KnMGuVclvFPRS7DJTrHgr6PUadX
 6t2Oknm20EPAekh8=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sqHGw-0001h7-9Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 19:20:30 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so3916528a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Sep 2024 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726514419; x=1727119219; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=;
 b=O927a2epNDqDj6n5FdSr0hiCggzhnNiFQElmv5KjiaGMT4V9yaTsPfmKp35X/3yvFC
 ytrbbrQD6vU+GMX4rxzzWjrWgHlek1pDQTjC/W+OEApOoVPXF4S+wcjPg3/zOUi5IUNl
 0gNyPuj8M6B/uGD0iQkvh4J8Jc3u+lL6y1BC81UKqXNTOSQv5ROrQvGKKpdxzEKGvywU
 Bem/gLhVo1Lt9E9CHAYHFR+z9U/4gndkUHxV8NdBLwTbRU6bqdLDuXTwTWKJcA8l1Sun
 h3shx24KIb7YqjaNL/wr8x9/AUv45PxPlLwPTOnockVkFi8onKJds43peFJbtNr1I9cw
 3xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726514419; x=1727119219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=;
 b=njimsvbU+NBxB4fusGTzYLWbADfHeokKCAx/iBabcNxmqRhRoor10Eocz8i0hRdwFP
 /u9A2fXNJ1bvKqI9Ga73hY5blbp3fTVo0c8fTVqY25IEMpIMCeflnbg3Fa2S3v9w1N1v
 FfkD7hG3wfWWT8V/xWbX1YkyBOBXeNdFIE459wmEqma2Dwn14P5lbSd4W1W8IdbiLlka
 WgjQqZFWyU9W0VdHRDtEQmT+VIcqKujhQWGPLgpZfPvMm7QfgXvbaNszghwOiEwe5ez8
 EkkW1+ZmcbOGTsNrUB5BKCglp/WezgldLp66e3vS2ob/VHlwzCiHQEHcWgkmsN3QYVXd
 h2mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyZnu75lyh576/UDEArLtdaXKjSIJonKipf75aJelkuoZtyLOfzj0LJUSBvnJ2ox4lXMNMSPXXJpWBAxDKOZ0u@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyRRw11lLMv+StvRxUYTj4E4j6s2cNhwmVgzhS+NH67YjBS7dj5
 tBUco1JaeflA8RHgsqi97aUBlv35aoKe4dF/Ksrqe4rSOeKFdkDdH34sOA==
X-Google-Smtp-Source: AGHT+IF2nMFy5fRfjIMPD4iNzaQ3EfphxhpscR8O2F4QebRfKGJA7y6e0tWvPk4fMNE2NipnfH6F7w==
X-Received: by 2002:a17:902:da84:b0:206:adc8:2dcb with SMTP id
 d9443c01a7336-2076e35b147mr297247795ad.25.1726514419271; 
 Mon, 16 Sep 2024 12:20:19 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:b01f:7889:2bb8:3ce5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207945da875sm39348975ad.39.2024.09.16.12.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 12:20:18 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 16 Sep 2024 12:20:13 -0700
Message-ID: <20240916192014.1611002-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
MIME-Version: 1.0
X-Headers-End: 1sqHGw-0001h7-9Z
Subject: [f2fs-dev] [PATCH v2 1/2] mkfs.f2fs: change -c option description
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

Current description confuses users like they can add addtional devices
with one -c option using commas(,) at the same time.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 mkfs/f2fs_format_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index c98e73c..2ba1c21 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -50,7 +50,7 @@ static void mkfs_usage()
 	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -b filesystem block size [default:4096]\n");
-	MSG(0, "  -c device1[,device2,...] up to 7 additional devices, except meta device\n");
+	MSG(0, "  -c [device_name] up to 7 additional devices, except meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
-- 
2.46.0.662.g92d0881bb0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
