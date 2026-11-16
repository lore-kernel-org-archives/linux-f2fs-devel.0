Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E3606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RoEEPb+r;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CzklwdlL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fxrHdm4g;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NoXlbGnh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=iakDaoBm2gI7792chUj6v6SDB3uoL4Z7NqFJqwkaxC4=; b=RoEEPb+rVUWZwuSXc06RXkqcdo
	CFAD3cTmLqyOGFRX0vwWVA0pn2w72hDI2CHFbfA+rdHBy9EWIkKq6AGLaRcxFa+FI/s+1AO/dw9G7
	CmLgzDWGnO7uiR91dsiQYgTWl9j6rRPwUhKPfOVxZTtzyueUbqB0At2LOovwKwsyd0PI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSvjB-000000007In-1mwZ;
	Mon, 16 Nov 2026 12:22:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xSvit-000000007I9-1Vrg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pnukD5Gp8r3cGqp/DzD0BlhAA3pMyd935F8TwUbU19M=; b=CzklwdlLDCZZgzdwRv5vFJG0Ar
 JnWVSwWZgU3UDDdKUdWWWObZoT26ssAyPRqd6WSGi/56XnZ3kumql7dkQPVeqhBAWarqfwguTkMS0
 yiBfcCuXcJ0feiTVBVUOvGRy4yr0ss9zpo9XE19yen/vG2eXXPGuPbiIi09eveknHJLM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pnukD5Gp8r3cGqp/DzD0BlhAA3pMyd935F8TwUbU19M=; b=fxrHdm4gp0PxiPt6um4R85bEl6
 Va7L0e2LCW0/nGlOXu60JA5nTKfGiqSNjHCx4E6TU7Pl0n1vwM3+IoZNafaCP4UsQE62VyAv1pC/j
 MnyU6d6n8aG3eMpumCNz4z4ACoN/Dh0ikfHypfmbjmTK6FUQ3VVKWwsqhe2mKJaRZstQ=;
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvif-000000005lf-3mM8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:21:58 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3b0a519049aso3516356a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831712; x=1795436512; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnukD5Gp8r3cGqp/DzD0BlhAA3pMyd935F8TwUbU19M=;
 b=NoXlbGnh7Zunrs4GVvezBPoyrD3Saft2SDXXgbBj9qA9rvsOOkdCfcww3zLUhhSUKa
 yXD8sb1YaVY0kVHR/SA9oZtpUc6Xx6SCCyvuj7KN1BI6/zDVsPA4phOacQNWinubwS+U
 m/QW0Gw6XRKVO1OkZLEa3xzxxdyLSjxtmn6Ph5FDXnyG6MtFPw6pBRc9HS1aOOVzYijy
 im3gGCbebCPu0DMejm+EpEfgBx05Fit0KTtHBCvt4WM2dgB7c5I7nL9Sv6C4e0h4VPBB
 t1cCVBw4yIof7F2dQOe1lr7TGwdndjnzTT6H0cu+hZQ83gRcWPMn2tL0l7txuN+GjNLg
 Sdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831712; x=1795436512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pnukD5Gp8r3cGqp/DzD0BlhAA3pMyd935F8TwUbU19M=;
 b=B3XXeHdeSU0UYPhgvjVcnQI2PC3iI82Uh+vTTbitiNegltEaEraaupqSgG+GUQyDqw
 s858Z4eVFyM/VsikuxUURscYSN6xAjTaQo1LNuAOrJHpAw8lMP8VpKPcoF0SSfvQIBUj
 YO0WF0yQCAVWgYHjPgFF+7Qwc630wl4+C1ZyYH98jeEq9N3H8n02YHLL5UuYYfsQYr8t
 owBatalWAAdlQvncNuwekgdR7YoGvB2ir3BQlgiy+pwmWkgdsNsmUXPbVaDI8PWVpEhM
 iwx4bsbzNYmgIeGDV3BgmYpOUlYvrT5Mi01ZniJEXfFSzmh2FH2pOdNGnOrrXuuOwfqF
 UqSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHlLe7EsSuM74lxwHSXZkpFva5RaQhauZp1oMYSrp7TuQr5GVdIl5sdlQA+T32ipRkPBDxqahKRxHCcChSR+ZDT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8w/Dkfx/7tJQjRKJvhCk2hxooQ9qZerTiI4gkK+4HYQ1OO6hZG
 2JZIHSTZGBKSgcdImzEM+s8uaZb4RYUTTVECWb2y+naYDhveW19gexJ2HKY6wZlE
X-Gm-Gg: AZFdTZcHOKp/EBe//QH7U9yQxHyZqvuSviLf7SfZKc4RNYifhM79VcVqPCPSMvPUbFI
 TncByO2hdM9zeEbC9gqyYP1oS/fKBVn8r4iOPUP/VZilZ0SrOaihRU/7bbHtkptoBOa6Y83MEGH
 SwOwZqJEXTtE7Ma7Lva7VrWSh6EnQMlt01ra/f86n8g3SDj/JFIdZdxATOPNUIG6nsaWmkn5Tji
 LTVLMw3kB90S8FObPzHwQd/RbBl0xLAFAuESn6Ln5MixDY4jvX/6Ir5NLqKzgKb9wTZnVSFBjZw
 3DkXEJxbRLFqP7DtJK59WcMBw8jeFvkfcW7dugUQBWvSgcFQqw6jIBCV/O/M42LyLmmoxA2vxMF
 vKtql41mn/M1HA27qx/N6sru9PYeT0qKhP5VZqePV3CjhvT6hBTPMKoGF5vG6Qmht/gT9eByxo1
 sNGp2ktiKtSfuKi6s7H5ZzgOAQjbUyqp/NnlZj9RqwsNVJjSD1gTf1idH6AqnplFf7p2C99XbdB
 KVVEJOHw21nglc0qIMHwe1rToNsyYTX+VUAIQFBrZjWm7pCLsacZBcIGZD1NSTTCSqZDmyEeY2u
 XEk/7yRE+G95ghuFIwTtTN4Xf1y5DgjwvAE48qtAgg4qljhQbTbBifKo3NhinteJKg8=
X-Received: by 2002:a17:90b:5105:b0:3b0:d0c5:c10e with SMTP id
 98e67ed59e1d1-3b1b0b546f7mr10545284a91.17.1794831712180; 
 Mon, 16 Nov 2026 04:21:52 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aed76745sm17820907a91.16.2026.11.16.04.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:21:51 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 16 Nov 2026 20:21:46 +0800
Message-ID: <20261116122146.2616475-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103030712.1514800-1-zhanxusheng1024@gmail.com>
References: <20261103030712.1514800-1-zhanxusheng1024@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xSvif-000000005lf-3mM8
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: fold casefolded names of
 F2FS_NAME_LEN bytes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: zhanxusheng@xiaomi.com, andrealmeid@igalia.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jaegeuk, Chao,

Gentle ping.  The open question is the hash change: a new entry for
such a name is hashed by its folded form, so a kernel without this
patch cannot find it ("back on the current kernel" above).  Is that
acceptable?

Thanks,
Zhan Xusheng


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
