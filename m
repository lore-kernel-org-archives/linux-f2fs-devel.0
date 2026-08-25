Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9033C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=En0Dr8o4nmd/BiOWsMeydE59pMAvZAwWO47YnfTWNy0=; b=g4efq6TiyOj/h2tfMG7bP/YGD9
	fkYWyDYijDcEvp9TCj0cGjr9XKMi8tX4Tu4UI8YYCSQuKNt1fb+9K+X9Bb8NvHUomyWM7+KVu9Ozf
	G+ahxss/l/y+rfXzHUJqCb0OPro5FQzMxF+OITHxM/iZn7VrYeoy/sZ8X+/5xtO+TxyA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wymfg-0005oZ-P1;
	Tue, 25 Aug 2026 08:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wymfH-0005o3-5O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mb+CK2NqBUYVaIe5Wsr+/1j4bZr/e8glNldexkHYN0o=; b=BIJBl6fVf88j8r05FJlXyKUkuN
 z+wMnFBKAabZUdyRIZtkHxmey8wODQolrD3O21xESsH1A8LReQ1vT4qhgzXYSGjrIUyRb+AZKzcp/
 oNodiPHk4w4iiC9PKJK2XPXHpJMVC+SiTBj2aSeItMfHeXJTywCUPxAAySJpfuMDS+PQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mb+CK2NqBUYVaIe5Wsr+/1j4bZr/e8glNldexkHYN0o=; b=j
 w2As+8ZFGdaTBaSe/dlVIRPGj77TSezwTmlWrwa74FKLIB6h1kVE4YG7hJKoLO4OXF478xUQoy7jt
 uOB93afr01nNByugdcgijw4uJ4jQMp6v9fToK91o2326mGWrxBaItIx1dXpmN0u7b2AkYHkQOUuS3
 mLuNj7H2VwYhz1Wo=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wymfH-00044D-D8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:37:51 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so4307793a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787647066; x=1788251866; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mb+CK2NqBUYVaIe5Wsr+/1j4bZr/e8glNldexkHYN0o=;
 b=NX90X88q2ukDlYsrdYAndsPwIJghb8S6E5U8/xJN6NEDQ3BcTgCkXphB6RTv3SFOqJ
 tuXUMwYMVzAtJBiXuI45z/WCfR1Rz174mwQW32N/MGRtcOiyS3FR+c+Rgbst0Plq1TFO
 es8a+B4bL1J+Fz7kl5pTMJyjzxea7yCuVCPWhnm1g8s+KaP7QZIXaEBFaJX0Iwqr+O8s
 e+IywyxjAb6rYJoKilHs7vcD0C501IgRLnbDLnoQmVllpu2Vj09Z2l1vI6qxHhP3yuhm
 XYQnO/L0mm6MnNbBpfbAa2B0/EOF8NKjlvb/tx7lbBQdP5+QbWzzTeW9ICxQM5dGm3nL
 nSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787647066; x=1788251866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mb+CK2NqBUYVaIe5Wsr+/1j4bZr/e8glNldexkHYN0o=;
 b=KfTZhMI1oD7QfmXDit/JpbGJdANvylAqQ6RU/+KFLvJlqZOa3XrD6Qh9s6SHYxNKd/
 twWWQlkX+jHJiH3PgN1waVVVOt9ATWzP4oq3y4JrKnL9GIAHEupraw9ycP2XX0RINcPf
 N3j8pKXc72M8Vve93wyBeN7SMg9/g76YeHIOpy65UsEwxMrQvZh6ttjfU5yCX1SfwRIi
 u8JrkO6rNZx3LGqX7/ayBJ1V4tryT7s0QKm7Ciu1016rHMPQecWjeZ8qj8BRzPMuq2gG
 LQuW9v1mcc/ngJFeEB+6HtmH4fnjeMNjcP51WW2O97ZBbP7lQzxGBK10TG6rJNN1OOaz
 gYvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roe/rRnsjptZM0eFZOFGEljJF1R/mwX7XcXZf1SUky4NAAG7d3PMlpNsPsM7iVe3K032ul5cGbjy3T/Gz4KtlrU@lists.sourceforge.net
