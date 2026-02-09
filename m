Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB156EF06E6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=COtkGPkeWkRpoASny+2DfgbW7In9+f7F44vtTedDvoI=; b=C5p25cPTY7+4UbZip9Ckrw7+Xc
	5PocPwet6Mqbsfplf5Wg3I/rSA0Ozmg8hEsQLy2V4IoSD7RRXBF8W1yLk0TyeUflLcfqHkh34v0jC
	N80TbTHowH5rpvRs2FlZ+B9Gw0JKg6yTTwXzmfYhvCxGdQOTXdUg3jvT5rioGqnDDgSI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vpIMD-0006wb-Mh;
	Mon, 09 Feb 2026 03:54:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@redhat.com>) id 1vpIMC-0006wO-LY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Feb 2026 03:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=; b=Wjuw3SoA88S2YdLTWuG9LMPY38
 r6+sL+xYIPZ5BQYy2tsh5VFPjj1nThd/tvk/qVACzUyktC9fKY592Wtae+i1hYSsR+PSGeP67wKlM
 9iX3Xg44nXJWN7okHL1j76bauOGsa0pdrnCV5xdQ1XUTaxVGJeomSB0atN6gCEk9GK9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=; b=mJQohJPj37Him0fjG8b2hnAyKk
 FvuKhZ0D0ybjS5EvwFvvVjraCy1IZpJJgrNKgyd0D6lW1fGCHZmOobJQt2fEPj23wqB3teYFkgWEO
 RHa799T3GmDb02VvCu55xjbjLot8jxM87YA5gIzwxj3H04wnj3gG1Wa4nRhb3bLNnLkA=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vpIMA-0002bQ-4z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Feb 2026 03:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770609266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=;
 b=Hf8BrvW+OfNKq11gdncuoX/hVQbTPXukZQrah2tyrqpL3jrjQhqtXARDPvwGUF2dhCYEoy
 8E9x5JtAVB6obYnOag3GQSgDcY5O7td0j9bRWYKisCKFRe2VOnAjQXLVHYzsVCUwGpIWGx
 dNmacAbEgnKGex95rk7KXAA4+ov0Hvo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-uXF64FuKONe7MDciwAyH1w-1; Sun, 08 Feb 2026 22:54:25 -0500
X-MC-Unique: uXF64FuKONe7MDciwAyH1w-1
X-Mimecast-MFC-AGG-ID: uXF64FuKONe7MDciwAyH1w_1770609264
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so1587637a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 08 Feb 2026 19:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770609264; x=1771214064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=;
 b=Ff7PUq69g3/gdSWBVpYnMayrl/cEOBznekEWOi4gz45O/Tqvq9PnwvD0HL1sWhF3dT
 yfrqHbXdTHmNaIoePQEHbxiUVwINvkOoJ9GHf4FaUGUV3s4vkaoCUNcL98DK/KJQa4uX
 Ptakp5YP+REKCuMRF/7oFbT34gwj7tSPMeYvWLwXJEgiOm5nNo6dM9S75+GDX2Ca2LT2
 SyY8AsN9mOnhcD++f/Qcirah+HsbL0ZW0LyF7J/Sghi6+vEU0/8sc2642eTvWB5Tpld4
 DCJ61sMabq1XDoOZoibAv/ojneJSDO2l+gfecLEWY+FWUv37UwiKY2L5EtgI2xXITbM9
 zZrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9wgACL+9N1G55dJde2bzduLvELqKmWfZGY3+fcyQ7JukaGuD4IapucQgePJ2LXeFnhpz4jWafoABBFDhzLw9N@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwKOUTaDWliv5cueaCm/XnvnQDFM88gYrr/xF81IF5zWWKND1nW
 IQ6mV97Kpli+SbtqlGF7OVdEsPlYsp0WfTHP+CGptzn3y3NQLGXa1bTvoosGhg1LYpN8xaFp5D8
 9jr8zib5BU1hfG0/YyhAqgIoo9g1APiVy/ack43fn3zD8qEbggHCHIWx6qq+iDuLuCdJjZUvkp4
 V8wWg=
X-Gm-Gg: AZuq6aJwPONRBHPysHT+wiaKNP73flFDwTWR29y6eXCKaauXzDjYirKN/W8R7YllZvw
 Zz4TEuSw+FsaBR0JkLUn/v0DSX3s/G9jhbUArbXk1FEgOohzBJAHfeKpCd3LQoIZrQaiBO/sCD8
 AaQZX3J+SQTbnc4UFrbyTBf89Y2d8/gYWOF5++zmaVhxC20ZBscx50ymZT3UzJz4Keg0TN2pJ5H
 Q0QcGB7MzZaDloDchAU3JNZ94nFNeG7WCqXHwo8RPaaHJ+Vnst1MvLMXZgCxrlK7UuHCE1vZDfi
 NynrsOaVbrTKdLk41EHAl/iuRG3d9BVN006MI5mbq2XX8NNBJTffyytU+1aRloHY4BOyfxzT16y
 xsFUePmVwQcC8a4kcdDn3rSWqnF7Zn5115bbr7VgeD3cpsYF9wg==
