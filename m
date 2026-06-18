Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A35CD98ED
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZ0zes9IN+NMUzXAz+3fUzd9wB9gRR49jZnqLM3phQY=; b=Xuv8XnEnTXfyMFsG+c+KzRCBpp
	YONhJ/wqCd3dvgcUQEFsysf0TPFM9oxgtSAUm4BylLDkB4wd66vDChVJBa4yqGqvfJTZU8Gu47Qr3
	wVqy+PGFM3n2Qtx800ln8dmRWopYxT7X+B5V5OytAXZLYE0fw4TyDTsTkbH+zHChIhoM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wa8m4-0000BP-Ua;
	Thu, 18 Jun 2026 09:11:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wa8m3-0000BJ-O5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 09:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mu/5JeWg9wGgtcFG3wqOUM31ha/q1C3fppjlkFjuvrM=; b=JL65Na4md6WIIg0kfsSYx/YUnb
 1hiA3PZgrJbz28DmazCW0g5Xiiy2EdRK9UuwCYJT9IY88gjRmLXDKgQemrBO+mHYhRUAOL82W1Oe9
 jrg9L16tzPecwY+tb0223xz/wSnzbf781cH50FzAwXoVdQ4Ng1+8BXO2MnmaToKbtHXE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mu/5JeWg9wGgtcFG3wqOUM31ha/q1C3fppjlkFjuvrM=; b=fi9Oj9GD3FjwZQ7+wvf/BI4wJY
 lphRRgTXhgxpNAKE/k5wMq4C1ntcMC8eSWhN2oXgqFOgIMU1aag6FDn8dW69jK71mBnuOQlgoE083
 90UxTaOdAnaospYXLDc4uuAyzrrFBLd+WHYEAbfbwmgXuaOpc38WuIgqBigwt81/qEhA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wa8lz-0000iW-OJ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 09:10:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8E7243F39;
 Thu, 18 Jun 2026 09:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C61F000E9;
 Thu, 18 Jun 2026 09:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781773845;
 bh=Mu/5JeWg9wGgtcFG3wqOUM31ha/q1C3fppjlkFjuvrM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=a8TmQdOYEc4RG5qU7fTNKbdi7+JVCHqvfQi28aKRCmj9NjgicMpKs16bt4EFCkbvJ
 r/oC+canvKL7VyqAsYOsJS+loTIdQJZZ5AgPG6GjxUhHBzZ2vRi0SvjhLpzHkzp3wg
 Exs+xvy76ecw/Y82iuGTHV5u7nHmU67s5NOAZ4Gv3dPXYDUL4azztSgzZZyqgDiYj4
 5Nhxkzx8Pw1nZT3Zan9LXm7XUPPKP0skBrSFCGND+0oSV5FMHHRsh62cj2f/xmIt38
 uZDJEquEkf+UTEZfU9WuL0v4gJtoHViL+GquJ5IwOmlSFhbuH8KlqngmBLCaoiEA5E
 JmYGzOdBA7g4Q==
Message-ID: <0d161878-6602-4bbb-b1db-754f4a37a011@kernel.org>
Date: Thu, 18 Jun 2026 17:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
 <ajLi3nLqyS31Y6J4@google.com>
 <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com>
