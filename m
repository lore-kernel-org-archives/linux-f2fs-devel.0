Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00000CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yzaUHt1NQSnacWlHWmYBOUoATgnDtkO5FGoOZ9uwk1s=; b=cLIivzrt7H4b+BMgaEdmpGWoPt
	+Ai5WpP4vwBSuR32jCcvQFyouW6Qt56P2i1MAMFF0xyseLqrWI4fG/N2keWTrtpfb7IQrzemLSFZr
	YX6pX7of56FA0PBEjtzWzMcefjchWwo4exZIGOB7rMVlioOcuzsxLGmp7hFoxRWMka/8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLdg0-0007FR-D3;
	Sat, 09 May 2026 09:08:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1wLdfy-0007FJ-TZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 09:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n/WDY4Y2OT4QgMsrPidU0JdpeCI6zSS8TCN0XFs+3IE=; b=Mjhx/GbYWoyuuFxGwctOTaefgc
 QPIEZt9HyEp6kSCdCEkr1/2XQidip220yBz7uj+078qm8m/GtUUIFNLVGuSkwGntu5J5bfFX9cOXq
 A5vpeBfWX23jZB1jXzJTWUXgG9f6W4+SrnvoNgV7iuGusRuvpCEQmCJK47/Zlw2Olgbo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n/WDY4Y2OT4QgMsrPidU0JdpeCI6zSS8TCN0XFs+3IE=; b=ci0iuvjKnXlnTJyQ614RFw9yGE
 La/zcgp17RoacQeisG7sOIqsVR3meAZ11HdvbYSWa0rHkv5DpbmwBAPiAZZY4iKtwSZgJO5Yri9E0
 8WNw1Zu8OlAs3IUbwkKxpu4hRJPCgIu0uDzEQqJSK17i2ciZL6tl661gqoK1RQLqgPYA=;
