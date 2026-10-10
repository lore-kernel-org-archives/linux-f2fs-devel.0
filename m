Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90B0CA9EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTjL2u7WqQ2AdR4aMZ1V5sY69/WQDdlsIFo0AHCVoVM=; b=cB+3rG3kINqSXlmZmn0c5PnsOm
	A0Ra0LQZI9x3B9gX+jEZqysevkv3ZdpIOXzoqQrY0l74P3K10h+i7Z1LiCbv2v8FzEOWVEDVci62g
	q3JjgERIOte6ri3kMcY1gw4LSm02pdwO3yXhSpak5xusikPKLfMKCCHibixktGKr5u1s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFYIS-0004lQ-EF;
	Sat, 10 Oct 2026 14:43:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xFYIM-0004lE-Jd
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 14:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=imLCGiXDmGn6Y+Ur+2RBxpevY4P7nxx5LtTBgp55UWA=; b=j8pawDCL9b6VN7/2oIvvra+068
 kr5DduNHXBg0Bh0DP3ObELXoWBuJH/qITI978IlbhCv2e9swlJ1iryn8XQ/u9HrOf3i49/Bn1WLqS
 dQcGmp3ZcR57ekCYDmoEyPBRM8sn7LW7Wk/7p0LNWXBncBRQ9LlsVQC+Dy/MPOreMfcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=imLCGiXDmGn6Y+Ur+2RBxpevY4P7nxx5LtTBgp55UWA=; b=IJn+mw+xJTWmyyXnLxtSJq65Vg
 dCKjF8BbDhnt3wREIjZUvxeRSG1MNjOzWlqh57ZHe2PYApp5lzzsYDQsR8fH2ZMU7dNrhiqRTRFTe
 If0xH6ebTi0YAKFYxRypqaKzygkZdE9hE4WF96Jh33fq4UTqwrN02bSi90LoHO8ZWuU4=;
