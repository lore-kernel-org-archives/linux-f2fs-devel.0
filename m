Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D497C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCncc4V+lSL0jX6TZomKaRqtbM3HgwYkRFgAA2rKZJg=; b=FSe1TUMwj0hXotugTb3fY8lbu9
	hBOAK8+6PEifE27rcOr5GivvFepjvTgu3RwxfcaCjnlcTBVJj7V/Oqy3vxks1Ydhh1XjuTeoF+tP3
	MpTKxC9Fv5He34P8S5+UiRrYJiH71qUE/cg2cSqLoQrIJWu01c5wwTzo+8P5MXA+yHbo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzvwd-0002LD-47;
	Fri, 28 Aug 2026 12:44:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wzvwH-0002Kh-Vq
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ik4UTvCRWlHGzsRjaFiqWKeE9mIxAcODYAJWayWGWU=; b=N1czRq/1cWzSMthd5kAvJCfydF
 6OwLTpi5y/efKVqMjcros4SWoSwU9zKbhZ3IkPUVD95ZofaZ2F4HVFBFHy5dK/w8FNZ4oneAWZB0d
 peFfp4b0QG2AYULk4jNbvfZncJl2zXslOg7MMoTWi4Osefb2vfCOjWCNRwS8FCf6LzGE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3ik4UTvCRWlHGzsRjaFiqWKeE9mIxAcODYAJWayWGWU=; b=kLlccyedb84ureugLvBKt+hF1C
 BNgfqWr0hhg/Wr4Jt/eMhZ4xYG7P0CWsRc0FaKUsmpakPQhREE7hCXpE3DIb1AKjQ53HqfBv/Xm0b
 X6GWalv9eXN5YzdeFs4VkjNZqbtaU/IZw+0Z3plOg+CjUr3OKtDuDQbz3WO5Z6oYQ5/8=;
Received: from smtp153-168.sina.com.cn ([61.135.153.168])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzvw6-00033s-TM for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1787921039; bh=3ik4UTvCRWlHGzsRjaFiqWKeE9mIxAcODYAJWayWGWU=;
 h=Message-ID:Date:Subject:From;
 b=LCHlB5LT5jqJjljjI1idLPjkevKOOQPAxIQMgFQkkhhkJXCPQOAXgTvrCCl46KOwH
 UuD2ZePtrlpSfZuYaZiN1SqW6eug1DmgbbWbCVw/PduhZzhGBfx2G53Y5IIBqyjhra
 3C1eyFKNbVD978efiDRrKMimwRtD0wgZpePsGafk=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 6A91828200002936; Fri, 28 Aug 2026 20:43:48 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 7226316685056
X-SMAIL-UIID: B832BBC10A4B4FCD9385103C4E80712C-20260828-204348-1
Message-ID: <86284b5b-b9bf-442c-bf7b-637c79763b43@sina.com>
Date: Fri, 28 Aug 2026 20:43:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Yongpeng Yang
 <yangyongpeng.storage@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
 <70a44f25-f38b-473e-b941-e001229a97c4@gmail.com>
 <c4eb34be-628f-45a7-ab5b-9ac55b48f83a@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <c4eb34be-628f-45a7-ab5b-9ac55b48f83a@kernel.org>
