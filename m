Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BDECF6BFF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CR/as5bdKkdV6KaLZ6RfOkzgeVAU4unzIht3ihuBYwg=; b=eOKTCqz0SO/e0B6unF40QCFEOH
	/mFnVtvqv5U+HwOQIL7aOOi/T8u76LU1aWew0dOIIN4XHhtVVh1kDGPJ/Yly9fm2ygi8YkoZ8hQks
	E4zOTfvObotjWBjYQcEayo7jc5Cx+oh1tHDLkoDrTJbhEuQt9eQBvJF5VbzbcsggowM4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdOfJ-00081p-Q8;
	Wed, 07 Jan 2026 08:13:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <joannechien@google.com>) id 1vdOfJ-00081j-1z
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 08:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=; b=Pkk5qrWfsIxbfq8ZDaghzlbX5Y
 PcTJn8NW6sZzsB68bxCimvNVmlbqdalGYpD8dp0gNUfj9DUaKWuiFPY46bJGNq0rR43y6ADIJSIf4
 ef/FnZwHXVwUUKA0nAdNs2m0qgy66Xujf/X9VkPTpPTgJNJYi1Kb3x6nL4k9yxCql40k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=; b=mW7gffTY4nVd+jdKnRjIhlBtNy
 mj8NFO1ZVC+9FrkoEEH34RG514sAea1VsPnRKZt2X7KdF0TMG4/BD3FmMK4m7YIpna+7brBa9itvl
 MPbDGt6ivBloHictjWbqREq8TfGlHCtZJvb/nBJHx7OwO6VbBuq8UyBgYW+n2Elpobfg=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vdOfI-0008EE-NI for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 08:13:12 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64b66d427e9so4481a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 07 Jan 2026 00:13:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767773581; cv=none;
 d=google.com; s=arc-20240605;
 b=HYND0HPrrAsumosjxd+lk5CRWDzKnr5dm73BohEOLcqycnE71WFWTLCcjiTHl07cz8
 cJruz8I1/ZioprpnR5OeeHHyYSeo4Izbe2wjIpQZp3xyriXaTsskGugntRpdgbKWFbqT
 KmH4pY3iqxvuSmaF7OWp8OuXsRm9pfYRDGdIKEoDzP2k8WUMkKCIRUmb7elgGJg6OehD
 1u0sdwubbc7Ox9ggmErLMMLqeYyQ1+6s4g6FyZNGsEuqWp66Bzuwdxg7EmkbA4E72xO9
 29tFl01PIzNNPxgJm0QDximRzK0uL8v2j3hzDAH/HdzCZXiyNMwZ16VYaXrACJRnj8zp
 bVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=;
 fh=HizxzpdcdQOUJkbtzSUo2mf9RGW0jNZwnmCWV1vAZHw=;
 b=f3YFNHRp91dtoZIuoMIX+4sEBvgN8rMdVUSqqHs/s0Z5LiGsNCkEIxPDM9Gp120lhf
 Akos7FJ3KMfLT4RR3G0w6V2iZAwxvZazHqhu7bst4DguRWnlxIxoy1f4Q7xENwWv2rpp
 PDAol22vCaJ1220V0j1XE4OTRLcv4K8xKmNdU6CHoozvtmc8jyYM1ryPVHSeTscedquI
 98of0ZzINC7ifWqmsFXwW9onlnFBZVKLzIylY5UDuefv5DLLzMW/j8OhgNyUdBahiPRt
 Hae/tOM83Gw7/f+ocfU3wMbgqcHYzXxFOXDEE9XG97YDI+BJklJjBsqApPvsAYY9REXu
 Sz3A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767773581; x=1768378381;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=;
 b=N4J8eSHHFW3xXSxUHjlE5qZ2Lx1VU4hPOODEb52AbQGDJ/46hmJKxNdoOjzJPWEtpK
 5nJtq6sL0g/bVkkeuR9jpS+Q6Bd9LzkPf3KLl7p/6nIoVsPhJFDKaxIehrfFU6tIF79A
 Ozk5waYpHZP8DCtxZtKgl6vNOunUf6t5T0bJps0OiKdoFjopLfSO6YInkK65quRDxkjF
 HUg9BJ8Yb1CYc0x4uulE1G719ODj/pRCGvAlj55Ac1tFqu/GSeHdRshzbToUj8EYlagm
 Tg3OCaYHZiHNhpsHGA3Gt+HoQ2zAHtJc+QguvAJavmeC1FCrz96vo8J+eZwqRbFc5+MV
 rzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767773581; x=1768378381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=;
 b=d4K1PIoGbnBAuq0Ldxg6vP24GsDkfyup6am6sM8wR5/nvUK/okwrnRD5T6NgwDfelQ
 2z350CtNBtObtoUf/yHS4m3IMa0XR2zazrdWiWB1Gyw0g7SpqnX4c7C5x3PubZlbhzow
 4EDbuaDS4Z6Xi/w6sg1F4D5dwDPPuzq18ZNh0hLBq96WT2849WD9GCjyHqYTyjv1tpUx
 s8x+JyR7WCXoaHUCZsgyZXDt55X8awFOOIYooGy81HSxEOYAjF1NApovXAk6pevF29Yf
 bywwPusln1md/k6xvCee3Pe6AZN+1skNtWyQJicC2Xsf6GBgIamwFNpIqTmAIVcZIQfo
 Qitw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmMqc3vsVXG5XfO/mvLlQP71lX51GaNuyINkBgMMXuB+Ml1RF20MsFARs1Vdy3Jyq53jQ3IqCsn1wzMFF9nD26@lists.sourceforge.net