Received: from mail-yw1-f179.google.com ([209.85.128.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wLdfz-0008Gj-4Q for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 09:08:47 +0000
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7bf0b47d2f1so25055087b3.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 09 May 2026 02:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778317716; cv=none;
 d=google.com; s=arc-20240605;
 b=VtviLLIBlTPKmjrkpSdMNFFuMQaYbJhxCARCzALmEEqBQmevi6I3gjsRRDBGYBglLy
 IOyCCXPb5MtGf8oa4BZwbWjAj6bpO/ryhzBgZPXPhbBA+s/8S58V7gkRuh9EuexitLT8
 yACvdi5cnFvmSwPE3gvPZlxz5UBP/eC8BfhTllWQO2o4sL4Ky3XuvrwPrEkh9x3EVHpP
 xz1b+Aj6TuoWypU/1RU/uPAOEhJqlxIfiXa5itVlhGYKDL05HKfsYpA5H0axxOwBjvfm
 hQ3enqe1OsEyrc7CYwaKhCZCas43Tgg6nwTvsDPNpqI/9uolVop6jReObd1Jd4Vc1Bgc
 xOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n/WDY4Y2OT4QgMsrPidU0JdpeCI6zSS8TCN0XFs+3IE=;
 fh=+/pCguBlqbSQUUaaCQmXEHPaWZq5Ye8IVAJTKADCoKU=;
 b=UIYxezwcB+1oRwBFD59wjz3AaBmtqJ7VV2JunlfGOY3zbOFS/SmdFpR/FPYWTeNxj+
 hg1MsTMrBUg9YSVqiXWntWQnAvOAHWqUiAubvInoL4wRSl9AwzLxxkCuLOm2ZPRlphdl
 5Tt42vQ+rQuv0/337KNnMtR1gBpFtnou1ELxg5TnuILXbx0t6TESAH4p5Ge14Q1TXa4r
 yMPErP9anefsYPCvhkhrbl2lMXv7SvXpDNQYoqaRDg8SqFjoSw7iHhT9bz1TH73rROB2
 wOw1Ogyf5xRrXGm3rFzwmEs8b6tCjRlPGy1gJlh4G+pzQEgTZoaoY3ppAjdMJVR/JJ1q
 LDZQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778317716; x=1778922516; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/WDY4Y2OT4QgMsrPidU0JdpeCI6zSS8TCN0XFs+3IE=;
 b=pajrrQ8AKXx31t4YKS5sdqWhOvlNW1zGsxZNwiy2VlOa3OAwdFYGt9Zt8MLCOVIYLV
 sdlfGRTUewW+/YRtC3vWyVGs/tQnjefbQkYgw/ebsv/yIwUY+zHGkkuDWQYpld6+IBbo
 ess5+LrBdm1E6ygtT6BcSFqK3NDJEXura6jC5Zvnsnky4vPDzvhpdQbgeL/bykbkHjoL
 GEWlDEwTavPh9NlqZqTf4CWujMnHVMlha3r2ajWS+xMNSvC6OMuKzSmbVRDbfLFyXmpX
 upsW4wnAZt3GxcQv46F3M6j0CQ8zSqni682ZlwttxZucraM/f5el0AjapurfQ436OkTZ
 2l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778317716; x=1778922516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n/WDY4Y2OT4QgMsrPidU0JdpeCI6zSS8TCN0XFs+3IE=;
 b=FS2bppRyKodTx/zPqsLQI7s5jNB1Hi9HNul1/uX2wgVMA54OsgSa1gk90Oa/cY78gu
 eVDbzFewofVkILm0Y9dLKBDDraXj4nPBvmVF274OI1UT9TdbCFQnwo/KY7bKRxYSC6IH
 V/ekHzsj0pon3Z7y1WgrILbOpAdom1hEycTMk8ZtDt4VbVwROiXif4Df1cNWAajJONXo
 ZUzfnTKMfJVTcaiI+Cdllg7nxMuNC93I+//VfsVN1BpC9oBd8hosLwl4xSpUBCF2KgXA
 J1ecaK6GY6LClJcAVUNcX+1Up8LhvTgZYqZlC7tpU1OVmcFnlWJM2J8kmXbn1Z3wbxP/
 JvXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zqq2gsDUNWnDLuCuSWEpom8KzUvZxV27tcz/7h7fyv1KaduHDdS0Bpfs4cEZyISSYBLWg5QkCJ+BGyMsm4bjG@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyzIawXaASipQcVoAs9F13/mPOwJVv8WcEtsborG4GxdO+LSPDn
 tqnJ2tWLgSXlaVQMwEb2mwG370MLgETwl9MqoP3sjLHExo0WI0ZyUhTkgMPmcrzPqp/HPW4oZjj
 obJGN6wHgOpUPZld8KYHRfthr/tYtHxA=
X-Gm-Gg: Acq92OGPK+1Ag4Zuz4uBlXenfR0Y9SXzWtwH6zqS+3pUe05bz+piOhRTypS1GoixIE1
 sNgnZUOplDyTAuxz+A5B/IYZmAKy1NxUTkwi69bVOmKR2MfsBCtlOnk18k6CH2wfFqy6dm5XPm8
 1+1L9OcfHNaeal2j4U+Ff6Km1iYqQUaWEooKNn+99oeek72XIQjF7jRiEWgkJwTr7Nf7Jn17SyX
 DvdkYm9Ie8UkDNLat3PzjKm6cq+Q8mJ87i2Y6OEbizpOCiCbD2NUqYqKAg7+Ur5suyRbcFiCQnZ
 MlSs0iQe
X-Received: by 2002:a05:690c:9988:b0:7bd:882a:43ef with SMTP id
 00721157ae682-7bfb95ae32amr56489827b3.26.1778317716282; Sat, 09 May 2026
 02:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260503045820.973718-1-zzzccc427@gmail.com>
 <2ba0b3ad-615e-43c8-a165-af631607a4c3@kernel.org>
 <CAFRLqsUirEtA4+xxVkB9B71+eaqHa+nk78HxT-eAHEW2erJBBA@mail.gmail.com>
 <d8ee4481-0d99-4ff8-b440-b6de53f21f01@kernel.org>
In-Reply-To: <d8ee4481-0d99-4ff8-b440-b6de53f21f01@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 9 May 2026 17:08:24 +0800
X-Gm-Features: AVHnY4Js6b8Awc08SpuRyI2dXpS6q1CyhWU2uSVDvJUJTn6ilrLmpjqUFdSuMek
Message-ID: <CAFRLqsVBLEQf2cp9tHBW0oQmRzc6hPorePz9Tjw-H=R+KUiRHQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wLdfz-0008Gj-4Q
Subject: Re: [f2fs-dev] [PATCH] f2fs: start discard thread after mount
 recovery
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
Cc: baijiaju1990@gmail.com, jaegeuk@kernel.org, quic_stummala@quicinc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiDkuo4yMDI25bm0NeaciDnml6Xlkajlha0gMTY6NTHl
hpnpgZPvvJoKCj4KPiBDZW4sIGNhbiB5b3UgcGxlYXNlIGFkZCBhbGwgYmVsb3cgZGV0YWlscyBp
bnRvIHYzPwo+Cj4gVGhhbmtzLAo+CgpTdXJlLCBJIHdpbGwgZm9sZCB0aGVzZSBkZXRhaWxzIGlu
dG8gdGhlIHYzIGNvbW1pdCBtZXNzYWdlIGFuZCBtYWtlCnRoZSBlYXJseS1zdGFydCB3aW5kb3cg
Y2xlYXJlci4KClRoYW5rcywKQ2VuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
