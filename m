Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77595FF8861
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GwZX81NdQRpnTuMdTaApIUyGH+dU5Koit6zQDLSqZnU=; b=jp3YzrwI2VcMxm8O4gjRtGxkpx
	mOxHbAoDgclFku6woLC90nCU4ptoFDIqznGbP/4wLhwq/WrNYHdjt7it2mwDjsOzvHsQYW4j3SUoD
	sJXdIDwWgY+1r9TAcdj0JqnPMGBoOc6Ty0rXN71Er2iipxWDHhq41g2piddoKZkLen0k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHGXv-0005lW-HX;
	Mon, 27 Apr 2026 07:38:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wHGXu-0005lP-CV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 07:38:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9s4/+LCDpd3Ro1X/FNv0rCNdDLF0vI2Pn5JKCLAS7vI=; b=mu7FiVMmMAGb1NTIy7EVgtJUsU
 zRdAiWdpGYN247vlT6Sb8fq61aTtyLnHNI+E7xxkkXO2fWn3p8qQlke0+2fHksR7Hv1JEM0Who0Ee
 hrvOJ3Khk5WSdNm340jdBOGY0GSh8h89dJFmedjz66Lrhkiv/yWgJ1Djk5uYG/lg4GXk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9s4/+LCDpd3Ro1X/FNv0rCNdDLF0vI2Pn5JKCLAS7vI=; b=CugV+uuFciu3yyBEOqpq5ip4St
 zL/IrGRoJq9QbEvOY46IEcEH8u5HdBHOOSh73aVBqb0+/vkx9lNlGIfu/hhF0sk8xuWpX2542GQjv
 7GesNRTUdnDmmHoOZhDfnwOi022uSkHENFa89f7//qkFNw04cqKI2LT3mzueqrIWSl4c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHGXu-0003nd-KW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 07:38:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FA4140201;
 Mon, 27 Apr 2026 07:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB71C19425;
 Mon, 27 Apr 2026 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777275497;
 bh=aGc8FNBDqefHeaRp2lzT5Pr9RmzOIch4aJ8kcMZPXQg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=TwEJEVGaZLtSy1HPXGx+tgFmcMqn6wQDdgEa3YGzJ4YZ+6/OuCJZ0JcN6bp90iwy9
 oZ54wC0jAu0/B+3zUuqnYeXsT/Gn6HDRYN4RWssZYSqpWwi9lmHYR/6wW9bQc+4/M8
 I10XoSoehyMJAT2VGi0VTEeJPO2STFH4UiH6VuySm0Zb4FkwOVPbHlDvjdQ7qZ7BEh
 mbD2OY0hI4ponS0CGIj0V26/LO+7Llqs0uaRHkIoMXYGnobOkJdr3Ex33VIqOSlzF9
 fpXA23SvUm03TQwETljTAxYB+T2b38bwFMeS34e+2JGbyT5U3XRv9MPem90UfZHfqj
 dc0P4UE1no7pQ==
Message-ID: <3550618a-4a16-4f1d-b8cb-4d7ff96f6ed7@kernel.org>
Date: Mon, 27 Apr 2026 15:38:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260422073525.2063784-2-monty_pavel@sina.com>
 <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
 <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
