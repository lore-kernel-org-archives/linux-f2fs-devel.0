Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F95C79F9F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DmhJfVj8Ur/jROgdCSIU8MtBr1E6PcgTdIsMRIjCG6A=; b=VFbiZSCKv+sxi2UWmrCH5zpEvd
	QE0cwGagMI1EN/sC62wW2pAn+uq9HxYVeBcyF1Z3oP3kHxVkztCk2Y3G0/uPX9f178zmXb5W7rfTT
	OI17EA4+U+Pe/vsqjjqJgSCvcsFKYpjk82TegiklRBc8YXhjEMEg7YTSgz7k+cfE/7HU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4gok-0002uk-91;
	Thu, 10 Sep 2026 15:36:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4goj-0002uY-Bs
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 15:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4rYX6ILhWeipoWe+WSeApRF+t34wwNzk1xhnGTYvKcE=; b=F4hidgllgCedPgftPblG8pP77t
 SBxSL4exMATHjQXRAHW6a1BKv1184ya1QnWC0wWeMqoOLju5+MipoCt1HjrGq2ORH+Ce2gbzT6Qff
 U8py/v9lCEnc0e6v4Flfq8yT/MsvtWHGkO80JRV93nKQgbPhkP26MOgMqmU3C0fiznq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4rYX6ILhWeipoWe+WSeApRF+t34wwNzk1xhnGTYvKcE=; b=L3+ZmrtyO6n6B/KfyqTmFqLFrw
 BqLKNBZ5GEKPriP/5IbXHEt4JHmCmFeGnRXOz/HDLjrlahWUk5FlYSQc+q1mR07ME/oWP0VvdfGqz
 AtIgzogqnq5OfZ2UWcqn2bjTGeRqMCD0gLC8IvbOB4ZjuC8xGrAkRtRv4Spg6kiSAuAQ=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4goh-0005Pw-0E for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 15:36:02 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so6106081a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 08:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789054553; cv=none;
 d=google.com; s=arc-20260327;
 b=qvIh6GheMETqx4IOoQLB/oJ6QuTvANpPux+RxcDS/Zu0CaIjBJg2Jgqjs6jQdiUnR+
 FVvA8gHaTcQK2olKsqZTOeFqoc/HeA697p2WA1LCbGS6bhtWwiFDHK4Pv09GHGOz0O08
 Niku/2aE6KF1MAr07QZaWx32Aeuv02ljKB7MV+CBXqwWmNJNRQorBGoprsXvCdkp0IUL
 W6Gj7nhk4k0lYmYPked8G/632You7igWCkleFZhhCl8GB3NtWOI26slwrzj/DH6aC3tq
 Mq3HmtUMQq7NRcTHnNGFBicw6sBxtIce8yXYsb+vV4j8BZjptU27CsqLA89Jzfj6tgwu
 9oEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4rYX6ILhWeipoWe+WSeApRF+t34wwNzk1xhnGTYvKcE=;
 fh=vHTVLj5USPu2z+/ZVjSCNcNJZxi5O5jTc//NJJXtx1k=;
 b=QKG19uwZcLv1uU0lZisSPxmAb0jqHPVgixjFHFzn3r13KNtiDGLSiDIRMcq3mv435F
 CiqiBXkeCpGvaxd23pQgwdRhu0x+WmM/BcRRUdcdIgpq0C5/t6EGl5yvuIlxrXN/m59F
 rJASLpzj920xIWQtFZmZAFIAobrDxyArxqUCArA4msU+EwCKS6BF7duy5XJoOmhh/ATQ
 raqQvn4hxcf3ppWnh54GjVeQ5aEJGCQ9MW0NruqXadhBZQm9w7OBn/ZNMtumBAB47ZT5
 1tPrwk00E80yiJOMzpxGx8PI2KCn40j7XWuC0f532yTQJfEGjYXDkouGb24GoJfSPEnJ
 eJQA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789054553; x=1789659353; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4rYX6ILhWeipoWe+WSeApRF+t34wwNzk1xhnGTYvKcE=;
 b=bNiu6fJzUNunoc65V9lQDqgIRIsVRYQGU53X07X2SA5r/xLsgUxiJXcrF/7mamtKK3
 5JWWFfCdmmwatBf3YT2UhuYQHPzczpvFulP+dyL6oX2mSlQP8wcitNM4C52Jn/u4DcUn
 7ARq27IKFTxIbKhSwnUDOI10QbnrAAshNNIulFoyWdUFXBsIVWS6XJeuQD9WyPQdkuKo
 RWioBx1zx7skPyL31DduZC6EItD6AnrApcMPoHrGSU6klMIOHdNTkJDyGsWm66De4oms
 I1QxwlK/CXNxa1bWtkFHJK10h/LcXDkYyrXXRGXcpDfm69Gtjizyz0eHv0T1p/K6mNMr
 Cclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054553; x=1789659353;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4rYX6ILhWeipoWe+WSeApRF+t34wwNzk1xhnGTYvKcE=;
 b=m9hajDp18crbDZTjthB8eXzqrm+Uuiy0TmVkNpAHBC6tLj/b8qWQR1F8052uzenZat
 90vhMV6EUG2wLFj37j2SEN/lJKc7dIB9a24J3a8EAm/3dUFUo04iT9SR3HfTxywF1YDM
 rSed8pLoPfllQugFNk++X3HSjj5dKyVFyaqp0RvYCKdCpNJ06iOrvbqyksaJZ0ZE/8dg
 BQbQGs3DTsNPN2aiLykw3OFcrLtJ79bircCpjoRZWAmJHRaLZlWZemp1n/qBB9b94J4f
 J0m7mg+y1ap2wjzRUqCoNi7Lx2VBXjxm8ts4+GrxgCD6ZUlMLkxMTelQCOly/IEdqtnn
 9OHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsvXPacG1n7zx3GKJ3JI+tZvCgEHiqjzZs+bhXGVqq6t+8gVPQC27w9FgMu/rS6tXJ9L8e+B/cekplbGLsaD96@lists.sourceforge.net
