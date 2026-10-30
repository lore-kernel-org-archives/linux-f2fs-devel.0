Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B2606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bSvMq2OC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SWnRU5A+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QGQsL+Wl;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4TzeycO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=FRqk1MqC/yzJlxgPuMV3PD6f3n/YkpPn0d70/F6CIFA=; b=bSvMq2OCe866JzwqH7aUC3pz3q
	L0w7WwMkA7tzMq3jUyAwBfi4HCTeTufcs8JQrEO+ekQwOkutX0rlN1opByj0E2K5fIKA6by8s78p5
	rD8RrC5DKA9P0//SeZjjNncOHB8rAMNlAG6XTYkJqCZv5KqMjFKyobgjQNh64Aa030+s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMgym-0000000085l-2g5X;
	Fri, 30 Oct 2026 07:24:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xMgyb-0000000085A-3Q5s
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 07:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=; b=SWnRU5A+56kQCjn8faqy4tzxA2
 G8EX8+5LvqS3tRuX/bntfxX4B5FQDf4P63hNiIBwALv6dCNfVLddhOBAgoYBfCyX4tRgQbr+aoIDw
 jAB7Bo95Sh52CO01xtk8c5G8KVPBTvop5HI10PWT8Ipn2f6AEEe4pp0xq7pw8gK1WBO8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=; b=QGQsL+WlG6wmxxfkTtAiigKqbe
 7tulCZH1N//Pf8QRomhkAXzKbTlfi9hAjoHYtO4w8cPciueS1uo1/TfK4C+jZnM96FKjkTMMYCf00
 Ua82oBrxoQ9hrL7VB5+HooCb9+yaDpBKEnlg6/hgnFP7hyLtRE9+jmKG8BlooqslbMj0=;
Received: from mail-dl1-f45.google.com ([74.125.82.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMgyb-000000002U8-1Dvw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 07:24:37 +0000
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso498192c88.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345072; x=1793949872; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=;
 b=p4TzeycOsdQXt+8OMnSP6tqm2a9Hb3qDMg2txuyYh+Ft3xPFJYDLKFmmXBigGRKRNL
 oLZ9+BFXrjUoWCxYR8GvQ9+x6cp+fJjwkbaf7Cna+r7Z6kUlkaGtKMkI9+/HU8Dhlafj
 /d6xzD6oArJXJKKdC/WKYlkOFWeNYEHjFycahnRsnSmVweMF3qS4+fqMgYEP9dwTTWxt
 EXx6JZvMP1HQYNSt9F4mMsPUd7a5l4P0gUsXk+FpHmPeyhNCkXNkmijRdEVE+gH4r8wW
 Ytu/iXQQOkARo18/GfW+pDjB474Wwkty/6VQlMAQNpc5fEGUKXmepVt8rdLVVb30MBRC
 hCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345072; x=1793949872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=;
 b=tJGAP7Sybbe9tccu6U+Ir9rjW+s/CMgZcV8UfUXz2aRpQ0U0x+JoQsssDVU5g/CKIk
 p61vB3TSN9bu494bqCfd36H1M2JteiQMXjiUVyrVo/3NSC/mxbkS4vhkBvOXBqfQvcUu
 ziHLLQq1zaaqDKWdO8D3ieq3zQ7331i1XpD847MFJa2NIP+PrqXRgkQ3s7ow7M9Pv6k/
 mE9rOmTpwXGAVUzvncqrBXqHH3rPDMIfMPt/ZkpxoF+SK0LQ0TZOQyQ65ZiHVBEXHOdO
 NVB37Q/Lp1GWBg3Xs/CVzS5GZ8DYi+THlhSjayOLueEXsoJzG7yP7gdfAoEOheJqkrIS
 e4sA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz5f1pb+2H6yyfF3xdc9yYXMeKo63jFk+jkYNMxnx8eRgCXQnNLaaXNPl9uw/dEGZKnItm+A0YroC03ZJYONnP@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKZ3m1c3jAVKgxhIviOPREy3YR7ydU9x/z4lNw0nFdvDqQttDR0
 E0K8sA7/7ZPXT7uuTqJrFxNL5ax1OlnjsS24dpuRdSC8YopduStCuF7e
X-Gm-Gg: AYBFou2pIOdg5flGKUugEUzhSqta2a27/l0tL9fFMdOCFJCB8F9l2Qj0zISOTKcL1VG
 67tCDWPwt4eHIVUGQZEgA9t0Alrwoh2GtHEdXhOFTNP08mo3TxZrFF3UZSBK8ImdIkpVESY72KN
 kkXhgQ4qYSDsIDeQRam9YA519lSSiOzYC+PtEjJsTOPDclUO/hWyf5Hgq98zdLXhAfhc6uwcijB
 wg/ZmHdE4stDaZD8PssKtLYHJJVqhQrZRvkwVWzUksWakddIYaLm76dIYHOJxKiEztUE/KDX7/o
 8DQKsGE8QfKnp8ZO92CfuIJCSWsYlPacAH77cXQNKWgA3iiWsNwKrP2gmiqMFlw0KFvraEtnbol
 CbR6lA3RVFXG826AOwEWlQNMv+VlnJuwSiuPT5qPQ6ybU09i4lrsidfE2RCdZvBCNXDpUeJ19uO
 2OepJeFMj6ry6w6XYgDBDpMgbAjkUgLuEah70AjTJJXvqg3FtEMVMXuDlcEFLn7QqfGMPNgmOGx
 wj9SPGb6CKHIIEGzrsEOT7rk3ujQfgCdvw5NJvhgxCTigZ6KFW702HnK7Yatkw6KOTgRtkjDLyb
 sptid60z3tLayFlNZBi0/K6T4Xd1A/iInMdY5ZrF6N8VKg==
X-Received: by 2002:a05:7022:628a:b0:14d:c7ae:85dd with SMTP id
 a92af1059eb24-1ac5bbb917cmr2714313c88.7.1793345071565; 
 Fri, 30 Oct 2026 00:24:31 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac18458e07sm4462883c88.8.2026.10.30.00.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:24:31 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 30 Oct 2026 15:24:23 +0800
Message-ID: <20261030072423.197883-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xMgyb-000000002U8-1Dvw
Subject: [f2fs-dev] [PATCH 2/2] f2fs: free the quota file name that remount
 drops
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Remounting with an empty journalled quota option such as "usrjquota="
clears the name, but f2fs_apply_quota_options() overwrites the old
string without freeing it, so every such remount leaks it.

Free it after a grace period, as f2fs_show_options() may still be
reading it.

Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in QEMU with KASAN and kmemleak, remounting with "usrjquota="
and "usrjquota=f2fs" in a loop while reading /proc/mounts: nothing is
reported.  A plain kfree() here trips KASAN in f2fs_show_options().

 fs/f2fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 510df7998c18..d86ab25fbcc5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
 	struct f2fs_fs_context *ctx = fc->fs_private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
-	char *qname;
+	char *qname, *old;
 	int i;
 
 	if (quota_feature)
@@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
 					GFP_KERNEL | __GFP_NOFAIL);
 			set_opt(sbi, QUOTA);
 		}
-		F2FS_OPTION(sbi).s_qf_names[i] = qname;
+		old = F2FS_OPTION(sbi).s_qf_names[i];
+		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
+		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
+		kfree_rcu_mightsleep(old);
 	}
 
 	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