X-Headers-End: 1wzvw6-00033s-TM
Subject: Re: [f2fs-dev] [PATCH v2 0/3] f2fs: fix read extent cache merge and
 add debug interface
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yOC8yNiAyMDozMSwgQ2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCB3cm90ZToKPiBZ
b25ncGVuZywKPiAKPiBTb3JyeSwgdG9vIGJ1c3kgdGhlc2UgZGF5cywgc28gSSBoYXZlIHRvIGFk
ZCB0aGlzIHNlcmlhbCBhbmQgaW5saW5lIGV4dGVudAo+IGludG8gbXkgVE9ETyByZXZpZXcgbGlz
dC4gOiBQCj4gCj4gTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgdXJnZW50IGZpeCB0aGF0IG5lZWRz
IHRvIHVwc3RyZWFtLgoKSSdtIG5vdCBpbiBhIGh1cnJ5LiA6KQoKVGhhbmtzLApZb25ncGVuZwoK
PiAKPiBPbiA4LzI1LzI2IDEwOjQ2LCBZb25ncGVuZyBZYW5nIHdyb3RlOgo+PiBPbiA4LzE1LzI2
IDAwOjQ5LCBZb25ncGVuZyBZYW5nIHdyb3RlOgo+Pj4gRnJvbTogWW9uZ3BlbmcgWWFuZyA8eWFu
Z3lvbmdwZW5nQHhpYW9taS5jb20+Cj4+Pgo+Pj4gVGhpcyBzZXJpZXMgZml4ZXMgYSByZWFkIGV4
dGVudCBjYWNoZSBtZXJnZSBidWcgYW5kIGFkZHMgYSBzeXNmcy1iYXNlZAo+Pj4gZGVidWcgaW50
ZXJmYWNlIGZvciBpbnNwZWN0aW5nIHRoZSBpbi1tZW1vcnkgZXh0ZW50IHRyZWUsIHdoaWNoIGlz
Cj4+PiBvdGhlcndpc2UgaW52aXNpYmxlIHRvIHVzZXJzcGFjZSAoZnNjayBjYW4gb25seSBzZWUg
dGhlIG9uLWRpc2sgaV9leHQsCj4+PiBuZXZlciB0aGUgaW4tbWVtb3J5IHJidHJlZSkuCj4+Pgo+
Pj4gQ2hhbmdlcyBzaW5jZSB2MSAoUkVTRU5EIFsxXSk6Cj4+Pgo+Pj4gLSBQYXRjaCAxICh3YXMg
MS81KSByZXVzZSB0aGUgcmVzdWx0IG9mIF9faXNfYmFja19tZXJnZWFibGUoKS4KPj4+Cj4+PiAt
IERyb3BwZWQgW1BBVENIIFJFU0VORCAyLzVdICJvbmx5IGluaXRpYWxpemUgbGFyZ2VzdCBleHRl
bnQgd2l0aG91dAo+Pj4gwqDCoCBleHRlbnRfbm9kZSBhdCBpbm9kZSBpbml0Ijogbm8gYmVuZWZp
dCB3YXMgb2JzZXJ2ZWQgaW4gcHJhY3RpY2UuCj4+Pgo+Pj4gLSBQYXRjaCAyICh3YXMgMy81KSB1
bmNoYW5nZWQuCj4+Pgo+Pj4gLSBEcm9wcGVkIFtQQVRDSCBSRVNFTkQgNC81XSAiYWRkIGV4dGVu
dF9hY2Nlc3NfbW9kZSB0byB0cmFjayBleHRlbnQKPj4+IMKgwqAgY2FjaGUgYWNjZXNzIHBhdHRl
cm5zIjogb24gcGhvbmVzIHRoZSByZWFkIGV4dGVudCBub2RlIG1lbW9yeSBidWRnZXQKPj4+IMKg
wqAgaXMgc21hbGwsIGFuZCBubyBoaXQtcmF0aW8gaW1wcm92ZW1lbnQgd2FzIG9ic2VydmVkIGlu
IHBlcmZvcm1hbmNlCj4+PiDCoMKgIHRlc3RzLgo+Pj4KPj4+IC0gUGF0Y2ggMyAod2FzIDUvNSkg
LS0gcmVwbGFjZSB0aGUgaW9jdGwgd2l0aCBhIHdyaXRlLW9ubHkgcGVyLXNiIHN5c2ZzCj4+PiDC
oMKgIGVudHJ5IGBleHRlbnRfY2FjaGVfZGVidWdgLiBXcml0aW5nIGEgZmlsZSBkZXNjcmlwdG9y
IHRvIGl0IHJlc29sdmVzCj4+PiDCoMKgIHRoZSBpbm9kZSBpbiB0aGUgd3JpdGVyJ3MgY29udGV4
dCwgZHVtcHMgdGhlIGxhcmdlc3QgZXh0ZW50IGFuZCBldmVyeQo+Pj4gwqDCoCByYnRyZWUgbm9k
ZSAoZm9mcy9ibGsvbGVuKSB0byB0aGUga2VybmVsIGxvZyB2aWEgZjJmc19pbmZvKCk7IGluc3Bl
Y3QKPj4+IMKgwqAgd2l0aCAiZG1lc2cgfCBncmVwIGlubz08aW5vPiIuIEEgbWF0Y2hpbmcgZjJm
c19pbyBgZXh0ZW50X2NhY2hlYAo+Pj4gwqDCoCBzdWJjb21tYW5kIGlzIGFkZGVkIGluIGYyZnMt
dG9vbHMuCj4+Pgo+Pj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDYxMjEx
NTgzOS4yMDY1OTAzLTEtCj4+PiB5YW5neW9uZ3Blbmcuc3RvcmFnZUBnbWFpbC5jb20vCj4+Pgo+
Pj4gUGF0Y2ggMTogZml4IGV4dGVudCBtZXJnZSBmYWlsdXJlIHdoZW4gbGFyZ2VzdCBleHRlbnQg
aXMgbm90IGluIHJiLXRyZWUuCj4+PiDCoMKgIFdoZW4gdGhlIGxhcmdlc3QgZXh0ZW50IGV4aXN0
cyBvbmx5IGFzIGEgaGludCB3aXRoIG5vIHJidHJlZSBub2RlCj4+PiDCoMKgIChlLmcuIGFmdGVy
IHNocmluayBldmljdGlvbiksIGEgbmV3bHkgaW5zZXJ0ZWQgZXh0ZW50IHRoYXQgaXMKPj4+IMKg
wqAgbWVyZ2VhYmxlIHdpdGggaXQgaXMgbm90IG1lcmdlZCwgbGVhdmluZyBhIGdhcCB0aGF0IGZp
ZW1hcCByZXBvcnRzIGFzCj4+PiDCoMKgIHNlcGFyYXRlIGV4dGVudHMuwqAgTWVyZ2UgdGhlIG5l
dyBleHRlbnQgd2l0aCB0aGUgbGFyZ2VzdCBiZWZvcmUgdGhlCj4+PiDCoMKgIG5vcm1hbCBsb29r
dXAuCj4+Pgo+Pj4gUGF0Y2ggMjogcHVuY2ggbGFyZ2VzdCBleHRlbnQgaW5zdGVhZCBvZiBkcm9w
cGluZyBpdCBlbnRpcmVseSBvbgo+Pj4gwqDCoCBvdmVybGFwLsKgIEtlZXAgdGhlIGxhcmdlciBy
ZW1haW5pbmcgbGVmdC9yaWdodCBwb3J0aW9uIGFmdGVyIGEKPj4+IMKgwqAgcGFydGlhbCBvdmVy
bGFwIGluc3RlYWQgb2YgZGlzY2FyZGluZyB0aGUgd2hvbGUgbGFyZ2VzdCBleHRlbnQsCj4+PiDC
oMKgIHByZXNlcnZpbmcgY2FjaGUgY292ZXJhZ2UgZm9yIHRydW5jYXRlL292ZXJ3cml0ZS4KPj4+
Cj4+PiBQYXRjaCAzOiBkdW1wIHJlYWQgZXh0ZW50IGNhY2hlIHZpYSBzeXNmcyBmb3IgZGVidWdn
aW5nLgo+Pj4KPj4+IFlvbmdwZW5nIFlhbmcgKDMpOgo+Pj4gwqDCoCBmMmZzOiBmaXggZXh0ZW50
IG1lcmdlIGZhaWx1cmUgd2hlbiBsYXJnZXN0IGV4dGVudCBpcyBub3QgaW4gcmItdHJlZQo+Pj4g
wqDCoCBmMmZzOiBwdW5jaCBsYXJnZXN0IGV4dGVudCBpbnN0ZWFkIG9mIGRyb3BwaW5nIGl0IGVu
dGlyZWx5IG9uIG92ZXJsYXAKPj4+IMKgwqAgZjJmczogZHVtcCByZWFkIGV4dGVudCBjYWNoZSB2
aWEgc3lzZnMgZm9yIGRlYnVnZ2luZwo+Pj4KPj4+IMKgIGZzL2YyZnMvZXh0ZW50X2NhY2hlLmMg
fCAxMDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPj4+IMKgIGZz
L2YyZnMvZjJmcy5owqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPj4+IMKgIGZzL2YyZnMvc3lz
ZnMuY8KgwqDCoMKgwqDCoMKgIHzCoCAxOCArKysrKysrCj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQs
IDExMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Pj4KPj4+IC0tIAo+Pj4gMi40My4w
Cj4+Pgo+Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4+PiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+Pj4gTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPj4KPj4gcGluZwo+Pgo+PiBUaGFua3Ms
Cj4+IFlvbmdwZW5nCj4+Cj4gCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
