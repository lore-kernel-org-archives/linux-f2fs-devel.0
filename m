Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E795EC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0S3JBo0DUBOBEQEVB512FJem2pbaCqldi3YNbX5k3s=; b=aNpvkbCIv+Lo3arTxs35a3JuAC
	SNrKoJbdrbf6SqULk04VVUXAC9YkZHRUKRQsJL3CjwEuOsE5KaJxYiVxEwUPW436nP4Eg5lZ1tggn
	/8CCCWd/DpOoP0y/0Yw9/0qGKsvTgmZBUODfRsHDJj4CV229NBe8T0aVB+c9lEmF3Fus=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzve1-00080G-62;
	Fri, 28 Aug 2026 12:25:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzvdz-00080A-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xZ9me54ezhfBhhLAqHw8CbjXHmjjvbvgWR0OVYdLObQ=; b=R0l8ZV4xnHPEJg1t0V0KyCOgPk
 O27OamLC0W5lmxrr72U3+kFuraad/9I+gben023Qswcbc0rTttU2Cst/J5AIpCnU8SH9yIFsLFcQC
 Iv65rDSm/Lj99rkDoxfDc8hayA/KvE9aH+fEa90ht1SC2y6wttkvY2z5z2L4KV78sws8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xZ9me54ezhfBhhLAqHw8CbjXHmjjvbvgWR0OVYdLObQ=; b=R+ZiaW08NNs8qt9ii0MXD3KwyU
 1V6TykyskqNBk/0S11/I1xPXHSthlSu1K2nXIPA8kGawMrurLQhFZr3lUeQKndV4wd5KUxs04hEAJ
 NGA62Cw0qu9bTLI2LUJH/qyiQ4vEcTjGRXnmBV9nfaxyAqgJtNHMXjwxRvyfBTS6Kr6c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzvdv-0002d7-O8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:25:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58B9B415CB;
 Fri, 28 Aug 2026 12:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFA51F000E9;
 Fri, 28 Aug 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787919906;
 bh=xZ9me54ezhfBhhLAqHw8CbjXHmjjvbvgWR0OVYdLObQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OE29sBoAshZwOVX+xFOEH9c+7aLynmgSJps5ULMrEHd46t53tLpe03Nr5BwQpFVWa
 I9o4lQmdPxtr5hsDPTEQBkcp/Yl2NkVOUjyj2e2xwgf7DIjLLcMBz8lPft8SgivtVC
 kSZ1oZ3qjhBLY9jEX6w5paD5xUiIdYOmNIRHFXAJuyQ8SFSoOI8Snenoe1zAU8qF3x
 j3p7Z4S7o3ENLIIPE8sbVXaALTun8jgaMoEda6Zc3EdmvYwXWeb/mjkYPXY+x0Yuej
 Jeyvt7N/cDbBdOTo4KSJ9B+vOgCt2jGFFxNT0pbcCBGI5GokfHrWODzrWLE2W4/y23
 Xq855ST1At/gw==
Message-ID: <12dc55dd-f85d-4f21-8eac-f1042bcf0565@kernel.org>
Date: Fri, 28 Aug 2026 20:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-10-chao@kernel.org>
 <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
 <b4711014-844e-45c0-b85a-4e3a98d7137c@kernel.org>
Content-Language: en-US
In-Reply-To: <b4711014-844e-45c0-b85a-4e3a98d7137c@kernel.org>
X-Headers-End: 1wzvdv-0002d7-O8
Subject: Re: [f2fs-dev] [PATCH v3 09/12] f2fs: cache: use compress cache
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yOC8yNiAyMDowMCwgQ2hhbyBZdSB3cm90ZToKPiBPbiA4LzI3LzI2IDA0OjA0LCBEYWVo
byBKZW9uZyB3cm90ZToKPj4gT24gVHVlLCBBdWcgMjUsIDIwMjYgYXQgNjowM+KAr0FNIENoYW8g
WXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGYyZnNfbG9ja19jYWNoZShlbnRyeSk7Cj4+Pgo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbm8gIT0gZm9saW9fZ2V0X2YyZnNfZGF0YShmb2xp
bykpIHsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZm9saW9fdW5sb2NrKGZvbGlvKTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gLQo+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdlbmVyaWNf
ZXJyb3JfcmVtb3ZlX2ZvbGlvKG1hcHBpbmcsIGZvbGlvKTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb2xpb191bmxvY2soZm9saW8pOwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFmMmZzX2lzX2NvbXByZXNzX2NhY2hlKGVu
dHJ5KSkgewo+Pgo+PiBIb3cgaXMgdGhpcyBwb3NzaWJsZT8KPj4gb3IgaWYgKCFlbnRyeS0+Y2Fj
aGUpPwo+IAo+IEkgc3VmZmVyIGEgcGFuaWMgZnJvbSBmMmZzX2J1Z19vbihzYmksICFmMmZzX2lz
X2NvbXByZXNzX2NhY2hlKGVudHJ5KSkgaGVyZSwKPiBpdCBtYXkgc3VmZmVyIHJhY2UgY29uZGl0
aW9uIHcvIHNocmlua2VyLgoKSSBjaGFuZ2VkIGxpa2UgdGhpcywgYmVjYXVzZToKMS4gd2Ugd2ls
bCBuZXZlciB1cGRhdGUgZW50cnktPmlubyBhZnRlciBpbml0aWFsaXphdGlvbiwgc28gaXQncyBz
YWZlIHRvCmNoZWNrIHcvbyBsb2NrLgoyLiBmMmZzX3RydW5jYXRlX2NhY2hlKCkgaGFzIGNoZWNr
ZWQgZW50cnktPmNhY2hlIGJ5IGl0c2VsZiwgc28gaXQgZG9lc24ndApuZWVkIHRvIGNoZWNrIHcv
IGYyZnNfaXNfY29tcHJlc3NfY2FjaGUoKSBvdXRzaWRlIF9fZjJmc190cnVuY2F0ZV9jYWNoZSgp
LgoKCWZvciAoaSA9IDA7IGkgPCBucjsgaSsrKSB7CgkJc3RydWN0IGYyZnNfY2FjaGVkX2Jsb2Nr
ICplbnRyeSA9IGVudHJpZXNbaV07CgoJCWluZGV4ID0gZW50cnktPmluZGV4ICsgMTsKCgkJaWYg
KGVudHJ5LT5pbm8gIT0gaW5vKQoJCQljb250aW51ZTsKCgkJZjJmc190cnVuY2F0ZV9jYWNoZShl
bnRyeSwgZmFsc2UpOwoJfQoKTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbmNlcm4gYWJv
dXQgdGhpcy4KClRoYW5rcywKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