X-Gm-Message-State: AOJu0YysmHf2dhz6MQPGtkuo5phJ+dNga5kEK6lL2GTuddm+YvyGtVl0
 NmoCF2RmuHP5qhpqeX489oBJ/AB0yDxs5ZyFwkdrAgAPE9DPlDFBZMN1WJdKJgHEP5I4wMUrnGK
 gmLVq8kNtDMsEIeWS0wApgZ6q/9RyOUapuFkjgRHL
X-Gm-Gg: AY/fxX44TjmTIyP8Xvt2OAlJFbekiV0vUj8L1FRUfBLmr5Z6lGc4zdi0TLwKJDZqToV
 IaaaU93BAghraU9rUnyckGZGeY2/E13nKjVFAOZZYM3O2A3kP5K4TKh6UVJ0l9s8DJ9t17bLJzG
 QKBe6NsdFSpuh2SMLqkXmmwSdwCkltU1OBgOKh9Gzhs4wYoPOJlI3yxBokEctRDbEodqxnfalwz
 dYRWwDt04gSWIxWqXnnBzU+wgSTkYNRVPAR1V0j4SFfva5d4ctA2+d4t5CSZgOfmpt0QkB3yQZj
 WDFvt/qs+kc+tIlbaqwUh+JF6A==
X-Google-Smtp-Source: AGHT+IHpxxOKv4iSlqA1lieNBkvOv14hAOgXKfYnTG8DCgWnhfFB10pXU+bh4zfUI3iwjJ6zlvmC9mnz+/z5qjsb5/A=
X-Received: by 2002:aa7:d501:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-65097c38f5bmr20502a12.7.1767773580954; Wed, 07 Jan 2026
 00:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20251229023145.1806877-1-joannechien@google.com>
 <aV34aGUeU0pQkwj2@infradead.org>
In-Reply-To: <aV34aGUeU0pQkwj2@infradead.org>
Date: Wed, 7 Jan 2026 16:12:44 +0800
X-Gm-Features: AQt7F2rZ_GgTF8O1iiCWfD-1Mi_3j_bm97c1HStlDJJG0l0OHLHskCcjugup32s
Message-ID: <CACQK4XCF-Hex_H31evMu8Zpv_OLtV0QBU0MpajOSHcfaREMAKw@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1vdOfI-0008EE-NI
Subject: Re: [f2fs-dev] [PATCH v2] common/rc: add _require_blocks_in_file
 helper
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
From: Joanne Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Joanne Chang <joannechien@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBKYW4gNywgMjAyNiBhdCAyOjA44oCvUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiBJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgd2h5IHdlIGNh
bid0IGRvIHRoaXMgcHJvZ3JhbW1hdGljYWxseS4gIEkgZ3Vlc3MKPiBpdCB3b3VsZCBiZSBzaW1w
bHkgdG9vIHNsb3c/ICBJbiB0aGF0IGNhc2UgdGhhdCBzaG91bGQgcHJvYmFibHkgYmUKPiBkb2N1
bWVudGVkIGhlcmUgaW4gdGhlIGNvbW1pdCBsb2cuICBPdGhlcndpc2UgdGhpcyBsb29rcyBnb29k
IHRvIG1lLgoKSSB1c2VkIGEgY29uc3RhbnQgdG8gYXZvaWQgbWFza2luZyBidWdzIHRoYXQgY2F1
c2UgdGhlIG1heGltdW0gZmlsZSBzaXplCnRvIHNocmluayBvbiBmaWxlc3lzdGVtcyB0aGF0IHNo
b3VsZCBzdXBwb3J0IHRoaXMgdGVzdC4gSSBjYW4gYWRkIHRoZQpyZWFzb24gdG8gdGhlIGNvbW1p
dCBtZXNzYWdlIGlmIHRoYXQgd291bGQgbWFrZSBpdCBjbGVhcmVyLgoKQmVzdCByZWdhcmRzLApK
b2FubmUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
