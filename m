Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DB4106FD69
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Mar 2026 02:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DamhG01O9ksV46mtLLtivI+gYiOqTKwMHQaovEfe5T4=; b=eq8eq3WvJ+YpmThjXYn7nH17e4
	oRIfctKmvFi1sfwo28VzeND5fZDtCIxJvUzAv8rB7Q2BAWCIdhgkd06qtStBYFC5khZXfAlXPA76F
	Hz+sseILaSV38nSSvtKgvaDSt6SGQsyerrQwBHTOuA/1tsXMrti9Ka6wFiUFSpzJUcv4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0sIN-0008Pr-74;
	Fri, 13 Mar 2026 02:30:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zangyangyang66@gmail.com>) id 1w0sI5-0008Pa-IK
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Mar 2026 02:30:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KGtaTiDyjH8jkqs7OHZPEvbo2pzxTLAIG6rHQbvSVhQ=; b=XR3t3LLbRNZ+y2Ecn1qv/xIYU6
 9Su+bniDhlAlQ4z+iYijIBjO/vavR/6/Cu3rzFJLKigtv9tnUAkQJtLrEA5UlGS0ZH+lzyupu8Yqh
 A7dQoPvS0pPCIuJy8DemlPdSusCI1cjZFE4HkSb39osqqgkID7KyqsW0XSUWpOf+dNCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KGtaTiDyjH8jkqs7OHZPEvbo2pzxTLAIG6rHQbvSVhQ=; b=ZL+O+5vcrDv0y1feAZuaH3BJU6
 9Q+cwjcZnWjS32lFlTNB45wk26kt7T2GnyJWQIFymRcOtSvYPx3zk4kNB2Tc7d7KNHOaHmMHwokkB
 jwE7ZPRnDirQ5OlXCdd1k8GI0ebePyADr9mSppzGnQ/oclKqdhgtr56kvWUAobUbCd7Q=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w0sI5-0002KI-7h for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Mar 2026 02:30:17 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so7723755ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Mar 2026 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773369006; x=1773973806; darn=lists.sourceforge.net;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGtaTiDyjH8jkqs7OHZPEvbo2pzxTLAIG6rHQbvSVhQ=;
 b=VqpWH65OH8QHGBJNE9lVY1VnGcZDciIMz5KZv4+jQvDaPSTrjnNj9dn45iWApi4622
 PqX4rAL0UHlgAXnPxpJgnkY5XSgtnKwVztpiV5EHBpAM+8YJKq3Dn3ZiDPDT2N+FPCs9
 yiAQRByuK0Y2/MORe3vZnuCrGCAzAtL4W4ZybN6X9WSoBpcp3jS+WEy+4qIwfeccBD6J
 2piemX7Ntf0aoj9XlsNWm6VVHUG4c+kDF/DMB225d7MDpVB/mZ9jkR1MZlvbR7QLg/uv
 8jZzkCjCD4eZzYVlyU4U/pk6qk2xzxuA8xiZzkXg/WF5RXGB9T+gBwDZcfA8pksAmHMu
 1i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773369006; x=1773973806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGtaTiDyjH8jkqs7OHZPEvbo2pzxTLAIG6rHQbvSVhQ=;
 b=de/75vzD2r6qfveFGfdG6iLh3nijOHjXkmPvBB1PL2+LqH88E3xOCl4DiGTMb0HKyT
 gW4MWLquCTZCffW3LQWl+1dDqw70UZ+JXO/HtmAVtqIuVM0IttoJvr2WnHwQTPUdg3my
 9fT04DVwoNghTnhcRv43cLULsom3Sn0nZ4VTGstwEMPFWnbepDSHZjafwyfny+7XR89N
 i4kPCfh4rD3MieqpqrqUPh8wkVHSmeq1kXZcWLVWKoYNEtsHyglKUt0BfieeSlwjp8nz
 2PwgFuKK00gMQZDcuxkv6EP+9bW1TUPX1FGGQnv6CQxhQy6Q+Vl5vH+goQhj1OtQ8x7N
 R4vA==
X-Gm-Message-State: AOJu0YzvCl0Jzreg942iWpU86BlMjzv+v6aa+/kd4Nir1bor8o3fgHwl
 Rxv8jygCtADcWLZWLTN0pXYTclgZeepAU/m+Nhu5rI2aiQo5PY5Sg42K7rfDsw==
X-Gm-Gg: ATEYQzxVHyiwDBK1USFnG20x2KcM82ur5ThnP+z2pI4MkGfhAepDx5aAr6kCWL3YHB7
 zGlKXyn/u6EI7JlE8iztDzFbr+E+CoRNzNOb9cxmLaVFcAhYKHPnaBkm+IdGWA2O2hcB+x533oV
 Tknst2/JHOSLbgTyxJKf5o449sPFUp86+fkpglbxjt99vtM4llAJ6XQT1Q+93jAg/mQ66CkVwCw
 E7lmw1mjp949S5evJR9jm+qsATABt4O+z2qDqYtTXWqeBSAjbJVPdKjxNOgUUD9x9cf8rrThjWM
 qRUi5I3edYCRSQOBk5kXXoBZOz6wipYgKCmAKVJXPc6/QIIpKoCSDusuQQ/mB/bU/YOv6Wx+EcM
 GVbpMdeK84CkeathCyXfm/rBeih13T+y3r2jO4n+hvwnSLB2L7hlXOvvpnt8R454kdsh23dvF4M
 wAvmSguItbgHp1fOFEF0cVMYFqLmo+TQDcLNyqPtTZHX/kEC2IcxtpcMUrzRh1a3NKHDli2dwAC
 NBvROxh
