Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FF7C79F9F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dJMjvunPEPp7YbiqENlj5Q1oGhGbHN6vx6QjzSI94jE=; b=gBRkaV4b/raGq6JmleneQ1iVJf
	kdbikC5M1a0Fwp2AFSoiEll025zI3FWsN0RKKLSF5rfrd3OqRQscw6DDjByuKMEVS/KGTQi96P9Px
	DNTAEiP9WB7w8WY51x6nWZmSzOO0bEcycX1AY6+01P9FofBG4ZeHBXWsnqPgqAsncUZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4c75-0004PD-HE;
	Thu, 10 Sep 2026 10:34:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x4c6r-0004Oz-FK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 10:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dayMhCsPsbw/CfnWPlNfiRbfApFHvA1ZYvqzVVCCO5A=; b=LcnNBO/WIBjbnPW96w3T7bFQnA
 qyTdzkV46YfS8SsoN62pjJdViIXtUAOQnAD1r3iGaEoix8AIktN1HRWuaa1Fn+ei0whN3bUnwr0zv
 M53oZb6J+3gFNqBii214w0lcQ5CsCvSieICcSGfD3hzyUjhURqEsoJysLxYXGKY4Psko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dayMhCsPsbw/CfnWPlNfiRbfApFHvA1ZYvqzVVCCO5A=; b=kktXTPGYnTEvsnR6srSJyVRH7k
 RgfILEMIWtDn9stHzYNxgPOHuH9wGGkt+t5twD8C4cpuP8hTNTOa7o7Q2PMvTKPPLdebuUrsJzSn9
 lKwW0AbuN1OKIwxpfWR3WSOruyITYmDzvZ8oSjf8kvn0vjBVJG1yA0TNl1nJj3Ux95Nc=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4c6q-0005QA-8M for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 10:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=da
 yMhCsPsbw/CfnWPlNfiRbfApFHvA1ZYvqzVVCCO5A=; b=A+ak4nQVAzeef4CTfc
 kKQz/x/VQpjJhSffOG5WnCoF5poJCJNu7Btm1V/KcKM3y21fL6Pe6k15PohEj+wN
 KCD2e9LTzpfq+310yba5ScU0F6VaAfkWenNl7vzEmDBG4DY/wSE4hCfek4Qof7Ex
 +q1h5EEk7U+JO5egvq+XhWnX0=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDXrzSSh6Jqjf+xAw--.37514S2; 
 Thu, 10 Sep 2026 18:33:55 +0800 (CST)
To: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 10 Sep 2026 18:33:54 +0800
Message-ID: <20260910103354.2644407-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_x_v+roRVKdny2XP36h_zhs9Y=XEnPeZgM1URDfMMp7ZA@mail.gmail.com>
References: <CACOAw_x_v+roRVKdny2XP36h_zhs9Y=XEnPeZgM1URDfMMp7ZA@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDXrzSSh6Jqjf+xAw--.37514S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4rZFWfGw4fuw43Kr4xXrb_yoWkKwc_uw
 n09347Aw4Uur95Kw4UGanrZFZ0qw47AFy5XFWkKF4DJ3W3Z3s0ganayryv9w1xWw1kWr1Y
 gws5A34DJry7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRfMa3UUUUU==
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsBRKGmqih5Ry3AAA3B
X-Headers-End: 1x4c6q-0005QA-8M
Subject: Re: [f2fs-dev] [PATCH 03/14] f2fs: support regular file buffered
 writes on large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> ret = submit_bio_wait(bio);

I wish I could use submit_bio_wait() to implement this sync read function,
but I found the following two problems:

1. submit_bio_wait() -> bio_await() unconditionally overwrites
   bi_private/bi_end_io, so f2fs_read_end_io() never runs: all post-read
   handling (tracepoint, iostat, verity/decompress, ffs bookkeeping) plus
   the iostat ctx lifecycle is lost. (Even if we allocate the bio with
   f2fs_grab_read_bio().)

2. f2fs_submit_read_bio() calls blk_crypto_submit_bio(); on devices
   without inline crypto, its read semantics rely on
   blk_crypto_fallback_bio_prep() taking over exactly bi_private/bi_end_io
   and restoring them via a hooked decrypt completion. Those are the same
   two fields that submit_bio_wait() owns, so the two cannot coexist.

From my investigation, I found that if we insist on using submit_bio_wait()
while preserving all the original f2fs semantics, the implementation becomes
very complex. That is why I went with this hacky approach. If you have any
better ideas, please let me know.

See https://lore.kernel.org/linux-f2fs-devel/f1ad5d3d-f4c5-498f-8378-a5efff74a458@kernel.org/ for more information



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
