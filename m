Return-Path: <SRS0=JrMS=EB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DFAC2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:45:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DBB20714;
	Mon, 26 Oct 2020 23:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PVckOqjJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="YeTXXdmm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiXZUswt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DBB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXCAm-0000n1-91; Mon, 26 Oct 2020 23:45:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kXCAl-0000ml-9M
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:45:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+ci8HfK0Jx/bpDWJmMVdhckawMI3McUJ3Muf62Y3os=; b=PVckOqjJ1Y02EqR7WkcdR4l6JC
 OWoFbEbwMpxEPQaa+V/4wcmZY/UDfeOuzl9EpYv84c2NLC1y1ssvt7sA5kwsWA1rg7DEeoPcYBAAQ
 qolQf18AjimZxeOTciphoMcP8yGhsrRQkr8/gCEghZiloMt3MGx57eGNwwlA3+/iYPCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U+ci8HfK0Jx/bpDWJmMVdhckawMI3McUJ3Muf62Y3os=; b=YeTXXdmm2PrRj3k8IhwphYCmMI
 qU5V7GDDTUEsN0h7nlAbIB3ANiMNFvkEfaS6H6YBJHLPuuxeoo1t5OmJkmfwfJUazlHAhIIYT/Bgp
 6+yWEhPXBrQzWASB4V+sAfh54LV3XcoMSBdaRU3E8EEsBVpgL9vXUeh+cSBSHJS3/Mrw=;
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kXCAh-00Etla-QS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:45:07 +0000
Received: by mail-lf1-f67.google.com with SMTP id h6so14670611lfj.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2020 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U+ci8HfK0Jx/bpDWJmMVdhckawMI3McUJ3Muf62Y3os=;
 b=AiXZUswtdTYC3oZ4+GUHPWtVP9jG18MnP79xWB/+b5a0T/FWq6q/+HReapl8Mjdyta
 AC3tnFDBxmu2mNZBS5h3nlUUY/L+X8ndPHc0sVuYATjf3U+cHkR/7sCAcQEcHsDmZkX0
 8F0y9YI7Mti9Up+dZ8Wq4KqMaSxOLeteiaLDLw91zaDQyys/tVyzaRlkrWTLRwyzLC+T
 FQje7c7Mn6OTXDhLi4l1IJoI9Ufe7yZ27TDH5OxywgPzx82BfrnJGbiaeCnwbhHRQoXw
 B9f+8raORPERSnfpRA8CP0S0JcnRgtXKSDhzM8ENJL3hGK3P7DazLlzc3BnGJDOk/jmj
 ssaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U+ci8HfK0Jx/bpDWJmMVdhckawMI3McUJ3Muf62Y3os=;
 b=Ps6HiV2yLt7DGoX8tENaPY4TMmmej2VhyUSJYt2u7wzeb3V1E/ILdybx825Flgx9Qk
 lETpJV2Y/PWl7jncIC6UItaMnBys7y0BYC6nk/nHlypR2FCfvAd22u4DtfMY3r/cZ+1p
 fFhXfmVnBjTZHKMxCg04/pp0LdOFYfKanp4NYETIzyBgpQyXmoeBggxtrzkqEp6KpSVm
 BNM9ctag0q0RorkLWIV1CLkuI+2Hk6RXte5zp1a2Vs67rbGRwB/K1/Zn3g3GAm68Wdbk
 rnZBAP/L01av0AzyUpiMtUhkff0hv2NQgY23ANPq3P9rfoNU0Xd6VhncsRSlH56C1STJ
 AtTw==
X-Gm-Message-State: AOAM533IdgtTZ3/NyCkDYl7Yx8sh/TK76bDCZ0r66G9KMTh+F1jGTXe6
 WoF8MAC9fY4QB1jwKNjbY8PSryLzxzuiyhgOaUzPmvnl7QI=
X-Google-Smtp-Source: ABdhPJy7g9BoxTMajgkhgTXmYywo57QYN/3JVTnSY/v2Anbz2XwZHF5bXTKb/yYHnp+DPltcJ7Qhsnpzm62OdfT5o1c=
X-Received: by 2002:a19:f71a:: with SMTP id z26mr5752205lfe.90.1603755897185; 
 Mon, 26 Oct 2020 16:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
 <20201026230555.GB1947033@gmail.com>
 <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
 <20201026232712.GC1947033@gmail.com>
 <CABdZyew=D=S7MmitF55K8Jd6QiVzdJzFuQ2JkJ6x_T_a=AVMvQ@mail.gmail.com>
In-Reply-To: <CABdZyew=D=S7MmitF55K8Jd6QiVzdJzFuQ2JkJ6x_T_a=AVMvQ@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 27 Oct 2020 08:44:46 +0900
Message-ID: <CACOAw_xYHr7YY_e-cLYUurh07T-T=CNTM6gKUv5VKjYp9=h9nw@mail.gmail.com>
To: Daeho Jeong <daehojeong@google.com>
X-Headers-End: 1kXCAh-00Etla-QS
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: add
 F2FS_IOC_GET_COMPRESS_OPTION ioctl
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
Cc: Eric Biggers <ebiggers@kernel.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T29wcywgdHlwb3MuLi4KCjIwMjDrhYQgMTDsm5QgMjfsnbwgKO2ZlCkg7Jik7KCEIDg6NDMsIERh
ZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+64uY7J20IOyekeyEsToKPgo+IE9vcHMs
IHR5cG9zLi4uCj4KPiBPbiBUdWUsIE9jdCAyNywgMjAyMCBhdCA4OjI3IEFNIEVyaWMgQmlnZ2Vy
cyA8ZWJpZ2dlcnNAa2VybmVsLm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIFR1ZSwgT2N0IDI3LCAyMDIw
IGF0IDA4OjE4OjQ0QU0gKzA5MDAsIERhZWhvIEplb25nIHdyb3RlOgo+PiA+IEkgY2hlY2tlZCB0
aGF0LiBXZSBzZWVtIHRvIG5lZWQgdG8gY29tcGxlbWVudCBtaXNzaW5nIHBhcnRzIGluY2x1ZGlu
Zwo+PiA+IG90aGVyIGlvY3RscyBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2ZzY3J5cHQu
cnN0Lgo+PiA+Cj4+ID4gVGhhbmtzfgo+PiA+Cj4+Cj4+IFdlbGwsIHRoZSBmMmZzLXNwZWNpZmlj
IGlvY3RscyBzaG91bGQgcHJvYmFibHkgYmUgZG9jdW1lbnRlZCBpbgo+PiBEb2N1bWVudGF0aW9u
L2ZpbGVzeXN0ZW1zL2YyZnMucnN0Lgo+Pgo+PiAtIEVyaWMKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
