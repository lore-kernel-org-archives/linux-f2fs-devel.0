Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1C609B648
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W3+VYruj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ol5BdDtF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YnSbRsqE;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lv7dncuT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+NTLyB/FsW6rKyqAIcIPqtynhrypBcb8/slFrUHYeo=; b=W3+VYruj/K7gD1dKXTeTNtm7kE
	x0SgbwQXJXpYVlqtgk8Q3Adci4/fBR3K+YqyvRM1SSUI9ohxZ//yDS1em6+wCJqWf5gzhXzokRVUL
	zzLpES4OdmWIPZMKPIcRqTGkxLaCZZbNHwaxe8mhq5SXqcmYYcqFZG3KOF4Oj1VPfnVc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpBK-0006cs-2G;
	Mon, 19 Oct 2026 15:21:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xIpBI-0006cc-Ec
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YwaKnHbySTdduqYIAo0uIt5iSJ/S/CGViQ8hARGAuYE=; b=Ol5BdDtFi0LVdLZ5zD1O6cREgT
 uw5hMmaqU6pCYST4Lmw7izLi66n/04Rw/pI8kkCQquSxCnfx3mtDO0IBU/HvqRMvisMkJ1VUy6+a1
 4YajeOAT76KI7RxwM1ZaOMweQYlMs7GGa4KW2Q1kf2DakEH6Dpx/leqLKlN0nk/zmGnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YwaKnHbySTdduqYIAo0uIt5iSJ/S/CGViQ8hARGAuYE=; b=YnSbRsqEoR+Tnv67Mw1LH7OFhh
 jGWhvOHt4wI1Tt3c0gx4fn++XCt2pIlEKo9cZ+XRXMvG1Sz5FXbKqklOGmIKyxDkJZQhQQUqm6Q7l
 Sivg2kLrH2tX/0yXwhZMTm38DAwoewLe+4/QHlaN77y8LD8BUs26S7NgIEJR9kREbOSM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpBI-0003Hq-MV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:21:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19ED8602C2;
 Mon, 19 Oct 2026 15:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412731F000C5;
 Mon, 19 Oct 2026 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423298;
 bh=YwaKnHbySTdduqYIAo0uIt5iSJ/S/CGViQ8hARGAuYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Lv7dncuT0A5cXTc4DnHQrJuxWL83mt/CqJrazSkUg5smuYKcwpLRehvvxY/Uc2PA2
 WqQ8y8v6iCcmmS0kJP4dAA23IEvgneEX5LT43jLujLj80VxuE4JVDTYj/NIF3N/a9r
 l+mk16TPti32HCMeMg25qG47ug4GbJ9J618E2u1BdhfM9xRWUXCydQrXdYzyp/mnoT
 IEECHdqharsOcA8fBv2/BOBOtluIOX4dSYB4LpebwhdvOjvKgNrHn/GUSa7dAaaX7Z
 y3NHvXd2opjA9+I9Sh55q2qrXV9dumn/NbB1qFCMGrRO5nsp1867QDKNt5yVSvyhl0
 MMhO4FrQfOh+g==
