Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2BDC55838
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xnmfP2x2VmuLozg1AMa5+OyvN6jk5grjBZU/Luzb2LQ=; b=TFPGkt1+ezUMTMeI0Vdmat1S0z
	NvFzGgHwuFNXO921ELrdEHaUz+543qWc0zGO5C0PmCo/NQrsfFfFuF9MD48iGFBXqBTXd157e4PWq
	IlYSDVYzxkJFvrHGOnmuY9MtiymYv/aDdDEbMREfNb4G13ZNHKNI/UPQdXojdSiDo1ig=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrQOo-0005fO-0A;
	Wed, 05 Aug 2026 01:26:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wrQOm-0005fG-GQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjB5UbMgEH+fadVKrw/dy/5s6yUledcJxc4bfMv8qu4=; b=RcV7SFwvMDJuYhg9FX4dmidSZf
 GoBb2UF1CAOsAOCJT6W7Eo58PEAS5nVlK9XaGz7avoXwVUYPZiANaMsYLyNpTF/8O8AMOeoLmeYkT
 t2Fpg9hCEXYZKGD1nTx/cIy4usmPCXS0ll+4RlV2Y7lmma8DLbfZvLIaucecN83RwDMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RjB5UbMgEH+fadVKrw/dy/5s6yUledcJxc4bfMv8qu4=; b=cdIFmmvmj/+Y6WILPTx8vLjRKp
 080CH4TguZQUa/RTHn4DwZXL40LICQ7x1exNuis4SnpkdBLQyKt+dwojs4ZRXAFRuulvCDGGYl7At
 Mtu6Fxc3QSMcuOcHlW5fat8TBHJD/oOUHubeV6kFLwGV3Icd7TNNmgn//phCDWS1hl4k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrQOm-0005sk-Sg for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:26:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02C6B416C1;
 Wed,  5 Aug 2026 01:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B8F1F000E9;
 Wed,  5 Aug 2026 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785893175;
 bh=RjB5UbMgEH+fadVKrw/dy/5s6yUledcJxc4bfMv8qu4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=X7mNLcDrFEB4Tf3nzdJw55mPnMIZp3XUBD7jrTkOsH6adrH6BL1evXW1XK3Vu5FOT
 zzzkAetM2iMyNP6D+G66whLHr6feZu66vjZwnwDLy0CFnnrb3RMZyg1EY/cYnAniWe
 Ej96D1Dxc4lVBd4Q392xs81mKauUOi8lwX/xGIf3QDaPgbnkMiz3lyFCr83X7q5+vO
 BZKTODrV/A9grZiJt9FvvKqpah6A3qiaMED29xAGMFKF6Hm1hNqmqYMtyp6Z8xnNCO
 JtHjB/bkLXcMyMWc095EQVrpN2TZECxdSc4UIovy70v0N/LsepnQ4iX1i3Rm7j+zru
 f6LeBViG7AUCQ==
Date: Wed, 5 Aug 2026 01:26:13 +0000
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Message-ID: <anKRNeeIKO9K7Z2r@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-4-haoqinhuang7@gmail.com>
 <amr3P_4zxX2w7ZNR@google.com>
 <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>
 <anFspPi023HFlwwE@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anFspPi023HFlwwE@google.com>
X-Headers-End: 1wrQOm-0005sk-Sg
Subject: Re: [f2fs-dev] [PATCH v4 3/4] zram: validate parameters in each
 backend's setup_params
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Rongwei Wang <zigiwang@tencent.com>, Haoqin Huang <haoqinhuang@tencent.com>,
 haoqin huang <haoqinhuang7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMDgvMDQsIFNlcmdleSBTZW5vemhhdHNreSB3cm90ZToKPiBPbiAoMjYvMDgvMDMgMjA6MjAp
