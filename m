Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D51AC98318
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6TzK3wheok53IhFcctsSXvdNpVemw4q/NxRsv8yXqBw=; b=hnIfaNBFnYDxTR8WgKKVI6uW3s
	dFw42ZxxlpMFCF6IB5pozUVcIoi69vbJIH8u9+Fgtl1rAhfT0GZ0oWcGiYkaqPP6uWM+HfHKGl7RE
	NqjAfMw9wJ8MEPD619QUgL2SM4H3w6Fo+tMJJyDldgDn6ZUW7doo8MTezYLichQkUzb0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9lZZ-0004dU-I6;
	Thu, 24 Sep 2026 15:41:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x9lZY-0004dN-70
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 15:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qWxD79vUZyai/sHOLSDW1n6nwDIj4zL5Fu4g5Vd8VLA=; b=S1sG5/aVd4Dll2G3Z9doqJDJeQ
 zBfec10SovZw8ir/pRXRLvuzXdfo9LFFnOYhRhuRGQGw9DsVi3dGU4vgD9lRHTbH8vrL5a0+5RvXk
 4Q7I4q55bN7kNvxKrO3qF/SkpRhGkCd/6/23AVc0u8XvKjPS8wKdeiQ0etDfrZr6qamE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qWxD79vUZyai/sHOLSDW1n6nwDIj4zL5Fu4g5Vd8VLA=; b=Ja8qvElt9y4RArCzwUwQ6h1mlg
 COoZQe8wS+yxAb/8NLbT43Kz/ftIBdisvWAQHRz1B0neqHTluxfXBZrFObUvU/X7b/akOwI4fcvmc
 gZqXhDgSjRzCobFx0Z2Hf9PDMXsWiaUiEB+EX7sHotQ1LuuvX8Vs6ZMn0g/nw38hJCe0=;