Content-Language: en-US
In-Reply-To: <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
X-Headers-End: 1wHGXu-0003nd-KW
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNC8yNC8yNiAxNzo0NSwgWW9uZ3BlbmcgWWFuZyB3cm90ZToKPiAKPiBPbiA0LzIyLzI2IDIw
OjMzLCBDaGFvIFl1IHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOgo+PiBPbiA0LzIyLzIwMjYg
MzozNSBQTSwgWW9uZ3BlbmcgWWFuZyB3cm90ZToKPj4+IEZyb206IHlhbmd5b25ncGVuZyA8eWFu
Z3lvbmdwZW5nQHhpYW9taS5jb20+Cj4+Pgo+Pj4gV2hlbiBfX2Rlc3Ryb3lfZXh0ZW50X25vZGUo
KSBzZXRzIHRoZSBpbm9kZSBmbGFnIEZJX05PX0VYVEVOVCwgaXQgZG9lcwo+Pj4gbm90IHJlc2V0
IHRoZSBsZW5ndGggb2YgdGhlIGxhcmdlc3QgZXh0ZW50IHRvIDAgYW5kIHVwZGF0ZSB0aGUgaW5v
ZGUKPj4+IGZvbGlvLiBTaW5jZSBtb2RpZmljYXRpb25zIHRvIHRoZSBleHRlbnQgdHJlZSBhcmUg
ZGlzYWxsb3dlZCBhZnRlcndhcmQsCj4+PiB0aGUgY2FjaGVkIGxhcmdlc3QgZXh0ZW50IG1heSBi
ZWNvbWUgc3RhbGUuIFRoaXMgY2FuIHRyaWdnZXIgdGhlCj4+PiBmb2xsb3dpbmcgZXJyb3IgaW4g
eGZzdGVzdHMgZ2VuZXJpYy8zODg6Cj4+Pgo+Pj4gRjJGUy1mcyAoZG0tMCk6IHNhbml0eV9jaGVj
a19leHRlbnRfY2FjaGU6IGlub2RlIChpbm89MTc2MSkgZXh0ZW50Cj4+PiBpbmZvIFsyMjAwNTcs
IDU3LCA2XSBpcyBpbmNvcnJlY3QsIHJ1biBmc2NrIHRvIGZpeAo+Pj4KPj4+IEluIHRoZSBmMmZz
X2Ryb3BfaW5vZGUgcGF0aCwgX19kZXN0cm95X2V4dGVudF9ub2RlKCkgZG9lcyBub3QgbmVlZCB0
bwo+Pj4gZ3VhcmFudGVlIHRoYXQgZXQtPm5vZGVfY250IGlzIDAsIGJlY2F1c2UgY29uY3VycmVu
Y3kgd2l0aCB3cml0ZWJhY2sKPj4+IGlzIGV4cGVjdGVkIGluIHRoaXMgcGF0aCwgYW5kIHdyaXRl
YmFjayBtYXkgdXBkYXRlIHRoZSBleHRlbnQgY2FjaGUuCj4+Pgo+Pj4gVGhpcyBwYXRjaCB1cGRh
dGVzIF9fZGVzdHJveV9leHRlbnRfbm9kZSgpIHRvIGF2b2lkIHNldHRpbmcgdGhlIGlub2RlCj4+
PiBmbGFnIEZJX05PX0VYVEVOVCwgYW5kIHRvIHJlbW92ZSB0aGUgY2hlY2sgemVybyBvZiBldC0+
bm9kZV9jbnQuCj4+Pgo+Pj4gRml4ZXM6IGVkNzhhZWViZWYwNSAoImYyZnM6IGZpeCBub2RlX2Nu
dCByYWNlIGJldHdlZW4gZXh0ZW50IG5vZGUKPj4+IGRlc3Ryb3kgYW5kIHdyaXRlYmFjayIpCj4+
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+Pj4gUmVwb3J0ZWQtYnk6IENoYW8gWXUgPGNo
YW9Aa2VybmVsLm9yZz4KPj4+IFN1Z2dlc3RlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogeWFuZ3lvbmdwZW5nIDx5YW5neW9uZ3BlbmdAeGlhb21pLmNv
bT4KPj4+IC0tLQo+Pj4gIMKgIGZzL2YyZnMvZXh0ZW50X2NhY2hlLmMgfCA0IC0tLS0KPj4+ICDC
oCAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZnMv
ZjJmcy9leHRlbnRfY2FjaGUuYyBiL2ZzL2YyZnMvZXh0ZW50X2NhY2hlLmMKPj4+IGluZGV4IDg3
MTY5ZmQyOWQ4OS4uM2FkYmVhZDI3OTUzIDEwMDY0NAo+Pj4gLS0tIGEvZnMvZjJmcy9leHRlbnRf
Y2FjaGUuYwo+Pj4gKysrIGIvZnMvZjJmcy9leHRlbnRfY2FjaGUuYwo+Pj4gQEAgLTY0NSwxNCAr
NjQ1LDEwIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgX19kZXN0cm95X2V4dGVudF9ub2RlKHN0cnVj
dAo+Pj4gaW5vZGUgKmlub2RlLAo+Pj4gIMKgIMKgwqDCoMKgwqAgd2hpbGUgKGF0b21pY19yZWFk
KCZldC0+bm9kZV9jbnQpKSB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRlX2xvY2soJmV0
LT5sb2NrKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoIWlzX2lub2RlX2ZsYWdfc2V0KGlub2Rl
LCBGSV9OT19FWFRFTlQpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0X2lub2RlX2Zs
YWcoaW5vZGUsIEZJX05PX0VYVEVOVCk7Cj4+Cj4+IFdlJ2QgYmV0dGVyIHJldmVydCBhbGwgY2hh
bmdlIGxpbmVzIGluICJmMmZzOiBmaXggbm9kZV9jbnQgcmFjZSBiZXR3ZWVuCj4+IGV4dGVudCBu
b2RlIGRlc3Ryb3kgYW5kIHdyaXRlYmFjayI/Cj4gCj4gVGhlIG90aGVycyBhbGwgY2hlY2sgd2hl
dGhlciBGSV9OT19FWFRFTlQgaXMgc2V0LiBXaGVuIGl0IGlzIHNldCwKPiBpbnNlcnRpbmcgYW4g
YWdlIGV4dGVudCBpcyBkaXNhbGxvd2VkLCBzbyBub3RoaW5nIHdhcyByZW1vdmVkLgoKZGlmZiAt
LWdpdCBhL2ZzL2YyZnMvZXh0ZW50X2NhY2hlLmMgYi9mcy9mMmZzL2V4dGVudF9jYWNoZS5jCmlu
ZGV4IDg3MTY5ZmQyOWQ4OS4uMGVkODRjYzA2NWE3IDEwMDY0NAotLS0gYS9mcy9mMmZzL2V4dGVu
dF9jYWNoZS5jCisrKyBiL2ZzL2YyZnMvZXh0ZW50X2NhY2hlLmMKQEAgLTExOSwxMCArMTE5LDkg
QEAgc3RhdGljIGJvb2wgX19tYXlfZXh0ZW50X3RyZWUoc3RydWN0IGlub2RlICppbm9kZSwgZW51
bSBleHRlbnRfdHlwZSB0eXBlKQogICAgICAgICBpZiAoIV9faW5pdF9tYXlfZXh0ZW50X3RyZWUo
aW5vZGUsIHR5cGUpKQogICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKCi0gICAgICAgaWYg
KGlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBGSV9OT19FWFRFTlQpKQotICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOwotCiAgICAgICAgIGlmICh0eXBlID09IEVYX1JFQUQpIHsKKyAgICAgICAg
ICAgICAgIGlmIChpc19pbm9kZV9mbGFnX3NldChpbm9kZSwgRklfTk9fRVhURU5UKSkKKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgICAgICAgICAgIGlmIChpc19p
bm9kZV9mbGFnX3NldChpbm9kZSwgRklfQ09NUFJFU1NFRF9GSUxFKSAmJgogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIWYyZnNfc2JfaGFzX3JlYWRvbmx5KEYyRlNfSV9TQihpbm9k
ZSkpKQogICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwoKLi4uCgpAQCAtNjkx
LDEyICs2ODgsMTIgQEAgc3RhdGljIHZvaWQgX191cGRhdGVfZXh0ZW50X3RyZWVfcmFuZ2Uoc3Ry
dWN0IGlub2RlICppbm9kZSwKCiAgICAgICAgIHdyaXRlX2xvY2soJmV0LT5sb2NrKTsKCi0gICAg
ICAgaWYgKGlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBGSV9OT19FWFRFTlQpKSB7Ci0gICAgICAg
ICAgICAgICB3cml0ZV91bmxvY2soJmV0LT5sb2NrKTsKLSAgICAgICAgICAgICAgIHJldHVybjsK
LSAgICAgICB9Ci0KICAgICAgICAgaWYgKHR5cGUgPT0gRVhfUkVBRCkgeworICAgICAgICAgICAg
ICAgaWYgKGlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBGSV9OT19FWFRFTlQpKSB7CisgICAgICAg
ICAgICAgICAgICAgICAgIHdyaXRlX3VubG9jaygmZXQtPmxvY2spOworICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47CisgICAgICAgICAgICAgICB9CisKICAgICAgICAgICAgICAgICBwcmV2
ID0gZXQtPmxhcmdlc3Q7CiAgICAgICAgICAgICAgICAgZGVpLmxlbiA9IDA7CgpIbW0sIEknbSBu
b3Qgc3VyZSBJIHVuZGVyc3Rvb2QgeW91IGNvcnJlY3RseSwgaWYgeW91IHdhbnQgdG8ga2VlcCBh
Ym92ZSBjb2Rlcywgd2hhdAphYm91dCBjaGFuZ2luZyBpbiBhbm90aGVyIHBhdGNoIHcvIGNvcnJl
Y3QgY29tbWl0IG1lc3NhZ2U/CgpUaGFua3MsCgoKPiAKPiBUaGFua3MKPiBZb25ncGVuZywKPiAK
Pj4KPj4gVGhhbmtzLAo+Pgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBub2RlX2NudCArPSBfX2Zy
ZWVfZXh0ZW50X3RyZWUoc2JpLCBldCwgbnJfc2hyaW5rKTsKPj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqAgd3JpdGVfdW5sb2NrKCZldC0+bG9jayk7Cj4+PiAgwqDCoMKgwqDCoCB9Cj4+PiAgwqAgLcKg
wqDCoCBmMmZzX2J1Z19vbihzYmksIGF0b21pY19yZWFkKCZldC0+bm9kZV9jbnQpKTsKPj4+IC0K
Pj4+ICDCoMKgwqDCoMKgIHJldHVybiBub2RlX2NudDsKPj4+ICDCoCB9Cj4+PiAgICAKPj4KPj4K
Pj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4g
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKPj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo+IAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
