Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B96CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Blr0G1/NNcoHAM2U6xdiVJOI0YEl1Nb1p8ZU3+l/f9I=; b=hu+A4WMBffqt0uqnyZ9yhrUY/M
	/zcXErcFX3qyS1NpmM8ZUriLnmUEiOqu1jAKim6SyQUFUhu7xU0UMqSrOZqLxpaNTCkysCbzJwk6y
	choFP792rpfdQe2A023RGtWi3LZbnJMII6JMntad4/PXfYNTNHxCN/fXcgKr7cp6NyIc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO1Ad-00033u-KC;
	Fri, 15 May 2026 22:38:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO1AY-00033j-KG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p2jCAN1uGGBFod+dAEVc9V87Hx8HKAYcRyCM/+scJWs=; b=ZE5UfIws7DVhQeqIMwnf9WsQfo
 mvkmmOmXYK0+05Kqz4/w9ttvS4iq/dRay2X2bJxmthb3T1GXVrdeVRDWxeOiQLdin/nYWIH61JNwd
 czZCqpqrl5RAV936bemxIYvwfhkY5n+OaEFUQzqonU4RpiJXlw6CVw4ch6/ZmD5CYj+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p2jCAN1uGGBFod+dAEVc9V87Hx8HKAYcRyCM/+scJWs=; b=j4CGSdhtHyh6nWZaJGKqR6zdKu
 3yb75iXjHEmTMvmSIpvtkltfz8StbUIXLMU04ej9NGfNWw9cHu5PG8aNrOixwgcyUwJZEZ8NQQESF
 u0BQ4wstLe6UzQgmq61AhkkbSM4SUflu9+3JwYZyf+BlzLCV8qKeehMCOLWrp9UEa/SY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO1AV-0004Am-2k for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:38:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 324B3445BA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A97C2BCF5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778884677;
 bh=J22XAuCby1Nk4FIP13WT2u/GUxKM6wuoH7hrzV1Eqf0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=J6SQPUHbeQl+M/9tFaMbK8dZygMG4wF3FeDwXrfnAGoeuZ9v43RFXPi3i6PlUEyiY
 qBY2PB9tpcgkHiNjKM3nu+tcCujL6QueIqUkX9tN/dTiWw6og/+ClebItMZvq3cMkT
 vgZnaxUDZ5ZpKpPGSQXREQbo72kuouuzw8BV7etUgGve0Sj0gy7Gf3dVbWhB4ui+SJ
 8aVZ/MPSUGgiJiIlGr/mzCEQp6NXdNvts0FxgtV7VTfgZICdUvENCJTtEbhFIHPwLu
 wKsygrKzRHlvxrF3qEqfDaUVvViuaPg4sRY8c8vqUrBVwcjH1EGTh3YzoMz3G9HpWQ
 RKL1x7I9KsoDw==
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-65c477a3278so689540d50.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 15:37:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/Td4iQr8mCewo6Ir0BpvXGL5Hf3T5jBBzrWFSMl24bI/dtWfzv0kUgsqc+PXCrKFmDxgbe30Ub/qLdBpPnPxTL@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxHWt4k96jx+OWxtqZjDCGoc1EUDkAM9NTT3oiFMlqO9ebRpE+0
 1IFn5gTZ32aMaV3k0gv1UqfVUO2TIqqvRDh8v0eIlLSCfohVMRSgEpF4ky3xPmh2utdW5Kd9mGP
 05PyCzjrUBIaQYv128igocGCnbi2vlbUVnO764SeioA==
X-Received: by 2002:a05:690e:1482:b0:651:b13e:f9ef with SMTP id
 956f58d0204a3-65e226d2c42mr6465616d50.14.1778884676176; Fri, 15 May 2026
 15:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-2-hch@lst.de>
