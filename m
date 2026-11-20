Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEC606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fu0HmONY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kj/NHpyb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AqMQALbN;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=puf6OKcG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=puvdT752zPMc4ixIjKGboyZ2gveCWnH6Bem+F99d/Wg=; b=Fu0HmONYTNXGW4gQOvdrxhuDU8
	XGiqoZa+A0uc4FCWt+c8SL3iuJ411xgFjmOPcRsX/C63fceLK+V7fcviR++zPrwbfjNtIZqhxmLQI
	v12YZT4YS3kZ/ObbiGr/rg2irLxjtbieE+gSxtOCszk/U9DEyNtIDXlLujzXAFEzfPag=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUL8f-000000008Ro-0z7m;
	Fri, 20 Nov 2026 09:42:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xUL8e-000000008Ri-06op
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 09:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HYiPFmYp7+iZyLswjz6osZNQEu8q8a9IUu1zdV4DVbg=; b=kj/NHpybuy8PVt3luIl6WcBMac
 kavEYdXgvbJ839OlLK+tYZfCwI19Kye8ShLkb9IQDR48OlAGEoRC57ukgaGbzZyHBMC1pu7avS4I5
 bzSkNtGbAkeuPyXKWka2YyipOFg1P8BwKwmOzQCmBe3+kyPUrFwBlkXfepziz4rdZEX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HYiPFmYp7+iZyLswjz6osZNQEu8q8a9IUu1zdV4DVbg=; b=AqMQALbNZGMJxGBvbzkr0xnERL
 /GQzEUukOZmJl0mjwM+Dm4yimDrQnER6xzczeWPDGUWImsI5/RlwycVap886ZbbBuTHtZ81FULeu8
 O1tUlfl8Bmyh8Ze4/DRnz/v0Ij3NQ4OXkpI2bHx/bWqmRfxLfREOto8hglJsfh0q+FXM=;
