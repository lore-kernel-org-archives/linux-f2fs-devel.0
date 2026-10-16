Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C89CC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxByfuCGfd/BC7viQqlnxSiGLMPDOhr1mkhK1UCkK3w=; b=YybaNegmuA0C23q5HHkz93m12p
	ZqTwrASSvg96F529W0grBUKT7T5F9FXwRIXty+nEh/kX8MqQnW01UAM5OgrIJosTsMd7ZL7SsBW3N
	6SCnH0tTGCtMxa+xT0Df5RXVIdKZ0DlAA/mlL9ftMdn3nfnh6DiWkZUrVNOIb+D+AlKk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHajx-000185-JW;
	Fri, 16 Oct 2026 05:44:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHajv-00017y-JZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=; b=Rj2UTHJ42UlfUVo+CvZi+VVwaV
 XQjIQfQV18v9w7y65ptmQ+8+QvOHr5rLnC6NnpSp3UHuQeBeu1H1yxKrMnybY9WjiYAyiDPce2pF2
 FRW6Oo+EVRgfIy7OZgRsrnWyuTlyGnSuhFnhcP4O6mwBGVRnaYcll+T63hL7yAvS7v7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=; b=dfY1bcjYxaAJh5HS1xKRkcOjbW
 Rs1+IOUaTrTuPQLQP8WS9LmFYy1+Y9W/Ox1Lvrdnhg94eMzgLquWwAk/uY4qycZ5IVTbSsjvYcdrf
 Bw50GsdkGiBDeJt4ZFPz4wVNM8uxOsNqX/Wqrq3bV5okUGLVpWEwXEQlFakDfPvrEzqs=;
Received: from mail-dy1-f172.google.com ([74.125.82.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHaju-0003VU-Of for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:44:24 +0000
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3514b90bb89so5098408eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 22:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792129457; x=1792734257; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=;
 b=Fgxt0UCteRb9sgPDoDMXVKDrcRpPGIW6/fcC4EEvTtI1BCty8lGBOnzYosEPw/a28S
 m0FVcaslsU9LUVAof1K2dbL6slVk+08L0zSn0EOtu+8E+3iZaXaahOzpcGk02iO9yhiv
 wOB8MDTpHWGjTlRRPJujPCd+ZClm2no+gPCdYnsfLpPeIShwmxtdctZtb8CZY4b1jcg5
 nNG2rqSt302LqwUz1VVLJQhEVv1YapzIOR/RpK2XIhqi7ifKiohgTdQo9zjygafGofVy
 mQoDlV/H7HGcPJ8nxhBKylAuGNAc2IzasmQak9jufU3Bkfi1GUHh4idqJPkMk1yIL53w
 sdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129457; x=1792734257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=;
 b=jMs1qbh6zYIVK0IavZ6cswG3QA2NLeYPJHUkTNNv8ps2lgouO6Ka4zg+eC9vh6CbPW
 4aDOKsNixmt4ZVIdaWZUvveS2At5yGpb3UFCkB98ztCNEZwYi9atcbzFmEn38u1TkPiG
 wDdC5zVdS9XQCy8EgUEyNhSitZpzzXsrGXEsshvi5f0OqP3/MUlnyhn/vbyLJyo/8652
 gWGXEWo42C93gAxwppmaxawp/VKiqJk9Ona4N/Z3lnkH1K9n8QC9Zmx4YWqpVPzYQ0pQ
 aKuC8p8NspUQdSVQnCyvdUOWf81ZxO1pNRzv7Dz/IA4slw1lLJqyWwEod3FHj3NsJGNN
 +wog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJkv0ku2AfsWlRcUZYWw7w+D2Seb20sdW+Edy/9cMX3gDwBCpxfmBbGhBRULyBc6+gOl5q8MoKlk3/yprhW7Xd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKoQa/I1tGLcSZljK3Zlv5RBGcEVCuK8akjJqlbnmxKy264mCru
 MLfv8z9/8KfqSiw68KvyXTG7ey+TB3J/2T6o8lEzGEpdE15fA+XjyWAZ
X-Gm-Gg: AYBFou2c4eN3dI07E2rX6XHh+2e8DBI+p7kExIreQI6YErQ5oUhQf/M2a61W1hUGLxW
 fBgxZtIKJDzLOd8WE2nKBa1kEuMmySvcyWEVhWgy7+fVCI3n7GbRX9+bPhBm1C4GJbmqHgzsl5n
 TEe4tgbDbZ5yEJdqLadnIAeBwUsx/CCb0ZC4EK5iGVcupaJnJH80D5UpTrcolUeb4jCmMNKjTou
 5IyNEZEu/eUr4jYIBR3NK9AI4rcMOljZB6TnwcKmUTRZSVWTY7XW4O0N9OWubfr17/wAGWuVjDC
 wFZtzaSeL72POIeOmMXEztjaEz5eYziqFEOcbTqpnPjfJlIvl4LPrXrkeCF+Um3VDa7pASohHP/
 QBp4fAMYUp+MPfUsPN6X28TwdnA9nA9hX8LW7sHCuLlnTI8nhhE3Isxj2WX5GYqDGN+Fr4hrXiG
 OOSdmJAIZxxCsmHmw92kshdRCMJBCxZqWAuwfCBbceN2e6Ykf6Z0x596ZeKq2RBmo+Gdb3CmQXE
 WuX959Y4fG8ashL/GCzqJuttKUd9kbTK3A=
X-Received: by 2002:a05:701b:2412:b0:137:fa50:a242 with SMTP id
 a92af1059eb24-16a586a3183mr26627294c88.1.1792129456966; 
 Thu, 15 Oct 2026 22:44:16 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fdfesm2642428c88.7.2026.10.15.22.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 22:44:16 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 16 Oct 2026 13:44:05 +0800
Message-ID: <7884c62cae6e4b1ad516a9ac351c2604e57d5cc5.1792116883.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792116883.git.qiwenjie@xiaomi.com>
References: <cover.1792116883.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xHaju-0003VU-Of
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs: flush SIT journal during filesystem
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
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25785b7626bb9..bf8d07fcce331 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4893,7 +4893,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
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
