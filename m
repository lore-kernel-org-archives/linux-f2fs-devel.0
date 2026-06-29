Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0460DC43327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URkvf9MBNG4hK2+EjnXEVLe4bDF25Ho9wKgQmuJtwJI=; b=mFg3+9gZawHhsJIkuA+C/1nf4H
	6P2dOy2b2flFGh1oGcDE3j8FnWWA5KP4mTXcrLi0yYE/bj1nLudOb3PIWFJwH1d7946H/8eWnly0X
	a+MAyFQ7gsTwAjC9niQYIv9zNkiE8tnckD6vVf1uHxxku8w/RT57TErpPH6OFNb2ED+M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weA2s-0001P6-3p;
	Mon, 29 Jun 2026 11:20:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weA2W-0001Oi-Ip
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MuPLRfexlptKX+RaEs0SK/NmA/ICCUEIUoYkCLNNsTw=; b=bKXYLzXE+h/RNGujWTeQZ0MaHn
 8kd7zgCBff5eqqFidLCVpWVpma3qOsJ8VvijUQa3rgE6xpOzHXAg8Lt8/S6LNBlSxqC1KPuRw7CLK
 VilpGWrH9Mu7j9FXI7uazLA/mXzIEvu66CJ6gYItdlUE807eSUWt6ucs52NtHbpSoMjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MuPLRfexlptKX+RaEs0SK/NmA/ICCUEIUoYkCLNNsTw=; b=RMzgDICFLfSVCjjKzpATZ5enCt
 CvkiCmaWvXGmMJxxmHOV9SrWd5343l3I0FbLBS7Ut8wwSFYkWAI24AFn8wi49Vc+CfCqo5wacdi9J
 +m5/JlPXV1ecZpUEqy2wDBAPLpSO3ecWAsYrsESYPNGoSKcjaFIJCS65OnW5E0cDTUdY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weA2R-00078k-RG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:20:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F419F4134A;
 Mon, 29 Jun 2026 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA091F000E9;
 Mon, 29 Jun 2026 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782732021;
 bh=MuPLRfexlptKX+RaEs0SK/NmA/ICCUEIUoYkCLNNsTw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fwFrD4H+YJ7eebWy9aTEiEfjGBXtmmi3lZtCGIie5x802KQn5enMYMENp4tBKxhB7
 3njNi1Cdf1Wr87PDUdmBBLhOZE0u5PLkSWqr4h8kSPLqE+323VmDAJdBAejeRTgTut
 X/7QILMNSS1qdJCqdP+EwUB0dWCjDJihH8tXI3adVGSd+smHCBTvJxsMYLF5u0JcS/
 wuaSUVL4dUTWxVE6U3lRlMq+13aLmrxwm/QD0tiMrB18UPWdKyt8TOqda1UPhPmbDE
 NDFGtvXrjGZs+ScRfENJMD/WHT3HNGnH/kzLmoN0ucRom2+wJBEQjU8bBmZVtk3GHt
 xRwyq1bay+D3A==
Message-ID: <56739c99-ad0e-455d-8781-37aca2efc809@kernel.org>
Date: Mon, 29 Jun 2026 19:20:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>
References: <ajwtQRawMxcQkyo8@casper.infradead.org>
 <ca56ceb7-b0a7-41f2-9b26-085e81456794@amlogic.com>
 <324cc5b6-ebfd-4696-b2f4-33710b771249@kernel.org>
 <akHsfps-sQ1INJfS@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <akHsfps-sQ1INJfS@casper.infradead.org>
X-Headers-End: 1weA2R-00078k-RG
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