X-Gm-Message-State: AFuF++ntZbwv24dLo0AFKuy4r0sR+xcGha+dKIIfBdUAfuihiMBCWlMt
 5f8kMETlK9CWPiCO0CYv5BmQFXy0pfLQMu+eUGfWWWWvJN8r1mwC7ATI
X-Gm-Gg: AR+sD13Yp8skbHewDyJgDT8Ca+6fCU7RQgv9MCx+/WIDXfKrYmfWGCZ6VPAkgMQi/X9
 t0LL4QnRLOkcjkGndW7LQj+/xLiL+dONb8umnAT7B9qbsQUZFJpXvf6xHQsHgxEZdk6CTyUy7UH
 Q9Vhsa1fxfB7+MSq54sCo9JrN+mUrBJkd88jaH2nxqmHkm6PTIJFxSaplrJ2gb3DstdrOuaglCG
 MhzTT+ieRzzTS6TiGrNl1ITXmBmxYx7QtFVc1K8vK7NDM+7uDRvELuRT8FDC+KUGdhNyaBWew+I
 +IPC8rafuAeSbLEkvGi9iCjTA7lGq/Bms5SeSeCgF/+mwTac/kveuRolF9fKYFHy4WXfceCwwHA
 p7cqUGfC9bQwJRmayjKtHwKkfb9Yl6gR0Wq9TPaitio26kp0VHkQaIASOqBfPn1ps1PISEzBzGb
 VNUmOba8EOz5g22KUNJUPatitVpEiff32krUvUKjtpVh4obQiqAGkZorDNsejqWKWs7VGv290Cw
 lUO02ASyiLFgbTOR9ywhXHDcBzZBjnT24s=
X-Received: by 2002:a17:90b:5844:b0:393:1d92:db5 with SMTP id
 98e67ed59e1d1-395c35e1199mr67956027a91.10.1787647065666; 
 Tue, 25 Aug 2026 01:37:45 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d31e74sm2941246a91.11.2026.08.25.01.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 01:37:45 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 25 Aug 2026 16:37:38 +0800
Message-ID: <20260825083738.526423-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wymfH-00044D-D8
Subject: [f2fs-dev] [PATCH] f2fs: propagate resizable_tail_secno mount option
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
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Mount parsing stores resizable_tail_secno in F2FS_CTX_INFO(ctx),
but it does not mark the option in ctx->spec_mask. As a
result, f2fs_apply_options() never copies the value into
F2FS_OPTION(sbi), so adjust_pinned_area_boundary() ignores
the requested tail reservation.

Set the missing spec_mask bit and propagate the parsed value
through f2fs_apply_options().

Fixes: d8745ba260ab ("f2fs: support resizable tail section and unify pinned allocation")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
QEMU validation summary:
- plain mount reported `pinned_area_max_secno=502`
- `-o resizable_tail_secno=1` reported `pinned_area_max_secno=501`
- bounded fill stayed within the reduced boundary through the first
  `FALLOC_RET=-1 ERRNO=28`

 fs/f2fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c1e315282ec..6238dfe6f4e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -406,6 +406,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_errors			(1 << 23)
 #define F2FS_SPEC_lookup_mode			(1 << 24)
 #define F2FS_SPEC_reserve_node			(1 << 25)
+#define F2FS_SPEC_resizable_tail_secno		BIT(26)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -1250,6 +1251,7 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_resizable_tail_secno:
 		F2FS_CTX_INFO(ctx).resizable_tail_secno = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_resizable_tail_secno;
 		break;
 	}
 	return 0;
@@ -1779,6 +1781,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
 	if (ctx->spec_mask & F2FS_SPEC_lookup_mode)
 		F2FS_OPTION(sbi).lookup_mode = F2FS_CTX_INFO(ctx).lookup_mode;
+	if (ctx->spec_mask & F2FS_SPEC_resizable_tail_secno)
+		F2FS_OPTION(sbi).resizable_tail_secno =
+				F2FS_CTX_INFO(ctx).resizable_tail_secno;
 
 	f2fs_apply_compression(fc, sb);
 	f2fs_apply_test_dummy_encryption(fc, sb);

base-commit: d8745ba260abbcaf75fd458881381019ab3c5c07
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
