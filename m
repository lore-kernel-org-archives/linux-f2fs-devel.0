Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA6FCA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JeoELnyPjxrjav6glUe1RcbUhzGXK6fqEyi1uDTKYz8=; b=acGa/aHtr7jaBYMCjSPvqGhR1z
	KlT7DT3yyI35KsPncWi1qSCwpQ7oNZuaRoN6sL//fuaVlSqRflklNWxjrxR5Xaxeb1uq0NwSzh9du
	ORCZqp1a2XQ3rPGJoiHggi6SxVkSC5UdYc8ncqHMgdl2hcusHli9e7KovVJI7+EhGB1k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGCUg-00025p-DC;
	Mon, 12 Oct 2026 09:38:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGCUf-00025i-3a
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cbGm0ooFL5x122fX56bjjFxfgMNdMgVemH53wo0GHuA=; b=H+kt7VPFSeDGD1d4tnEbGgOdCG
 ODxDvE+aWIweq0fvxfvZeYT5fI33I/G5tLcxqmsbHRNM4VQBXfp3S+xqbTTnfgWIsROwZ3aF8dEd7
 MADnETYehg0nflqd8ToisR4n+eFfjn4RMugQfe2oSNktSDyUYF5xqGB4PKSCwCn/MWbM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cbGm0ooFL5x122fX56bjjFxfgMNdMgVemH53wo0GHuA=; b=MHpg8CyC6ZRWJDjKXV1LbpOTN6
 kHtOYnzMS5LApctrPCrp3G/jgCgTAtUgJ8a9dd/MqE4Ocyxbmp8j3y5IHorvUaqRbECccEwi/0SNw
 gG/OV3adYEYcygaigLzI7YXxiG8r/e9LpW65RrpGFL8qYicw29h0EgVLhHeoTf2UkE9w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGCUd-0003wO-4T for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:38:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABB9F419FC;
 Mon, 12 Oct 2026 09:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECBC1F0089B;
 Mon, 12 Oct 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791797925;
 bh=cbGm0ooFL5x122fX56bjjFxfgMNdMgVemH53wo0GHuA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=HwkG1TfsGDfCwohFYeWHULwS3HfN4RvifIiB2xRE/bhWlXRJveDzDobjv31wJZWmM
 U+Sk8g2ikaNaWKhyyqNx76QrFkG2rk3ZRv+xCoOiOaY+f2n+SHjFHmhXVcjgCDaW0f
 QFG1oFVeT1RImBV1M5mQyossmeXkqCMX5UOh/5iX7bLu3NHf4/nCwisBuJi9T8eeNn
 XAjoqUCdXKPMvOPeTZFpvxv0bBAVM0vhBbO9Do+10xGiX/qkO5ydEGa3FopdejZr3E
 4WszOtn0YFW4T7TLQ/u2XB0wCmbMNtxV7ZN35k8X1rqPyT7cGCtXOsIbgzFewoUz7C
 M+BFsOt942wIQ==
Message-ID: <70015ca7-6581-4c26-ade7-42418193118c@kernel.org>
Date: Mon, 12 Oct 2026 17:38:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>
References: <20261009095335.749891-1-joannechien@google.com>
 <2ae11ebc-dd27-409f-9b9f-a153fe310178@kernel.org>
 <CACQK4XALrKkq3jphYVxDoni7T0_Ez-T7QXZfbmNdRzM6GdAdHQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACQK4XALrKkq3jphYVxDoni7T0_Ez-T7QXZfbmNdRzM6GdAdHQ@mail.gmail.com>