LCBoYW9xaW4gaHVhbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIEp1bCAzMCwgMjAyNiBhdCAzOjI04oCv
UE0gU2VyZ2V5IFNlbm96aGF0c2t5Cj4gPiA8c2Vub3poYXRza3lAY2hyb21pdW0ub3JnPiB3cm90
ZToKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay96cmFtL2JhY2tlbmRfbHo0aGMu
YyBiL2RyaXZlcnMvYmxvY2svenJhbS9iYWNrZW5kX2x6NGhjLmMKPiA+ID4gPiBpbmRleCBmNmEz
MzZhY2ZlMjAuLjVkNTUxZDE2NTIxMyAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Jsb2Nr
L3pyYW0vYmFja2VuZF9sejRoYy5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ibG9jay96cmFtL2Jh
Y2tlbmRfbHo0aGMuYwo+ID4gPiA+IEBAIC0yMCw2ICsyMCwxMSBAQCBzdGF0aWMgaW50IGx6NGhj
X3NldHVwX3BhcmFtcyhzdHJ1Y3QgemNvbXBfcGFyYW1zICpwYXJhbXMpCj4gPiA+ID4gIHsKPiA+
ID4gPiAgICAgICBpZiAocGFyYW1zLT5sZXZlbCA9PSBaQ09NUF9QQVJBTV9OT1RfU0VUKQo+ID4g
PiA+ICAgICAgICAgICAgICAgcGFyYW1zLT5sZXZlbCA9IExaNEhDX0RFRkFVTFRfQ0xFVkVMOwo+
ID4gPiA+ICsgICAgIGVsc2UgaWYgKHBhcmFtcy0+bGV2ZWwgPCBMWjRIQ19NSU5fQ0xFVkVMIHx8
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgcGFyYW1zLT5sZXZlbCA+IExaNEhDX01BWF9DTEVWRUwp
IHsKPiA+ID4gPiArICAgICAgICAgICAgIHByX2VycigibHo0aGM6IGludmFsaWQgY29tcHJlc3Np
b24gbGV2ZWwgJWRcbiIsIHBhcmFtcy0+bGV2ZWwpOwo+ID4gPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7Cj4gPiA+ID4gKyAgICAgfQo+ID4gPgo+ID4gPiBTby4uLiAgbGliL2x6NC9s
ejRoY19jb21wcmVzcy5jIHN1cHBvcnRzIGxldmVscyAxIGFuZCAyLiAgSG93ZXZlciwKPiA+ID4g
TFo0SENfTUlOX0NMRVZFTCBpcyBzZXQgdG8gMywgYnV0IGNsZWFybHkgdGhlIGNvbXByZXNzaW9u
IGxpYnJhcnkKPiA+ID4gc3VwcG9ydHMgbGV2ZWxzIGxvd2VyIHRoYW4gTFo0SENfTUlOX0NMRVZF
TC4gIEluIGZhY3QsIExaNEhDX01JTl9DTEVWRUwKPiA+ID4gaXMgbmV2ZXIgdXNlZCBpbiB0aGUg
bHo0IGNvZGUuICBNYXliZSBoZXJlIHdlIG5lZWQgdG8ganVzdCBoYXJkY29kZQo+ID4gPiAiPCAx
IiBhbmQgcHV0IGEgY29tbWVudDoKPiA+ID4KPiA+IAo+ID4gTXkgYmFkLCBjb21wbGV0ZWx5IG1p
c3NlZCB0aGF0IExaNEhDX01JTl9DTEVWRUwgaXMgYWR2aXNvcnkgYW5kIHRoZQo+ID4gbGlicmFy
eSBhY3R1YWxseSBhY2NlcHRzIDEtMi4gIFdpbGwgaGFyZGNvZGUgPCAxIGluIHY1Lgo+IAo+IE5v
IHdvcnJpZXMsIHRoYXQgTFo0SENfTUlOX0NMRVZFTCB0aGluZyBpcyBkaWZmaWN1bHQgdG8gc3Bv
dC4KPiAKPiA+IEJ0dywgd291bGQgaXQgbWFrZSBzZW5zZSB0byBmaXggTFo0SENfTUlOX0NMRVZF
TCB0byAxIGluIHRoZSBsejQKPiA+IGhlYWRlciBhcyBhIHNlcGFyYXRlIGNsZWFudXA/ICBJdCBz
ZWVtcyBtaXNsZWFkaW5nIGFzLWlzLgo+IAo+IEknbSBhZnJhaWQgd2UgY2Fubm90IGRvIHRoYXQu
ICBmMmZzIHVzZXMgTFo0SENfTUlOX0NMRVZFTCwgSSBhc3N1bWUKPiBjb21wcmVzc2lvbiBsZXZl
bCBpcyBzdG9yZWQgcGVyLWlub2RlPyAgU28gaWYgd2UgY2hhbmdlIExaNEhDX01JTl9DTEVWRUwK
PiB0aGVuIG5ld2VyIGYyZnMgd2lsbCBzdGFydCBhY2NlcHRpbmcgY29tcHJlc3Npb24gbGV2ZWxz
IHRoYXQgb2xkZXIga2VybmVscwo+IGRvbid0IHN1cHBvcnQuICBDYy1lZCBKYWVnZXVrIGFuZCBD
aGFvIGp1c3QgZm9yIHZpc2liaWxpdHkuCgpZZWFoLCBzaW5jZSB3ZSBoYXZlCgogMjM5ICAgICAg
ICAgY2xldmVsID0gbGUxNl90b19jcHUocmktPmlfY29tcHJlc3NfZmxhZykgPj4KIDI0MCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENPTVBSRVNTX0xFVkVMX09GRlNFVDsKCiAyNTUg
I2lmZGVmIENPTkZJR19GMkZTX0ZTX0xaNAogMjU2ICNpZmRlZiBDT05GSUdfRjJGU19GU19MWjRI
QwogMjU3ICAgICAgICAgICAgICAgICBpZiAoY2xldmVsICYmCiAyNTggICAgICAgICAgICAgICAg
ICAgIChjbGV2ZWwgPCBMWjRIQ19NSU5fQ0xFVkVMIHx8IGNsZXZlbCA+IExaNEhDX01BWF9DTEVW
RUwpKQogMjU5ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2xldmVsOwogMjYwICNl
bHNlCiAyNjEgICAgICAgICAgICAgICAgIGlmIChjbGV2ZWwpCiAyNjIgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJfbGV2ZWw7CiAyNjMgI2VuZGlmCiAyNjQgI2VuZGlmCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZl
bAo=
