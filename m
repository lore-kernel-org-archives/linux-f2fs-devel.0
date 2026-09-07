Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41668C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C16Py769ExPvCDodjjel4reiEwh9DyvxpWF22QQ/cIU=; b=GNnws9XM2ov/B6MnwQ/6Ll8elJ
	iVFtgN7kdOFY7gORazQ/6H++8n4g6msEkZFKkjk+4b3MX3uaLlnrLWGXuhs3tRxhMSFhXLd/U1QRe
	SbsRKYJ6/nIMcQLddNMKPUr6TtR5lbg2108N4ohTiwsRZweVjCiHK++tIxw2828OahCc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3VhR-0000Qu-3C;
	Mon, 07 Sep 2026 09:31:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3VhP-0000Qm-C5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=arhJRzLGcFh7QxAKla9Gy2qjsP8Vk5xX1TysHcLnx40=; b=BMmKuHtJv6Mp+08Ouo+XDRTU+D
 z0BfcjN19E/VnBJ70nZn2p/PpcmPRKvbrrjrJUdwGDZXo3sj6azT0A9Ttlp8HDfLN/Un+WCvSWLaA
 vLPz+vBAC9JLOXF6ErKpb1mwmGhXB3Hbs2M5cw+ILnhB0syh0cPO0bCAaROHJ+k3rY6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=arhJRzLGcFh7QxAKla9Gy2qjsP8Vk5xX1TysHcLnx40=; b=g47z8AIj1G2ZMv1qWoMSMqt3RL
 n8Le59WIxDa91814OF4DMlhSQ8ea7DK6xm7mI50V7WFfOmcRgE+jliJxbtce+n9HLcNtNitM4mvOy
 rjXQvyagoqzv8525eCYjw5smikc7WiTkEEbqDTFdcoCOabPA1Fir9vD7VSsTgN2IE5bY=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3VhP-0004Fg-N7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:31:36 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-39b456fc4cbso1369568a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788773490; x=1789378290; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=arhJRzLGcFh7QxAKla9Gy2qjsP8Vk5xX1TysHcLnx40=;
 b=JlRo5WeL+34xT0XrFIYbsMZ13nwW/YirofouqswvyZkQgNXD+66QWFMw1XD3ePArWa
 hcSnnE1gdRzqTWPSON7yVFlN3QzifxiykXB56e+tRDE7mjFzBvtilcVV74xAy4uU+ODl
 MJDsDCsU0RiCqLhakQRHEETrLaTPsX7OF5OeAQg70jysj78kCnKFVg35tVdf3zYzdzVI
 whNHD+1kKGFbRu9WQCAXz9C+bic8wpkWELaLrhUvwKiDDejkJ+wz5R/gM4DCq6UBl0Ed
 nOwMv+YDxOd7QwvwtHskiGeray5d+VqfNzE+/lD2h4iR56ijA2xqdn0anb50PSMswYFq
 jwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788773490; x=1789378290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=arhJRzLGcFh7QxAKla9Gy2qjsP8Vk5xX1TysHcLnx40=;
 b=f+zVsKbdsxAZCsNSqfhdhcGdjWQ8etsz3pS2bUgtEO8N+/xGJBtB4nWLg5ZjzD2RIR
 wIlVEy9q5eFlAzazBK5dzBSndUi6u7Rk8xzrXHjk6WpirgVhfAvaXadMHiZOhmjJkBYL
 CkpTPqUEppktPtDH6ii2h/R+3YouIlG7FneL34WltCBu15S5WaYsBENS9X0Ex/ZPe2hJ
 6LpeevU+PpWROKhOQoBX+PO+ooSDbZT2QpNviNDJVyI3Oly6UX26OZCPuUfKuu1FeGxs
 eMEfKawtSYn7amtNuxpvUvKowfGF+325+g80rfTIpjuz5tAp8XeF49W4wTqXrXVJrLAS
 gfqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSUKhFxif61O/NkKTowLMETwmg8Ms1F8DMmAlpwLV0Qc4+B25Z6N71SMd+nUAkNaDjiMnRxV7utAERIXuo4Ecw@lists.sourceforge.net
