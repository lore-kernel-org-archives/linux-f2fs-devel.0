Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D081C5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:00:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1reVue-0007D3-Cn;
	Mon, 26 Feb 2024 08:00:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1reVuc-0007Cv-IT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 08:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hm3tr1syRrmHLKyQSIHwClxkXUP8u6fHCsfEqHE7DJ0=; b=bvTWPDTz19CxLKjPWEs44euAdH
 5KdwZwfirJZYaqAIdd8jOySc2gCjS3j4tRZkNMo1vTA8sIzDPLbZSrY0Lh0MvSutYpSHyfIWVL7eF
 cPtY47/XflGgt3e1el3ybeZkiUucpYjiR8uj15I2VP/pDF4Qd3iZ+6IvkMwmxf/Nzt1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hm3tr1syRrmHLKyQSIHwClxkXUP8u6fHCsfEqHE7DJ0=; b=GT5yqEFY6MfygRpfRCVv96Flob
 Hh7s/pRVPehKFuzC1Jk0nTTv8sP33UCyrV5E3ZjHu4q9o+a6fIrT4tkMOidQfEa+gXtqyH3WzRXNh
 eQHW9pCsV4vh1lLv1VpSoC2G9wk2Knkl8fsShYtWZV/IntsyHap4gMVcUus0C0/Ts/l4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1reVuY-0003ug-Ln for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 08:00:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3F6CC60F3C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Feb 2024 08:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBAC433C7;
 Mon, 26 Feb 2024 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708934424;
 bh=KaztjbJAu9AA6Q3r1wg6HIlBYGMJFuoPY5mQkV5N21k=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=LB+Md4fLk5a+tZj4Cuk9L8p08jvlDFgOEN2C2kA0a0llhHm/Aqp3b4x8wuHM/QM08
 5O9o6u9GHSeJyMqU3HxQiRyzjJmWu8yjTIqGAJRWqNJ/qs02tNySL95sOcqRaTHh7K
 y1HHy/KxQ8+jWQil+rd0MlR+BRfdZ54/fyb3g1lQvM/Va6cv+yWoev8WIpR90hLCeU
 d2VLdiEPUKJbhL1/JVKKkQqMZPgQjnFQFG5gR/hKGcYRDJGgTBe4dVWiT0Hp7yfz2k
 OQoNXz1poousLfzPi64o9ea9YmUckyCgWzks8jT9YlugO77IHaJnBt7+NvcBhuDWCe
 23IBhMPWv2RPg==
Message-ID: <23aa8351-e002-4185-89c7-ccde6b5b0549@kernel.org>
Date: Mon, 26 Feb 2024 16:00:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240206032513.2495025-1-chao@kernel.org>
 <ZcQd3DtIpiA5P9DQ@google.com>
 <8e69aa15-9779-4696-98ab-f173666a87a7@kernel.org>
In-Reply-To: <8e69aa15-9779-4696-98ab-f173666a87a7@kernel.org>
X-Headers-End: 1reVuY-0003ug-Ln
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return EIO when reading after
 device removal
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

