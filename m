Return-Path: <SRS0=xc4u=BJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD1C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:29:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9DA2075F;
	Thu, 30 Jul 2020 06:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cXQP66sX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aJJ4Mkve";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO1HEC4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9DA2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k124Z-0008Kq-BO; Thu, 30 Jul 2020 06:29:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1k124W-0008KM-7p
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jul 2020 06:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CsOxKachicy3OmqrENOn8EV2vNFswMwHeC3pAl1Oi8c=; b=cXQP66sXeRF3BvF8vhoWoOjYm9
 jWcoagPzlg6lIQOfZS0GOUCtghAnECGPe+d6xZA2/Vnhq765KQTwXXWZHoWJn5gN/TzWsPbjQikBR
 5UaXWByeWJRS1XyPJyTBUgRAuKpUxBcFU6NmsO60rb7VNdE/1SWOIneGMG1is3kZ7bnY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CsOxKachicy3OmqrENOn8EV2vNFswMwHeC3pAl1Oi8c=; b=a
 JJ4Mkve9Zso3JUXxb6QhG1EMppeYX54li6A2sLL9dN/22w+FwI+QUwNWvktjoQdl04J90MH0lz6rj
 CkMQwzFgpsHS8CFg9F0GxVzGhXHOg12q8S/hRQN7MczLaDytyjVKzXlgJutnU9TaWkaiCtfQuIYo6
 ffPkOUG9bcVS/QOY=;
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1k124S-00ENVj-CZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jul 2020 06:29:44 +0000
Received: by mail-pj1-f66.google.com with SMTP id t15so3630060pjq.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2020 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CsOxKachicy3OmqrENOn8EV2vNFswMwHeC3pAl1Oi8c=;
 b=SO1HEC4OS2pjdG85QuBpcYgYY9Rmt947bqURN2sZ8TdX0NxycVkBJIVoPkzBZCGDdb
 gTlh0dVwDgkDPNKWrJQVRhVIc7Nq1C8qiVnhebmsyWbfv4d+1jaSMBkgiA6Da4U+fkrp
 CfCBmuhUVenrqRVlbsz2YkfUgLAbC83qlb4BD4XGhivdS3hKPa8fK5YenbqVjBkkWs6p
 XP/SdEvoWVHqbiUN93F1UhfdtdHXnnc/I1sAiHKBpMy/xA5MtNWjDMeA1Y/HoMSpdfTR
 RVuqyUeLHXjfHMr1M7KToScO303uNHyx3WXXVi9Lj/j/u5IyaCg4OSA/ho/lEyemYzfF
 poxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CsOxKachicy3OmqrENOn8EV2vNFswMwHeC3pAl1Oi8c=;
 b=OMd0jqC5dAG8pBWuWfU/MHJZRgTMF5OyaMITxXYFC5/9iXpicpVuCV+Nh7Q37xf45B
 mZVmouYuVL9o1buR+37dYsXdju73wH092U4u7xiMPTBLuSUAQ8lvFPxiQstWVYvTjrDE
 Wap/QsZc7s4Tjy01oyUrCRPcsgqjD8Pvb0uaOZXxvMaCc0sZHAgAqXw3BAiru8QNwice
 SJv2U6R9IoO+vhun/gjzVOV2+YRd+aeLZvrV0jVLpJUqju5k4/FY0OYJX+4wfqpflxEA
 H5Pu+Xved9bpzPCKc6dmC08OzhFPLTvkYqaF3YXhJ0ZCdT61qfq5lBmF4DS91gg5VEUN
 qn9Q==
X-Gm-Message-State: AOAM532JgcdzmAxQJXGGDd7x9GtgeFiZHK3s5yc+lVgvAiO8nC9qSptz
 ZVootj1owTfB/NRvO89uGqZWHfBzXNE=
X-Google-Smtp-Source: ABdhPJwGAcoN3+jW8C/P/pZG/O9t6IdQABLEN5B1zNM2OuRr5cC0McmydHORnhDfrQ2nHATkXI1q4w==
X-Received: by 2002:a17:90a:31ce:: with SMTP id
 j14mr1631801pjf.65.1596090574367; 
 Wed, 29 Jul 2020 23:29:34 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
 by smtp.gmail.com with ESMTPSA id a6sm4255443pje.8.2020.07.29.23.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 23:29:33 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 30 Jul 2020 15:29:27 +0900
Message-Id: <20200730062927.375325-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
X-Headers-End: 1k124S-00ENVj-CZ
Subject: [f2fs-dev] [PATCH] f2fs_io: open file in read only mode for pinning
 file
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

To use "pinfile" command even with read only file, changed open
mode for it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 6266454..abb655a 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -349,7 +349,7 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	fd = xopen(argv[2], O_RDWR, 0);
+	fd = xopen(argv[2], O_RDONLY, 0);
 
 	ret = -1;
 	if (!strcmp(argv[1], "set")) {
-- 
2.28.0.rc0.142.g3c755180ce-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
