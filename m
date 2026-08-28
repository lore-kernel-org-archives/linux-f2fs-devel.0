Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1FEC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZPIgT9yQ1jlIW5r+c39SGMv5fMLW/KWbKfO8NfdKWcQ=; b=l8S9JxyvM8QN5CeCPn9tA16vMI
	NE+jzXBxxzpiLCYbeIZRmtR66QQxFoYu2+YOZtV1lwvFF2uKgqKBi6EK4iDs4XjUIX8DLJpq4YN9p
	w2iz4PxylE8UXqp110PZi7/NB8xZVSU0e+X7Fvzp8jWEhD+XSaDI1XFRNR+TKTJStdOo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzvdt-0000Ag-7i;
	Fri, 28 Aug 2026 12:25:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzvdr-0000AY-RU
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ghL++ZvF6V2+SKQri2NFYRwIeM8mcziADY1V3awfvk0=; b=Ua7jtNAwYZ+wVGZtI0VGELceNb
 Vjn6swrKhjzD8qbapiJ25vVb3I/bFVCj1vrBmiaG3KAj4CWgrZOPu3MkXxgyohvgbUIo/M+LZctIp
 Mdsg7Sj3bOL2cJ+0zhg+9KJ/2YPslW+rLPewIwgJZmxsGOwK884/qE5LkOkr1ECBpYGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ghL++ZvF6V2+SKQri2NFYRwIeM8mcziADY1V3awfvk0=; b=I
 rj9H5RHSgWxe0YWF3+2YDI9J0g+jqTRZCJO6BXQwyvgj2juklVuKNXqLm0x96ofemQsjHVfFAf4yW
 mB9gE9bTW3zTNNHbTUYmGCiT5Dg1ouqsqaaEOMJ3fabYQVdBoTQ7Bdu1qFdRbySV0z27OE/93Q1tO
 4Rak8pPuvcwmuiY4=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzvdq-0004b9-6M for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:25:07 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2caed617615so6636945ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787919900; x=1788524700; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ghL++ZvF6V2+SKQri2NFYRwIeM8mcziADY1V3awfvk0=;
 b=SGQ91zMgU3c4OdraIpEMb9Ei93CoQQeUnyxhJbPJbRwhA2q1AcTpgNm1qvMwY8Ue8X
 DIKpNGSwJWR4dMEXg3IS/CmZ4UulbZPn5/qkxwWDj6YKNv2Gx+3oEqCsKtBLPwA3df1j
 y2K2MWxgwA9eTQ9ACOasE599JuoMv8penQsurOTsHQZFi91JJS6CDOa/vpQpH3m5ce5n
 hNzkc88bWj9EWznGj86OAOKNtTTmEw/SdiD5wDjx5Y/5SPWj7FGikKLeyL1x6nvK77Ol
 /gVe4GAWXa0dx+fV2WvEzl48AGMD8SylbtMi//kNtDleFUrCwBedMYX8mqcYC0UlXREw
 QvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919900; x=1788524700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ghL++ZvF6V2+SKQri2NFYRwIeM8mcziADY1V3awfvk0=;
 b=VovkJZ3xgirs5ePmJh2VaNmhoeZFw/HXwc4ZmV+4Hi7uLMt2kbuJY9d84qsCTTBr9z
 1OTWXUgO43jW1RLG0v5mHJDc8LmGNpBd4EJ54hsoE7x9yOeNVzbaukHW6fM/MC/vvHZU
 maUcNx1pLnJkcbCMq2Z6onTMpKuCsHQNPt3LhuCao5h4yzIkSLPnmUIKb4o4OLsjj9RB
 kZ+HWUa0e/8eZCSHJgnOy8vj6NIdnTonPYDrYHAWNA1vmmxSxwXpElm95dUme5EXjy1h
 E0OZl3XhBeLXA09u2Jyx5bUt6dokXchuUyKApnO/s36hE90JzRmIAl2+AOx6cjwR+JUh
 4Bug==
X-Gm-Message-State: AFuF++n0UeZy13RLP2RUYAM4vbKSXUG+ypl9U1Wwe6hxOdnf/U01g8MI
 EY+f2r36H4yepFF9xGT9Q6htG0I+Q4QQWo/GxtJYKJmYJ+amamkKlOws
X-Gm-Gg: AR+sD10BHf79lb9aIAqEY21QHNPTc7whJ029Z8dOMuB5Gd7AnVs3rgG7BPc/GTHZzc5
 AsVYzJor9mz1+u7SqXnBEtLcTQwLLUjPw3wARtr8w8yMkVfvtyGpuymZRs+0o7N/bb4JToYyP6g
 JTXJZO6xPwmcRUbVfujyACZny6BPMqJCLKqoUSuNZNmsOTE2m55kZN4kozhiSuggYUg2tfptRO6
 y2SKLe/iZHSWH4wVn4bd1YJmrX9bE+P7u3gB+yuYiFhJPHPiMgmOQ14712YS5TPc2ykSbkPauU9
 0eXnWHRbhi0cLYnvqkyM2PM76W8MwprvH6WPuL5PPF8loNoyXYRCCjZtyPnT4rDBYXNElXRAOh3
 +TgZ/+Q1USVYFmoQ+rl3UVaUCW0NKOIKcvMXzVph/lAvsx70yMlSqe4upowz5P+6RaFxZ5wdvyE
 ePGw+y1DQSe2pSjjruNBS5TsA4tbSskGR/Yohn35NO7MwWykdFntMO7qaFn+jc2mJBwY3U+BOQe
 gB+jL5n0ZI6QFC/6071LR+q
X-Received: by 2002:a17:903:22d0:b0:2d6:ccc5:a3dd with SMTP id
 d9443c01a7336-2d74dc2ff23mr111979445ad.4.1787919900181; 
 Fri, 28 Aug 2026 05:25:00 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7594fb48dsm4969115ad.14.2026.08.28.05.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:24:59 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 28 Aug 2026 20:24:51 +0800
Message-ID: <20260828122451.1154128-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wzvdq-0004b9-6M
Subject: [f2fs-dev] [PATCH v2] f2fs: sync pending discards before reserving
 device alias
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
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A released device-alias range can accumulate pending discard
commands. The reserve path later makes the same range valid again
through f2fs_reserve_device_alias().

If pending discards in that range are not synchronized first, the
discard thread can still submit them and hit __check_sit_bitmap().

Handle the synchronization under sit_i->sentry_lock by moving the
range wait into f2fs_reserve_device_alias().

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v2:
- move the discard wait under sit_i->sentry_lock in
  f2fs_reserve_device_alias()

  kernel BUG at fs/f2fs/segment.c:1228!
  Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
  CPU: 1 UID: 0 PID: 79 Comm: f2fs_discard-25
  RIP: 0010:__check_sit_bitmap+0x2e1/0x4e0
  Call Trace:
   __submit_discard_cmd+0x921/0x1140
   __issue_discard_cmd+0x524/0x12f0
   issue_discard_thread+0x686/0xe20

 fs/f2fs/segment.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71..50d49ba3e11 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1916,6 +1916,15 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
+static void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi, block_t blkaddr,
+				   unsigned int len)
+{
+	block_t end = blkaddr + len;
+
+	while (blkaddr < end)
+		f2fs_wait_discard_bio(sbi, blkaddr++);
+}
+
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
@@ -2684,6 +2693,7 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 	seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
 
 	down_write(&sit_i->sentry_lock);
+	f2fs_wait_discard_bios(sbi, addr, len);
 
 	if (seg_num == 1)
 		cnt = len;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
