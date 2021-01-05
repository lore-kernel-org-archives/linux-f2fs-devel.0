Return-Path: <SRS0=actn=GI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE36C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Jan 2021 23:49:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B93022D74;
	Tue,  5 Jan 2021 23:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B93022D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kww5N-0006Hx-EV; Tue, 05 Jan 2021 23:49:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kww5M-0006Hr-Ut
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 23:49:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=whc2U5gu5zwKqW7Z1BCd12zYqBfLakFsyLK0IzuWzP8=; b=If6P8Z8U1LvvIefZKhwLRsORmW
 FMxGxarYJWje63PpO/df0hl2FsoXNSYNm9MPrYxR0oemNG0XwR7zIrG3jaydBWQaZL1gr20Chvswn
 ki5o1fws5TViDW/y33W0p3VQt6J4F8ufRMA3/qOtDGqChqmfuPdAGawrQC27vSU3dDk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=whc2U5gu5zwKqW7Z1BCd12zYqBfLakFsyLK0IzuWzP8=; b=W
 AhPZJEsjLTZMSqaB1An14ppeCLGHbtE6RJfjE+vc8nr/WDv2lRaCvrKrZs6efb1jjzchU8MF15NOv
 u0RucNmWyHPd/Y2Rj8AS+4ZOymdV1wlcXyHND8Zv9qrtnJVtMbEzfqGkS4G68ionshG0STpqbNud9
 ddmHa3bE5Gl0WT1M=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kww5G-00CGUG-2K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 23:49:56 +0000
Received: by mail-pl1-f181.google.com with SMTP id be12so618996plb.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 05 Jan 2021 15:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=whc2U5gu5zwKqW7Z1BCd12zYqBfLakFsyLK0IzuWzP8=;
 b=RSYt8aWDjjxG6udavDTUY19W7lHxifCi8492IhANNtipB66/pAWN4AWXhxP+tKJjzj
 NAt6EZe3Zc49FsV8iZqgXQYgJhiyWJGhH2M+FU4a+hrkDhxcKleEPmDxC/dbtEfz1xUt
 pCyc5Z1UjpWdgzYdXymMqBg4/iQss87JLDkc3GBlPcvhXS8glcjpf6uYvbc7H/RMDvu/
 CFA768T2YFosp2nuzRHipHGrkO/FmljBtLCcy/EAk49H2eGvFNq+g4C5l8ia3GpKPluR
 YyRYxluQN/pzIVaPgOrg0Aeix4rrrI4HowMzphddpO2W6+g+v6qwwgOxUHV7jgOodkf9
 oyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=whc2U5gu5zwKqW7Z1BCd12zYqBfLakFsyLK0IzuWzP8=;
 b=RCLAUt/rxEPmZe5QsdAD/8VjVDkKW/3eHsDIn+cBVCkYAFsGrlRdfonDw1kF+Q0kHv
 LD2TbNp9Ngbf8rscOxIfQmB1MDqb/qaVEX8GXV92YIP8kvTpNLR7lU5uls3rIRN09zTH
 huvh/Jzpb8jWGA0M9B0dl6HO58Npw194uPKwVGmYih/ljvx0x0TI/5YdxupStZYguEJS
 r7FjbDNiVT9ioiga1Q8L6HBzKj4WVGx5D0TkPQ6GOwD3W3Dq9T9ijILFziQZljxEGH7X
 Wvbs1KqS1ITtMntRZxO8Lz3dP8XPMz27cWoWmuTJbdRtj3IM12WG0crkhzqSU/VX8bDJ
 /lXQ==
X-Gm-Message-State: AOAM530yCTCyEM5QNlEIsqdi1/sPtrdpsv8JHydO7gC+I4vhTm9encIU
 742b7UshkQLDvLw6MfzqTiw=
X-Google-Smtp-Source: ABdhPJwL704VReSw6jgByR6yvKwqCTroZ13+bPc6/tofWoYLUxpY5mR6MoNopmnlk4n6HDG6LBwFJA==
X-Received: by 2002:a17:902:b693:b029:da:e92c:fc23 with SMTP id
 c19-20020a170902b693b02900dae92cfc23mr1531675pls.55.1609890577267; 
 Tue, 05 Jan 2021 15:49:37 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
 by smtp.gmail.com with ESMTPSA id 8sm285724pgx.48.2021.01.05.15.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 15:49:36 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed,  6 Jan 2021 08:49:28 +0900
Message-Id: <20210105234928.1598326-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
X-Headers-End: 1kww5G-00CGUG-2K
Subject: [f2fs-dev] [PATCH v2] f2fs: fix null page reference in
 redirty_blocks
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
Cc: Colin Ian King <colin.king@canonical.com>,
 Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

By Colin's static analysis, we found out there is a null page reference
under low memory situation in redirty_blocks. I've made the page finding
loop stop immediately and return an error not to cause further memory
pressure when we run into a failure to find a page under low memory
condition.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
---
v2: changed error value and quit the page finding loop immediately
    when error occurs
---
 fs/f2fs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e5275716be8..d27173c24391 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 
 	for (i = 0; i < page_len; i++, redirty_idx++) {
 		page = find_lock_page(mapping, redirty_idx);
-		if (!page)
-			ret = -ENOENT;
+		if (!page) {
+			ret = -ENOMEM;
+			break;
+		}
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
-- 
2.29.2.729.g45daf8777d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
