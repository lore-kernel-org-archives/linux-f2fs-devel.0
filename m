Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FCCC61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0LPzJTD+LecL2JDd6AZ4gwkrBi+JpKRXBW+SDhyuPM=; b=HZAW0G91XH8VMusyQbiiFeiFAb
	gUE9trWKCJ5ZKpP2t1RkiXvUxiFhC6G4fxjSdw++ubMguU4f2RwDrTsZ5FiDBzH7bC7idPARHohlM
	HPL5Xb9eYeYm40mLMxdgYiP2fgrkrNma4uaIPu5Th/RMVtW1uT1o0m+E4ZV4iv6bVBE0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0CCF-0004EF-Sq;
	Sat, 29 Aug 2026 06:05:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x0CCE-0004Dx-3o
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:05:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=; b=V5xkw40gaSkV63y62aRI3ebEpo
 UISQBQXMfl85/70PEprnk2CHknzTSH3gN+wyEDtgWAQvLzjfLPyNFASjh8aHUaE0EQq9w0jg/yenY
 YJvOwrOTYtZKxUoyA0lMXDocbs9GSknbp3CURqXBAcX2JUNQxVADYabD0waHHtz4Hgfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=; b=GtTUWvSCx3NGvkqUysK6bLZiJT
 QAOVcoHLOJ0ny8bVEjgQiLhbMygBtWoNDGJjpxG5KoHEVIldyIVn2DI343bfNWnynuoERPgHbLsmb
 aPhe5TjWQJRkueTpcyv7rEio2+7bFn+iuDnk6gzA2kLUJM+krFFEButKKA9xa8R/v0cw=;
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0CCE-00050j-FK for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:05:42 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so127874a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 23:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787983537; x=1788588337; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=;
 b=SJZxMFPY/ZR1kqNdQfw+CVQuqCCEA4XdznMKRFclk6C1htLQ/q5bIuuAHWDwUJqlgI
 hlYD174NyR1avGmQcYVKNeobwTQnmIi7sgpnA2C4AnGGxVpeJn3JnGAUqv4c16/DLGuv
 vNTnvXnbEAzgthJ7pSChQQcMF4zqGPlzd2eWD4clbFYLzkVqZBRfM47wDivV2/WgkLzV
 luUJF2wZ2d4FqEZG/RRl40Fm0YfqvQ3jImTDq+XKPbAj3a8htZIRa2D8ySBwc767cGdn
 0IkxbvLWn3fD3Hs7yXqNQXvpeG3w5WvSscxFPJ1eqV7LEhNuyB9rIViTd5B7uSPau0vu
 Ix4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787983537; x=1788588337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=;
 b=BCRVJrFAZFXDzuxVbiM5y1d653mCP+eJ9lmxuyJmJyfqIG3kRshMvgBPt+8AV9JR+4
 ktJcY2WTKRx9xgxINhmuL3FMELXBI1m7bHRClYxOUFWXL6OHNg0r+zDtYtbFCHjEYcES
 bhOEhNZ38PYCPC0jcpacPUdhPSkf/h8oMXDlzcECc/7DWdZDuRkKF48BS0pwRd+bvlYu
 VbCI4n+zmhTc0JZe28RCMfFCX+qonUbMvGeSDZlSXJedojAzVW1DEvzHxiWWkatLoofZ
 cRqOHw98Okto8DN7UXWfNuxtyZoipiSW5vxBiZoX44e7dk3F8HCy84PTOPv2BBcbBrIx
 23rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywZ3MiTHGpLyuxAm5KuM17VOdU4rTgpWtG+WQziA88WZ6AwSq2aRsve8dAG6uQtzsNrm7fYeDtlSpEo3YLDHFt@lists.sourceforge.net
X-Gm-Message-State: AFuF++kkbhDmQJfNTMkzo8N3SJGNAQxqle6mzmW5AIhWr8iVVzCulx40
 tkJAo5XmTmlU2c7qZu8LsM8C6da0vUhzdsu+EeyqaS85kinqp1xQ2Dt0CkSfPOLd
X-Gm-Gg: AYBFou3KQaolEcSANn8lv+bqX29Imb3uGI4MRrTbaXRyMd1I/Zfjtar2tL6aib0H/w1
 vIlmMjkpoSGI6aXRb0hQ1q/OildMeQIE/Q+htnj4jIwI9tF/cMHuc6Y1vw4nGn8VBDHYrlb0oyb
 dYBuhdh8GyycbpXylr6i087HfvC0EsbJx2r1sdMLwfT6jo+93I44O2enjSJuXEn/8GaJA6ciD/E
 By4OatorfxhKf/ANJvo0VQoBJKUIvv52jxOXwdfip8d4NNcQYpUX+LRVIX0Ret0w9jkbnhKQ6Jv
 msry0PrZ1H5HHHVfCIIirHc2b/P4d/74y9MdnfzsUIwvuFAeV8ASRlj/oAdjgWyDPIM4v2ff32J
 uT94EbWEwvm4aRYAlNHC7OKTP3Wp70sDZRwLRqll3Dcl1SCFGhfGhhm+0yl/fdDj3P7Xbn5wBWf
 pslEL3tbe21jyGpaZHUQZGO4KfbQWm2aKNKvXccgUwjYBzy+ErqWUMAP17Z8oibRm/zIVt6O0D7
 +0eeB/cXfPHBd/2xWXMHP2n
X-Received: by 2002:a17:90b:50cf:b0:38e:42f5:d096 with SMTP id
 98e67ed59e1d1-3989b0db85fmr3991699a91.0.1787983536638; 
 Fri, 28 Aug 2026 23:05:36 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396dda36ed6sm5609411a91.2.2026.08.28.23.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:05:36 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 29 Aug 2026 14:05:23 +0800
Message-ID: <20260829060524.2656620-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x0CCE-00050j-FK
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: flush SIT journal during filesystem
 resize
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

During a filesystem resize, SBI_IS_RESIZEFS prevents new SIT entries
from being added to the journal and forces existing entries to the SIT
area. However, f2fs_flush_sit_entries() returns early when there are no
new dirty sentries, leaving existing journal entries behind.

After the main area shrinks, a later checkpoint can access a journal
entry whose segment number is outside the new geometry and trigger
f2fs_bug_on().

Only take the zero-dirty fast path when entries may be written back to
the journal. This lets resize drain existing entries through
remove_sits_in_journal() even when there are no new dirty sentries.

Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71d..9f9ce25dd07e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4816,7 +4816,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	down_write(&sit_i->sentry_lock);
 
-	if (!sit_i->dirty_sentries)
+	if (!sit_i->dirty_sentries && to_journal)
 		goto out;
 
 	/*
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
