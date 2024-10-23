Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26489D2E01E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:07:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t3WOa-0002E3-LH;
	Wed, 23 Oct 2024 08:07:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t3WOZ-0002Dx-5c
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Oct 2024 08:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wOYezcsecD4FGbhEstD3xwmP6wqwKPDBoRMID9pnzZM=; b=gRR9XGSUJE5THLZvVb0IvdGlDj
 X5NdeSOrc3PFMnaC4c5PgxEUsUflpRWfRE3VDiNTqtVf7o/Gwnq4osQVio3IZ6tm909qMdirl7Tnw
 2BzolnqV9yetGibjQ7l2TJpQ0r02WxrSHCqpopGJj7o4vE0bcF+scbrVd7WPp09+LQOo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wOYezcsecD4FGbhEstD3xwmP6wqwKPDBoRMID9pnzZM=; b=HYJYEb7lzYdquIIEyH2fhr+5lP
 nxg9iRi3YP3+TA2gIu6IDKv6HDfLndOkVuoQKuyuv3kruvWya/GC4bZsE0S365uZa98Y4zFnqTaVy
 qSpjtNUI5POn8moHUdrxCIRM84jUv7rScIURLNp5RM25wF9NykfKf4dty460zH8bLPTg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t3WOY-00023p-Ax for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Oct 2024 08:07:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6EEBA5C588F;
 Wed, 23 Oct 2024 08:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021EC4CEC6;
 Wed, 23 Oct 2024 08:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729670820;
 bh=BrPGJSsFR50m0x0nz9fvVLzKZkp6YxV1ErfJzYmZ32s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Bf2bOZz8gcBBmuaYLP5SenDfzWYS+PXK540NcmOit7X+g/AwHLyB/nVXp6dkqDVT9
 3H2x5Y2HGhhF6paAqBlWY2lkaeHgALajXGNdLGbl3U6tSs5l7MsDiVlJ6+2TypKXMN
 njj2HaEhRLKsQAHkvVyI0wh3Chy/K5J5aaebaY3pps+DB5mWbQ6FoCJOgugDjroAsk
 HHAp0OtcDTygmbFU3xVDCL5pYIE+EYCfgjrpNJ+nUHySNVyC2SEDaACoQTMfpeRcFf
 MsmVu8h+eqAK5FhsEbzs2aYtriWl+3ydsxy5uBzwAKdSypSzI9muEna7Kwr0iULI14
 chRyPSRqFIU6g==
Message-ID: <12559def-2ca2-4e4d-851c-6ae906b6a2d7@kernel.org>
Date: Wed, 23 Oct 2024 16:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?6Z+p5qOL?= <hanqi@vivo.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <20241023025945.1817457-1-hanqi@vivo.com>
 <9825b1c1-9d24-48d1-a807-d1e6e25c4157@vivo.com>
