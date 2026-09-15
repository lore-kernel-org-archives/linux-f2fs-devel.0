Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE95C88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Adk6Iu9W/6zf5zvxO3gmybv3gDY3HbXOrNIyiOXVJTQ=; b=AoOVvwnDCFsTSzt3PD32ZAG6NV
	N73WHG3TvGqvTS1Pi+kvQI2eY7kcsgs46a4dn2U1kneSvUFIh9YYDfA7L3VpCtPA8dstGTLuaC04g
	mWfX67442DjjN0e6Q3Br4uUj4dPJS1SJ+IfT5kwkJtktARP0Jej+Ix1G1AvO6DHstzvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6Ilj-0004k6-HZ;
	Tue, 15 Sep 2026 02:19:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6Ilg-0004ji-9e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 02:19:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WqICZCmo+XU66iHWMmT0ym9EBpC3glaNJd36LYT/K5M=; b=VCmtUydR4MW8LkAYcn+NKtHKBj
 2fTfG8NQp4w/Wx8/KOyWvuSBMi45Pnp8H3ni6g3m8tc40P8PRvlIr8duvhbdK+PwOL2lUeLDSipjs
 C9aWGd3Yi0fsmXWWOZUE04oS/2JBitAQA7SH0HIsawjI2n9DqyZaTkKXftb75i5wI6z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WqICZCmo+XU66iHWMmT0ym9EBpC3glaNJd36LYT/K5M=; b=Msxm6yWx2fsnp4/Iglu4NtxQf3
 cWusA+qVOQJD5GWXfb4QWoz8QV3ubxyhnfkA3f0/JBPiD6h8Tm725e4pFGcsWfuGOXIF/QJEsHoWl
 +F6Fa6Oy5sqFYHcftAizsDNJm/0l+CXGcmZjgQ0D0Z4rCIa1lEIpU80w6KaAmxbH3GJ4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6Ile-0002Ms-MK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 02:19:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A0C46025F;
 Tue, 15 Sep 2026 02:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF88B1F000FF;
 Tue, 15 Sep 2026 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789438764;
 bh=WqICZCmo+XU66iHWMmT0ym9EBpC3glaNJd36LYT/K5M=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=dYJFepxLFfD43Vcn0o9o9Sf6WsBAgfRpV6HC67x/zmtqwQQNr+cQqHzNI+Tug17qa
 nQNcIzWY8Lk06iDB/gUIllQ8gd4t+G3jQwVH/EGqRTHNACh3L35ptGo0ecDqlrXhkv
 BPWMey07Vz9RTmdyzAte4jZ0RLxL9xXn/zp9XCNxQezJcQi8tJNj3MhCmBuKcimcFm
 EeBaK7CK4yWFfTtoNpc+3foiKXkrBA84OIvpiFYm7q4O+Sq2RFXCtJr7kKo7kkONRu
 pjfeDHX01yFi/3/8NqgRJEonPjDWm9Mdz9zqYSAMtM2TELdIUdd02qleIE9/u2byZG
 txN22R37rRrHw==
Message-ID: <e8a2114f-6f76-45bc-a10c-2193790f2cee@kernel.org>
Date: Tue, 15 Sep 2026 10:19:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260911232405.1815804-1-chao@kernel.org>
 <20260911232405.1815804-11-chao@kernel.org>
 <CAHJ8P3+cDHYmS22Jj4Za1=9bHEDQzsDYP=uBvDHT3ZyAizYZXA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3+cDHYmS22Jj4Za1=9bHEDQzsDYP=uBvDHT3ZyAizYZXA@mail.gmail.com>
X-Headers-End: 1x6Ile-0002Ms-MK
Subject: Re: [f2fs-dev] [PATCH v7 10/12] f2fs: cache: support fault injection
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

