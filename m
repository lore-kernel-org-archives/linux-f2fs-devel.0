Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428DCD11C2
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Apr 2024 07:29:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rtMy5-0004Cj-D0;
	Sun, 07 Apr 2024 07:29:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rtMy3-0004CS-U4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 07:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0LgOyS1TRM/uP23jtucXc5fiEJFgH+5DfHGysuGOTUc=; b=g7a5eVPKncvlBmBVAiinDbCAAw
 EF90IuXzDFxBrePazjrY0LZa3FbgwiLnpB2TMLi9a0SVXB7GsJqkHITjPhpUZqxkqbfaussldtoGk
 PfqauBOy49mtsK+QwcEfqFxITxu5f6qy6tB8hx2jh2DKGAO0irDmPPBU5BdGtygrUz5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0LgOyS1TRM/uP23jtucXc5fiEJFgH+5DfHGysuGOTUc=; b=N5SeyXhoqCmSxqEx3vJ30OoLv4
 hmf17s9vatM2lYJf/wkOfg2uctkvQPqB2wFqT18wDEu4XDOL/D46lBlIk7aeBmb/oPXw+bYrB1euF
 qfV765t5880Bo7Pujzy2OjJwQQr4CI9n8XGO5KdkvHF/YxZJVZMsj4jJFbhp9+9jOT0A=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rtMy3-0001SF-LT for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 07:29:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 91CF260C17;
 Sun,  7 Apr 2024 07:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B265C433F1;
 Sun,  7 Apr 2024 07:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712474966;
 bh=29YP5x/Os973Sl32/dIiO+nQ4l2sbAEznxA8GpsSHS8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m+es7zhb6d8kBBprLCV3fRWapkeqAnZHqpxDTSeZbFtIoUOOlZXIT/Kc/0f55Yl/H
 XtRGjpcNfI7X81yaP/o9u0BrfwkoifSpVMke7s6cjaUUPDabSzw4MG+EkHppR+RHLo
 5XssEb8U7UZ1y+0NTm15xbxYC+9icWnGuWZVU0AQ5ulUX77GW0HA4I/9gLNF5pq+B0
 axw1ck0U4/yJL7s4mlpjX2v0bDEORK/2sktFwaaWKgiCZWPJ/gb6K9MYLx5MGI6xVh
 3Z6Ky5fG+7vhym7mITs1cBF6pkUniF6CrC6jGk8aiReOxefYLIYQjywCTkEhPJMEdo
 Hi8BywgbNXwMQ==
Message-ID: <6a50a23e-8975-43cb-9496-38b6a083c703@kernel.org>
Date: Sun, 7 Apr 2024 15:29:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20240403142420.2042498-1-chao@kernel.org>
 <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
X-Headers-End: 1rtMy3-0001SF-LT
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to relocate check condition in
 f2fs_fallocate()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC80LzcgMTA6MTEsIFpoaWd1byBOaXUgd3JvdGU6Cj4gT24gV2VkLCBBcHIgMywgMjAy
NCBhdCAxMDoyNuKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+Cj4+IGNv
bXByZXNzIGFuZCBwaW5maWxlIGZsYWcgc2hvdWxkIGJlIGNoZWNrZWQgYWZ0ZXIgaW5vZGUgbG9j
ayBoZWxkIHRvCj4+IGF2b2lkIHJhY2UgY29uZGl0aW9uLCBmaXggaXQuCj4+Cj4+IEZpeGVzOiA0
YzhmZjcwOTViZWYgKCJmMmZzOiBzdXBwb3J0IGRhdGEgY29tcHJlc3Npb24iKQo+PiBGaXhlczog
NWZlZDBiZTg1ODNmICgiZjJmczogZG8gbm90IGFsbG93IHBhcnRpYWwgdHJ1bmNhdGlvbiBvbiBw
aW5uZWQgZmlsZSIpCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4K
Pj4gLS0tCj4+ICAgZnMvZjJmcy9maWxlLmMgfCAyMCArKysrKysrKysrKy0tLS0tLS0tLQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+PiBpbmRleCAxNDhi
ZmUzZWZmZGYuLjgzYTgwN2UyNWUzMSAxMDA2NDQKPj4gLS0tIGEvZnMvZjJmcy9maWxlLmMKPj4g
KysrIGIvZnMvZjJmcy9maWxlLmMKPj4gQEAgLTE4MjAsMTUgKzE4MjAsNiBAQCBzdGF0aWMgbG9u
ZyBmMmZzX2ZhbGxvY2F0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IG1vZGUsCj4+ICAgICAgICAg
ICAgICAgICAgKG1vZGUgJiAoRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFIHwgRkFMTE9DX0ZMX0lO
U0VSVF9SQU5HRSkpKQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4K
Pj4gLSAgICAgICAvKgo+PiAtICAgICAgICAqIFBpbm5lZCBmaWxlIHNob3VsZCBub3Qgc3VwcG9y
dCBwYXJ0aWFsIHRydW5jYXRpb24gc2luY2UgdGhlIGJsb2NrCj4+IC0gICAgICAgICogY2FuIGJl
IHVzZWQgYnkgYXBwbGljYXRpb25zLgo+PiAtICAgICAgICAqLwo+PiAtICAgICAgIGlmICgoZjJm
c19jb21wcmVzc2VkX2ZpbGUoaW5vZGUpIHx8IGYyZnNfaXNfcGlubmVkX2ZpbGUoaW5vZGUpKSAm
Jgo+PiAtICAgICAgICAgICAgICAgKG1vZGUgJiAoRkFMTE9DX0ZMX1BVTkNIX0hPTEUgfCBGQUxM
T0NfRkxfQ09MTEFQU0VfUkFOR0UgfAo+PiAtICAgICAgICAgICAgICAgICAgICAgICBGQUxMT0Nf
RkxfWkVST19SQU5HRSB8IEZBTExPQ19GTF9JTlNFUlRfUkFOR0UpKSkKPj4gLSAgICAgICAgICAg
ICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4gLQo+PiAgICAgICAgICBpZiAobW9kZSAmIH4oRkFM
TE9DX0ZMX0tFRVBfU0laRSB8IEZBTExPQ19GTF9QVU5DSF9IT0xFIHwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIEZBTExPQ19GTF9DT0xMQVBTRV9SQU5HRSB8IEZBTExPQ19GTF9aRVJPX1JB
TkdFIHwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIEZBTExPQ19GTF9JTlNFUlRfUkFOR0Up
KQo+PiBAQCAtMTgzNiw2ICsxODI3LDE3IEBAIHN0YXRpYyBsb25nIGYyZnNfZmFsbG9jYXRlKHN0
cnVjdCBmaWxlICpmaWxlLCBpbnQgbW9kZSwKPj4KPj4gICAgICAgICAgaW5vZGVfbG9jayhpbm9k
ZSk7Cj4+Cj4+ICsgICAgICAgLyoKPj4gKyAgICAgICAgKiBQaW5uZWQgZmlsZSBzaG91bGQgbm90
IHN1cHBvcnQgcGFydGlhbCB0cnVuY2F0aW9uIHNpbmNlIHRoZSBibG9jawo+PiArICAgICAgICAq
IGNhbiBiZSB1c2VkIGJ5IGFwcGxpY2F0aW9ucy4KPj4gKyAgICAgICAgKi8KPj4gKyAgICAgICBp
ZiAoKGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSB8fCBmMmZzX2lzX3Bpbm5lZF9maWxlKGlu
b2RlKSkgJiYKPj4gKyAgICAgICAgICAgICAgIChtb2RlICYgKEZBTExPQ19GTF9QVU5DSF9IT0xF
IHwgRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFIHwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
RkFMTE9DX0ZMX1pFUk9fUkFOR0UgfCBGQUxMT0NfRkxfSU5TRVJUX1JBTkdFKSkpIHsKPj4gKyAg
ICAgICAgICAgICAgIHJldCA9IC1FT1BOT1RTVVBQOwo+PiArICAgICAgICAgICAgICAgZ290byBv
dXQ7Cj4+ICsgICAgICAgfQo+PiArCj4gRGVhciBDaGFvLAo+IEkgc2VlICB0aGUganVkZ21lbnQg
Y29kZSAiaWYoIWYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSkiIGFsc28gaXMKPiBiZWZvcmUg
aW5vZGVfbG9jayBpbiBmdW5jdGlvbnMKPiBmMmZzX2lvY19kZWNvbXByZXNzX2ZpbGUvZjJmc19p
b2NfY29tcHJlc3NfZmlsZS9mMmZzX3Jlc2VydmVfY29tcHJlc3NfYmxvY2tzL2YyZnNfcmVsZWFz
ZV9jb21wcmVzc19ibG9ja3MuCj4gc2hvdWxkIHRoZXkgYXJlIGNoYW5nZWQgdG9nZXRoZXI/Cgpa
aGlndW8sCgpUaGFua3MgZm9yIG5vdGljaW5nIHRoYXQsIEkndmUgc3VibWl0dGVkIHNlcGFyYXRl
ZCBwYXRjaGVzIGZvciBmaXhpbmcKYmVjYXVzZSB0aG9zZSBidWdzIHdlcmUgaW50cm9kdWNlZCBi
eSBzZXBhcmF0ZWQgY29tbWl0cy4KClRoYW5rcywKCj4gdGhhbmtz77yBCj4+ICAgICAgICAgIHJl
dCA9IGZpbGVfbW9kaWZpZWQoZmlsZSk7Cj4+ICAgICAgICAgIGlmIChyZXQpCj4+ICAgICAgICAg
ICAgICAgICAgZ290byBvdXQ7Cj4+IC0tCj4+IDIuNDAuMQo+Pgo+Pgo+Pgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdAo+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+
PiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAo=