X-Gm-Message-State: AFuF++mf+ot1VeV+hA0juVBICp6Nr0hIMkdqgWMzzeWPPUp3WV+HwWlE
 HyOCzNDGnvUxGrX6ctKeI14ERppP2tbCNY2igaENwOOe3H6OML5WAJhJ
X-Gm-Gg: AYBFou2XfDA1E9xOcuv0jKUszArW6xcTBgeJOIXYp3G5UHV6kqx4dtOxUZG77aWTq1O
 ujvp80KkVTGogZymI5Ak+VsW/AsPxTFFl9WQ2Z/La67xLbqSU7CbzVQSIDevWM8O1ZwQdOajrCd
 dVE00J+kk8erSu+Pm5q1VBXRE/Ebk48KkG17tq48f/fOgN2lWYstTgz3nPVUihvelMMCe2tPsh9
 b6volNUUdzZN6MWKtLjijsQ9W3TnAWerJ6zgzVibew6pRpOC+NmxD1vP4kSRVkLnLxlkjgzFTpc
 As8n3ZCMS/qezti04/T3673DMqjaouY0m+O/88dgx6VI5f+I8YChfSzxRP68J12T5cYPlsD96QT
 abJIE54jEasTMtj5xhuyYk8r5BxmBTF7gKoQSneBw1SdQBSqt7XiXdtSPeCM+grCT/LllLSEkGC
 WXs+O/EXnTwTQqohMlA1bpj141n1tNbM9bc7/JUNiQDaWKkS6UkLWxZwOsHQr6i1cLybFIhYKn7
 ctyJFXBk51BwyZjjDqBO6X5Ag==
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39b261b1bcfmr38517893a91.16.1788773489864; 
 Mon, 07 Sep 2026 02:31:29 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c397b1sm25503181a91.8.2026.09.07.02.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:31:29 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Mon,  7 Sep 2026 17:31:22 +0800
Message-ID: <20260907093123.2438228-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
References: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3VhP-0004Fg-N7
Subject: Re: [f2fs-dev] [PATCH 01/14] f2fs: extend folio state for large
 folio write path
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 27 Aug 2026 13:51:06 -0700, Daeho Jeong wrote:
> +		ffs->private_flags |= flags;
>
> Is this field protected by holding a lock properly?

Thanks for the review.
No, it doesn't. Thanks for pointing out.

I want to change this using per-field atomic read-modify-write ops
instead, to avoid taking state_lock, like below:

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
@@ f2fs_folio_get_private_flags()  (f2fs.h:2719)
 	if (f2fs_folio_has_ffs(folio)) {
 		struct f2fs_folio_state *ffs = folio->private;
 
-		return ffs->private_flags;
+		return READ_ONCE(ffs->private_flags);
 	}
@@ f2fs_folio_set_private_flags()  (f2fs.h:2730)
 	if (f2fs_folio_has_ffs(folio)) {
 		struct f2fs_folio_state *ffs = folio->private;
 
-		ffs->private_flags |= flags;
+		if (flags)
+			__atomic_or_fetch(&ffs->private_flags, flags,
+					  __ATOMIC_RELAXED);
 		return;
 	}
@@ f2fs_folio_clear_private_flags()  (f2fs.h:2746)
 	if (f2fs_folio_has_ffs(folio)) {
 		struct f2fs_folio_state *ffs = folio->private;
 
-		ffs->private_flags &= ~flags;
+		if (flags)
+			__atomic_and_fetch(&ffs->private_flags, ~flags,
+					   __ATOMIC_RELAXED);
 		return;
 	}

Please let me know if this lock-free approach looks acceptable.

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
