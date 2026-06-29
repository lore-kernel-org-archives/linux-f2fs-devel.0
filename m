Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16E8C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZwuQDaDqAjYebEkLDIT9cR+gmtUOanM534zMbeyM44=; b=mVqVkCFbvdUlRGobhB0SZtWhvV
	CcwmJ/C9yQHDwJIY1TQPZ78jGJI8HxUXPJ5yWbDKKoNUaC8qhba2DsmRzGCBAgsreKAFirBLcwJsu
	hy2q8R/cBA3Q3S7Y6Fsi9Gl8QnG8y/poV01uCkSCBaKLDEzuawdwrwwgLpkfr7SADl7I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1we9tT-000602-Vo;
	Mon, 29 Jun 2026 11:11:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1we9tS-0005zw-NU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vdT1ft6eQ8lfPJtlPgw/cSQ0Bl8AGtQ9WC6HLK0l1lc=; b=Q90ADPczn66SyNu8V89jquFSPR
 uP3YPWJs92osdYIJlZrXwzF+DIhcTem7/W6VI376UzgcQ/7MPLM3S+MykGzqe2swEtuNiTE0kYC8M
 Lpc0P0jwSmD58Vg7+YZROCsAq/8+aFtckycbNJXJr5NGVpB7aVd4NmHGwLyFTat+lCxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vdT1ft6eQ8lfPJtlPgw/cSQ0Bl8AGtQ9WC6HLK0l1lc=; b=hK7jQytkfMu7PAhPXafzqKtrAQ
 aieD+m55flF5ucn8AEIi7RiubUEOK3NkpZOzlO5VFLiUm8008gyUWnJ3AF03QYNL4dZuUe4HDtCKi
 k5eC2Z1xlTjbt6L8s20sG5blmB4DVG+0McYnC6Yl2V1g93tjDPVKTpzManxWxqxvxjV4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1we9tQ-0006cf-Tq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:11:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC46260008;
 Mon, 29 Jun 2026 11:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8211F000E9;
 Mon, 29 Jun 2026 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782731462;
 bh=vdT1ft6eQ8lfPJtlPgw/cSQ0Bl8AGtQ9WC6HLK0l1lc=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=bdIf8F099Xrm9aGQmo8VOu9szJ2JEo7Bt8OlWbwCfsWGUVE7gonLBmNZKka/8lRiJ
 pmLI1fJ54c8aUuHagY02Q0+p3j2uhlDyPdPqoHicMhnK8EizdzifmwQjLqXOCMUuq2
 egqi2LBNHIHcfZBFDd/7JJwxhqZqiQ2l82WKGmSrFhtuMZh3uiKh3uKhQRcVgO0ylY
 oDrtmeJWkO8dqwwW9Vjxyef13KHFg8Tc9kVsuybs25hj13IkRcyIm7ljk586NS9x/P
 3g+OmX0GLYlQNEOsgXobbLEcjcqduPaVkN0e64g6Cea9WCA7guOW1snM8mfQjFTWeM
 2dCVaPyPjz7iw==
Message-ID: <b38096d4-20e6-40f9-8c89-c0219542a63d@kernel.org>
Date: Mon, 29 Jun 2026 19:10:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
References: <ajwtQRawMxcQkyo8@casper.infradead.org>
 <ca56ceb7-b0a7-41f2-9b26-085e81456794@amlogic.com>
 <324cc5b6-ebfd-4696-b2f4-33710b771249@kernel.org>
 <akHsfps-sQ1INJfS@casper.infradead.org>
 <kuag63fjw2cvzqc2gahefcxnlp3jwqtapr6gwkgvhse6aez6hr@spvbvpprpwgb>