X-Gm-Message-State: AFuF++mHG8/M3GfXRYuBasd3bTQ725teAWSGj7GiPpRrSCIc2BwhndiB
 fEsPo1ljSEYQe3Opcub+/O4+RO5FdYsvHI2hgZh0LETnQB9oedG80R2S4ALO3j4Q9ddUqdAq8Wt
 R1QgQepwa8T6nfuPI9g0C34WcG94De8J55MomxZo=
X-Gm-Gg: AYBFou2zYpb0nEwyshYRw3RPfBq7BIKUXulDy8iPzQOVCu6XjsRo2V3gFtPdQXeKHr7
 3Ewra/9zYeXo4LjfJ9Z4nNI8Q9YCD8tDlcdc+fpUCYDgLR//JhE7AaUOl7kRfn4YiNY+aU4Ehwx
 ZoN+WbrdbLwiByu1d/lBOC9SWWFrVdIndDrQ5YpZ5dz0MbgLuqiyUS2InWxKjlpcIJXWb8MT80+
 h3HGMjVE9GLHd4wIz7EtEuGjdhWvtjxm//443jblvSklWqS1nBdj+AQwU8zOprVCSDj82rFQNKd
 Cd7gzXxtt9tbqiDKvRWa3q1jRszX5u7M1D8r6FacDSDvPFNzdqJBa8jrIs4zYmguqR0ta3895rm
 6lBqz5abnST/quBBXCliBNj40DMSA1P/nimEwK6tV8w==
X-Received: by 2002:a17:90a:d004:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-39b26273267mr64659485a91.13.1789054553156; Thu, 10 Sep 2026
 08:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260828121816.1463654-1-ke.li11@transsion.com>
 <20260910021502.10024-1-ke.li11@transsion.com>
 <41cfe667-115c-4f95-b5c2-ec9344e46519@kernel.org>
In-Reply-To: <41cfe667-115c-4f95-b5c2-ec9344e46519@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 10 Sep 2026 08:35:38 -0700
X-Gm-Features: AcwNN1U6zBccFw2V32Wwa301z4UfUo7ZnwpuFYvivAIePlL4qS5g_YDLtKupLoA
Message-ID: <CACOAw_yyfGt58mTk2oUPdqR=CbvHBtMgpfF3NhaN0vvh6EbVnQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x4goh-0005Pw-0E
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>,
 Daeho Jeong <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBTZXAgOSwgMjAyNiBhdCA3OjQ54oCvUE0gQ2hhbyBZdSB2aWEgTGludXgtZjJmcy1k
