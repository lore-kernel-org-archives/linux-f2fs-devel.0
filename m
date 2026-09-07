Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D715C79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=deDqn28CCWrG488tA4R7YPE+WShatFum0n9I/rhOXNU=; b=Ltd1KycQ/pC9C4IgOhFVcwt813
	iGLS32uOL010vzo2QxJT67H8+IAiGNkBpQ/gErq1OsTnh8dErk3/gi05SzGeZ0OdMMcKZph+rP24F
	OSrl+tbpkOKxdvuy/ddg9KTKo+Q7BLPCEgLrjcWj46lwOBKAIzmANQbMzmDGCrpvTShQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3Xnc-0004Ja-VR;
	Mon, 07 Sep 2026 11:46:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3Xnb-0004JO-ON
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:46:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hSaXnB4SJwu6iwBOmgQqS2PyTjgCq6JqLDuo0OaEhp8=; b=gLZ5k5eIJUucVsMmMr+ajNmoIC
 nlj7kWlRzvfbo0I4iccc2DGDbONvL5CrUHLZwUB0D7/PlaytGQto1cs/ufdwP3q3Z198zR6cFvFws
 kKVvPJZb5RONv09vZ9um2fk893cHONBlLuY5MXTsjtGcEeH5xgTCN6wPJuOTclaHgtho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hSaXnB4SJwu6iwBOmgQqS2PyTjgCq6JqLDuo0OaEhp8=; b=AVUMrDSTeniq3kgiuXnat8ECi/
 l4FXqKLSLjZ2ynCPwfn4/YH+hCb79cahvEQs7pk3N7H8YHjJoZiHpryoyzMJKuBvjnjTBus+4mvaA
 PHeZnf4gY307Z4GkDiX7KblBSWfTQj/nXcMvas6bUNH5qdJoGBRH6gr1ru5xyvOZDhgk=;
Received: from mail-pj2-f2.google.com ([74.125.227.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3Xnc-0007Cn-6I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:46:08 +0000
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2db39df9c51so5251585ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788781562; x=1789386362; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSaXnB4SJwu6iwBOmgQqS2PyTjgCq6JqLDuo0OaEhp8=;
 b=YF96I1OmixyZIpsetFN5iWp8dX7Npf32du6VtbTB8h8+JL5ILglIsDn+RO+JfpZNxu
 e9qwlrJx1LkCsArr2oR5qebGNoFnFWECU74YbE8IAKOaaZHRnRg4z0q9jKSpvRFXt0nc
 HJvxy8GH+bFT/XEWV+/+Owgl/ZLQ6Y6dptNXK9xjRhIBHpNrRSTHFKePPUMIPOfgzLP5
 kwFB6/H6WLhyyBabG8tgdNn22vLNVwJhjbxER/XouZK0Gessr+PKELPvRpq3hI4HQaST
 oUbnOj6S2+5vPAquQLz30SgdL7Cy7s65uN6jxacZtpNTgYFvgBVjZLDJ69CeX9DneYjH
 tHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781562; x=1789386362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSaXnB4SJwu6iwBOmgQqS2PyTjgCq6JqLDuo0OaEhp8=;
 b=ddtF9tcAfhY39izcbefCzdHhSKImjv2FD9p1V8ie3gcpQD1s/EPt1SY3RwJuKPG+hH
 y5//kwqOjf4xk8QG9MpFalGMVlfBLS4+r5T5NVgR1xDz+NdOuo/AVjRdQ7UaByJlTJb3
 zjiwR1MqjMpwXVDIOPTlQx01nHWEmpe5+BVAL5SUI0jtatdpoBj9I6rMgn5hJuLN1/nD
 QQSrXfdiG0UF6omFYMyxTTkak0M/YbBO3WNRPVMPR/udFeR6uVisy+I5DHys45wb4k8Z
 Fyw0QBcCYmU7V0rb5ylFctp8ILxh1WMhu6UUR+//K9lg5LPRCZk66eWt+pIWI5FE2N3J
 T97A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx21ZhEF3AUmJP6tR7PsUTRHIqgNFno29pQbANVd2cECTy8xbB00c4Fv7rXxiufq1iAmssZ2DSux7Ogp7Fph5BX@lists.sourceforge.net
X-Gm-Message-State: AFuF++mN94/iNvoEgQTdRtq60EUQ+lyCR1gjYzlXCd1SQfA8iCg8ykFb
 DPQcxqFt2ertO/BsUoC5OqCoaJyte+vpBU9QVqY3eoCFnm94Vgrxgyq/
X-Gm-Gg: AYBFou3BGN4ynyIMXQJoAO1GAc8j7mFaqKF828B6HzOIjjPUM985bazEJJFyGoIgFWI
 PkzBeIJWhgQ/xfJ3VnZSCZSmiAX0zzsEhraGDrYgmCsgUUK0eGh437mb2sT4sLeO7bejV/MtVoP
 H7x2ld+IKGuH9rjMdXhCN1D7eG9uJ++NmaY+gmXFshrqFq4s92dNOAEMp1FMNI+40Kk+axZxw+F
 Keu4f3qG+y8QiNXqc+Hvkj+fHvdyo/xk4qpX19LhE5sVyV/sDl5eZmQHgf3kzyNOzTA7oHZtA4A
 3JEstI36kKwSte5w+mZfnD8q3FNgqqDVnRvBm9oNDMUQh/aKlAVQ25Bk3YsY1FmZS1uFaM4eVyQ
 xeTlsn6KhFtC8Xo4i+0+3g4+Ed9WcrdwcMYmrIkY4v1a7c4sdgSutthkPeiniJPHUcoVxQx8OdY
 rJy6KahBDhHKeZFtudeK9YcLFGGEbD9yvleKj6Em8etnPRYLyND22cyOxz9W1J1NnA3/NHoVL9p
 mJKCd9DkcdPZsZbTM//ah2GYQ==
X-Received: by 2002:a17:903:94e:b0:2db:4bae:1ece with SMTP id
 d9443c01a7336-2db4bae2044mr100806565ad.3.1788781562396; 
 Mon, 07 Sep 2026 04:46:02 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1483dbddsm44065975ad.12.2026.09.07.04.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:01 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Mon,  7 Sep 2026 19:45:53 +0800
Message-ID: <20260907114553.2551964-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_yO+CyS=xBDA1iRTfjZtm_40wLGwD6TZQLRN2nFmuw7xQ@mail.gmail.com>
References: <CACOAw_yO+CyS=xBDA1iRTfjZtm_40wLGwD6TZQLRN2nFmuw7xQ@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3Xnc-0007Cn-6I
Subject: Re: [f2fs-dev] [PATCH 07/14] f2fs: make GC migration large-folio
 aware
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

On Fri, 28 Aug 2026 10:20:40 -0700, Daeho Jeong wrote:
> Under Patch 08, a cleanly read large folio may NOT have
> f2fs_folio_state allocated
> (folio->private == NULL), right?
>
> When foreground/background GC tries to migrate a 4KB block in such a folio,
> `ffs` is NULL, and `atomic_inc(&ffs->write_pages_pending)` will instantly crash
> with a NULL pointer dereference!
>
> Fix: Call `ffs = f2fs_ffs_find_or_alloc(folio);` before accessing `ffs`.

In move_data_page(), the folio is obtained via
f2fs_get_read_data_folio() / f2fs_get_lock_data_folio(), where
f2fs_folio_state is allocated unconditionally for large folios. So
there shouldn't be a NULL pointer dereference here, right?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