Content-Language: en-US
In-Reply-To: <9825b1c1-9d24-48d1-a807-d1e6e25c4157@vivo.com>
X-Headers-End: 1t3WOY-00023p-Ax
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: modify f2fs_is_checkpoint_ready
 logic to allow more data to be written with the CP disable
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC8xMC8yMyAxNTo0MCwg6Z+p5qOLIHdyb3RlOgo+IOWcqCAyMDI0LzEwLzIzIDEwOjU5
LCBRaSBIYW4g5YaZ6YGTOgo+PiBXaGVuIHRoZSBmcmVlIHNlZ21lbnQgaXMgdXNlZCB1cCBkdXJp
bmcgQ1AgZGlzYWJsZSwgbWFueSB3cml0ZSBvcgo+PiBpb2N0bCBvcGVyYXRpb25zIHdpbGwgZ2V0
IEVOT1NQQyBlcnJvciBjb2RlcywgZXZlbiBpZiB0aGVyZSBhcmUKPj4gc3RpbGwgbWFueSBibG9j
a3MgYXZhaWxhYmxlLiBXZSBjYW4gcmVwcm9kdWNlIGl0IGluIHRoZSBmb2xsb3dpbmcKPj4gc3Rl
cHM6Cj4+Cj4+IGRkIGlmPS9kZXYvemVybyBvZj1mMmZzLmltZyBicz0xTSBjb3VudD02NQo+PiBt
a2ZzLmYyZnMgLWYgZjJmcy5pbWcKPj4gbW91bnQgZjJmcy5pbWcgZjJmc19kaXIgLW8gY2hlY2tw
b2ludD1kaXNhYmxlOjEwJQo+PiBjZCBmMmZzX2Rpcgo+PiBpPTEgOyB3aGlsZSBbWyAkaSAtbHQg
NTAgXV0gOyBkbyAoZmlsZV9uYW1lPS4vMk1fZmlsZSRpIDsgZGQgXAo+PiBpZj0vZGV2L3JhbmRv
bSBvZj0kZmlsZV9uYW1lIGJzPTFNIGNvdW50PTIpOyBpPSQoKGkrMSkpOyBkb25lCj4+IHN5bmMK
Pj4gaT0xIDsgd2hpbGUgW1sgJGkgLWx0IDUwIF1dIDsgZG8gKGZpbGVfbmFtZT0uLzJNX2ZpbGUk
aSA7IHRydW5jYXRlIFwKPj4gLXMgMUsgJGZpbGVfbmFtZSk7IGk9JCgoaSsxKSk7IGRvbmUKPj4g
c3luYwo+PiBkZCBpZj0vZGV2L3plcm8gb2Y9Li9maWxlIGJzPTFNIGNvdW50PTIwCj4+Cj4+IElu
IGYyZnNfbmVlZF9TU1IoKSBmdW5jdGlvbiwgaXQgaXMgYWxsb3dlZCB0byB1c2UgU1NSIHRvIGFs
bG9jYXRlCj4+IGJsb2NrcyB3aGVuIENQIGlzIGRpc2FibGVkLCBzbyBpbiBmMmZzX2lzX2NoZWNr
cG9pbnRfcmVhZHkgZnVuY3Rpb24sCj4+IGNhbiB3ZSBqdWRnZSB0aGUgbnVtYmVyIG9mIGludmFs
aWQgYmxvY2tzIHdoZW4gZnJlZSBzZWdtZW50IGlzIG5vdAo+PiBlbm91Z2gsIGFuZCByZXR1cm4g
RU5PU1BDIG9ubHkgaWYgdGhlIG51bWJlciBvZiBpbnZhbGlkIGJsb2NrcyBpcwo+PiBhbHNvIG5v
dCBlbm91Z2g/Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFFpIEhhbiA8aGFucWlAdml2by5jb20+Cj4+
IC0tLQo+PiAgICBmcy9mMmZzL3NlZ21lbnQuaCB8IDE3ICsrKysrKysrKysrKysrKysrCj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9mcy9m
MmZzL3NlZ21lbnQuaCBiL2ZzL2YyZnMvc2VnbWVudC5oCj4+IGluZGV4IDcxYWRiNGE0M2JlYy4u
MjBiNTY4ZWFhOTVlIDEwMDY0NAo+PiAtLS0gYS9mcy9mMmZzL3NlZ21lbnQuaAo+PiArKysgYi9m
cy9mMmZzL3NlZ21lbnQuaAo+PiBAQCAtNjM3LDEyICs2MzcsMjkgQEAgc3RhdGljIGlubGluZSBi
b29sIGhhc19lbm91Z2hfZnJlZV9zZWNzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKPj4gICAg
CXJldHVybiAhaGFzX25vdF9lbm91Z2hfZnJlZV9zZWNzKHNiaSwgZnJlZWQsIG5lZWRlZCk7Cj4+
ICAgIH0KPj4gICAgCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgaGFzX2Vub3VnaF9mcmVlX2Jsa3Mo
c3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+PiArewo+PiArCXVuc2lnbmVkIGludCB0b3RhbF9m
cmVlX2Jsb2NrcyA9IDA7Cj4+ICsJdW5zaWduZWQgaW50IGF2YWlsX3VzZXJfYmxvY2tfY291bnQ7
CgoKCj4+ICsKPj4gKwlzcGluX2xvY2soJnNiaS0+c3RhdF9sb2NrKTsKPj4gKwo+PiArCWF2YWls
X3VzZXJfYmxvY2tfY291bnQgPSBnZXRfYXZhaWxhYmxlX2Jsb2NrX2NvdW50KHNiaSwgTlVMTCwg
dHJ1ZSk7Cj4+ICsJdG90YWxfZnJlZV9ibG9ja3MgPSBhdmFpbF91c2VyX2Jsb2NrX2NvdW50IC0g
KHVuc2lnbmVkIGludCl2YWxpZF91c2VyX2Jsb2NrcyhzYmkpOwo+PiArCj4+ICsJc3Bpbl91bmxv
Y2soJnNiaS0+c3RhdF9sb2NrKTsKPj4gKwo+PiArCXJldHVybiB0b3RhbF9mcmVlX2Jsb2NrcyA+
IDA7Cj4+ICt9Cj4+ICsKPj4gICAgc3RhdGljIGlubGluZSBib29sIGYyZnNfaXNfY2hlY2twb2lu
dF9yZWFkeShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkpCj4+ICAgIHsKPj4gICAgCWlmIChsaWtl
bHkoIWlzX3NiaV9mbGFnX3NldChzYmksIFNCSV9DUF9ESVNBQkxFRCkpKQo+PiAgICAJCXJldHVy
biB0cnVlOwo+PiAgICAJaWYgKGxpa2VseShoYXNfZW5vdWdoX2ZyZWVfc2VjcyhzYmksIDAsIDAp
KSkKPj4gICAgCQlyZXR1cm4gdHJ1ZTsKPiAKPiBIaSwgQ2hhbywKPiAKPiBBZnRlciBaaGlndW8n
cyByZW1pbmRlciwgSSBqdXN0IHNhdyB5b3VyIHByZXZpb3VzIHBhdGNoOgo+IGYyZnM6IGZpeCB0
byBhY2NvdW50IGRpcnR5IGRhdGEgaW4gX19nZXRfc2Vjc19yZXF1aXJlZCgpLAo+IHRoZSBjdXJy
ZW50IG1vZGlmaWNhdGlvbiBtYXkgc3RpbGwgcmV0dXJuIHRydWUgaWYgdGhlIHNlZ21lbnQKPiBp
cyBmb3VuZCB0byBiZSBpbnN1ZmZpY2llbnQgd2hlbiBMRlMgYW5kIENQIGlzIGNsb3NlZCwgc2hv
dWxkCj4gSSBhZGQgdGhlIExGUyBtb2RlIHJlc3RyaWN0aW9uIGhlcmU/CgpIaSBRaSwKCkkgZ3Vl
c3Mgc28sIEkgdGhpbmsgd2UgbmVlZCB0byBhZGQgYSBsZnNfbW9kZSBjaGVjayBjb25kaXRpb24g
aW4KaGFzX2Vub3VnaF9mcmVlX2Jsa3MoKSwgb3RoZXJ3aXNlIHRoaXMgcGF0Y2ggd2lsbCB0cmln
Z2VyIHN5c3RlbQpwYW5pYyB3LyBiZWxvdyB0ZXN0Y2FzZToKCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2ZzdGVzdHMvMjAyNDEwMTUwMjUxMDYuMzIwMzY3Ni0xLWNoYW9Aa2VybmVsLm9yZy8KClRo
YW5rcywKCj4gCj4gVGhhbmtzLgo+IAo+PiArCWlmIChsaWtlbHkoaGFzX2Vub3VnaF9mcmVlX2Js
a3Moc2JpKSkpCj4+ICsJCXJldHVybiB0cnVlOwo+PiAgICAJcmV0dXJuIGZhbHNlOwo+PiAgICB9
Cj4+ICAgIAo+IAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