ZXZlbAo8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ+IHdyb3RlOgo+Cj4g
SGkgS2UgTGksCj4KPiBUaGFua3MgZm9yIHRoZSBwYXRjaGVzLgo+Cj4gQWRkIERhZWhvLCBJIHRo
aW5rIGhlIG1heSBoYXMgc29tZSBleHBlcmltZW50cyBvbiB0aGlzIGFuZCBjYW4gaGVscCB0bwo+
IGNvbW1lbnQuCj4KClRoYW5rcyBmb3IgdGhlIHBhdGNoLgoKSG93ZXZlciwgSSdtIHRyeWluZyB0
byB1bmRlcnN0YW5kIHRoZSBtb3RpdmF0aW9uIGFuZCBrZXkKZGlmZmVyZW50aWF0aW9uIG9mIHRo
aXMgYXBwcm9hY2guCgpXZSBhbHJlYWR5IHN1cHBvcnQgZmlsZXN5c3RlbSByZXNpemluZyBhbG9u
ZyB3aXRoIHRoZQpyZXNpemFibGVfdGFpbF9zZWNubyBtb3VudCBvcHRpb24uCgpUaGUgZXhpc3Rp
bmcgaW1wbGVtZW50YXRpb24gYWxyZWFkeSBoYW5kbGVzIHJlc2VydmluZyB0YWlsIHNlY3Rpb25z
IHRvCnByZXZlbnQgcGlubmVkIGFsbG9jYXRpb25zIGZyb20gYmxvY2tpbmcgc2hyaW5rYWdlIGJ5
IHJlc3RyaWN0aW5nCmFsbG9jYXRpb24gcmFuZ2VzIHZpYSBwaW5uZWRfYXJlYV9tYXhfc2Vjbm8g
YW5kIHRyaWdnZXJpbmcgcmFuZ2UgR0MKYWNjb3JkaW5nbHkuCgpGdXJ0aGVybW9yZSwgd2UgZXZl
biBoYXZlIHN1cHBvcnQgZm9yIGR5bmFtaWMgZGV2aWNlIGFsaWFzaW5nLCB3aGljaAphbGxvd3Mg
ZHluYW1pY2FsbHkgYXR0YWNoaW5nIGFuZCBkZXRhY2hpbmcgZGV2aWNlcyB0by9mcm9tIHRoZQpm
aWxlc3lzdGVtLgoKR2l2ZW4gdGhlc2UgZXhpc3RpbmcgbWVjaGFuaXNtcywgY291bGQgeW91IGNs
YXJpZnkgd2hhdCBkaXN0aW5jdApwcm9ibGVtIHRoaXMgbmV3IHBhdGNoIGFpbXMgdG8gc29sdmU/
IEl0IHdvdWxkIGJlIGhlbHBmdWwgaWYgeW91IGNvdWxkCmVsYWJvcmF0ZSBvbjoKCi0gVGhlIGV4
YWN0IGdhcCBvciBsaW1pdGF0aW9uIGluIHRoZSBjdXJyZW50IHJlc2l6aW5nLApyZXNpemFibGVf
dGFpbF9zZWNubywgb3IgZHluYW1pYyBkZXZpY2UgYWxpYXNpbmcgaW1wbGVtZW50YXRpb25zIHRo
YXQKeW91IGFyZSBlbmNvdW50ZXJpbmcuCgotIFRoZSBhcmNoaXRlY3R1cmFsIG9yIGJlaGF2aW9y
YWwgZGlmZmVyZW5jZXMgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzCmNvbXBhcmVkIHRvIHRoZSBleGlz
dGluZyBmZWF0dXJlcy4KCj4gVGhhbmtzLAo+Cj4gT24gOS8xMC8yNiAxMDoxNSwg5p2O54+CMTEg
d3JvdGU6Cj4gPiBIaSBKYWVnZXVrLCBDaGFvLAo+ID4KPiA+IEdlbnRsZSBwaW5nLiBUaGlzIHNl
cmllcyB3YXMgcG9zdGVkIG9uIEF1ZyAyOCBhbmQgSSBoYXZlIG5vdCBzZWVuCj4gPiByZXZpZXcg
Y29tbWVudHMgeWV0Ogo+ID4KPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJm
cy1kZXZlbC8yMDI2MDgyODEyMTgxNi4xNDYzNjU0LTEta2UubGkxMUB0cmFuc3Npb24uY29tLwo+
ID4KPiA+ICAgMS8yICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVsLzIw
MjYwODI4MTIxODE2LjE0NjM2NTQtMi1rZS5saTExQHRyYW5zc2lvbi5jb20vCj4gPiAgIDIvMiAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJmcy1kZXZlbC8yMDI2MDgyODEyMTgxNi4x
NDYzNjU0LTMta2UubGkxMUB0cmFuc3Npb24uY29tLwo+ID4KPiA+IE5vIGNvZGUgY2hhbmdlIHNp
bmNlIHYxLiBIYXBweSB0byByZXZpc2Ugb3IgYWRkIHRlc3RzIGlmIG5lZWRlZC4KPiA+Cj4gPiBU
aGFua3MsCj4gPiBrZS5saTExCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
