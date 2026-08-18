Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3022C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ybyuuc/77Tx1u2BbhiE1Krdp2Ql4nv9yWVl6LL4M00=; b=bRMd8f9mPANITXJg1I2PgDm0DU
	EEFY5B7YFIbKCTnZ5zmu211lE8a6HECzH2LKYOm1Sz94vD33f5iXM1/krTasEmI5yGUDTokop6yf/
	BqMa0CyX/qwDCzYG+TPY67YgSHrl0J844dqSZjaP2rFQZhkanyWmmM8AZNFC7YYOhfK8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwNAw-0001XV-06;
	Tue, 18 Aug 2026 17:00:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wwNAu-0001XN-Fn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 17:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xmCVRpXxKwkhcx1lJpD7Ch8hM3Y/f5hFXgHyNXwdBpY=; b=P7UPirBUAA0ptRIGocoGRrKX5T
 DWCCzYcicvzqHvLJrzawczqPGImFW3V3iPnvbXEEN0vQNCNBMeBw+RTqoWVz7sQHT1KrrOg5dDlLF
 JajpHNlvLlAs7QdXzkB009jWIYB6DtL8kLAH0NugaNrX9lkywe5SX0xkzLKMpPCPa4tk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xmCVRpXxKwkhcx1lJpD7Ch8hM3Y/f5hFXgHyNXwdBpY=; b=g
 r6lsRLXYyYkRosd/CTEQkhiTIgqaHh3NnbrG0T05wZ9y62UpfpB77PWpqEQwfpILyeN9O65Qw63K2
 vwy3MLBdveW6u+fAuIE6C2jxG8YBAEDvXiBJkBn1mpLVooDVKrdME34BQ3lh5cpZmz6MXA5aYplX6
 Sdg2uH6cPqxWnAyw=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwNAr-000621-Dv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 17:00:29 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso8514a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787072424; x=1787677224; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xmCVRpXxKwkhcx1lJpD7Ch8hM3Y/f5hFXgHyNXwdBpY=;
 b=XYMFxFiCzXaGFb49FFDsX0gnxzsnGf7m//Nyych8LWjOlLzpgRHu76/MqGKeefSNAt
 1X0Dys27zj4etALba9RHs260DaD+ypPrzJd8+M08rPHaU6ZTvGayUSoDAF0jGXgf0b6q
 agE7wFTN1EfmfDAumPPUd2DAfy+D72J8DtW5yRqBtYpJiJjT0YGyDNUChLucEXkEYyis
 yj1A3E0w4Wz3FtaJTZDUeu1nfqiz1dpvzdXxEFrXBr9fKatFOzFo84lIORo3G3y5vBTp
 zQynrZ4GcynuX0LJ5lHSG47fQ/tTCqi9iGAT7QfzNQZgJL/oyPx5BG0kiN2Q+DTTSQsw
 xklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072424; x=1787677224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xmCVRpXxKwkhcx1lJpD7Ch8hM3Y/f5hFXgHyNXwdBpY=;
 b=Oo+SNVS0ALo/0QSn1Ouo8r+MYkhzKiN5Lied4Ntr1tdzVriq2VCqJ7YRiBS6H4ocR0
 QA2qupWXvCyoKOzok9h3sYkty+rJz7TL1hrbn2d6bQNlaEJA7SPGnzX6ag5Wxqyq8v30
 tsqL6Ins3pQqDbqnJA1zQnnqEC7R6qB2LsYu9MzrKlEUJgZVbIRdL7tUTn5Hf96qM8qe
 lasLYzZ4eUrYd6t4vRgqxonX95ycpFV1PF8mWpvvTWS2BBT9rPxuJwyYiw5u7vVwdwoN
 4nJj/I5euHt4cTjk8t8T3NyvqShLNKm1cJkSFPlKFw7jkG40MIaDZZzf0jQu5BU0TSHJ
 2kDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNg2lA5eEjyQdQrYMSt8ibqfbNshFCYU7D8ivHmqHtbBWc0wnuNk5zmVi0BjCaDva8KpWyRefMida7kBvJgB5u@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw3U2oe0I/uM2mKQS3xGyMOH7Qzc1rDn6bOHNAnyX0RyJL10N0J
 2zrVCI/Ug/g0ATMsy0KVzwW2cQFKq/IGROXykwe0NDr+3UvnSvieUBCl
X-Gm-Gg: AR+sD10MZFtdj1HnSIbwR8HVnfqao6IqMDA87sAFE5YNSqIdLMkONm6cNK8gGoPqieC
 F0S96D+MVJm3fQhve85NrBjfne+ny6HXGZd707kQxvU7nW4KZmcPIpJr/IRxxeQod/5+mWC+UmV
 bPG0ekdLd844ot9Anf+jNuekKnYmeiRib6t7LoO3iftk2nXu5JvXJgxmmhy5xoTX+5Jd966e9mJ
 Q5TR8uDE7cw5Llj/b1hzQba6FDeeUNOQKT7KheF/okef8k/Sve23G1Ki+t+VUfXbmU41xrKpn7N
 nhTCDnuqJ2kUmqEqvVvoms4QbhcY1e1fuR4Z7c9u6n05iR8lB2FsvaMpfcAurn4xk6ZwkkuP8Yt
 ziFYJocIobMCSGyFz8QVwOsiB1Hek+v08XTAU2J3AXC+ONPIV7SEv7xodj8vLKMZlTAQwlrhkbZ
 JupM8LemUUrdzr7+Za224KgKS2xx+LfKiGm+GLj54mv06Q+vU1I7LYaKzB3PV4MhHfVMD5rOReU
 gOWYaIa2BEa8yzQY/w50DJYD/oU+Vug0TfNwmjf9EPaA/9u+c4kCmw/nHD4JHZNpNj9hoYzBkpp
 uM0DXlEcymtJ
X-Received: by 2002:a05:6a21:3f92:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3ccf2810f99mr5367476637.5.1787072423432; 
 Tue, 18 Aug 2026 10:00:23 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:50d9:e296:7754:dc83])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14153064d86sm16046645c88.6.2026.08.18.10.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:00:21 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 18 Aug 2026 10:00:18 -0700
Message-ID: <20260818170018.3132110-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wwNAr-000621-Dv
Subject: [f2fs-dev] [PATCH] f2fs: fix to migrate all curseg types during
 free_segment_range
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

In free_segment_range(), the curseg evacuation loop only iterates up to
NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.

Even though these in-memory curseg types are not saved in the on-disk
checkpoint header, they still occupy active physical segments at runtime.
If an active in-memory curseg happens to be allocated within the segment
range being truncated during filesystem shrink, failing to evacuate it
will cause subsequent writes to the curseg attempting out-of-bounds I/O
on the truncated storage range.

Fix this by expanding the curseg evacuation loop upper bound to
NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
out of the target range.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ffaa7ba76a1b..192b16ac02f8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2222,7 +2222,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.55.0.691.gc56d675ccc-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
