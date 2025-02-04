Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CBDC02194
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:54:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tfKJZ-0002ed-DL;
	Tue, 04 Feb 2025 14:54:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jyh429@gmail.com>) id 1tfKJY-0002eR-BS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Feb 2025 14:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+8ttmp0NvexMeU8QQSg6ArXANMDaNCsP5ZfjLcy1EPU=; b=Cf4YaFqjc1ZJf+bxQQCVfh0BEP
 DLhbFf1gQIheUvkx0zucSfGa8vQ8ybt2eEbSBFG+K0p/6S5zz4Rgb1WIIw64gyfWJYNNMBIiGeSMu
 KWMIqCHFQrtqtAFJR+ItsckTiXf5x4WyPmbwGafW67a3YJhqMvQdhKSCUZMPlRNq3OBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+8ttmp0NvexMeU8QQSg6ArXANMDaNCsP5ZfjLcy1EPU=; b=Q
 S4ZKjYWbduSEf8RQroCLMw9lticrehL3cuexfYnxFCi5Mm1lD8uOvbD/5Hh/FPdHxoQQwBp1YGgCe
 nTm511PItgXJMrf+0eMB3Pfkz7zRiK+micLIGuWaJrv46MGUVATJtDBrF3QnZcTbHdR1dwN9oi4/C
 BhHxCjwqtW2XEXHw=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tfKJX-0000qC-Oe for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Feb 2025 14:54:12 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2161eb94cceso71312865ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Feb 2025 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738680841; x=1739285641; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+8ttmp0NvexMeU8QQSg6ArXANMDaNCsP5ZfjLcy1EPU=;
 b=Jif2JGFkRx+Ac5HPOQ0aU2EaobSZlCYde2lChNgNHctNC+zSHD261K8QiUI5r1/w2L
 d6429H+jHZXTQwct3u5r/eDipi/uzJb7syFtTHi5SRyxl8ljurCtHsiUDNKyl5qMfrgM
 RPfDJvZkbcJUTY0bBb1wzhfw+ETWoB8yw+X/ubm0SjvWgyCATCBYSwOPYOPd07JM4+0o
 pCxEPF0COHaQnyPySxbrigCcMfF0eAB6gXdQ9AjiRB6D/rVZspIFxiUsiQ4FRocbocvC
 qjTqi0/SW/9wOjJKbSOHarD8MdwdwImcpbVGTEiht9HgyGsTVgDIdHA7opYsGO0ok8Tk
 r0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680841; x=1739285641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8ttmp0NvexMeU8QQSg6ArXANMDaNCsP5ZfjLcy1EPU=;
 b=NI/GGioX07VSTCXkcTttxSaeMV+OMDwcPdbevW59Hf93QxVVBGCV2dDz9LFezx/TUq
 iscIwMSk0G4dMGQJLnxL4s7osFofEHKf2aEt78mfld0WYlXpgiGgsiN946Hnh4TZoLxk
 l6S/02mR+afY6uMZIIPupeUu06TwFCSmX/FvzaM25ZDDC+zfrMAV5yUKMUbJMxTx/qPN
 wrtgurWKdyk5L5IC4RqfabdydybhduL3FAWBqX/Ds0xrwTd19cJqgg5Q5/FeKygQHghd
 qneIIR3yEJvuiJ6E9p6w6EuAlMkgFdwmCGWErZIhugtW0D1VWZeV/UHcBq6YjuyB3/1l
 Zmxg==
X-Gm-Message-State: AOJu0YypHSnaOg3lBb08moihFOOtQTjgMSDXvyJ736tBhNgpQOn4aRzQ
 ofBm1If06NLaXjdUnX1yXy1JBtyY6fv2hygzGlpV3/APfSYNR3tR
X-Gm-Gg: ASbGncsoPCPn9D6UekUQcRWqb0t+BNkxCrzJTEayvDkoZIl8k/dhhyIuUXqDCYsn6yd
 j8C10nmAgjZDHbUIa0mG3DRpnYouyWlKxbDxxiUwvBxeByF9kUxV1K2RMTGNsSsWZC49hcPiRuK
 NbpEhm5v14im+Zc1GUilslVyMHUjPO3MlcIC1iSv+SXo3VmTIh8nqA11JSmGYLoaXOikNMjwv/+
 YvPNT0O97OEyxp4B5FzrJDHN0j/5pmpCPX1wO1U9ZQkLgti5NRE4+yxb/O8H2UzKCtEoiaKT0qo
 f54CgF3oJd5aJaZ/CrRbxEQtpr2FVGvKW+RbhwRAVngz
X-Google-Smtp-Source: AGHT+IG2lapVMZgZQ9LQSouXdyvk895bbON6DUrnazK4M8yCav3CZgmsqTf4nTF06tw9i5dalZ5VbQ==
X-Received: by 2002:a17:902:d549:b0:215:8847:435c with SMTP id
 d9443c01a7336-21dd7c55d18mr427267965ad.12.1738680841006; 
 Tue, 04 Feb 2025 06:54:01 -0800 (PST)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de31f7927sm97257315ad.99.2025.02.04.06.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:54:00 -0800 (PST)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Date: Tue,  4 Feb 2025 23:53:53 +0900
Message-Id: <20250204145353.165-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1tfKJX-0000qC-Oe
Subject: [f2fs-dev] [PATCH v1] f2fs: fix to ensure queued discard commands
 are properly issued
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

F2FS zone storage requires discard and reset zone for each conventional,
zoned device.
In the current configuration, Discard granularity is set to the zone
size but queuing is inserted into the pend list with a maximum size of the
segment size As a result queued commands cannot be issued.
so we are restorting discard granularity to its original state

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/segment.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c282e8a0a2ec..938bf5144ae8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2320,10 +2320,6 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
-		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);
 
 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