X-Received: by 2002:a05:6a21:a89:b0:392:e5eb:f0f with SMTP id
 adf61e73a8af0-393ad3b6c44mr8349851637.68.1770609264491; 
 Sun, 08 Feb 2026 19:54:24 -0800 (PST)
X-Received: by 2002:a05:6a21:a89:b0:392:e5eb:f0f with SMTP id
 adf61e73a8af0-393ad3b6c44mr8349831637.68.1770609263897; 
 Sun, 08 Feb 2026 19:54:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb526676sm7675744a12.12.2026.02.08.19.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 19:54:23 -0800 (PST)
Date: Mon, 9 Feb 2026 11:54:19 +0800
To: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Chang <joannechien@google.com>
Message-ID: <20260209035419.ivosuxils2gnn3lw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260108022501.754320-1-joannechien@google.com>
 <20260110013802.GB15541@frogsfrogsfrogs>
 <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>
 <20260208195043.vhvkanq5pysbb74y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20260209015326.GK1535390@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20260209015326.GK1535390@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: neunCGCeHb92IdUzhLqD2XoAuRKkcfPWYnebrgIugkc_1770609264
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1vpIMA-0002bQ-4z
Subject: Re: [f2fs-dev] [PATCH v3] common/rc: add _require_blocks_in_file
 helper
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU3VuLCBGZWIgMDgsIDIwMjYgYXQgMDU6NTM6MjZQTSAtMDgwMCwgRGFycmljayBKLiBXb25n
IHdyb3RlOgo+IE9uIE1vbiwgRmViIDA5LCAyMDI2IGF0IDAzOjUwOjQzQU0gKzA4MDAsIFpvcnJv
IExhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIEphbiAxMiwgMjAyNiBhdCAxMToyMDozNkFNICswODAw
LCBKb2FubmUgQ2hhbmcgd3JvdGU6Cj4gPiA+IE9uIFNhdCwgSmFuIDEwLCAyMDI2IGF0IDk6Mzji
gK9BTSBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gPiBP
biBUaHUsIEphbiAwOCwgMjAyNiBhdCAwMjoyNTowMUFNICswMDAwLCBKb2FubmUgQ2hhbmcgd3Jv
dGU6Cj4gPiA+ID4gPiBnZW5lcmljLzczNSBhdHRlbXB0cyB0byBjcmVhdGUgYSBmaWxlIHdpdGgg
bmVhcmx5IDJeMzIgYmxvY2tzLiBIb3dldmVyLAo+ID4gPiA+ID4gc29tZSBmaWxlc3lzdGVtcyBo
YXZlIGEgbWF4aW11bSBmaWxlIGJsb2NrIGxpbWl0IGJlbG93IHRoaXMgdGhyZXNob2xkLgo+ID4g
PiA+ID4gRm9yIGluc3RhbmNlLCBGMkZTIGlzIGxpbWl0ZWQgdG8gYXBwcm94aW1hdGVseSAyXjMw
IGJsb2NrcyBkdWUgdG8gdGhlCj4gPiA+ID4gPiBjYXBhY2l0eSBvZiB0aGUgaW5vZGUuIFNvIGFk
ZCBfcmVxdWlyZV9ibG9ja3NfaW5fZmlsZSBoZWxwZXIgdG8gc2tpcCB0aGUKPiA+ID4gPiA+IHRl
c3QgaW4gc3VjaCBjYXNlcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGUgaGVscGVyIHVzZXMgYSBo
YXJkY29kZWQgY29uc3RhbnQgaW5zdGVhZCBvZiBhIHByb2dyYW1tYXRpYyBtZXRob2QsCj4gPiA+
ID4gPiBzbyB0aGF0IGJ1Z3Mgd2hpY2ggYWZmZWN0IHRoZSBtYXhpbXVtIGZpbGUgc2l6ZSBhcmUg
bm90IG1hc2tlZC4KPiA+ID4gPgo+ID4gPiA+IE5vdCB0byBtZW50aW9uIHRyeWluZyB0byBjcmVh
dGUgYSBmaWxlIHdpdGggMSwwNTcsMDUzLDQzOSBibG9ja3MKPiA+ID4gPiBhbGxvY2F0ZWQgdG8g
aXQgd291bGQgcHJvYmFibHkgdGFrZSBmb3JldmVyLgo+ID4gPiA+Cj4gPiA+ID4gSGFuZyBvbiwg
d2UncmUgdGFsa2luZyBhYm91dCBpYmxvY2tzIChha2EgdGhlIG51bWJlciBvZiBibG9ja3MgYWxs
b2NhdGVkCj4gPiA+ID4gdG8gdGhpcyBpbm9kZSksIG5vdCB0aGUgbWF4aW11bSBmaWxlIHNpemUg
aW4gYmxvY2tzLCByaWdodD8KPiA+ID4gPgo+ID4gPiA+IElmIHNvLCB0aGVuIG1heWJlIHRoaXMg
ZnVuY3Rpb24gYW5kIGl0cyBjb21tZW50cyBzaG91bGQKPiA+ID4gPiBzL2Jsb2Nrcy9pYmxvY2tz
Lz8gIE9yIGFtIEkgY29uZnVzZWQ/IDspCj4gPiA+ID4KPiA+ID4gPiAtLUQKPiA+ID4gCj4gPiA+
IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIGdlbmVyaWMvNzM1IGNyZWF0ZXMgYSBsYXJnZSBs
b2dpY2FsIGZpbGUsIGJ1dAo+ID4gPiB0aGUgYWN0dWFsIHBoeXNpY2FsIGJsb2NrIGFsbG9jYXRp
b24gaXMgbXVjaCBzbWFsbGVyLiBBbHNvLCB0aGUgRjJGUwo+ID4gPiBsaW1pdGF0aW9uIGlzIGFi
b3V0IGhvdyBtYW55IGJsb2NrcyB0aGUgaW5vZGUgY2FuIGFkZHJlc3MsIG5vIG1hdHRlciBpZgo+
ID4gPiB0aGUgYmxvY2tzIGFyZSBhY3R1YWxseSBhbGxvY2F0ZWQuCj4gPiA+IAo+ID4gPiBTbyBJ
IGJlbGlldmUgdGhlIHJlcXVpcmVtZW50IGlzIGFib3V0IHRoZSBtYXhpbXVtIGZpbGUgc2l6ZSBp
biBibG9ja3MsCj4gPiA+IG5vdCB0aGUgbnVtYmVyIG9mIGJsb2NrcyBhY3R1YWxseSBhbGxvY2F0
ZWQuIERvZXMgaXQgbWFrZSBzZW5zZSB0byBrZWVwCj4gPiA+IHRoZSBuYW1lLCBvciBkbyB5b3Ug
dGhpbmsgYW5vdGhlciB0ZXJtIHdvdWxkIGJlIGNsZWFyZXI/IEkgYXBwcmVjaWF0ZQo+ID4gPiB5
b3VyIHRob3VnaHRzIG9uIHRoaXMuCj4gPiAKPiA+IEhpIERhcnJpY2ssCj4gPiAKPiA+IEkgdGhp
bmsgSm9hbm5lJ3MgZXhwbGFuYXRpb24gbWFrZXMgc2Vuc2UsIGlmIHlvdSBkb24ndCBoYXZlIG1v
cmUgcmV2aWV3IHBvaW50cwo+ID4gb24gaXQsIEknbGwgbWVyZ2UgdGhpcyBwYXRjaC4KPiAKPiBB
Z3BndGgsIEkgZGlkbid0IG5vdGljZSB0aGlzIHJlcGx5ISAgTXkgYXBvbG9naWVzISA6KAo+IAo+
IE9rLCBzaW5jZSB0aGlzIGlzIGEgbGltaXQgb24gdGhlIG1heGltdW0gbG9naWNhbCBmaWxlIGJs
b2NrIG51bWJlciwKPiBfcmVxdWlyZV9tYXhfZmlsZV9yYW5nZV9ibG9ja3MsIHBlcmhhcHM/CgpU
aGFua3MgRGFycmljayEgSSdtIGdvb2Qgd2l0aCB0aGlzLCBpZiBKb2FubmUgYWdyZWVzIHdpdGgg
dGhpcyB0b28sIEkgY2FuIGhlbHAgdG8KbWFrZSB0aGlzIGNoYW5nZSBsb2NhbGx5IHRvIGF2b2lk
IGFza2luZyBmb3IgYSBuZXcgcGF0Y2guCgpUaGFua3MsClpvcnJvCgo+IAo+IC0tRAo+IAo+ID4g
Cj4gPiBUaGFua3MsCj4gPiBab3Jybwo+ID4gCj4gPiA+IAo+ID4gPiBCZXN0IHJlZ2FyZHMsCj4g
PiA+IEpvYW5uZQo+ID4gPiAKPiA+IAo+IAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
