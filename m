Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ED3C79FB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ft4hSDEPdq3JQQgcAKyLCBoWiSCQoCZNm/tN8YIguXc=; b=Sz4tAmJcKTrO0I1NhmImQZZkPA
	PhopMn5c40gEbHcOCxDIp4JQXqnhd0iGNZdbKjMtQo2yBI8YuRCMADigoi2+fTn1Y8dEHyZxy861e
	PrT2X1WLoMyBgg1JMQEcXWzd4b70EH5V7u0FZYLMG1alD5EsmKZ7yHePZQTdaCOPyn28=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4fW2-00005Z-NL;
	Thu, 10 Sep 2026 14:12:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4fVx-00005C-2o
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 14:12:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yktsf0ORBBGvD3SUCnSD4sWyXidehM6lXLw0baTYOAM=; b=nLuSFY7TyfrcopZX731MagdXsy
 jXoQ1xwHmKEu9w38+txxPTFCQ2x/HHoOT2mPXMuddUGZTRaHuru0fcEekOmbcplXdxnbCk00qG9Xr
 ca+owfrk/4wqF6uFFnK+XaSj8c1AZOX/Mwzpkrw96a7eElqmJ/Gz9R6NIclORDuL2iMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yktsf0ORBBGvD3SUCnSD4sWyXidehM6lXLw0baTYOAM=; b=f723YG/MTOWvenED5ozy+uqPga
 BupxScmbg1ekMT4E8fh6Q2wRTMTTMApl+ocn9MIEnCNEd9859jXb0I2dhZVe+ELjI0Xf41h2HbSQU
 I3WwwAYVMif1x8bFMTqmSne2B+7PHgo+8hP58ptsawyDxn1UpTC1hay8NyfQd2yCJuFQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4fVu-0002jT-Fs for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 14:12:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 386F943868;
 Thu, 10 Sep 2026 14:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE4A1F000FF;
 Thu, 10 Sep 2026 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789049545;
 bh=yktsf0ORBBGvD3SUCnSD4sWyXidehM6lXLw0baTYOAM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DR6cm8ko/3qgt7iRmoOIc+GkqzbQjdop9yWq5Qik1mdngrStdgw91yb2SUbPXRgbW
 +BwGaOl0FycosQqQyaUBgDbkqExHUPG+pOv2sSls+AsxWJg54mEnXl52PjWuCrreGi
 hwCwDtwMH8OgDzuEjzEznCDdswRjeUj5abQ7ggKoPngUWt3BtZBfFdRcsxW0QRDuz7
 n2TOMEkhjmrSdH8t1oY+Y4w6VHgCKAwBLDvc/SfIxmb3hLjbdI3UPxIzNjk6rWWrSW
 u7T00RS1twz/70OYQ+4j4WksFSYOKY/C9f7gbGrGpx6iSrBeiVtAzffqbAPx7Ny/Q2
 acKYLC0X1B4nQ==
Message-ID: <8b3df80c-2cf6-4331-89ac-4ae75edf5b40@kernel.org>
Date: Thu, 10 Sep 2026 22:12:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260910022258.3308187-1-chao@kernel.org>
 <CAHJ8P3Kah8NTiSMsXdb1PF9yA59UE+MZTg8MkcYcH4OrVQVjQw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3Kah8NTiSMsXdb1PF9yA59UE+MZTg8MkcYcH4OrVQVjQw@mail.gmail.com>