In-Reply-To: <20260512053625.2950900-2-hch@lst.de>
Date: Fri, 15 May 2026 15:37:44 -0700
X-Gmail-Original-Message-ID: <CACePvbWdxJfCgZzbfFoSOFLKnizDJE62oHKj=mA5jkBGo0dHkw@mail.gmail.com>
X-Gm-Features: AVHnY4KhYBpZIvUDwx68vRewVOsNKOXtAJOmYrhmxnQGCpjvviSHXcfEap0R7tY
Message-ID: <CACePvbWdxJfCgZzbfFoSOFLKnizDJE62oHKj=mA5jkBGo0dHkw@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO1AV-0004Am-2k
Subject: Re: [f2fs-dev] [PATCH 01/12] swap: remove the maxpages variable in
 sys_swapon
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
From: Chris Li via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chris Li <chrisl@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBNYXkgMTEsIDIwMjYgYXQgMTA6MzbigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cj4KPiBBbHdheXMgdXNlIHNpLT5tYXggd2hpY2ggaXMgdXBkYXRlZCBz
ZXR1cF9zd2FwX2V4dGVudHMgaW5zdGVhZCBvZiBjb3B5aW5nCj4gaW50byBhbmQgb3V0IG9mIG1h
eHBhZ2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
CgpBY2tlZC1ieTogQ2hyaXMgTGkgPGNocmlzbEBrZXJuZWwub3JnPgoKPiAtLS0KPiAgbW0vc3dh
cGZpbGUuYyB8IDI3ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbW0v
c3dhcGZpbGUuYyBiL21tL3N3YXBmaWxlLmMKPiBpbmRleCA5MTc0ZjFlZWZmYjAuLmY3ZWJkOTdl
MjhhMyAxMDA2NDQKPiAtLS0gYS9tbS9zd2FwZmlsZS5jCj4gKysrIGIvbW0vc3dhcGZpbGUuYwo+
IEBAIC0zMzUwLDEwICszMzUwLDkgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcmVhZF9zd2FwX2hl
YWRlcihzdHJ1Y3Qgc3dhcF9pbmZvX3N0cnVjdCAqc2ksCj4gIH0KPgo+ICBzdGF0aWMgaW50IHNl
dHVwX3N3YXBfY2x1c3RlcnNfaW5mbyhzdHJ1Y3Qgc3dhcF9pbmZvX3N0cnVjdCAqc2ksCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5pb24gc3dhcF9oZWFkZXIgKnN3YXBf
aGVhZGVyLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgbWF4cGFnZXMpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5pb24g
c3dhcF9oZWFkZXIgKnN3YXBfaGVhZGVyKQo+ICB7Cj4gLSAgICAgICB1bnNpZ25lZCBsb25nIG5y
X2NsdXN0ZXJzID0gRElWX1JPVU5EX1VQKG1heHBhZ2VzLCBTV0FQRklMRV9DTFVTVEVSKTsKPiAr
ICAgICAgIHVuc2lnbmVkIGxvbmcgbnJfY2x1c3RlcnMgPSBESVZfUk9VTkRfVVAoc2ktPm1heCwg
U1dBUEZJTEVfQ0xVU1RFUik7Cj4gICAgICAgICBzdHJ1Y3Qgc3dhcF9jbHVzdGVyX2luZm8gKmNs
dXN0ZXJfaW5mbzsKPiAgICAgICAgIGludCBlcnIgPSAtRU5PTUVNOwo+ICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBpOwo+IEBAIC0zMzk1LDcgKzMzOTQsNyBAQCBzdGF0aWMgaW50IHNldHVwX3N3YXBf
Y2x1c3RlcnNfaW5mbyhzdHJ1Y3Qgc3dhcF9pbmZvX3N0cnVjdCAqc2ksCj4gICAgICAgICAgICAg
ICAgIGlmIChlcnIpCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gICAgICAg
ICB9Cj4gLSAgICAgICBmb3IgKGkgPSBtYXhwYWdlczsgaSA8IHJvdW5kX3VwKG1heHBhZ2VzLCBT
V0FQRklMRV9DTFVTVEVSKTsgaSsrKSB7Cj4gKyAgICAgICBmb3IgKGkgPSBzaS0+bWF4OyBpIDwg
cm91bmRfdXAoc2ktPm1heCwgU1dBUEZJTEVfQ0xVU1RFUik7IGkrKykgewo+ICAgICAgICAgICAg
ICAgICBlcnIgPSBzd2FwX2NsdXN0ZXJfc2V0dXBfYmFkX3Nsb3Qoc2ksIGNsdXN0ZXJfaW5mbywg
aSwgdHJ1ZSk7CgpOaXRwaWNrOiBJIGNvdWxkbid0IGhsZXAgYnV0IG5vdGljZSB0aGUgc2ktPm1h
eCBkb2VzIG5vdCBjaGFuZ2UKYmV0d2VlbiBzZXR1cCBiYWQgc2xvdHMsIHNvIGluIHRoZW9yeSB5
b3UgY2FuIGNhY2hlIHRoZSBzaS0+bWF4IHZhbHVlCnRvIGEgbG9jYWwgdmFyaWFibGUgZm9yIHRo
ZSBsb29wLiBJbiByZWFsIGxpZmUsIGl0IHdpbGwgbWFrZSBubwpkaWZmZXJlbmNlLCBzbyBmZWVs
IGZyZWUgdG8ga2VlcCBpdCBhcyBpcy4KCkNocmlzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