Received: from mail-pj2-f13.google.com ([74.125.227.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9lZV-0004Ub-BM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 15:41:17 +0000
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so11889255ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 08:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264471; cv=none;
 d=google.com; s=arc-20260327;
 b=RE98CUMLpP/yeVkQp2M7xkSYhfLO08D98c058YJKQn+dJQ3PhICUCGgJCtebqcW4cb
 W8Uj3I6pAtlxt+9eatoTmIhYbcagRyqnpNwXN2qJpmlihbH3ZKqES3vF6k47vumxvxN0
 RmMNNQvBiz/fQf8ZEO4hXW4pi8GX/T1HvG4P2dO5dHy/IJFGOvoaTv1PT8d0VsOssfX+
 CzVPqh8NMdrIl+JZvWoTvrfD9pnaIt7kWihmsC0WF4w73I7BN0YNnqdimbAxOLitv9e9
 5jgL5CW0dSX4ccbwTHc3J3KSM2LPv7zdcOhxhDiGZDyWK/2UfexWGWEk+tkkipj7mHMd
 A7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qWxD79vUZyai/sHOLSDW1n6nwDIj4zL5Fu4g5Vd8VLA=;
 fh=3q4QjP3gCZU58QhDLLFIHIOZARsbt0Q0BZlHU7goaYQ=;
 b=iTYFIgyWch6MzNAf3df0+lGToLXxYol4ypHhpow0lELfF+sdp5wARe7Nuvs9MHPgjt
 lT35keq3xei3nyyUTmIhtwrFq8gGDRubTXyWsXeuktsxUo9cOjWXh4HDPQWsbSJOzMSI
 8orDD8qfuy7zVuzuBjbFwWueKKO2176NeW+SWTngYt+JYNncL/eoXbvw2/2E+d5IoFoG
 xa7Q7qS+xjxQ7t2Q9LOWV3BVMhaf952ewwBgnWZU8zD75EgIiB98yiNz6uIny88Fccgd
 Vgcqr2scg2kcFdr7O91DL14ps0OsTQSiAlDl5YK0yac/527FmFCVDmDkBfbTnZ4Vkl0F
 eIIQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790264471; x=1790869271; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qWxD79vUZyai/sHOLSDW1n6nwDIj4zL5Fu4g5Vd8VLA=;
 b=ShUEK8XRJS5hE0rQF4BVsaHI6XTVhUl4pig+EAOQDoQiQVmFXlBnQqk6obqpw0aeAj
 1M8tqqCscQn4RGgx0L3zPlBtPNtJRPytQNoJYg0lDSFgavzLfkQMrjkJCW6o2H6y08tP
 13zGcr/17hxBUFub/esIQRu83o5IveW5cUrnMcRN6Ny8QwIdYDpHy6MbatKAis5Vg8/S
 3eVdEkrwgaDMK5dEH+X3JjEO4Jra53RHKVrGiVuKfQUSn2jjitL1v/7JRoJqrpe4/mwV
 LSNJp9EXCovUgbh79klmIn1/J1DJ0lDoWjqdrFiNdrLDFWdG5iwoNk3EvTdAvwypgS+5
 fT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790264471; x=1790869271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qWxD79vUZyai/sHOLSDW1n6nwDIj4zL5Fu4g5Vd8VLA=;
 b=0eW1mKARp0M2YY3UiJyvYJjAthH39NLKqVgzg1OfyxwyFFd5RQqHBMW+iJVjs2GIE7
 q3ko3XGOVtJ1hjgqhZKxlaaEnIUEROwDmDtrcv0DLRZFDQcgm8ygRN3Nii/dTA8AGdFz
 cxW3EbTPeg2SJise/WpfIen7NbyxIxiRslS9dGEVS2f0pelP3DaWdVK2Kht6M8tuypuK
 dRhyU6hUMKoEET0OKsIYt3KIEz0Z60bBHUsN60/RDSeoNxqZLxCdER7aA1a70R324Tgy
 DkOaemEhqJ9zhxKLb2iHGc9myEOmuQPBcGSWJS6tM6IeOkiWsv4XECC+LBMUC451bX4m
 zEkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCHMZN0vbkV23lTDH07wxk5zy2NBK8OLnke0Rui9jk+S2qS9cpMVHiU5l5ZonHaoS0rMeyO4MwPJ/xpHEDWBA/@lists.sourceforge.net
X-Gm-Message-State: AFuF++nRiSuDX/t0+kZrMx2I4mKCjGQFy7U9I/q8Q32Z1NcYrumojCGT
 IroldncsP1YY41e9WcZUJ4k71eHH07rpWxJCY4vZMAHF/pTm9b0PgzOqaBgJoz4tsFkeRMS/ypQ
 PFT75/eM4H9b7Ci0etRQoMdI+EkzxklE=
X-Gm-Gg: AYBFou1D/MtrwHbuWBPjWtnadvhIYBeNooodii1zrmp+MiB/D50vaz17fZqxz9PSnAe
 wR+0aobu31f1+7Thoj3Cw90WD66nw07GEQAV31BPcp+cHTBOpO+NmmvE6R49+NosQgtxirp4Sgn
 99jxBPhChew9GtfOrxvIoQpGhER6squWCUY/mlF5rDWUdgX5ixO9ZnH7LJdCD7UIA+fXk4yEKyH
 xqWfKgPdrA+RfRl4qAmlAJvohVdOqg7zH7fBp8DfQ/D8QrEuMIhE8PRQ5BTtr4NtD69fv51zTgK
 VNU9jr4XYjNioSDG8ozFMMv9yVXgslZI2gjXOagv80lu6L+ATC3jtimI5+xPkIDX1vvNZx//XJS
 IdJ26+XUK2RqL5OambJLQClQL0WdkG19BUzKGFLpHcA==
X-Received: by 2002:a17:903:19f0:b0:2df:8e69:1d5a with SMTP id
 d9443c01a7336-2df8e693622mr2471525ad.21.1790264466896; Thu, 24 Sep 2026
 08:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_xP_xNt8km5rxEC1-eiBpm83AK6=m+p_N5GK7H+Djj68A@mail.gmail.com>
 <20260924061641.2188583-1-ke.li11@transsion.com>
In-Reply-To: <20260924061641.2188583-1-ke.li11@transsion.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 24 Sep 2026 08:40:52 -0700
X-Gm-Features: AclHuK9aULfwvuC7xEdFKq4YLzoolxuuv2LxUlvQG8v9UztUnsBH5Ipy65sl_Y4
Message-ID: <CACOAw_ycqEb8Nov_rVa2W=GL6=8hiLju4AnALJJ=7hvW_sc_Sw@mail.gmail.com>
To: =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
X-Headers-End: 1x9lZV-0004Ub-BM
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
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgS2UsCgpJIHN0aWxsIGRvbid0IHNlZSB3aHkgYSBzZXBhcmF0ZSBGMkZTIHNlY29uZGFyeSBk
ZXZpY2UgbXVzdCBiZSBhdHRhY2hlZAphbmQgdGhlbiBjb21wbGV0ZWx5IGRldGFjaGVkLCBvciB3
aHkgdGhlIHJlY2xhaW1lZCBzcGFjZSBuZWVkcyB0byBiZQpwaHlzaWNhbGx5IGNvbnRpZ3VvdXMg
d2l0aCB0aGUgc3VwZXIgcGFydGl0aW9uLgoKV2l0aCBkbS1saW5lYXIsIHlvdSBjYW4gdXNlIGEg
c2luZ2xlLWRldmljZSBGMkZTIG9uIHVzZXJkYXRhIHdpdGgKcmVzaXphYmxlX3RhaWxfc2Vjbm8s
IHNocmluayB0aGUgdGFpbCB2aWEgc3RhbmRhcmQgZjJmc19yZXNpemVfZnMoKSwKYW5kIHRoZW4g
c2ltcGx5IGNvbmNhdGVuYXRlIHRoZSByZWNsYWltZWQgcGh5c2ljYWwgYmxvY2sgcmFuZ2Ugd2l0
aCB0aGUKZXhpc3Rpbmcgc3VwZXIgcGFydGl0aW9uIHVzaW5nIGEgZG0tbGluZWFyIHRhcmdldC4g
QmVjYXVzZSBkbS1saW5lYXIKbWFwcyBub24tY29udGlndW91cyBwaHlzaWNhbCBleHRlbnRzIGlu
dG8gYSBzaW5nbGUgbG9naWNhbCBibG9jayBkZXZpY2UsCnBoeXNpY2FsIGFkamFjZW5jeSB0byBz
dXBlciBpbiB0aGUgcGFydGl0aW9uIHRhYmxlIGlzIG5vdCByZXF1aXJlZCwgbm9yCmlzIHRoZXJl
IGEgbmVlZCB0byBtYWludGFpbiB0d28gc2VwYXJhdGUgZW5jcnlwdGlvbiBrZXlzIGFjcm9zcyB0
d28KRjJGUyBkZXZpY2VzLiBFdmVuIGlmIGEgc2Vjb25kIHBhcnRpdGlvbiBpcyB1c2VkLCB5b3Ug
Y2FuIGhhbmQgb3ZlciB0aGUKc2hydW5rIHNwYWNlIHRvIHN1cGVyIHZpYSBkbS1saW5lYXIgd2l0
aG91dCBuZWVkaW5nIHRvIGNvbXBsZXRlbHkgZHJvcAp0aGUgc2Vjb25kYXJ5IGRldmljZSBmcm9t
IEYyRlMuCgpTaW5jZSB0aGlzIHVzZSBjYXNlIGNhbiBiZSBjbGVhbmx5IGhhbmRsZWQgdXNpbmcg
ZXhpc3RpbmcgRjJGUyBtZWNoYW5pc21zCihyZXNpemFibGVfdGFpbF9zZWNubyBhbmQgc3RhbmRh
cmQgcmVzaXplKSBjb21iaW5lZCB3aXRoIGRtLWxpbmVhciBpbgp1c2Vyc3BhY2UsIEkgZG9uJ3Qg
dGhpbmsgd2Ugc2hvdWxkIGFkZCBhIG5ldyBtb3VudCBvcHRpb24gYW5kIGRldmljZQpkZXRhY2ht
ZW50IGxvZ2ljIHRvIEYyRlMgZm9yIHRoaXMgc3BlY2lmaWMgbGF5b3V0LgoKVGhhbmtzLApEYWVo
bwoKT24gV2VkLCBTZXAgMjMsIDIwMjYgYXQgMTE6MTbigK9QTSDmnY7nj4IxMSA8a2UubGkxMUB0
cmFuc3Npb24uY29tPiB3cm90ZToKPgo+IEhpIERhZWhvLAo+Cj4gVGhyZWUgcG9pbnRzIG9uIHRo
aXMgc2VyaWVzOgo+Cj4gMS4gUGF0Y2ggMSBjYW4gYmUgZG9uZSB3aXRoIHJlc2l6YWJsZV90YWls
X3NlY25vLCBzbyB0aGF0IHBhdGNoIGRvZXMgbm90Cj4gICAgbmVlZCB0byBiZSBtZXJnZWQuCj4K
PiAyLiBEeW5hbWljIGRldmljZSBhbGlhc2luZyBkb2VzIG5vdCBmaXQgdGhpcyB1c2UgY2FzZS4g
QWZ0ZXIgcmVzZXJ2ZSwgdGhlCj4gICAgc3BhY2Ugc3RheXMgb24gdGhlIHNlY29uZGFyeSBkZXZp
Y2UgYW5kIGNhbm5vdCBiZSB1c2VkIGJ5IHRoZSBBbmRyb2lkCj4gICAgc3VwZXIgcGFydGl0aW9u
Lgo+Cj4gMy4gUGF0Y2ggMiBpcyBzdGlsbCBuZWNlc3NhcnkuIEl0IGNvdmVycyB0aGUgcmVzaXpl
IGJvdW5kYXJ5IGluIHRoZQo+ICAgIG11bHRpLWRldmljZSBjYXNlOiBvbmNlIHRoZSBzaHJpbmsg
ZHJvcHMgdGhlIGxhc3Qgc2Vjb25kYXJ5IGRldmljZSwKPiAgICBGMkZTIGNsZWFycyB0aGF0IGRl
dmljZSdzIG9uLWRpc2sgcGF0aCBhbmQgZGV0YWNoZXMgaXQuCj4KPiBUaGFua3MsCj4gS2UgTGkK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1m
MmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCg==