X-Headers-End: 1xGCUd-0003wO-4T
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: allow pinning empty compressed files
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMTAvMTIvMjYgMTc6MjcsIEpvYW5uZSBDaGFuZyB3cm90ZToKPiBPbiBTdW4sIE9jdCAxMSwg
MjAyNiBhdCA0OjMx4oCvUE0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPj4KPj4g
T24gMTAvOS8yNiAxNzo1MywgSm9hbm5lIENoYW5nIHdyb3RlOgo+Pj4gQ29tbWl0IGE2NGEzZmVj
MTFlNyAoImYyZnM6IGZvcmNlIG91dC1wbGFjZSB1cGRhdGUgZm9yIGFsbCB3cml0ZXMgb24KPj4+
IGNvbXByZXNzZWQgZmlsZSIpIHVwZGF0ZWQgZjJmc19zaG91bGRfdXBkYXRlX291dHBsYWNlKCkg
dG8gYWx3YXlzCj4+PiByZXR1cm4gdHJ1ZSBmb3IgY29tcHJlc3NlZCBmaWxlcy4gSG93ZXZlciwg
dGhpcyBmdW5jdGlvbiBpcyBhbHNvCj4+PiBjYWxsZWQgZHVyaW5nIGYyZnNfaW9jX3NldF9waW5f
ZmlsZSgpIHZhbGlkYXRpb24sIHNvIHBpbm5pbmcgYW4KPj4+IGVtcHR5IGZpbGUgd2l0aCBjb21w
cmVzc2lvbiBlbmFibGVkIG5vdyBmYWlscyB3aXRoIC1FSU5WQUwgYmVmb3JlIHRoZQo+Pj4gY29t
cHJlc3Npb24gZmxhZyBjYW4gYmUgc3RyaXBwZWQuCj4+Cj4+IEJ1dCwgSSB0aGluayBpdCdzIGFz
IGV4cGVjdGVkLCB3ZSBmb3JjZSBjb21wcmVzc2VkIGZpbGUgdG8gT1BVLCBhbmQgcGluZmlsZQo+
PiB0byBJUFUsIGl0J3MgY29uZmxpY3QuCj4gCj4gVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhl
IHBhdGNoLiBJIHVuZGVyc3RhbmQgdGhhdCBjb21wcmVzc2VkIGZpbGVzCj4gY2Fubm90IGJlIHBp
bm5lZCBiZWNhdXNlIGNvbXByZXNzZWQgZmlsZXMgbmVlZCBPUFUuCj4gCj4gVGhlIGNhc2UgSSB3
YW50IHRvIGNoZWNrIGlzIHBpbm5pbmcgYSBjb21wcmVzc2VkIGZpbGUgd2l0aCBubyBibG9ja3Mu
Cj4gZjJmc19pb2Nfc2V0X3Bpbl9maWxlKCkgb25seSBhbGxvd3MgcGlubmluZyBmaWxlcyB3aXRo
IG5vIGJsb2NrcywgYW5kCj4gYWxzbyBjYWxscyBmMmZzX2Rpc2FibGVfY29tcHJlc3NlZF9maWxl
KCkgdG8gY2xlYXIgdGhlIGNvbXByZXNzaW9uIGZsYWcsCgpBaCwgb2theSwgSSBtaXNzZWQgdG8g
Y2hlY2sgZjJmc19kaXNhYmxlX2NvbXByZXNzZWRfZmlsZSgpIGxvZ2ljIGJlbG93CmYyZnNfc2hv
dWxkX3VwZGF0ZV9vdXRwbGFjZSgpLCB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4KClRoYW5r
cywKCj4gc28gdGhlcmUgaXMgbm8gY29uZmxpY3Qgd2l0aCBJUFUgZm9yIHN1Y2ggYSBmaWxlLiBJ
ZiBJIHVuZGVyc3RhbmQKPiBjb3JyZWN0bHksIHRoaXMgaXMgYWxsb3dlZCBvbiB6b25lZCBkZXZp
Y2VzIGFzIHRoZQo+IGYyZnNfc2hvdWxkX3VwZGF0ZV9vdXRwbGFjZSgpIGNoZWNrIGlzIHNraXBw
ZWQgdGhlcmUuCj4gCj4gQmVzdCByZWdhcmRzLAo+IEpvYW5uZQoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
