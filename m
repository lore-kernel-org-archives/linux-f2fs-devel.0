Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B2CC77B75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Apr 2023 17:42:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1popLL-0006xy-80;
	Tue, 18 Apr 2023 17:42:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1popLK-0006xs-C3
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Apr 2023 17:42:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sHyjYp6Hjl+6GDv9l+kCEg3GNInbwlyw7HjQ8Eh94JI=; b=AQGQY60TbMZ1RAN6qFw0Dp72Gm
 MJcOyXNBZl5tQz7d07T25W3G54kNV31m4v2lbvC530J6pnxKaqUEZ5igGNy/YK49KSc91SXHtu4Em
 Mt51igDQL6cKjVqOaiNkIIDAw/Se4R2In9qnDcgeyWA3IgHmKUz89UszkwmJ9tut6gfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sHyjYp6Hjl+6GDv9l+kCEg3GNInbwlyw7HjQ8Eh94JI=; b=U
 P8bAxBOfSo9S1iuh3vE2nz7WVVfJ4laBnczlinBh9wkPLBasYIwnuunB1qbEysSQ16YWq9sSPFoaY
 XDJTeV7rZ4yJFVFQJ9V9wRHtMIcv36qKGBb+SINpRF4e8w+1u+0gPOcsWVofcbpsfi6POpD0xCzHQ
 2wp+H8WVVvSuu2qw=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1popLG-00BbIJ-WF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Apr 2023 17:42:15 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1a66888cb89so18971225ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Apr 2023 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681839725; x=1684431725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sHyjYp6Hjl+6GDv9l+kCEg3GNInbwlyw7HjQ8Eh94JI=;
 b=XrAb43vwMDc65b3HQn6MCi+VmFmdVYtAsimCWPePMYUKZS5Tx6Hluo9tyLwy9Kaj0R
 SGXLBS8Yl/LNp4RmXtLVTeyiEsiv4WQbeNHOxKGmp1EbFy6Sk9TVP6ZSOHQOYmRx8yzJ
 OK5qVWkUT7fkN/YNRLNoRVXeFAJmzFvJtmcVgNSeLo5D8wOlACTiRUDxFWlMwL4aGwmV
 dOA8piybU5NtaSFziNIeBf2KdFKgEeYAWaCAFITn7g2y25ZDQFc6n9se9JFlBbJVBFaq
 3AL9kT4KKvCt9TzBK3iyJ6FnJkEaaMJFw8Evf5qsdfHUHML92PDs7T8kFVuQ6CI/MPPz
 DrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681839725; x=1684431725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHyjYp6Hjl+6GDv9l+kCEg3GNInbwlyw7HjQ8Eh94JI=;
 b=Y5q/k1LVZEUU5zB6XC0hSIckVO+kOx5kPcKbAG8nRDCLyA5T+/WG6loW1f49Ub0c+T
 diU1hvXJMMFCThdqOY0s05AyVlc3K0cit2YJjLhHqJVrbRJ2utKF/0xeEcb17ix+MEgT
 XkcYEtMfKY2oLKzpB3TKhpgNhqC09YikL7DCcfqr96EYn+I8Qbsx28MZaAF35vncCeF0
 1nfhW3t3bgtKZPYHantUhlicVTmJRIN6XgSHoQ8un54FXh9XarVAQ3o4manoOe4hCeql
 8gFqI+HPoCdnFytpxBowEcXbpsvbik1hWWDEHmsOQCfE/sGIb/OiD5FcYeOuhTZQWU4E
 rQsQ==
X-Gm-Message-State: AAQBX9dPb5hv3tkpsIzK7A7Ki8LoIlXM2/qv5gWX0somCcw7ucFOv56N
 zOOWUfJ7tcNLKefm2z3y+Z9EACcnPfo=
X-Google-Smtp-Source: AKy350ZrYckzFA5/P3ZMGw/eDtJ2wO64rJ03YAM30EEAXMnHOYF4qIVIa6UTRInFUkoW2lDHVPtmdA==
X-Received: by 2002:a17:902:d2c6:b0:1a6:9d98:e763 with SMTP id
 n6-20020a170902d2c600b001a69d98e763mr2929403plc.26.1681839725130; 
 Tue, 18 Apr 2023 10:42:05 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:e22b:bd7c:4df6:1ae0])
 by smtp.gmail.com with ESMTPSA id
 ji17-20020a170903325100b001a522cd8545sm9880563plb.130.2023.04.18.10.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Apr 2023 10:42:04 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 18 Apr 2023 10:42:01 -0700
Message-ID: <20230418174201.3274634-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
X-Headers-End: 1popLG-00BbIJ-WF
Subject: [f2fs-dev] [PATCH] f2fs: allocate node blocks for atomic write
 block replacement
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

When a node block is missing for atomic write block replacement, we need
to allocate it in advance of the replacement.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c35476b3c075..0e1e29800934 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -217,7 +217,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 
 retry:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE_RA);
+	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
 			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-- 
2.40.0.634.g4ca3ef3211-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