QW55IGNvbW1lbnRzPwoKVGhhbmtzLAoKT24gMjAyNC8yLzE5IDExOjEzLCBDaGFvIFl1IHdyb3Rl
Ogo+IE9uIDIwMjQvMi84IDg6MTgsIEphZWdldWsgS2ltIHdyb3RlOgo+PiBPbiAwMi8wNiwgQ2hh
byBZdSB3cm90ZToKPj4+IGdlbmVyaWMvNzMwIDJzIC4uLiAtIG91dHB1dCBtaXNtYXRjaCAoc2Vl
IC9tZWRpYS9mc3Rlc3RzL3Jlc3VsdHMvL2dlbmVyaWMvNzMwLm91dC5iYWQpCj4+PiDCoMKgwqDC
oCAtLS0gdGVzdHMvZ2VuZXJpYy83MzAub3V0wqDCoMKgIDIwMjMtMDgtMDcgMDE6Mzk6NTEuMDU1
NTY4NDk5ICswMDAwCj4+PiDCoMKgwqDCoCArKysgL21lZGlhL2ZzdGVzdHMvcmVzdWx0cy8vZ2Vu
ZXJpYy83MzAub3V0LmJhZMKgwqDCoCAyMDI0LTAyLTA2IDAyOjI2OjQzLjAwMDAwMDAwMCArMDAw
MAo+Pj4gwqDCoMKgwqAgQEAgLTEsMiArMSBAQAo+Pj4gwqDCoMKgwqDCoCBRQSBvdXRwdXQgY3Jl
YXRlZCBieSA3MzAKPj4+IMKgwqDCoMKgIC1jYXQ6IC06IElucHV0L291dHB1dCBlcnJvcgo+Pj4g
wqDCoMKgwqAgLi4uCj4+PiDCoMKgwqDCoCAoUnVuICdkaWZmIC11IC9tZWRpYS9mc3Rlc3RzL3Rl
c3RzL2dlbmVyaWMvNzMwLm91dCAvbWVkaWEvZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmljLzczMC5v
dXQuYmFkJ8KgIHRvIHNlZSB0aGUgZW50aXJlIGRpZmYpCj4+PiBSYW46IGdlbmVyaWMvNzMwCj4+
PiBGYWlsdXJlczogZ2VuZXJpYy83MzAKPj4+IEZhaWxlZCAxIG9mIDEgdGVzdHMKPj4+Cj4+PiBU
aGlzIHBhdGNoIGFkZHMgYSBjaGVjayBjb25kaXRpb24gaW4gZjJmc19maWxlX3JlYWRfaXRlcigp
IHRvCj4+PiBkZXRlY3QgY3BfZXJyb3Igc3RhdHVzIGFmdGVyIGRldmljZSByZW1vdmFsLCBhbmQg
cmV0cnVybiAtRUlPCj4+PiBmb3Igc3VjaCBjYXNlLgo+Pgo+PiBDYW4gd2UgY2hlY2sgZGV2aWNl
IHJlbW92YWw/Cj4gCj4gV2UgY2FuIHVzZSBibGtfcXVldWVfZHlpbmcoKSB0byBkZXRlY3QgZGV2
aWNlIHJlbW92YWwsIGJ1dCwgSU1PLCBkZXZpY2UKPiByZW1vdmFsIGNhbiBhbG1vc3Qgbm90IGhh
cHBlbiBpbiBBbmRyb2lkLCBub3Qgc3VyZSBmb3IgZGlzdHJvcyBvciBzZXJ2ZXIsCj4gZG8geW91
IHdhbnQgdG8gYWRkIHRoaXMgY2hlY2sgY29uZGl0aW9uIGludG8gZjJmc19jcF9lcnJvcigpPwo+
IAo+IFRoYW5rcywKPiAKPj4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvQGtl
cm5lbC5vcmc+Cj4+PiAtLS0KPj4+IMKgIGZzL2YyZnMvZmlsZS5jIHwgMyArKysKPj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJm
cy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+Pj4gaW5kZXggNDViN2UzNjEwYjBmLi45ZTQzODZk
NDE0NGMgMTAwNjQ0Cj4+PiAtLS0gYS9mcy9mMmZzL2ZpbGUuYwo+Pj4gKysrIGIvZnMvZjJmcy9m
aWxlLmMKPj4+IEBAIC00NDYyLDYgKzQ0NjIsOSBAQCBzdGF0aWMgc3NpemVfdCBmMmZzX2ZpbGVf
cmVhZF9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKPj4+IMKg
wqDCoMKgwqAgY29uc3QgbG9mZl90IHBvcyA9IGlvY2ItPmtpX3BvczsKPj4+IMKgwqDCoMKgwqAg
c3NpemVfdCByZXQ7Cj4+PiArwqDCoMKgIGlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9yKEYyRlNf
SV9TQihpbm9kZSkpKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTzsKPj4+ICsKPj4+
IMKgwqDCoMKgwqAgaWYgKCFmMmZzX2lzX2NvbXByZXNzX2JhY2tlbmRfcmVhZHkoaW5vZGUpKQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4+IC0tIAo+Pj4gMi40
MC4xCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