X-Headers-End: 1x4fVu-0002jT-Fs
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to handle race between
 truncate and writeback
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOS8xMC8yNiAxNToyMiwgWmhpZ3VvIE5pdSB3cm90ZToKPiBDaGFvIFl1IHZpYSBMaW51eC1m
MmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPiDkuo4y
MDI25bm0OeaciDEw5pel5ZGo5ZubIDEwOjI05YaZ6YGT77yaCj4+Cj4+IEZyb206IENoYW8gWXUg
PGNoYW9Aa2VybmVsLm9yZz4KPj4KPj4gZnNzdHJlc3MgcmVwb3J0cyBhIGtlcm5lbCBCVUcgaW4g
ZjJmc190cnVuY2F0ZV9wYXJ0aWFsX2NsdXN0ZXIoKToKPj4KPj4ga2VybmVsIEJVRyBhdCBmcy9m
MmZzL2NvbXByZXNzLmM6MTIzOCEKPj4gUklQOiAwMDEwOmYyZnNfdHJ1bmNhdGVfcGFydGlhbF9j
bHVzdGVyKzB4MjkyLzB4MmEwCj4+IENhbGwgVHJhY2U6Cj4+ICAgPFRBU0s+Cj4+ICAgZjJmc190
cnVuY2F0ZSsweGY2LzB4MjEwCj4+ICAgZjJmc19zZXRhdHRyKzB4NmI3LzB4NzcwCj4+ICAgbm90
aWZ5X2NoYW5nZSsweDMzYi8weDUyMAo+PiAgIGRvX3RydW5jYXRlKzB4YzIvMHhmMAo+PiAgIHZm
c190cnVuY2F0ZSsweDE1My8weDFkMAo+PiAgIGtzeXNfdHJ1bmNhdGUrMHg3OC8weGQwCj4+ICAg
X194NjRfc3lzX3RydW5jYXRlKzB4MTYvMHgyMAo+PiAgIGRvX3N5c2NhbGxfNjQrMHhiZS8weDU0
MAo+Pgo+PiBUaGUgcm9vdCBjYXVzZSBpcyB0aGF0IFRocmVhZCBBICh0cnVuY2F0ZSkgYW5kIFRo
cmVhZCBCIChiYWNrZ3JvdW5kCj4+IHdyaXRlYmFjayBvciBmc3luYykgY2FuIHJhY2UgYXMgZm9s
bG93czoKPj4KPj4gVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRocmVhZCBC
Cj4+IC0gZjJmc19zZXRhdHRyCj4+ICAgLSBmMmZzX3RydW5jYXRlCj4+ICAgIC0gZjJmc190cnVu
Y2F0ZV9ibG9ja3MKPj4gICAgIC0gZjJmc190cnVuY2F0ZV9wYXJ0aWFsX2NsdXN0ZXIKPj4gICAg
ICAtIGYyZnNfaXNfY29tcHJlc3NlZF9jbHVzdGVyCj4+ICAgICAgICByZXR1cm4gMQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc193cml0ZV9jYWNoZV9wYWdl
cwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGYyZnNfd3JpdGVf
bXVsdGlfcGFnZXMKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0g
ZjJmc193cml0ZV9yYXdfcGFnZXMKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtIGYyZnNfd3JpdGVfc2luZ2xlX2RhdGFfcGFnZQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZG4uZGF0YV9ibGthZGRyICE9IENPTVBSRVNTX0FE
RFIKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChjbHVzdGVy
IGNvbnZlcnRlZCB0byBub3JtYWwpCj4+ICAgICAgLSBmMmZzX3ByZXBhcmVfY29tcHJlc3Nfb3Zl
cndyaXRlCj4+ICAgICAgIC0gZjJmc19pc19jb21wcmVzc2VkX2NsdXN0ZXIKPj4gICAgICAgICBy
ZXR1cm4gMAo+PiAgICAgICAtIHJldHVybiAwCj4+ICAgICAgLSBmMmZzX2J1Z19vbihzYmksIGVy
ciA9PSAwKTogQlVHIQo+Pgo+PiBXcml0ZWJhY2sgcGF0aCBkb2VzIG5vdCBhY3F1aXJlIGlfZ2Nf
cndzZW0gb3IgZmlsZW1hcF9pbnZhbGlkYXRlX2xvY2suCj4+IFdoZW4gYSBjb21wcmVzc2VkIGNs
dXN0ZXIgZmFpbHMgY29tcHJlc3Npb24gZHVyaW5nIHdyaXRlYmFjaywgaXQgaXMKPj4gb3Zlcndy
aXR0ZW4gd2l0aCByYXcgZGF0YSBibG9ja3MuIElmIFRocmVhZCBBIGNoZWNrZWQKPj4gZjJmc19p
c19jb21wcmVzc2VkX2NsdXN0ZXIoKSBiZWZvcmUgdGhlIGNvbnZlcnNpb24sIGJ1dCBjYWxscwo+
PiBmMmZzX3ByZXBhcmVfY29tcHJlc3Nfb3ZlcndyaXRlKCkgYWZ0ZXIgdGhlIGNvbnZlcnNpb24s
Cj4+IGYyZnNfcHJlcGFyZV9jb21wcmVzc19vdmVyd3JpdGUoKSByZXR1cm5zIDAgYmVjYXVzZSB0
aGUgY2x1c3RlciBpcyBubwo+PiBsb25nZXIgYSBjb21wcmVzc2VkIGNsdXN0ZXIuCj4+Cj4+IFRv
IGZpeCB0aGlzLCByZW1vdmUgdGhlIGYyZnNfYnVnX29uKCkgYW5kIHJldHJ5IGNoZWNraW5nIHRo
ZSBjbHVzdGVyIHN0YXR1cwo+PiB3aGVuIGYyZnNfcHJlcGFyZV9jb21wcmVzc19vdmVyd3JpdGUo
KSByZXR1cm5zIDAsIHNvIHRoYXQgaXQgY2FuIGZhbGwgYmFjawo+PiB0byBmMmZzX2RvX3RydW5j
YXRlX2Jsb2NrcygpIHRvIGhhbmRsZSBpdCBhcyBhIG5vcm1hbCBjbHVzdGVyLgo+Pgo+PiBDYzog
c3RhYmxlQGtlcm5lbC5vcmcKPj4gRml4ZXM6IDMyNjVkM2RiMWYxNiAoImYyZnM6IHN1cHBvcnQg
cGFydGlhbCB0cnVuY2F0aW9uIG9uIGNvbXByZXNzZWQgaW5vZGUiKQo+PiBTaWduZWQtb2ZmLWJ5
OiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4+IC0tLQo+PiAgIGZzL2YyZnMvY29tcHJlc3Mu
YyB8IDggKysrKy0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9jb21wcmVzcy5jIGIvZnMvZjJm
cy9jb21wcmVzcy5jCj4+IGluZGV4IGNlODgwOTJkOWNlMi4uZTFjYzcxODU0MjhlIDEwMDY0NAo+
PiAtLS0gYS9mcy9mMmZzL2NvbXByZXNzLmMKPj4gKysrIGIvZnMvZjJmcy9jb21wcmVzcy5jCj4+
IEBAIC0xMjIyLDYgKzEyMjIsNyBAQCBpbnQgZjJmc190cnVuY2F0ZV9wYXJ0aWFsX2NsdXN0ZXIo
c3RydWN0IGlub2RlICppbm9kZSwgdTY0IGZyb20sIGJvb2wgbG9jaykKPj4gICAgICAgICAgaW50
IGk7Cj4+ICAgICAgICAgIGludCBlcnI7Cj4+Cj4+ICtyZXBlYXQ6Cj4+ICAgICAgICAgIGVyciA9
IGYyZnNfaXNfY29tcHJlc3NlZF9jbHVzdGVyKGlub2RlLCBzdGFydF9pZHgpOwo+PiAgICAgICAg
ICBpZiAoZXJyIDwgMCkKPj4gICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+PiBAQCAtMTIz
MywxMSArMTIzNCwxMCBAQCBpbnQgZjJmc190cnVuY2F0ZV9wYXJ0aWFsX2NsdXN0ZXIoc3RydWN0
IGlub2RlICppbm9kZSwgdTY0IGZyb20sIGJvb2wgbG9jaykKPj4gICAgICAgICAgLyogdHJ1bmNh
dGUgY29tcHJlc3NlZCBjbHVzdGVyICovCj4+ICAgICAgICAgIGVyciA9IGYyZnNfcHJlcGFyZV9j
b21wcmVzc19vdmVyd3JpdGUoaW5vZGUsICZwYWdlcCwKPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0X2lkeCwgJmZzZGF0YSk7Cj4+ICsgICAg
ICAgaWYgKGVyciA9PSAwKQo+PiArICAgICAgICAgICAgICAgZ290byByZXBlYXQ7Cj4gSGkgQ2hh
bywKPiAgIHNvbWUgY29tbWVudHMgaGVyZSB3aWxsIGJlIGVhc2llciB0byB1bmRlcnN0YW5k77yf
CgpaaGlndW8sIGFkZCBjb21tZW50cyBpbiB2MiwgdGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKVGhh
bmtzLAoKPiBvdGhlciBMR1RNCj4gUmV2aWV3ZWQtYnk6IFpoaWd1byBOaXUgPHpoaWd1by5uaXVA
dW5pc29jLmNvbT4KPiB0aGFua3MhCj4+Cj4+IC0gICAgICAgLyogc2hvdWxkIG5vdCBiZSBhIG5v
cm1hbCBjbHVzdGVyICovCj4+IC0gICAgICAgZjJmc19idWdfb24oRjJGU19JX1NCKGlub2RlKSwg
ZXJyID09IDApOwo+PiAtCj4+IC0gICAgICAgaWYgKGVyciA8PSAwKQo+PiArICAgICAgIGlmIChl
cnIgPCAwKQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+Cj4+ICAgICAgICAgIHJw
YWdlcyA9IGZzZGF0YTsKPj4gLS0KPj4gMi40OS4wCj4+Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IExpbnV4LWYyZnMtZGV2ZWwgbWFp
bGluZyBsaXN0Cj4+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4+IGh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