Date: Mon, 19 Oct 2026 15:21:36 +0000
To: Nanzhe Zhao <nzzhao@126.com>
Message-ID: <atY1gNfX9Lhg3zC6@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
 <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
 <atD9Csw1-lj5_SR_@google.com> <atFFXafuVyyimmUk@google.com>
 <15373a26.1e3d.1a1494e8d1a.Coremail.nzzhao@126.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15373a26.1e3d.1a1494e8d1a.Coremail.nzzhao@126.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpBI-0003Hq-MV
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTAvMTcsIE5hbnpoZSBaaGFvIHdyb3RlOgo+IAo+IAo+IAo+IEhpIEphZWd1aywKPiDCoMKg
Cj4gwqAgSSBhbSB0cnlpbmcgdG8gcmVwcm9kdWNlIHRoZSBmYWlsdXJlIGluIHlvdXIgbG9nOiBz
ZCAwOjA6MDo0OiBSZXRyeWluZyB1bmFsaWduZWQgd3JpdGUgZm9yIHpvbmUgMjYzOSDihpIgY3Jp
dGljYWwgdGFyZ2V0IGVycm9yIOKGkiBzZGU6Cj4gwqAgem9uZSAyNjM5OiBBYm9ydGluZyBwbHVn
Z2VkIEJJT3Mg4oaSIGYyZnNfc3RvcF9jaGVja3BvaW50IChrZXJuZWwgNi4xMi44MS1hbmRyb2lk
MTYtNikgYW5kIGdvdCB0d28gdHdvIHF1ZXN0aW9ucy4KPiDCoMKgCj4gwqAgMS4gS2VybmVsIGJh
c2VsaW5lLiBDb3VsZCB5b3UgY29uZmlybSB0aGF0IHRoZSBrZXJuZWwgeW91IHRlc3RlZCBoYXMg
QmFydCBWYW4gQXNzY2hlJ3Mgem9uZWQgd3JpdGUgcGlwZWxpbmluZywgaS5lLiBtdWx0aXBsZSBp
bi1mbGlnaHQKPiDCoCBzZXF1ZW50aWFsIHdyaXRlcyBwZXIgem9uZSwgd2l0aCB0aGUgb3JkZXIg
a2VwdCBieSBCTEtfRkVBVF9PUkRFUkVEX0hXUSBhbmQgdGhlIHBlci16b25lIGZyb21fY3B1IGlu
IGJsb2NrL2Jsay16b25lZC5jPyBBbmQgdGhhdCBpdAo+IMKgIGRvZXMgbm90IGluY2x1ZGUgdGhl
c2UgdGhyZWUgZm9sbG93LXVwIGZpeGVzOgo+IMKgwqAKPiDCoCAtICJBTkRST0lEOiBibG9jazog
UHJlc2VydmUgdGhlIHN1Ym1pc3Npb24gb3JkZXIgb2Ygem9uZWQgd3JpdGVzIgo+IMKgIC0gIkFO
RFJPSUQ6IGJsb2NrOiBQcmVzZXJ2ZSB0aGUgb3JkZXIgb2Ygem9uZWQgUkVRX0ZVQSB3cml0ZXMi
Cj4gwqAgLSAiQU5EUk9JRDogYmxvY2s6IFJlc3RvcmUgdGhlIHdyaXRlIHBvaW50ZXIgb2Zmc2V0
IGNoZWNrIgo+IMKgwqAKPiDCoCBJbiBBT1NQIHRoZXkgYXJlIDA1MGRlNTcwZiwgYzYxNmY3YzFh
LCBkNTA2MDFkMGYgb24gYW5kcm9pZDE2LTYuMTIsIGFuZCA2MDY4ZWQ5ZjAsIGQ3ODZmODYwOSwg
ZjA4NDMwZjgwIG9uIGFuZHJvaWQxNy02LjE4LiBUaGUKPiDCoCBzaW1wbGVzdCBjaGVjayBpcyB3
aGV0aGVyIFJFUV9aT05FX1NFUklBTElaRUQgYW5kIHdvcmtfYnVzeSgmendwbHVnLT5iaW9fd29y
aykgYXBwZWFyIGluIHlvdXIgYmxvY2svYmxrLXpvbmVkLmMuIFRoZSBvdXRwdXQgb2YgZ2l0IGxv
Zwo+IMKgIC0tb25lbGluZSAtLSBibG9jay9ibGstem9uZWQuYyB3b3VsZCBhbHNvIGRvLgoKSSdt
IHRlc3Rpbmcgb24gYW5kcm9pZDE2LTYuMTIgd2hlcmUgaXQgaGFzIGFsbCBCYXJ0J3MgcHJldmlv
dXMgcGF0Y2hlcy4KCj4gwqDCoAo+IMKgIDIuIFRlc3Qgd29ya2xvYWQuIElmIHRoYXQgaXMgdGhl
IGNhc2UsIGNvdWxkIHlvdSBzaGFyZSB0aGUgdGVzdCB3b3JrbG9hZCB0aGF0IHRyaWdnZXJzIGl0
P8KgIFNvIGZhciBJIGhhdmUgbm90IGJlZW4gYWJsZSB0byByZXByb2R1Y2UgaXQgdXNpbmcgbnVs
bF9ibGsgdG8gc2ltdWxhdGXCoAo+IHpvbmUgZGV2aWNlcyB3aXRoIHFlbXUgYW5kIGFuZHJvaWQx
Ny02LjE4IGdraSBrZXJuZWwuIEFueSBzdWdnZXN0aW9ucyB3b3VsZCBiZSBtdWNoIGFwcHJlY2lh
dGVkLgoKSSdtIHRlc3RpbmcgdGhlIGtlcm5lbCBvbiBteSBwcmltYXJ5IHBob25lLiBBZnRlciBh
cHBseWluZyB0aGUgbGF0ZXN0IG9uZXMKYWdhaW4sIEkgaGF2ZW4ndCBoaXQgdGhlIHBhbmljIHll
dC4gU28sIGNvdWxkIHlvdSBwbGVhc2Ugc2VuZCB2Nj8gVGhlbiwgSSdsbApyZWFwcGx5IGFsbCBh
bmQga2VlcCB0ZXN0aW5nLgoKPiBUaGFua3MsCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFp
bGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