X-Received: by 2002:a17:902:e951:b0:2ae:c5fc:b2ea with SMTP id
 d9443c01a7336-2aecab1ef18mr14510045ad.30.1773369006413; 
 Thu, 12 Mar 2026 19:30:06 -0700 (PDT)
Received: from ?IPV6:2408:8607:1b00:8:27ea:d5d9:74f4:31ef?
 ([2408:8607:1b00:8:27ea:d5d9:74f4:31ef])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece858d18sm4036665ad.86.2026.03.12.19.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 19:30:06 -0700 (PDT)
Message-ID: <41b970e5-799f-42e2-9d82-8619db24716e@gmail.com>
Date: Fri, 13 Mar 2026 10:29:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, daehojeong@google.com
References: <20260311083530.2582720-1-zangyangyang1@xiaomi.com>
 <6e89694d-5e3d-4d1c-91f6-56dcd36fcced@kernel.org>
Content-Language: en-US
From: Yangyang Zang <zangyangyang66@gmail.com>
In-Reply-To: <6e89694d-5e3d-4d1c-91f6-56dcd36fcced@kernel.org>
X-Headers-End: 1w0sI5-0002KI-7h
Subject: Re: [f2fs-dev] [PATCH v3 1/3] resize.f2fs: fix to avoid zeroing
 main area blocks in migrate_ssa()
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
Cc: Yangyang Zang <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

5ZyoIDIwMjYvMy8xMiAxMDowMSwgQ2hhbyBZdSDlhpnpgZM6Cgo+IE9uIDIwMjYvMy8xMSAxNjoz
NSwgWWFuZ3lhbmcgWmFuZyB3cm90ZToKPj4gYWQxMzU3YzM0MDIzICgiZjJmcy10b29sczogcmV2
ZXJ0IHN1bW1hcnkgZW50cnkgY291bnQgZnJvbSAyMDQ4IHRvCj4+IDUxMiBpbiAxNmtiIGJsb2Nr
IHN1cHBvcnQiKSBjaGFuZ2VkIHRoZSBsb2dpYyBmb3IgbWlncmF0aW5nIFNTQQo+PiBibG9ja3Ms
IHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUgcGFja2VkX3NzYSBmZWF0dXJlIGlzIGVuYWJsZWQu
Cj4+IER1cmluZyB0aGUgcmVpc3plIHByb2Nlc3MsIHRoaXMgcGF0Y2ggbWF5IGNvcnJ1cHQgdGhl
IGZpbGUgc3lzdGVtCj4+IHJvb3QgaW5vZGUuCj4+Cj4+IFJlcHJvZHVjZXI6Cj4+IGRkIGlmPS9k
ZXYvemVybyBvZj0vZGF0YS9mMmZzLmltZyBicz00ayBjb3VudD01MjUzMTIKPj4gbWFrZV9mMmZz
IC1nIGFuZHJvaWQgL2RhdGEvZjJmcy5pbWcgMTMxMDcyCj4+IHJlc2l6ZS5mMmZzIC1GIC9kYXRh
L2YyZnMuaW1nCj4+IG1rZGlyIC9tbnQvZjJmcwo+PiBtb3VudCAvZGF0YS9mMmZzLmltZyAvbW50
L2YyZnMKPgo+IEhpIFlhbmd5YW5nLAo+Cj4gRG8geW91IGhhdmUgYW55IHBsYW4gdG8gd3JhcCBh
Ym92ZSB0ZXN0Y2FzZSBpbnRvIHhmc3FhPwpJIGRvbid0IGhhdmUgYW55IHBsYW5zIHlldCwgYnV0
IEkgY2FuIGdpdmUgaXQgYSB0cnkuCj4+Cj4+IFRoZSByb290IGNhdXNlIGlzIHRoYXQgdGhlIG51
bWJlciBvZiBTU0EgYmxvY2tzIGFmdGVyIHNlZ21lbnQKPj4gYWxpZ25tZW50IGlzIGluY29uc2lz
dGVudCB3aXRoIGBnZXRfbmV3c2Ioc2VnbWVudF9jb3VudClgLgo+PiBUaGlzIG1heSByZXN1bHQg
aW4gc29tZSBTU0EgYmxvY2tzIG5vdCBiZWluZyB6ZXJvZWQgb3V0LCBvcgo+PiB0aGUgbWFpbiBh
cmVhIGJsb2NrcyBiZWluZyBpbmNvcnJlY3RseSB6ZXJvZWQgb3V0IGR1cmluZyBTU0EKPj4gbWln
cmF0aW9uLiBaZXJvaW5nIG91dCB0aGUgbWFpbiBhcmVhIGJsb2NrcyBtYXkgY29ycnVwdCB0aGUK
Pj4gcm9vdCBpbm9kZS4KPj4KPj4gRml4ZXM6IGFkMTM1N2MzNDAyMyAoImYyZnMtdG9vbHM6IHJl
dmVydCBzdW1tYXJ5IGVudHJ5IGNvdW50IGZyb20gMjA0OCB0byA1MTIgaW4gMTZrYiBibG9jayBz
dXBwb3J0IikKPj4gU2lnbmVkLW9mZi1ieTogWWFuZ3lhbmcgWmFuZyA8emFuZ3lhbmd5YW5nMUB4
aWFvbWkuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+
IFRoYW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCg==