Received: from mail-lj1-f173.google.com ([209.85.208.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFYIM-00038I-HR for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 14:43:31 +0000
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-3a777d4f321so6406301fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 07:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791643404; cv=none;
 d=google.com; s=arc-20260327;
 b=E0yHPLMWI7vuXpMS6HPLJNgWYqjXlOtTyYa3gTyKlAcMoV8cKTUjOl+VdvqXbdp0Fl
 6CXIFhEbyi9kb0RS7Iti5Xj3Ht/UTP8kq6BPWSpvczi9MmKwnnWLpSobk2piIKEtJp4F
 +yrEpr9GuolNTdqW8sH+OALI5omNkRSCxi//5O6A8OUkPbko1hXgCZMVDCRH9ABdefc0
 eUuPfpDcSk4oW69jOYvBCVFwh8cWubS7R+aEoedVpIuHdcMiKgob9i7yuycnqz/qjxJB
 Bn4Z/DS4SoF+yqlG2nWOuG2mMVxkC7coXD2GrYHKKaAU7FYhjqKTzRI42m/dGitltKH/
 jG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=imLCGiXDmGn6Y+Ur+2RBxpevY4P7nxx5LtTBgp55UWA=;
 fh=SkMKahCo5OUnWtw6jUU6hKx6jqRxFkeVAUdPr82hpPQ=;
 b=K/8ks2c+ZJ46rCBYKdy8HJITmBflp0AEpuqmtcha878e2M5FLEldt2gmqkP/bsjGmX
 1qRVLPuhy76imegHHzAdAuNmZXHAYF7NXQ9IiBAqoZOiDNgLMxXpVI7QzosZ0yaXJYC6
 fthtYu+n3yWpIJZldTtpu2W+UCAHh40XmgGPQtBMGPTlbDfsO/8ysaH3r++ERizB0KfD
 BPs4/YPhhOpgIssEp9+yDo11BxC+iH3yXZTQrVOnd04PVLLj8gKSpVWLHqpDAY94WP7B
 qj/0TuxwfytQjBruDDQwcsjAoLOyk5wpZGtQfgDfaHKar2lsa054ImxNRUIMQCSA9BLN
 iaAw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791643404; x=1792248204; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=imLCGiXDmGn6Y+Ur+2RBxpevY4P7nxx5LtTBgp55UWA=;
 b=DvdRSByKOblRH9RE0SpeWB+tzQsJyPg+WYn1+C8YH0JkhhEOjQVPDNdQ7dr420I7KM
 pI1r+3bvLv/JNPOUSWuql3JcqlKTJJpQ0AI3uIH2pq7iLHo1WgRaMDll6NSFl1hMfDUf
 c21GugXc1KqFaBczVy/5UjQsQX0IBxK9+lskHYSu1I3HVfH2WvmJE6bweGPzS/v0Mnow
 PFBaxoNCQXc8giXRLLv1tT8WI7bp3vjyRoATCqOIFS0OBuDMOY3T4jDKw+Rhn9UPi3cU
 M9A7/y16z/PBqh+id2CmMb18jqaUssD3dY2x11jA1/WZzAlk4Mu2nSfgW2cainkrSqsw
 A8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791643404; x=1792248204;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imLCGiXDmGn6Y+Ur+2RBxpevY4P7nxx5LtTBgp55UWA=;
 b=YQ/FfLx6L3IRsxbyuqkTPqBHZjhs1+Uq4dE94CARNb9Q0e6gyFyWwBJOyeA9ARBRvA
 AP7LOYQ8fcxO1CuJX/lQOHj+QIj3jdcXKkebpG1Kc93IP4d0utejUJDrmfn+elP3GaF9
 Wfl01Wg9gwF5dc6OBl98JF9fHTkqwQ/UXFXd3PGeYsD1XKQw/CRItlPIqKwyaslaQyW5
 UzgHewlH/1sek1+Xx29oNY/d/jlI7l79mpFf/SAwKVWDFyBgB6/A30GK3frDDFlB9GBc
 AlDND5Am+C7kZ6bpvVun+qVgiEZ4XtdH2nY6IgW+eLDIjMqi9u9CeS3LE9K8WTcInaPT
 ko5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwctj4PZewmChzLEs0sTsrFRE3TC607ajdimPvsOvn6mcmwJhsKYUc6vR0TaHuhS9JYGdju6ZCr1K/G6aAv2yNo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIBq/AezGo5WRl8tY1dbgBQlfhxBZQDDnp+ChyqicA362dSBtne
 cy6wiWW5lUOPFwZbvS6xE2+O6BXkUOOu1uesO8IXB5ZPnr4n/K5j9pCzW9tnaiAXsrbFXO5JeXD
 cHEtjmr/D8Nzt/+P8YLDVln4o4Hw5s8Q=
X-Gm-Gg: AYBFou2C4O1VURbnRW4+qw1XyA6cy5IOan3r8Bs9N4awltpJzC0pMeurw+RKoWaw1Z9
 qTwg/RtK+QBIFqHDxRPfK7+ypsN/IMNrugKRvCYsjb0BXhq1J9wrVmP5/6YH3dBQjoJvTZwJwrB
 DBx9Oso7WRyf8h7BinDzCdGf6v/TJdncu7QX33VYTIdRsXynA9zcbhzXKVPskh4z3HGSNX9NlIA
 JL0n4xbBd4gGFQ+p6rH8haPnMLQGjgCxKiMXi0LXWCEtbxcKrTuB7Ts9N9oIYSQrGmFYh7jXk6q
 WGaIVXqu0fQA0GHWNEOurUMOL75L6GLqjM0KeOE0OtwvMg79PnruhkasvJrJ4OhoSSN3PSj7z+o
 pY0Up24FDkm6Ld5jMotYIQUCRvGJ8qY877bxZQ+dRgEWU
X-Received: by 2002:a05:651c:a10f:10b0:3a9:849c:b169 with SMTP id
 38308e7fff4ca-3a9c55cd2d5mr7396811fa.26.1791643403535; Sat, 10 Oct 2026
 07:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261010024133.2444761-1-daeho43@gmail.com>
 <99957074-c89a-44c4-a86d-f65e7dc85024@kernel.org>
In-Reply-To: <99957074-c89a-44c4-a86d-f65e7dc85024@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Sat, 10 Oct 2026 07:43:11 -0700
X-Gm-Features: AclHuK94B3UGQhAWFJWoilECADYbd4c_BmvhAts7YTa277lgZePZ3pQNwdrBDZE
Message-ID: <CACOAw_yhAvKMHVa_-e7R6vastOGq1jYdG2g=KicMCFFAAQO91w@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xFYIM-00038I-HR
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: disallow mmap write and
 data-modifying fallocate on atomic files
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
Cc: stable@kernel.org, Daeho Jeong <daehojeong@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU2F0LCBPY3QgMTAsIDIwMjYgYXQgMTI6MzfigK9BTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Cj4gT24gMTAvMTAvMjYgMTA6NDEsIERhZWhvIEplb25nIHdyb3RlOgo+ID4g
RnJvbTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBTdG9yZXMg
dGhyb3VnaCBhIHNoYXJlZCB3cml0YWJsZSBtYXBwaW5nIGFuZCBmYWxsb2NhdGUgd2l0aAo+ID4g
RkFMTE9DX0ZMX1BVTkNIX0hPTEUsIEZBTExPQ19GTF9aRVJPX1JBTkdFLCBGQUxMT0NfRkxfQ09M
TEFQU0VfUkFOR0Ugb3IKPiA+IEZBTExPQ19GTF9JTlNFUlRfUkFOR0UgZG8gbm90IGdvIHRocm91
Z2ggLT53cml0ZV9iZWdpbiwgc28gdGhleSBieXBhc3MKPiA+IHRoZSBDT1cgaW5vZGUgYW5kIG1v
ZGlmeSB0aGUgb3JpZ2luYWwgaW5vZGUgZGlyZWN0bHkuIFJlamVjdCB0aGVtIHdoaWxlCj4gPiB0
aGUgZmlsZSBpcyBpbiBhdG9taWMgd3JpdGUgbW9kZSwgYXMgZmFsbG9jYXRlIGFscmVhZHkgZG9l
cyBmb3IgcGlubmVkCj4gPiBhbmQgY29tcHJlc3NlZCBmaWxlcy4gQSB3cml0ZSBmYXVsdCBnZXRz
IFNJR0JVUyBhbmQgZmFsbG9jYXRlIGdldHMKPiA+IC1FT1BOT1RTVVBQLgo+ID4KPiA+IGZhbGxv
Y2F0ZSB3aXRob3V0IHRoZXNlIGZsYWdzIG9ubHkgcHJlYWxsb2NhdGVzIGJsb2NrcyBhbmQgc3Rh
eXMKPiA+IGFsbG93ZWQuCj4gPgo+ID4gZjJmc192bV9wYWdlX21rd3JpdGUoKSBjYW5ub3QgdGFr
ZSBpbm9kZV9sb2NrLCBzbyBjaGVjayB0aGUgZmxhZyB1bmRlcgo+ID4gaW52YWxpZGF0ZV9sb2Nr
LCBhbmQgaG9sZCBpbnZhbGlkYXRlX2xvY2sgaW4KPiA+IGYyZnNfaW9jX3N0YXJ0X2F0b21pY193
cml0ZSgpIGZyb20gdGhlIGZsdXNoIHVudGlsIHRoZSBmbGFnIGlzIHNldC4KPiA+IE90aGVyd2lz
ZSBhIGZhdWx0IGNvdWxkIGNoZWNrIHRoZSBmbGFnLCB0aGVuIHN0YXJ0X2F0b21pY193cml0ZSBj
b3VsZAo+ID4gZmx1c2ggYW5kIHNldCB0aGUgZmxhZywgYW5kIHRoZSBmYXVsdCB3b3VsZCBkaXJ0
eSB0aGUgZm9saW8gYWZ0ZXJ3YXJkcy4KPiA+Cj4gPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcKPiA+
IEZpeGVzOiAzZGIxZGUwZTU4MmMgKCJmMmZzOiBjaGFuZ2UgdGhlIGN1cnJlbnQgYXRvbWljIHdy
aXRlIHdheSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29n
bGUuY29tPgo+Cj4gRGFlaG8sCj4KPiBQbGVhc2UgdGFrZSBhIGxvb2sgYXQgaHR0cHM6Ly9zYXNo
aWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMDEwMDI0MTMzLjI0NDQ3NjEtMS1kYWVobzQzJTQwZ21h
aWwuY29tCj4KPiBJIHRoaW5rIHdlIG5lZWQgdG8gYXBwbHkgdGhpcyBhZnRlciAoImYyZnM6IHJl
bW92ZSBtYXBwZWR0b2Rpc2sgZmxhZyB1c2FnZSBpbiBtbWFwIHdyaXRlIHBhdGgiKQo+Cj4gTW9y
ZSBkZXRhaWxzIGFyZSBpbiBteSBjb21tZW50cyBvbiB0aGlzIHBhdGNoOgo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvNDk2YjkxM2MtZWI4MS00ZmE4LWJlNzItYzZh
MDZhMTBhYmEyQGtlcm5lbC5vcmcvCj4KPiBPdGhlcndpc2UgaXQgbG9va3MgZ29vZCB0byBtZS4K
Pgo+IFJldmlld2VkLWJ5OiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4KPiBUaGFua3MsCgpP
aCwgZ290IGl0LgoKVGhhbmtzLAoKPgo+ID4gLS0tCj4gPiB2Mjogc2VyaWFsaXplIGF0b21pYyBm
bGFnIGNoZWNrIGluIGYyZnNfdm1fcGFnZV9ta3dyaXRlKCkuCj4gPiAtLS0KPiA+ICBmcy9mMmZz
L2ZpbGUuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL2Yy
ZnMvZmlsZS5jIGIvZnMvZjJmcy9maWxlLmMKPiA+IGluZGV4IGVmNGQyMThlNjk0Li43MDIwYjNl
ODk0MCAxMDA2NDQKPiA+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4gPiArKysgYi9mcy9mMmZzL2Zp
bGUuYwo+ID4gQEAgLTE4Nyw2ICsxODcsMTcgQEAgc3RhdGljIHZtX2ZhdWx0X3QgZjJmc192bV9w
YWdlX21rd3JpdGUoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCj4gPiAgICAgICBmaWxlX3VwZGF0ZV90
aW1lKHZtZi0+dm1hLT52bV9maWxlKTsKPiA+ICAgICAgIGZpbGVtYXBfaW52YWxpZGF0ZV9sb2Nr
X3NoYXJlZChpbm9kZS0+aV9tYXBwaW5nKTsKPiA+Cj4gPiArICAgICAvKgo+ID4gKyAgICAgICog
bW1hcCBzdG9yZXMgYnlwYXNzIHRoZSBDT1cgaW5vZGUgYW5kIHdvdWxkIGJyZWFrIGF0b21pY2l0
eS4gQ2hlY2sKPiA+ICsgICAgICAqIHVuZGVyIGludmFsaWRhdGVfbG9jazogZjJmc19pb2Nfc3Rh
cnRfYXRvbWljX3dyaXRlKCkgaG9sZHMgaXQgd2hpbGUKPiA+ICsgICAgICAqIGZsdXNoaW5nIGRp
cnR5IGZvbGlvcyBhbmQgc2V0dGluZyBGSV9BVE9NSUNfRklMRSwgc28gZWl0aGVyIGl0IHNlZXMK
PiA+ICsgICAgICAqIG91ciBkaXJ0eSBmb2xpbyBhbmQgd3JpdGVzIGl0IGJhY2ssIG9yIHdlIHNl
ZSB0aGUgZmxhZy4KPiA+ICsgICAgICAqLwo+ID4gKyAgICAgaWYgKHVubGlrZWx5KGYyZnNfaXNf
YXRvbWljX2ZpbGUoaW5vZGUpKSkgewo+ID4gKyAgICAgICAgICAgICBlcnIgPSAtRU9QTk9UU1VQ
UDsKPiA+ICsgICAgICAgICAgICAgZ290byBvdXRfc2VtOwo+ID4gKyAgICAgfQo+ID4gKwo+ID4g
ICAgICAgZm9saW9fbG9jayhmb2xpbyk7Cj4gPiAgICAgICBpZiAodW5saWtlbHkoZm9saW8tPm1h
cHBpbmcgIT0gaW5vZGUtPmlfbWFwcGluZyB8fAo+ID4gICAgICAgICAgICAgICAgICAgICAgIGZv
bGlvX3Bvcyhmb2xpbykgPiBpX3NpemVfcmVhZChpbm9kZSkgfHwKPiA+IEBAIC0yMTEzLDkgKzIx
MjQsMTEgQEAgc3RhdGljIGxvbmcgZjJmc19mYWxsb2NhdGUoc3RydWN0IGZpbGUgKmZpbGUsIGlu
dCBtb2RlLAo+ID4KPiA+ICAgICAgIC8qCj4gPiAgICAgICAgKiBQaW5uZWQgZmlsZSBzaG91bGQg
bm90IHN1cHBvcnQgcGFydGlhbCB0cnVuY2F0aW9uIHNpbmNlIHRoZSBibG9jawo+ID4gLSAgICAg
ICogY2FuIGJlIHVzZWQgYnkgYXBwbGljYXRpb25zLgo+ID4gKyAgICAgICogY2FuIGJlIHVzZWQg
YnkgYXBwbGljYXRpb25zLiBBdG9taWMgZmlsZXMgc2hvdWxkIG5vdCBlaXRoZXIsIHNpbmNlCj4g
PiArICAgICAgKiB0aGVzZSBtb2RpZnkgdGhlIG9yaWdpbmFsIGlub2RlIGRpcmVjdGx5IGFuZCBi
cmVhayBhdG9taWNpdHkuCj4gPiAgICAgICAgKi8KPiA+IC0gICAgIGlmICgoZjJmc19jb21wcmVz
c2VkX2ZpbGUoaW5vZGUpIHx8IGYyZnNfaXNfcGlubmVkX2ZpbGUoaW5vZGUpKSAmJgo+ID4gKyAg
ICAgaWYgKChmMmZzX2NvbXByZXNzZWRfZmlsZShpbm9kZSkgfHwgZjJmc19pc19waW5uZWRfZmls
ZShpbm9kZSkgfHwKPiA+ICsgICAgICAgICAgZjJmc19pc19hdG9taWNfZmlsZShpbm9kZSkpICYm
Cj4gPiAgICAgICAgICAgICAgIChtb2RlICYgKEZBTExPQ19GTF9QVU5DSF9IT0xFIHwgRkFMTE9D
X0ZMX0NPTExBUFNFX1JBTkdFIHwKPiA+ICAgICAgICAgICAgICAgICAgICAgICBGQUxMT0NfRkxf
WkVST19SQU5HRSB8IEZBTExPQ19GTF9JTlNFUlRfUkFOR0UpKSkgewo+ID4gICAgICAgICAgICAg
ICByZXQgPSAtRU9QTk9UU1VQUDsKPiA+IEBAIC0yNDAzLDYgKzI0MTYsOCBAQCBzdGF0aWMgaW50
IGYyZnNfaW9jX3N0YXJ0X2F0b21pY193cml0ZShzdHJ1Y3QgZmlsZSAqZmlscCwgYm9vbCB0cnVu
Y2F0ZSkKPiA+Cj4gPiAgICAgICBmMmZzX2Rvd25fd3JpdGUoJmZpLT5pX2djX3J3c2VtW1dSSVRF
XSk7Cj4gPiAgICAgICBmMmZzX2Rvd25fd3JpdGUoJmZpLT5pX2djX3J3c2VtW1JFQURdKTsKPiA+
ICsgICAgIC8qIHNlcmlhbGl6ZSB3aXRoIGYyZnNfdm1fcGFnZV9ta3dyaXRlKCksIHNlZSB0aGUg
Y29tbWVudCB0aGVyZSAqLwo+ID4gKyAgICAgZmlsZW1hcF9pbnZhbGlkYXRlX2xvY2soaW5vZGUt
PmlfbWFwcGluZyk7Cj4gPgo+ID4gICAgICAgLyoKPiA+ICAgICAgICAqIFNob3VsZCB3YWl0IGVu
ZF9pbyB0byBjb3VudCBGMkZTX1dCX0NQX0RBVEEgY29ycmVjdGx5IGJ5Cj4gPiBAQCAtMjQ1OCw2
ICsyNDczLDcgQEAgc3RhdGljIGludCBmMmZzX2lvY19zdGFydF9hdG9taWNfd3JpdGUoc3RydWN0
IGZpbGUgKmZpbHAsIGJvb2wgdHJ1bmNhdGUpCj4gPiAgICAgICBmMmZzX2lfc2l6ZV93cml0ZShm
aS0+Y293X2lub2RlLCBpc2l6ZSk7Cj4gPgo+ID4gIG91dF91bmxvY2s6Cj4gPiArICAgICBmaWxl
bWFwX2ludmFsaWRhdGVfdW5sb2NrKGlub2RlLT5pX21hcHBpbmcpOwo+ID4gICAgICAgZjJmc191
cF93cml0ZSgmZmktPmlfZ2NfcndzZW1bUkVBRF0pOwo+ID4gICAgICAgZjJmc191cF93cml0ZSgm
ZmktPmlfZ2NfcndzZW1bV1JJVEVdKTsKPiA+ICAgICAgIGlmIChyZXQpCj4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