T24gNi8yOS8yNiAxMTo1NCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4gW0FkZGluZyBKYW4gS2Fy
YTsgcmV0YWluaW5nIHdob2xlIG1lc3NhZ2UgZm9yIGNvbnRleHRdCj4gCj4gT24gTW9uLCBKdW4g
MjksIDIwMjYgYXQgMDk6Mzk6MjVBTSArMDgwMCwgQ2hhbyBZdSB3cm90ZToKPj4gT24gNi8yNi8y
NiAxNzozMCwgSml1Y2hlbmcgWHUgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDYvMjUvMjAyNiAzOjE3
IEFNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToKPj4+PiBbIEVYVEVSTkFMIEVNQUlMIF0KPj4+Pgo+
Pj4+IEhpIEppdWNoZW5nLAo+Pj4+Cj4+Pj4gSSBhbSB0cnlpbmcgdG8gcmVtb3ZlIEZHUF9OT0ZT
IGZyb20gdGhlIGtlcm5lbCBhbmQgdGhlIGxhc3QgcmVtYWluaW5nCgpNYXR0aGV3LAoKV2hhdCBh
Ym91dCB0aGlzIHR3byBzdGVwcyBwcm9wb3NhbD8KCjEuIFVzZSBtZW1hbGxvY19ub2ZzX3NhdmUo
KSBhbmQgbWVtYWxsb2Nfbm9mc19yZXN0b3JlKCkgdG8gcmVwbGFjZSBGR1BfTk9GUwpvciBHRlBf
Tk9GUywgdGhlbiB5b3UgY2FuIGhhbmRsZSBGR1BfTk9GUyBhbmQgR0ZQX05PRlMgYXMgeW91IHBs
YW5lZC4KMi4gdGhlbiBJIGNhbiBwcm9wb3NlIGFub3RoZXIgUkZDIHBhdGNoIHRvIGRyb3AgbWVt
YWxsb2Nfbm9mcyouIEkgZ3Vlc3MgaXQKbmVlZHMgc29tZSB0aW1lIHRvIHRlc3Qgc2luY2UgSSBz
dXNwZWN0IHRoZXJlIG1heSBiZSBwb3RlbnRpYWwgZGVhZGxvY2sgZHVlCnRvIGNvbXBsaWNhdGVk
IGxvY2sgaW1wbGVtZW50YXRpb24uLi4KClRoYW5rcywKCj4+Pj4gdXNlciB3YXMgYWRkZWQgYnkg
eW91IGxhc3QgeWVhciBpbiBjb21taXQgMjMwOGRlMjdjMDNkLsKgIEknbSB0cnlpbmcgdG8KPj4+
PiB1bmRlcnN0YW5kIHdoeS7CoCBEaWQgeW91IHNlZSBhbiBhY3R1YWwgcHJvYmxlbSBpZiB5b3Ug
ZG8gbm90IHVzZSBpdCwKPj4+PiBvciB3YXMgaXQgdGhlb3JldGljYWw/wqAgVGhlIGNvbW1pdCBt
ZXNzYWdlIHNheXMgInRvIGF2b2lkIHBvdGVudGlhbAo+Pj4+IGRlYWRsb2NrIGlzc3VlcyIsIGJ1
dCBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGV0aGVyIHlvdSBrbm93IHRoZXkgYXJlCj4+Pj4gdGhl
cmUsIG9yIG9ubHkgdGhpbmsgdGhleSBhcmUgdGhlcmUuCj4+Pj4KPj4+PiBJJ2QgcmVhbGx5IGxp
a2UgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSBpc3N1ZXMgYXJlIGFzIHRoZSBub3JtYWwgaXNzdWVz
Cj4+Pj4gd2hpY2ggbWFrZSBjYWxsaW5nIGludG8gdGhlIGZpbGVzeXN0ZW0gKGhvbGRpbmcgYW5v
dGhlciBmb2xpbyBsb2NrZWQsCj4+Pj4gaG9sZGluZyBhIG11dGV4IHJlbGllZCB1cG9uIGJ5IHJl
Y2xhaW0pIGRvbid0IHNlZW0gdG8gYmUgcHJlc2VudC4KPj4+PiBTbyBpZiB0aGVyZSBpcyBzb21l
dGhpbmcsIEknbSBub3Qgc3VyZSB3aGF0IGl0IGlzLgo+Pj4gSGkgTWF0dGhldywKPj4+Cj4+PiBU
aGUgRkdQX05PRlMgZmxhZyB3YXMgc3VnZ2VzdGVkIGJ5IENoYW8gYW5kIG5vdCBhZGRpbmcgaXQg
bWlnaHQgbGVhZCB0byBkZWFkbG9jayBpc3N1ZXMuCj4+Pgo+Pj4gQENoYW8gY291bGQgeW91IGV4
cGxhaW4gdGhpcyBmb3IgTWF0dGhldz8KPj4KPj4gSGkgTWF0dGhldywgSml1Y2hlbmcsCj4+Cj4+
IElJUkMsIGZvciBub3JtYWwgcGF0aCBmcm9tIHdyaXRlIC0+IHdyaXRlX2JlZ2luLCBpdCBzZWVt
cyBmaW5lIHNpbmNlIHRoZXJlIGlzCj4+IG5vIGYyZnMtc3BlY2lmaWVkIG11dGV4IG9yIG90aGVy
IGZvbGlvIGxvY2sgaW4gdGhlIHBhdGgsIGJ1dCBJIHdhcyB3b3JyaWVkIGFib3V0Cj4+IHF1b3Rh
IHBhdGggd2hlbiBJIHN1Z2dlc3RlZCB0byBrZWVwIEdGUF9OT0ZTIGZsYWcsIGFzIHRoZSBsb2Nr
IHJhY2UgY29uZGl0aW9uCj4+IGlzIHF1aXRlIGNvbXBsaWNhdGVkIHRoZXJlOiBmMmZzIGludGVy
bmFsIGxvY2sgdnMgcXVvdGEgc3lzdGVtIGxvY2sgdnMgZm9saW8gbG9jay4uLgo+Pgo+PiBJIHNl
YXJjaGVkIHRoZSBjb21taXRzIGFuZCBmb3VuZCB0aGlzOgo+Pgo+PiBDb21taXQgMDIxMTdiOGFl
OWMwICgiZjJmczogU2V0IEdGX05PRlMgaW4gcmVhZF9jYWNoZV9wYWdlX2dmcCB3aGlsZSBkb2lu
Zwo+PiBmMmZzX3F1b3RhX3JlYWQiKQo+Pgo+PiBJbiB0aGlzIGNhc2UsIGYyZnNfcXVvdGFfcmVh
ZCgpIHdhcyBjYWxsaW5nIHJlYWRfbWFwcGluZ19wYWdlKCksIHdoaWNoIGFsbG93ZWQKPj4gR0ZQ
X0ZTIGFsbG9jYXRpb25zLiBUaGlzIHRyaWdnZXJlZCB0aGUgZm9sbG93aW5nIGRlYWRsb2NrOgo+
Pgo+PiAgICAgVGhyZWFkIDEgKFVzZXIgT3Blbi9Xcml0ZSkKPj4gICAgIC0gZG9fc3lzX29wZW4K
Pj4gICAgICAtIHZmc19vcGVuCj4+ICAgICAgIC0gZHF1b3RfZmlsZV9vcGVuCj4+ICAgICAgICAt
IGRxdW90X2luaXRpYWxpemUKPj4gICAgICAgICAtIGRxZ2V0Cj4+ICAgICAgICAgIC0gZHF1b3Rf
YWNxdWlyZQo+PiAgICAgICAgICAgOiBsb2NrcyAmZHFvcHQtPmRxaW9fbXV0ZXggKFZGUyBRdW90
YSBNdXRleCkKPj4gICAgICAgICAgIC0gcXRyZWVfcmVhZF9kcXVvdAo+PiAgICAgICAgICAgIC0g
ZjJmc19xdW90YV9yZWFkCj4+ICAgICAgICAgICAgIC0gcmVhZF9tYXBwaW5nX3BhZ2UgKEdGUF9L
RVJORUwgLyBhbGxvd3MgR0ZQX0ZTKQo+PiAgICAgICAgICAgICAgLSBfX2FsbG9jX3BhZ2VzX25v
ZGVtYXNrCj4+ICAgICAgICAgICAgICAgLSB0cnlfdG9fZnJlZV9wYWdlcyAoRGlyZWN0IFJlY2xh
aW0pCj4+ICAgICAgICAgICAgICAgIC0gcHJ1bmVfaWNhY2hlX3NiCj4+ICAgICAgICAgICAgICAg
ICAtIGV2aWN0Cj4+ICAgICAgICAgICAgICAgICAgLSBmMmZzX2V2aWN0X2lub2RlCj4+ICAgICAg
ICAgICAgICAgICAgIC0gZHF1b3RfZHJvcAo+PiAgICAgICAgICAgICAgICAgICAgLSBkcXB1dAo+
PiAgICAgICAgICAgICAgICAgICAgIC0gZHF1b3RfY29tbWl0Cj4+ICAgICAgICAgICAgICAgICAg
ICAgIDogdHJpZXMgdG8gbG9jayAmZHFvcHQtPmRxaW9fbXV0ZXggYWdhaW4KPj4gICAgICAgICAg
ICAgICAgICAgICAgPT0+IERFQURMT0NLICh3YWl0aW5nIGZvciBpdHNlbGYpCj4+Cj4+IEl0IG1h
eSB0cmlnZ2VyIGRlYWRsb2NrIGluIGYyZnNfcXVvdGFfd3JpdGUoKSBhcyB0aGUgc2FtZSB3YXkg
aW4gZjJmc19xdW90YV9yZWFkKCkKPj4gcGF0aD8gbGV0IG1lIGtub3cgaWYgSSdtIG1pc3Npbmcg
YW55dGhpbmcuCj4+Cj4+IEFyZSBtZW1hbGxvY19ub2ZzX3NhdmUoKSBhbmQgbWVtYWxsb2Nfbm9m
c19yZXN0b3JlKCkgcmVjb21tZW5kZWQgZm9yIHN1Y2ggY2FzZT8KPj4gYW55IHN1Z2dlc3Rpb25z
Pwo+IAo+IEluIGdlbmVyYWwsIHllcywgbWVtYWxsb2Nfbm9mc19zYXZlKCkgYWZ0ZXIgbG9ja2lu
ZyBkcWlvX211dGV4IHNvdW5kcyBsaWtlCj4gdGhlIHJpZ2h0IGlkZWEgdG8gbWUuICBJJ2Qgd2Fu
dCB0byBmYW1pbGlhcmlzZSBteXNlbGYgbW9yZSB0aG9yb3VnaGx5Cj4gd2l0aCB0aGUgY29kZSBi
ZWZvcmUgbWFraW5nIGEgZmlybSByZWNvbW1lbmRhdGlvbiwgYW5kIGl0J3MgcHJvYmFibHkKPiBx
dWlja2VyIHRvIGp1c3QgYXNrIEphbiA7LSkKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
