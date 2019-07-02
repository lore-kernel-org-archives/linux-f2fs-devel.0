Return-Path: <SRS0=nB2U=U7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1094DC06511
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:11:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E0D20659;
	Tue,  2 Jul 2019 08:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="RyMsSP+z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="nO0VsFNo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZXg0hrR9";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="SUuiCpEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0D20659
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v2evgfUoUWIavlxD38m5tcnNvDJCIlJnFEgY+M1TGSM=; b=RyMsSP+zeZGaye3nNASish7m6g
	0XQe8jkW1uWv/1qXtysmoVZF14IIorIyzaEKCmblP/J5Hff/LAUdda5lYzz217F74OSbOaCigtFcv
	S7DVJ6TuxvrWR4qHKjlKLRDPyTN7bO0SY51Ud2pdXiKnfsPacfKmYS2bBe4M9oNYG2R8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hiDtI-0007XT-8e; Tue, 02 Jul 2019 08:11:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3NhAbXQkKALEfTVReTYVeXffXcV.Tfd@flex--oceanchen.bounces.google.com>)
 id 1hiDtH-0007XH-Rk
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 08:11:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NEsgFhBOsHO1SUu/GnNK2DPDOJTChWsbzIPYkeXfosU=; b=nO0VsFNoMxFmR7LrfiPSpTxtgu
 AjFHZV6D/8KwdxbPuVkamuvKVugnXh9D08dPcp9MW2Zd8bELkQ7oHsFqWV/dffLnma/H6CsqYsdfY
 KL+nZrM2QtBIpmg0GCvBuLW4LlSUWZ4On6bobED3AiGqM4tU/40HO/c7GUWBGxskR0aE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NEsgFhBOsHO1SUu/GnNK2DPDOJTChWsbzIPYkeXfosU=; b=Z
 Xg0hrR9J33BNeouYqeUoQf8tmS2LMezDTZWvW08xC2Tye50hyXFxzzwMyAGNdflHW6JfQ9Sh/ZzBr
 Rtp9lhtu95JinWDGOUa7kwytnX+FWPezoNOVJhkxs45HrkfovTDNpL6xJbmHEHvKcDxdiz2YsI4rH
 4NtwJUo9eRyN5V10=;
Received: from mail-qk1-f202.google.com ([209.85.222.202])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hiDtM-00409j-Qc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 08:11:58 +0000
Received: by mail-qk1-f202.google.com with SMTP id n77so15927860qke.17
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 02 Jul 2019 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=NEsgFhBOsHO1SUu/GnNK2DPDOJTChWsbzIPYkeXfosU=;
 b=SUuiCpEyaak5XfddxqDhgd8CZLbHmyS+aWA9tOcpJKwvJ+lmczEa4pAv2doIL/MNAx
 oxbvwgOT7JP95TVpHvEKVEhqSCkHTaAIJ2qYLYjYX/sM5EVQ/ehuStA1RZaAx9WKHIu2
 HOMEvp+RFG18HWtxgTcDEihisRNtMoN4fr51BGqd0Y1aNZ9EUIBxSnArjNTNPZj0qKeC
 7lDfBfPvpuhQ5dGD+qwIbY14OOVkD/4L9H5Ax829EjB1ByMvbQVVg8/LyR1nThS/JZpC
 sGyguTYXTlq79AT/k0ECihTxoUZa47U8PBCFXFAtW0FYIKiTXq8syA+AF8rl0mZfO7q0
 9njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=NEsgFhBOsHO1SUu/GnNK2DPDOJTChWsbzIPYkeXfosU=;
 b=Mfl+3sEqKSZkkCmOtUAv904lvzp7spMPlYAEcRC8ins3F0+GdmbnIdb6FZVVE+JzE+
 rCvpxtndcMMQP0XcikA/Tv0q0D1LiunCb5SQl7O3p32hURIkpd2aB9Qi5ycuGak+Y9Qk
 3oB5rR4o+9KrJLmpRNYuj4486dv5/Yta2dmd04qrpZUAUD23F0i3ellGt0UTB79YIzxO
 d0nphbRUQaGHOoS4at8nW5R+JB8PlvxwnWDJ08BXnnXZvk07REjF6ZWR30t5Yf5ZL94K
 sYMT9T8CFGEmVrZz/DiT5TDkqLpJaMFD6QpsGXPhnKou7BEKflVK0ztqN2YK04RWeO5F
 BzHw==
X-Gm-Message-State: APjAAAUeCbixDap+Q0lb88+/W6OUj3pFvVCTiSR5n0H7vG/c3uB8J4Iq
 faidylgjCTbrjgst0eKG393uF5yny5kVO8w=
X-Google-Smtp-Source: APXvYqwrXvbk11TVxxDHQCIkdbAtLKP9A2wasQz4c5X/idjoID/jWMQN/mQNqcB/Hw6wGFCTefiRv8WenyeupcE=
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr24972711qkm.168.1562054710600; 
 Tue, 02 Jul 2019 01:05:10 -0700 (PDT)
Date: Tue,  2 Jul 2019 16:05:03 +0800
Message-Id: <20190702080503.175149-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
To: jaegeuk@kernel.org, yuchao0@huawei.com, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Headers-End: 1hiDtM-00409j-Qc
Subject: [f2fs-dev] [PATCH v2] f2fs: avoid out-of-range memory access
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
From: Ocean Chen via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Ocean Chen <oceanchen@google.com>
Cc: oceanchen@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

blk_off might over 512 due to fs corrupt.
Use ENTRIES_IN_SUM to protect invalid memory access.

v2:
- fix typo
Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..a5e8af0bd62e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
+			if (j >= ENTRIES_IN_SUM)
+				return -EFAULT;
 			s = (struct f2fs_summary *)(kaddr + offset);
 			seg_i->sum_blk->entries[j] = *s;
 			offset += SUMMARY_SIZE;
-- 
2.22.0.410.gd8fdbe21b5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