Content-Language: en-US
In-Reply-To: <kuag63fjw2cvzqc2gahefcxnlp3jwqtapr6gwkgvhse6aez6hr@spvbvpprpwgb>
X-Headers-End: 1we9tQ-0006cf-Tq
Subject: Re: [f2fs-dev] Use of FGP_NOFS in f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNi8yOS8yNiAxNjo1OCwgSmFuIEthcmEgd3JvdGU6Cj4gT24gTW9uIDI5LTA2LTI2IDA0OjU0
OjM4LCBNYXR0aGV3IFdpbGNveCB3cm90ZToKPj4gW0FkZGluZyBKYW4gS2FyYTsgcmV0YWluaW5n
IHdob2xlIG1lc3NhZ2UgZm9yIGNvbnRleHRdCj4gCj4gVGhhbmtzIQo+IAo+PiBPbiBNb24sIEp1
biAyOSwgMjAyNiBhdCAwOTozOToyNUFNICswODAwLCBDaGFvIFl1IHdyb3RlOgo+Pj4gT24gNi8y
Ni8yNiAxNzozMCwgSml1Y2hlbmcgWHUgd3JvdGU6Cj4+Pj4gT24gNi8yNS8yMDI2IDM6MTcgQU0s
IE1hdHRoZXcgV2lsY294IHdyb3RlOgo+Pj4+PiBbIEVYVEVSTkFMIEVNQUlMIF0KPj4+Pj4gSSBh
bSB0cnlpbmcgdG8gcmVtb3ZlIEZHUF9OT0ZTIGZyb20gdGhlIGtlcm5lbCBhbmQgdGhlIGxhc3Qg
cmVtYWluaW5nCj4+Pj4+IHVzZXIgd2FzIGFkZGVkIGJ5IHlvdSBsYXN0IHllYXIgaW4gY29tbWl0
IDIzMDhkZTI3YzAzZC7CoCBJJ20gdHJ5aW5nIHRvCj4+Pj4+IHVuZGVyc3RhbmQgd2h5LsKgIERp
ZCB5b3Ugc2VlIGFuIGFjdHVhbCBwcm9ibGVtIGlmIHlvdSBkbyBub3QgdXNlIGl0LAo+Pj4+PiBv
ciB3YXMgaXQgdGhlb3JldGljYWw/wqAgVGhlIGNvbW1pdCBtZXNzYWdlIHNheXMgInRvIGF2b2lk
IHBvdGVudGlhbAo+Pj4+PiBkZWFkbG9jayBpc3N1ZXMiLCBidXQgaXQncyBub3QgY2xlYXIgdG8g
bWUgd2hldGhlciB5b3Uga25vdyB0aGV5IGFyZQo+Pj4+PiB0aGVyZSwgb3Igb25seSB0aGluayB0
aGV5IGFyZSB0aGVyZS4KPj4+Pj4KPj4+Pj4gSSdkIHJlYWxseSBsaWtlIHRvIHVuZGVyc3RhbmQg
d2hhdCB0aGUgaXNzdWVzIGFyZSBhcyB0aGUgbm9ybWFsIGlzc3Vlcwo+Pj4+PiB3aGljaCBtYWtl
IGNhbGxpbmcgaW50byB0aGUgZmlsZXN5c3RlbSAoaG9sZGluZyBhbm90aGVyIGZvbGlvIGxvY2tl
ZCwKPj4+Pj4gaG9sZGluZyBhIG11dGV4IHJlbGllZCB1cG9uIGJ5IHJlY2xhaW0pIGRvbid0IHNl
ZW0gdG8gYmUgcHJlc2VudC4KPj4+Pj4gU28gaWYgdGhlcmUgaXMgc29tZXRoaW5nLCBJJ20gbm90
IHN1cmUgd2hhdCBpdCBpcy4KPj4+PiBIaSBNYXR0aGV3LAo+Pj4+Cj4+Pj4gVGhlIEZHUF9OT0ZT
IGZsYWcgd2FzIHN1Z2dlc3RlZCBieSBDaGFvIGFuZCBub3QgYWRkaW5nIGl0IG1pZ2h0IGxlYWQg
dG8gZGVhZGxvY2sgaXNzdWVzLgo+Pj4+Cj4+Pj4gQENoYW8gY291bGQgeW91IGV4cGxhaW4gdGhp
cyBmb3IgTWF0dGhldz8KPj4+Cj4+PiBIaSBNYXR0aGV3LCBKaXVjaGVuZywKPj4+Cj4+PiBJSVJD
LCBmb3Igbm9ybWFsIHBhdGggZnJvbSB3cml0ZSAtPiB3cml0ZV9iZWdpbiwgaXQgc2VlbXMgZmlu
ZSBzaW5jZSB0aGVyZSBpcwo+Pj4gbm8gZjJmcy1zcGVjaWZpZWQgbXV0ZXggb3Igb3RoZXIgZm9s
aW8gbG9jayBpbiB0aGUgcGF0aCwgYnV0IEkgd2FzIHdvcnJpZWQgYWJvdXQKPj4+IHF1b3RhIHBh
dGggd2hlbiBJIHN1Z2dlc3RlZCB0byBrZWVwIEdGUF9OT0ZTIGZsYWcsIGFzIHRoZSBsb2NrIHJh
Y2UgY29uZGl0aW9uCj4+PiBpcyBxdWl0ZSBjb21wbGljYXRlZCB0aGVyZTogZjJmcyBpbnRlcm5h
bCBsb2NrIHZzIHF1b3RhIHN5c3RlbSBsb2NrIHZzIGZvbGlvIGxvY2suLi4KPj4+Cj4+PiBJIHNl
YXJjaGVkIHRoZSBjb21taXRzIGFuZCBmb3VuZCB0aGlzOgo+Pj4KPj4+IENvbW1pdCAwMjExN2I4
YWU5YzAgKCJmMmZzOiBTZXQgR0ZfTk9GUyBpbiByZWFkX2NhY2hlX3BhZ2VfZ2ZwIHdoaWxlIGRv
aW5nCj4+PiBmMmZzX3F1b3RhX3JlYWQiKQo+Pj4KPj4+IEluIHRoaXMgY2FzZSwgZjJmc19xdW90
YV9yZWFkKCkgd2FzIGNhbGxpbmcgcmVhZF9tYXBwaW5nX3BhZ2UoKSwgd2hpY2ggYWxsb3dlZAo+
Pj4gR0ZQX0ZTIGFsbG9jYXRpb25zLiBUaGlzIHRyaWdnZXJlZCB0aGUgZm9sbG93aW5nIGRlYWRs
b2NrOgo+Pj4KPj4+ICAgICBUaHJlYWQgMSAoVXNlciBPcGVuL1dyaXRlKQo+Pj4gICAgIC0gZG9f
c3lzX29wZW4KPj4+ICAgICAgLSB2ZnNfb3Blbgo+Pj4gICAgICAgLSBkcXVvdF9maWxlX29wZW4K
Pj4+ICAgICAgICAtIGRxdW90X2luaXRpYWxpemUKPj4+ICAgICAgICAgLSBkcWdldAo+Pj4gICAg
ICAgICAgLSBkcXVvdF9hY3F1aXJlCj4+PiAgICAgICAgICAgOiBsb2NrcyAmZHFvcHQtPmRxaW9f
bXV0ZXggKFZGUyBRdW90YSBNdXRleCkKPj4+ICAgICAgICAgICAtIHF0cmVlX3JlYWRfZHF1b3QK
Pj4+ICAgICAgICAgICAgLSBmMmZzX3F1b3RhX3JlYWQKPj4+ICAgICAgICAgICAgIC0gcmVhZF9t
YXBwaW5nX3BhZ2UgKEdGUF9LRVJORUwgLyBhbGxvd3MgR0ZQX0ZTKQo+Pj4gICAgICAgICAgICAg
IC0gX19hbGxvY19wYWdlc19ub2RlbWFzawo+Pj4gICAgICAgICAgICAgICAtIHRyeV90b19mcmVl
X3BhZ2VzIChEaXJlY3QgUmVjbGFpbSkKPj4+ICAgICAgICAgICAgICAgIC0gcHJ1bmVfaWNhY2hl
X3NiCj4+PiAgICAgICAgICAgICAgICAgLSBldmljdAo+Pj4gICAgICAgICAgICAgICAgICAtIGYy
ZnNfZXZpY3RfaW5vZGUKPj4+ICAgICAgICAgICAgICAgICAgIC0gZHF1b3RfZHJvcAo+Pj4gICAg
ICAgICAgICAgICAgICAgIC0gZHFwdXQKPj4+ICAgICAgICAgICAgICAgICAgICAgLSBkcXVvdF9j
b21taXQKPj4+ICAgICAgICAgICAgICAgICAgICAgIDogdHJpZXMgdG8gbG9jayAmZHFvcHQtPmRx
aW9fbXV0ZXggYWdhaW4KPj4+ICAgICAgICAgICAgICAgICAgICAgID09PiBERUFETE9DSyAod2Fp
dGluZyBmb3IgaXRzZWxmKQo+Pj4KPj4+IEl0IG1heSB0cmlnZ2VyIGRlYWRsb2NrIGluIGYyZnNf
cXVvdGFfd3JpdGUoKSBhcyB0aGUgc2FtZSB3YXkgaW4gZjJmc19xdW90YV9yZWFkKCkKPj4+IHBh
dGg/IGxldCBtZSBrbm93IGlmIEknbSBtaXNzaW5nIGFueXRoaW5nLgo+Pj4KPj4+IEFyZSBtZW1h
bGxvY19ub2ZzX3NhdmUoKSBhbmQgbWVtYWxsb2Nfbm9mc19yZXN0b3JlKCkgcmVjb21tZW5kZWQg
Zm9yIHN1Y2ggY2FzZT8KPj4+IGFueSBzdWdnZXN0aW9ucz8KPj4KPj4gSW4gZ2VuZXJhbCwgeWVz
LCBtZW1hbGxvY19ub2ZzX3NhdmUoKSBhZnRlciBsb2NraW5nIGRxaW9fbXV0ZXggc291bmRzIGxp
a2UKPj4gdGhlIHJpZ2h0IGlkZWEgdG8gbWUuICBJJ2Qgd2FudCB0byBmYW1pbGlhcmlzZSBteXNl
bGYgbW9yZSB0aG9yb3VnaGx5Cj4+IHdpdGggdGhlIGNvZGUgYmVmb3JlIG1ha2luZyBhIGZpcm0g
cmVjb21tZW5kYXRpb24sIGFuZCBpdCdzIHByb2JhYmx5Cj4+IHF1aWNrZXIgdG8ganVzdCBhc2sg
SmFuIDstKQo+IAo+IFNvIHRoZSBhYm92ZSBzdGFja3RyYWNlIHNob3VsZG4ndCBiZSBwb3NzaWJs
ZSBzaW5jZSB5b3UndmUgYWRkZWQKPiBtZW1hbGxvY19ub2ZzX3NhdmUoKSAvIHJlc3RvcmUoKSBw
YWlycyBpbnRvIHF1b3RhIGNvZGUgaW46Cj4gCj4gNTM3ZTExY2RjN2E2ICgicXVvdGE6IFByZXZl
bnQgbWVtb3J5IGFsbG9jYXRpb24gcmVjdXJzaW9uIHdoaWxlIGhvbGRpbmcgZHFfbG9jayIpCgpB
aCwgSSBzZWUsIGl0IGhhcyBiZWVuIGZpeGVkIGluIHF1b3RhIHN5c3RlbS4KCj4gCj4gQ2hhbywg
YXJlIHlvdSBzdXJlIHRoZSBHRlBfTk9GUyBtYXNrIGlzbid0IGp1c3QgYSByZWxpYyBmcm9tIHRo
ZSBwYXN0PwoKU28sIEkgYWdyZWUgaXQncyBhIHJlbGljIGltcGxlbWVudGF0aW9uLCB0aGFua3Mg
SmFuIGZvciByZW1pbmRlci4KClRoYW5rcywKCj4gCj4gCQkJCQkJCQlIb256YQoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVs
Cg==
