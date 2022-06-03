Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C582EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jun 2022 02:14:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwwp8-0005NA-5t; Fri, 03 Jun 2022 02:14:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <fengnanchang@gmail.com>) id 1nwwp6-0005N4-Ut
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jun 2022 02:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bqHxo/kHHYMRtQhcYyrq4pvXWONZ6Pm920j6ABq0328=; b=AD3owpUQ0ldWDhbL6/JOESyKfU
 5B94ja9UQ8pBUchPJK/oio7hpCcoH5+UVPxx70Y8plLn+B3w9wDaP7I4T+KJ0VGQSH0CZovKHoQqq
 r1h4jV3ooRFEPLRx4zoOEKsRvpaSHx6+DSangiOK+q9GeBmmMDGtfIAi6NfS+ol0bPt0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bqHxo/kHHYMRtQhcYyrq4pvXWONZ6Pm920j6ABq0328=; b=MmaXtVqV/Jo4U7n1iM7NSrUg9f
 pRPDwRHMvCDcCPTG5JT1FDVwDwb4sx2qo8tdfwsrkDiA6SScN7eMs9jN26tRhGEyjAutwXGXR7bvb
 BGG1iySKCl1kezPwPmGvLJs7/RSxCtchF8aTQUkYid9mXkGJc+8N/K7uTuLXxogiCJUI=;
Received: from mail-lj1-f177.google.com ([209.85.208.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nwwp5-0031zj-1Z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jun 2022 02:13:59 +0000
Received: by mail-lj1-f177.google.com with SMTP id y29so7059989ljd.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 02 Jun 2022 19:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bqHxo/kHHYMRtQhcYyrq4pvXWONZ6Pm920j6ABq0328=;
 b=T1wQdqVlvv27wUbQTCKAATxzmvacq2QcDoSEAwwImV86FI9SM61SgnOjUnAnRGlmrL
 dEKGrWbK7S/GjDrjv7hff/0g4l8b+gg3d/9AxTGUmQ0W5pbIEH7PVL9lHCWZpnXWmREE
 NSzAf61+WydZvAAbg58owHTFj11V4P2qbJGxRobQE9pBB3gwiqe7NWRsJx4TttMT0JsH
 oKl7lDZZ9GdPVlxFd8pHIoOy5q428+e5TS1JRzNOh2/N0i8mjdi7JU76AG29p+0Xe8iO
 P+valgIE/OeY5aEtfhTeQu8YvVD1ljsFjJWYfXcpLdwjrgVC6UyXrvpxPfJQLxsOaCoV
 z1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bqHxo/kHHYMRtQhcYyrq4pvXWONZ6Pm920j6ABq0328=;
 b=z0WsawT6RSHWbTlc1DEkmlIMg4xyu2RWIyHBYcAJrkRs2Gxs6BzpRL+bhUjCTS6jJF
 YwCHhepZ3GX/669w4qpVEGTqd7Cb21nOc0t7B3FEYYrGOpM3Ri3I6i445i/UaTDIC/UO
 QxNavHdj/imeatzObmtlR5IAGjA8Qnt2/oxUb8qpFd7W2PK9aqGF/Sq9ZN40+2eAR6cV
 Svz7T1K1IGz1horOe5WYA+REOsgAhCPBODkL14R8H3GunVY4yk1tizYfOAD0s0frs/Jv
 e/2r78k1EhNDKEzfcrODaid4zdXHVeCqAJk0xmhMyCHNKxCGOGJwZa98MlH0N4uxlsfi
 A2xA==
X-Gm-Message-State: AOAM533QR5ekByJ3b1dlsVzSxIZfGdVxUx/UlJkEqeDRR1/c71sVmpLl
 YAOlticMr/SRwyFVCUiECoKkWPeAjZn2drMFO0o=
X-Google-Smtp-Source: ABdhPJz1Jc+Y/yvS6gUr7QLE9rpQ7AXCRpFvOYzr8sDfbr+OFQsXJN7H9Iw5oj3912+ik9EDVNjO8gGkxULaV1UPxro=
X-Received: by 2002:a05:651c:4d1:b0:255:6c06:295e with SMTP id
 e17-20020a05651c04d100b002556c06295emr6381741lji.339.1654222432467; Thu, 02
 Jun 2022 19:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220507081710.117162-1-changfengnan@vivo.com>
In-Reply-To: <20220507081710.117162-1-changfengnan@vivo.com>
From: fengnan chang <fengnanchang@gmail.com>
Date: Fri, 3 Jun 2022 10:13:41 +0800
Message-ID: <CALWNXx8EYPLkGM68Bhcw5mqLBbb4CcQW1rCLefkSYcpW8D5amw@mail.gmail.com>
To: Fengnan Chang <changfengnan@vivo.com>
X-Headers-End: 1nwwp5-0031zj-1Z
Subject: Re: [f2fs-dev] [PATCH v2 0/3] support compressed file write/read
 amplifiction
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

cGluZy4uLgoKRmVuZ25hbiBDaGFuZyB2aWEgTGludXgtZjJmcy1kZXZlbAo8bGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ+IOS6jjIwMjLlubQ15pyIN+aXpeWRqOWFrSAxNjox
OOWGmemBk++8mgo+Cj4gT3B0aW1pc2UgZjJmc193cml0ZV9jYWNoZV9wYWdlcywgYW5kIHN1cHBv
cnQgY29tcHJlc3NlZCBmaWxlIHdyaXRlL3JlYWQKPiBhbXBsaWZpY3Rpb24gYWNjb3VudGluZy4K
Pgo+IEZlbmduYW4gQ2hhbmcgKDMpOgo+ICAgZjJmczogaW50b3JkdWNlIGYyZnNfYWxsX2NsdXN0
ZXJfcGFnZV9yZWFkeQo+ICAgZjJmczogdXNlIG9uc3RhY2sgcGFnZXMgaW5zdGVhZCBvZiBwdmVj
Cj4gICBmMmZzOiBzdXBwb3J0IGNvbXByZXNzZWQgZmlsZSB3cml0ZS9yZWFkIGFtcGxpZmljdGlv
bgo+Cj4gIGZzL2YyZnMvY29tcHJlc3MuYyB8IDE1ICsrKysrKysrKystLS0tLQo+ICBmcy9mMmZz
L2RhdGEuYyAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
Cj4gIGZzL2YyZnMvZGVidWcuYyAgICB8ICA3ICsrKysrLS0KPiAgZnMvZjJmcy9mMmZzLmggICAg
IHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ICA0IGZpbGVz
IGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjM1
LjEKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