X-Headers-End: 1wa8lz-0000iW-OJ
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for
 cp_wait wakeup
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
Cc: geoo115@gmail.com, yangyongpeng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNi8xOC8yNiAxMTozOCwgV2VuamllIFFpIHdyb3RlOgo+ICAgIFRoZSByYWNlIGlzIGJldHdl
ZW4gZGVjX3BhZ2VfY291bnQoKSBhbmQgdGhlIGxhdGVyIGdldF9wYWdlcygpIGNoZWNrOgo+ICAg
IGFub3RoZXIgQ1AtZGF0YSB3cml0ZWJhY2sgY2FuIGJlIHN1Ym1pdHRlZCBhZnRlciB0aGUgY291
bnRlciByZWFjaGVzIHplcm8KPiAgICBidXQgYmVmb3JlIGdldF9wYWdlcygpIG9ic2VydmVzIGl0
LCBzbyB0aGUgemVybyB0cmFuc2l0aW9uIG1heSBtaXNzIHRoZQo+ICAgIGNwX3dhaXQgd2FrZXVw
LgoKQ2FuIHlvdSBkZXNjcmliZSByYWNlIGNvbmRpdGlvbiBsaWtlIGJlbG93IGNhbGx0cmFjZT8g
d2hpY2ggd2lsbCBiZSBlYXNpZXIgdG8KdW5kZXJzdGFuZD8KCiAgICAgbG9vcCBkZXZpY2UgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVtb3VudAogICAgIC0gd29ya2VyX3RocmVhZAogICAg
ICAtIGxvb3BfcHJvY2Vzc193b3JrCiAgICAgICAtIGRvX3JlcV9maWxlYmFja2VkCiAgICAgICAg
LSBsb19yd19haW8KICAgICAgICAgLSBsb19yd19haW9fY29tcGxldGUKICAgICAgICAgIC0gYmxr
X21xX2VuZF9yZXF1ZXN0CiAgICAgICAgICAgLSBibGtfdXBkYXRlX3JlcXVlc3QKICAgICAgICAg
ICAgLSBmMmZzX3dyaXRlX2VuZF9pbwogICAgICAgICAgICAgLSBkZWNfcGFnZV9jb3VudAogICAg
ICAgICAgICAgLSBmb2xpb19lbmRfd3JpdGViYWNrCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0ga2lsbF9mMmZzX3N1cGVyCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtIGtpbGxfYmxvY2tfc3VwZXIKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGYyZnNfcHV0X3N1cGVyCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGZyZWUoc2JpKQogICAg
ICAgICAgICA6IGdldF9wYWdlcygsIEYyRlNfV0JfQ1BfREFUQSkKICAgICAgICAgICAgICBhY2Nl
c3NlZCBzYmkgd2hpY2ggaXMgZnJlZWQKClRoYW5rcywKCj4gCj4gICAgdjYgYWxzbyBhZGRzIGRl
Y19wYWdlX2NvdW50X3JldHVybigpIGFuZCB1c2VzIGl0IGluc3RlYWQgb2YgYWNjZXNzaW5nCj4g
ICAgbnJfcGFnZXMgZGlyZWN0bHkuICBUaGUgd2FrZXVwIGxvZ2ljIGlzIHVuY2hhbmdlZCBmcm9t
IHY1Lgo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvMjAyNjA2
MTgwMzEwMDguMjQ0NzI3OS0xLXFpd2VuamllQHhpYW9taS5jb20vVC8jdQo+IAo+IE9uIFRodSwg
SnVuIDE4LCAyMDI2IGF0IDI6MDnigK9BTSBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3Jn
PiB3cm90ZToKPj4KPj4gT24gMDYvMTYsIFdlbmppZSBRaSB3cm90ZToKPj4+IGYyZnNfd3JpdGVf
ZW5kX2lvKCkgZGVjcmVtZW50cyB0aGUgd3JpdGViYWNrIHBhZ2UgY291bnRlciBhbmQgdGhlbgo+
Pj4gcmVhZHMgaXQgYWdhaW4gd2l0aCBnZXRfcGFnZXMoKSB0byBkZWNpZGUgd2hldGhlciB0aGUg
bGFzdAo+Pj4gRjJGU19XQl9DUF9EQVRBIGNvbXBsZXRpb24gc2hvdWxkIHdha2UgY3Bfd2FpdC4K
Pj4+Cj4+PiBVc2UgYXRvbWljX2RlY19yZXR1cm4oKSBmb3IgRjJGU19XQl9DUF9EQVRBIGNvbXBs
ZXRpb25zIHNvIHRoZSB3YWtldXAKPj4+IGRlY2lzaW9uIGlzIG1hZGUgZnJvbSB0aGUgdmFsdWUg
cHJvZHVjZWQgYnkgdGhlIGRlY3JlbWVudCBpdHNlbGYuIEtlZXAKPj4+IHRoZSBleGlzdGluZyBk
ZWNfcGFnZV9jb3VudCgpIHBhdGggZm9yIG90aGVyIHdyaXRlYmFjayBjb3VudGVycy4KPj4KPj4g
SXMgdGhlcmUgYSByYWNlIGNvbmRpdGlvbiB0byBkbyB0aGlzPyBJZiBzbywgY2FuIHlvdSBkZXNj
cmliZT8gQW5kLCBJIHRoaW5rCj4+IHdlIG5lZWQgYSB3cmFwcGVyIGZ1bmN0aW9uIGluc3RlYWQg
b2YgY2FsbGluZyBucl9wYWdlcyBkaXJlY3RseS4KPj4KPj4+Cj4+PiBGaXhlczogZTIzNDA4ODc1
OGZjICgiZjJmczogYXZvaWQgd2FpdCBpZiBJTyBlbmQgdXAgd2hlbiBkb19jaGVja3BvaW50IGZv
ciBiZXR0ZXIgcGVyZm9ybWFuY2UiKQo+Pj4gRml4ZXM6IGNlMjczOWU0ODJiYyAoImYyZnM6IGZp
eCB0byBhdm9pZCBVQUYgaW4gZjJmc193cml0ZV9lbmRfaW8oKSIpCj4+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwo+Pj4gU2lnbmVkLW9mZi1ieTogV2VuamllIFFpIDxxaXdlbmppZUB4aWFv
bWkuY29tPgo+Pj4gLS0tCj4+PiAgIGZzL2YyZnMvZGF0YS5jIHwgMTIgKysrKysrKy0tLS0tCj4+
PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPj4+IGluZGV4
IGQ4M2EyMTk5OGVjMi4uNThkMjNlYjc0ZWMyIDEwMDY0NAo+Pj4gLS0tIGEvZnMvZjJmcy9kYXRh
LmMKPj4+ICsrKyBiL2ZzL2YyZnMvZGF0YS5jCj4+PiBAQCAtMzkyLDE1ICszOTIsMTcgQEAgc3Rh
dGljIHZvaWQgZjJmc193cml0ZV9lbmRfaW8oc3RydWN0IGJpbyAqYmlvKQo+Pj4gICAgICAgICAg
ICAgICAgaWYgKGYyZnNfaW5fd2FybV9ub2RlX2xpc3QoZm9saW8pKQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICBmMmZzX2RlbF9mc3luY19ub2RlX2VudHJ5KHNiaSwgZm9saW8pOwo+Pj4KPj4+
IC0gICAgICAgICAgICAgZGVjX3BhZ2VfY291bnQoc2JpLCB0eXBlKTsKPj4+IC0KPj4+ICAgICAg
ICAgICAgICAgIC8qCj4+PiAgICAgICAgICAgICAgICAgKiB3ZSBzaG91bGQgYWNjZXNzIHNiaSBi
ZWZvcmUgZm9saW9fZW5kX3dyaXRlYmFjaygpIHRvCj4+PiAgICAgICAgICAgICAgICAgKiBhdm9p
ZCByYWNpbmcgdy8ga2lsbF9mMmZzX3N1cGVyKCkKPj4+ICAgICAgICAgICAgICAgICAqLwo+Pj4g
LSAgICAgICAgICAgICBpZiAodHlwZSA9PSBGMkZTX1dCX0NQX0RBVEEgJiYgIWdldF9wYWdlcyhz
YmksIHR5cGUpICYmCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3cV9oYXNfc2xl
ZXBlcigmc2JpLT5jcF93YWl0KSkKPj4+IC0gICAgICAgICAgICAgICAgICAgICB3YWtlX3VwKCZz
YmktPmNwX3dhaXQpOwo+Pj4gKyAgICAgICAgICAgICBpZiAodHlwZSA9PSBGMkZTX1dCX0NQX0RB
VEEpIHsKPj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoIWF0b21pY19kZWNfcmV0dXJuKCZz
YmktPm5yX3BhZ2VzW3R5cGVdKSAmJgo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICB3cV9o
YXNfc2xlZXBlcigmc2JpLT5jcF93YWl0KSkKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHdha2VfdXAoJnNiaS0+Y3Bfd2FpdCk7Cj4+PiArICAgICAgICAgICAgIH0gZWxzZSB7Cj4+
PiArICAgICAgICAgICAgICAgICAgICAgZGVjX3BhZ2VfY291bnQoc2JpLCB0eXBlKTsKPj4+ICsg
ICAgICAgICAgICAgfQo+Pj4KPj4+ICAgICAgICAgICAgICAgIGZvbGlvX2NsZWFyX2YyZnNfZ2Np
bmcoZm9saW8pOwo+Pj4gICAgICAgICAgICAgICAgZm9saW9fZW5kX3dyaXRlYmFjayhmb2xpbyk7
Cj4+Pgo+Pj4gYmFzZS1jb21taXQ6IGMwYjY1ZjYxMjljN2ZiYjUyNmU5MjFkZDYwMjYxNjUwZjFi
MmJlZjkKPj4+IC0tCj4+PiAyLjQzLjAKPj4+Cj4+Pgo+Pj4KPj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdAo+Pj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4+IGh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