Received: from mail-oo2-f6.google.com ([74.125.231.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUL8c-000000003x3-2tGv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 09:42:35 +0000
Received: by mail-oo2-f6.google.com with SMTP id
 46e09a7af769-862990b7bbbso259258a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 01:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795167749; cv=none;
 d=google.com; s=arc-20260327;
 b=Ckqc0WrBs0Imu2aSjyNow9DCNvTsWQW+2zJ6AteuMYe20LttnKa5eiDweiG+nKkQ+5
 2BV3qljH40+DByDXnurBHGtq9p8r4iQYWntJiXqVr6ZcXESlsI2A5S6IP2kL1h1tsfa/
 msWvl0Qjbx/euZwTFQvpHpYv9yqgCTMcorrXLz1gSn6Cs7BhXI6NHJTKhbAemuv1b2k8
 JEYVCtGVq1f4W6mooHOOJJj5Gpax4JZINLd1foW8O5xGGRniBZomDmLl8+Uoj9diHdj9
 95boPHny3vI6SfXcwqeDWFhD9zSgJQ4487vu1Yw840/DPRm2ANX5j5racWKWqnsFZos5
 FdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HYiPFmYp7+iZyLswjz6osZNQEu8q8a9IUu1zdV4DVbg=;
 fh=hxTetJC8tC8mZFsOM9Bsj8Tc01qXwJ7C9QKKgFFfI8k=;
 b=l+fqOI4qaFyq9nSitE6VUhRxGsl2VuvCzX3+l6cpLliR+Q+z29XCvXauY3UkBsCN7d
 6jbIql837LkKhF8kcQzk2RwwLI1oX7E+fzetTf3gehna/dYoxU1SC+d0PrY9vOoecsaJ
 hMncwuMwnZ6FUwHNKpat/WsjU/3xmQ4Irz2Q1xgZuir9XnUzHWoZ9woqwk3AONlDXZfT
 xAf5zh1yCS/QWD1Tqfe8AbgpUcMuE6lmIOCjpIejQVpDpZwSexW2DYg8ezqbconJ4TQC
 AAL/pNXcYMkQrnWcfOkuuTX8mqFrz6qh1FhK+/OMN7uL4a3044AkyW9F/e4f+t/S95LW
 N8aA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795167749; x=1795772549; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HYiPFmYp7+iZyLswjz6osZNQEu8q8a9IUu1zdV4DVbg=;
 b=puf6OKcGkY2jX4e9FJdOmqG4fDU2r4mn4jbRIFZfy2xUJnpgwQNleRAHNVvju56wWL
 J2j+fBgZ1FU/edaSEfWX/tZ4MfKodRmiy+d5JWAoSYou8STOpNPAGCrocPJAMjN6W49L
 NYxLX35hmYtAeUrSdcl+6Xh99VRic3M+ftJdHrfyq7+BI7sE8AOnA1pFoCa1Dn+2SeT7
 3KtPrELgn7PmprnDejb1QLtJ7ElFt9J90rdKNOqcl6SPumH2VQX7+NvyaydqXX31d/5A
 iyTBpirSRcA/lfhafpQjF4HdMvYd8eAvG/QRpsKzW9UGCKncwf3b+BFz8hwHHgQOqiYr
 3V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795167749; x=1795772549;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HYiPFmYp7+iZyLswjz6osZNQEu8q8a9IUu1zdV4DVbg=;
 b=QvgRgpajJImIUQ/2HYotOkcv/1w4gXUQoDX8mNGVWBXi07D4XRXq38Pgp/xgBdB8ZG
 OZSLFqHTjtrPLEXS2jEcfcXgUTbIPF+N74WqyUJshWTMIULndK2znhllY64KIh+TnBfh
 jgAa49LMr5nXnDKItrtt1qlx938zWt1vxD4zw+8WU+aV0RhHPWd0tieIlx+pQApwMwlE
 lyl810uixw2CSFA3982r5SKMQ62oqODYzGPTyVQ2ZppURGUfrY365ZT652PC2H4mUZvl
 0LqS2xAM/8nbY66C1aNuR4vYAa62KLIkOXJvO+rXFBeTzejjYGUHWdMCetN6iRTA+RGA
 zJUw==
X-Forwarded-Encrypted: i=1;
 AL+hErHDZ367+r/mqxlHFuldMm16Nme1fsto95P84uHzIid1dGpV/t3jvoh33IyRUCmF5/nBoi8Egy67rOETfO559u6h@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+8gURK147l5J6Zbkt5QDeCYJG6f+5aXpeenDIyVw38mA3KyecT
 t1dqESu7QAsej4/PAFWypzvkLYXTtPzChRXXoo1F3eviIOBYTrfqwxMYQ3kenP/qd6ytMssru2L
 lIyEZo/snTfOjCeEFc6qonTSzrf+oM7Q=
X-Gm-Gg: AYBFou3ZRg8qmvpEMjgMB3XkONuzWmbmJ76y+SGn0xWnyGAlE2o1+HwKDVo6cWoc0aA
 l0zJyTeqNrIuRfWwMzyKTi/xQZ/OaP80TZ8KzyLKXqU8KsEin/pDLDpR8AqvRVkveGdc+T8HzFD
 vPoNvTXymjY1TOjWv6URCNRnvcB8yGcd1ukbnuvy4SBuBTCVVgt9Sqp6V4kONpYIZLmrTpQiepn
 lzfGpdOYd4HL0ga1uVZm+Kqnwo3rxKyJtQUfg118RXE9r7dgT7YfTp6UaxQ5DY0is+oShQkPiIg
 diCoVMbuBpIa5VF/sS1UzVotrc+kywZZIonDsal10mUXZq2zExr2mkOon7Oxs50keoNSVfkP9HW
 6kOTMWv3h6wWdtp6d2VS6SyK8PnqFCJ145nAJXVCzjoJ1R+l87O6AbOoqVkLu2rU3KGCNlg5r2I
 FeGduu3U93Rxen7/3bGaZfCVtQnH+eOjZHd+MLpDbwSFQ+48Gi9LnF
X-Received: by 2002:a05:6808:23c2:b0:571:c073:748e with SMTP id
 5614622812f47-57a056c8709mr3278883b6e.3.1795167748870; Fri, 20 Nov 2026
 01:42:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108075357.43331-1-dennylin0707@gmail.com>
 <64dfd4fe-46eb-45b5-9eb1-ab0564bc2d47@kernel.org>
In-Reply-To: <64dfd4fe-46eb-45b5-9eb1-ab0564bc2d47@kernel.org>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 20 Nov 2026 01:42:16 -0800
X-Gm-Features: Aa3M54pavuzVtQLnDUZtRz03vVYkTYh6vhGn95UQJXSbIJgWZPsvg1RiTYB2wBY
Message-ID: <CAGEkeHfeO-_2MS-v_Mn28Dn7vmLfLzKjx0yTnFGvnWC8F5C9xg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xUL8c-000000003x3-2tGv
Subject: Re: [f2fs-dev] [PATCH] f2fs: require CAP_SYS_ADMIN for fallocate on
 pinned files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 1:42 AM Chao Yu <chao@kernel.org> wrote:
> Or maybe we can call f2fs_secure_erase() on the blkaddr range after
> preallocation and before return from fallocate().

Thanks. If the erase runs after preallocation, could a concurrent read
see the old data before the erase finishes, since reads don't take the
inode lock? Or should the blocks be zeroed before they are allocated?
I can send a v2 either way.

Thanks,
Hungyu


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