T24gOS8xNC8yNiAxNzozNSwgWmhpZ3VvIE5pdSB3cm90ZToKPiBDaGFvIFl1IHZpYSBMaW51eC1m
MmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPiDkuo4y
MDI25bm0OeaciDEy5pel5ZGo5YWtIDA3OjI45YaZ6YGT77yaCj4+Cj4+IEZyb206IENoYW8gWXUg
PGNoYW9Aa2VybmVsLm9yZz4KPj4KPj4gVGhpcyBwYXRjaCBhZGRzIGZhdWx0IGluamVjdGlvbiBz
dXBwb3J0IGZvciBtZXRhZGF0YSBjYWNoZSBhbGxvY2F0aW9ucwo+PiB0byBpbXByb3ZlIGVycm9y
LXBhdGggdGVzdCBjb3ZlcmFnZS4KPj4gLSBpdCBpbnRlZ3JhdGVzIGVudHJ5IGFsbG9jYXRpb25z
IHdpdGggRkFVTFRfS0FMTE9DCj4gRkFVTFRfS0FMTE9DIC0+ICBGQVVMVF9LTUFMTE9DPwoKV2ls
bCBmaXguCgpUaGFua3MsCgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvQGtlcm5l
bC5vcmc+Cj4+IC0tLQo+PiAgIGZzL2YyZnMvY2FjaGUuYyB8IDI0ICsrKysrKysrKysrKysrLS0t
LS0tLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvY2FjaGUuYyBiL2ZzL2YyZnMvY2FjaGUu
Ywo+PiBpbmRleCA3MjYwYzE1NzY1NGIuLmRjYWIwZjMyMTczMCAxMDA2NDQKPj4gLS0tIGEvZnMv
ZjJmcy9jYWNoZS5jCj4+ICsrKyBiL2ZzL2YyZnMvY2FjaGUuYwo+PiBAQCAtMTU0LDIzICsxNTQs
MjcgQEAgc3RhdGljIHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9jayAqZjJmc19jcmVhdGVfY2FjaGUo
Cj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IGYyZnNfY2FjaGVkX2Jsb2NrX2xpc3QgKmNhY2hl
LAo+PiAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaW5kZXgsIGJvb2wgbm9mYWlsKQo+
PiAgIHsKPj4gKyAgICAgICBzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkgPSBjYWNoZS0+c2JpOwo+
PiAgICAgICAgICBzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2sgKmVudHJ5Owo+PiAgICAgICAgICB1
bnNpZ25lZCBpbnQgZmxhZ3MgPSBHRlBfTk9GUzsKPj4KPj4gICAgICAgICAgaWYgKGluZGV4ID09
IFVMT05HX01BWCkKPj4gICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRVJBTkdFKTsK
Pj4KPj4gLSAgICAgICBpZiAobm9mYWlsKQo+PiArICAgICAgIGlmIChub2ZhaWwpIHsKPj4gICAg
ICAgICAgICAgICAgICBmbGFncyB8PSBfX0dGUF9OT0ZBSUw7Cj4+IC0KPj4gLSAgICAgICBlbnRy
eSA9IGt6YWxsb2Nfb2JqKCplbnRyeSwgZmxhZ3MpOwo+PiAtICAgICAgIGlmICghZW50cnkpCj4+
IC0gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4gLQo+PiAtICAgICAg
IGVudHJ5LT5kYXRhID0ga21hbGxvYyhjYWNoZS0+c2JpLT5ibG9ja3NpemUsIGZsYWdzKTsKPj4g
LSAgICAgICBpZiAoIWVudHJ5LT5kYXRhKSB7Cj4+IC0gICAgICAgICAgICAgICBrZnJlZShlbnRy
eSk7Cj4+IC0gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4gKyAgICAg
ICAgICAgICAgIGVudHJ5ID0ga3phbGxvY19vYmooKmVudHJ5LCBmbGFncyk7Cj4+ICsgICAgICAg
ICAgICAgICBlbnRyeS0+ZGF0YSA9IGttYWxsb2Moc2JpLT5ibG9ja3NpemUsIGZsYWdzKTsKPj4g
KyAgICAgICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgICAgZW50cnkgPSBmMmZzX2t6YWxsb2Mo
c2JpLCBzaXplb2YoKmVudHJ5KSwgZmxhZ3MpOwo+PiArICAgICAgICAgICAgICAgaWYgKCFlbnRy
eSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4+
ICsKPj4gKyAgICAgICAgICAgICAgIGVudHJ5LT5kYXRhID0gZjJmc19rbWFsbG9jKHNiaSwgc2Jp
LT5ibG9ja3NpemUsIGZsYWdzKTsKPj4gKyAgICAgICAgICAgICAgIGlmICghZW50cnktPmRhdGEp
IHsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUoZW50cnkpOwo+PiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4gKyAgICAgICAgICAgICAg
IH0KPj4gICAgICAgICAgfQo+Pgo+PiAgICAgICAgICBlbnRyeS0+aW5kZXggPSBpbmRleDsKPj4g
LS0KPj4gMi40OS4wCj4+Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4+IGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
