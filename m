Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1380606A888
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LEfapwwT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JPNAycHn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fSDz8Zsu;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LWhxZPOa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=FtbasWoLI6H8/2MiuFQzt/erhnM530qOsPYIN0cQd8Y=; b=LEfapwwT/Uf6Wzbyohm5OqadyB
	D3fN1wd6PjPxIJ+ZEebYingfBQOxWIBty28CmJiUyJAFRYuP0hhc77A2q6/O9fIDDqysEYhrsw8kE
	DQaUP7sCuAEsdc45AEwI0ZK9hFpPrxxMbbJp9Z9HRS3hdd/vxNOpGIrxLcC3qUVnCZ2w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2N-000000005Es-1ay6;
	Mon, 16 Nov 2026 04:09:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo2L-000000005Ej-34oR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQYaNjdcGQv9Uj6dMxhoXtev65GzOguk0tG1Y60v4H0=; b=JPNAycHnCXJuhVuCaznz+yFVeT
 Ajs1EPDDpxjKhL9WZGVMbaJFKmtOdHX3TDec2tzvCXeAGHrYbnN8hTnGiioDzRkILrHJu6o3tMFfp
 HNGOpv9oyzRaxN5PzHJ98nxWuTCaCttGvozyKavNypnixRxn2mUlxk66fnXBv0T9R+qU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQYaNjdcGQv9Uj6dMxhoXtev65GzOguk0tG1Y60v4H0=; b=fSDz8ZsuVVOP0zxr67gU+uxAPc
 NL/Ly+lRDyBL9xoje+fupiPvJtwZWIn+dLcq4GL8o0wyw+cVKriVsmls/oWrHnsB3agDpaHoTrLyX
 UmVmtCGWTQa7/am1i7C3f6tf6AVmb7KLc3yLr5lVpsdIjJk2FrIaBmw3A5GuPM4LzJoc=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo2K-000000005hr-28NK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:45 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ed06b725fdso26805805ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802179; x=1795406979; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CQYaNjdcGQv9Uj6dMxhoXtev65GzOguk0tG1Y60v4H0=;
 b=LWhxZPOayd2cXIbn+Zp/4PpFJf9y5t0I7n+doYPzbWqZ9slIeokVt12HD9/Vg/zGd9
 /BbIQHNyYIAm3oYI40pcZPcFtAQteGXM5MQhII6IZ260rEQC/91s0MCc61jnY4fYSb3p
 y7c6M90FjQb2Ck++MQ8qmkfmE011trq1uIyN3hMmg+W9NMbbEI7zOhm08QGFe8J/6bOj
 NqTKjb6Qyd2YQJDZp9FEsTGNgmyBhJIB9VoK7Q6ft+uuuKxtHWQjC74EJA4YHlVj1zbJ
 36IA7nEnS7bngPME/aTAcQZEFDmM4eCt0xy/du49XuIx+eRmcLS6Ml8NIw6l5QgqWps9
 6u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802179; x=1795406979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CQYaNjdcGQv9Uj6dMxhoXtev65GzOguk0tG1Y60v4H0=;
 b=L9FraqQLwZDqQwQmmOfMEpt82BdmiCdEOfqSbCrTFTYrto987f+595WYiVpPFGTSb/
 Y18RExnQEX9VHeZqYg/+LMGIZpUB5A+iPesOnxicyPmAap/sRpyAn0wD8FcZ9u6gouUi
 XhlOt587P2JJwLBOqf9oEqoy9AXYbPC6nJxTSMH4e8r3Aeawvl7b0a9Ct4hLm5sqGIgk
 f0hROJShObk4Ji6YPdEh+hv56xhQk8Oj1Y7or+NoAt9n+2NqTTeLKtWFW0Z30JSZJwbc
 VTTfRk7ygoRU/LTyyZegsTnkxQGt9NFtsdzRA7qE1oNEqKMxxAWafdm8mwrHbkSdRdRP
 UXJw==
X-Forwarded-Encrypted: i=1;
 AL+hErGB7cYaLwPesOS4RsZc21CMLz6J8ncm5eQB+mh120bse7bY7jDlFS8KIzGwlrq54/YLBR0q/QHlQFUuM3PvuHdc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8DvyZD/leDrmMqqFTh6ewOyAOST7v8cbmUOFh/xp0Gzkb6S0iw
 sEW2t4jHJYd3rvEXrJOMAI6HEjqkMO0papeYhsdUEF372l8oczBaubmU
X-Gm-Gg: AYBFou2WhOpa5k7Aw3jKS5OoN7VfCkIcXnesy33AId4ChaZ00X8PLYqV0sBUCWF7G5G
 U4wObdNBcNkLGzeMYpxQxO6Pt2MH4SkU/rVxP1JDJwJGLViCRRV+Z23zvFEHn9mcqsevntCTi4l
 kRB1AR4OjSQWyu8i/rH3f3U1qSIoO+ScGGtwomuEAqc5FxYx+dlHdGpM8w5/PiJk9hQrBdSrR3u
 D+0GyVp7jfueU2DVMoeuJxEp05QMba6NrMYPu0LE0zFYdw6RFOmhulDWD9ApyXvs3rW37qGFS5y
 bT66AGQQgu0cm1m+X6s6JZVKJ3Or4/aI1ymQY1u1l12+aXatWruIcDMMU25VhEzm72kDBA75nnJ
 Tl14iJqzAsp9TJ/4SdrcFHkVv4UZVdV3n3bMxwOAwTAAZjeIWgEzQil2HvHwJeIAwzdoKcxt3WN
 5CKBfFbp9hgJeqlrZ9lZYAzl/713jkinSg8dRRMBd6z5djawgiSEDTMaM/WCZBcX2DMAtN4CgnR
 dOm0zjw3Q6r/unC1tGbQv7E3j6q62VobVGgILS/47DmAkSkT/KEPVbA8YJ3CkN5auLa/wUYrCd0
 kBuCNQ5vKsM0Scwlja64+mZeEdzr11qW8NajhFckrwDUGWrIVo7xRxUiHko25huSA0Nj3Doxijm
 D0TB5eKjsUSFfDLWBHvWBQOCysID7Rt5hLicIGVPzQ5O1zcI=
X-Received: by 2002:a17:90b:3ec9:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3b1b0b9207fmr6746777a91.18.1794802178829; 
 Sun, 15 Nov 2026 20:09:38 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:37 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:50 -0800
Message-ID: <20261116040851.2849696-20-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo2K-000000005hr-28NK
Subject: [f2fs-dev] [PATCH v2 19/20] f2fs: count compress cache entries in
 pages for its memory limit
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

The compress cache holds one filesystem block per entry, but
f2fs_available_free_memory() compares the number of entries with a
percentage of free memory counted in pages. With subpage blocks, this
limits the compress cache to a fraction (block size / PAGE_SIZE) of
the memory that compress_percent allows. Convert the entry count to
pages before the comparison.

No functional change when the block size equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/node.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f1eae132c4d3..c83a5d79f2f3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -116,10 +116,12 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 
 		/*
 		 * free memory is lower than watermark or cached page count
-		 * exceed threshold, deny caching compress page.
+		 * exceed threshold, deny caching compress page. A cache
+		 * entry holds one block, so convert the entry count to pages.
 		 */
 		res = (free_ram > avail_ram * sbi->compress_watermark / 100) &&
-			(COMPRESS_CACHE(sbi)->num_entries <
+			((COMPRESS_CACHE(sbi)->num_entries >>
+			  F2FS_LOG_BLKS_PER_PAGE(sbi)) <
 			 free_ram * sbi->compress_percent / 100);
 #else
 		res = false;
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
