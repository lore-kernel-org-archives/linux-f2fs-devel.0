Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F003C369A2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:08:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2m1f-00025l-K0;
	Thu, 10 Apr 2025 07:08:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1u2m1e-00025c-8Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 07:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0gPVNYGnt3+KJG/9xLN6aLMUD/Y9tMayBs/WtcNi/WI=; b=NQpBW1FacNy6TTwtPBA0Td2VDR
 RHuEnwCr8YYULYRD81ljx2CBITD8v6yyTeLV6zWkt7BqIJCD+3cYcWL6A638/lRSVGuN38l7Gqijd
 g3hslzElnFZRfXlQMRRbUZ0AN/mre2i0X/2lD0KlY0RDQ3ivmOInbcaKPHBx5YmdlmOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0gPVNYGnt3+KJG/9xLN6aLMUD/Y9tMayBs/WtcNi/WI=; b=Jrz+duujSZgmHAKKJo1Edy1ciz
 a1ZEmoMEDiYuR+0p2+xYkMlRMUBsrHrnIWktubqksoQOXk8kVK9bdIt9X7gQCXuGuvP2g6oEDdcjy
 E2FfAmi+Zjde/mxSGquDvx9Ib1qqBs1a2LtFF2SryKPdGS3PyHIMZKAztI019nCMwizU=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1u2m1N-00030v-RM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 07:08:37 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5e60cfef9cfso780113a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Apr 2025 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744268895; x=1744873695; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gPVNYGnt3+KJG/9xLN6aLMUD/Y9tMayBs/WtcNi/WI=;
 b=CN93XeBfTpHIteOKtM+lx7QiDUfXfXHKi/5foVIG32X2Y3B2chIsuTvNVzpNPixohC
 fDo7+M7aUP5wVfxEbQpCVAntOOQfTfs6xM6cc2/bPOCgxZGKIYvlYeZoico0NSlaFuzz
 qpMQtT5LL9iHryIdqPeY1jzJ4iM3nLgvRLXd7xiQ1xItBN6trAPcARL9C39QR7PHaKeG
 BAfHTPGjVqwqUfpu8AG/EF+fRiq4CY3Nh4PM3oMZdbczSzmhYHqeb1x/QkVz041wkzm7
 pHMenlxFX+HCO8sfG5aXWQdqSMm1QPsbLfkakrK7lKnBvMT2xBxReuaoFSBDuGhIW313
 f/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744268895; x=1744873695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gPVNYGnt3+KJG/9xLN6aLMUD/Y9tMayBs/WtcNi/WI=;
 b=qmKsFm3whl2ERfs8Q71bWKNuqPTw6tQb73mrkHFUIOAOtOhDT5+skxNPDqF2FS+Mc1
 RliBLAqVh7BjPoITwBdoB27rnfVsiQEKmcWSbcrFVUdhsM4yCn5u969Au6r3O6qHrgM3
 8dYMo72mtwlbI1DZaKEAJ2Qmf7lA4kZ0Kya2OUnrfLv6wQeRiOMWHEiiEDgo/SujP7Yg
 4DThjIfpZAKxAzc/QcGUcDBNSAmu6tWMbHyEJjIWkeD5d2pdafCBGDMUei19M8T+WPMO
 rVwaDN2703+lcpkbPx7nE2Y1j7/gfP8ymwI1n+6YmVMQM7qywCOxCiT0tw1aKA6U1MZL
 IjVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwaN+KOVFkoN3yXNWx2y4lp45heAHLWdaHtG75qOWIktrX41rFjxz0JWSb5O6gGJoax8un4mWHtrdvYXMv4QcK@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxr953Ok1Xv0r1CZSOwaX1dFlS0iLlmoBQ0PK+oku2HQP+5sCBZ
 gYYiPFuCK1o0fevJSPoirrgQKXJlJgA8GoJH47wvwIjZYPWYmTLT0NvII0Kk5vGUPiwL6jet5LV
 whvJR9q/GuC9lk0hm8irFDU6p/u185tne
X-Gm-Gg: ASbGncsOjVXQVHlPAGAwfW8JVfhilLjGuUK5jua+mUv7B7jfPNll/nCCU6KezG7071e
 wwKNHNtW6OshiiGsndixov9Zo9/4jv+WNQS3rIkrdurw8NEMAsCviUns4BWEq1CslmhXckRurSV
 GI7RTjir5Qqn+F5MGprdq4jjo=
X-Google-Smtp-Source: AGHT+IEwP8YKKrLHgq08AeWVny1T4TMdzO/48phJZb9uJV9ZaHD37SFsHKEMhVw68OwJ3ODIrISHzthr4HGnVMFMvBI=
X-Received: by 2002:a17:907:3c93:b0:ac2:49de:3969 with SMTP id
 a640c23a62f3a-acabd4d2ee7mr136373766b.47.1744268895047; Thu, 10 Apr 2025
 00:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <88f281ff9ff9b1fb899c92d6b32f52b7@airmail.cc>
 <CAD14+f1CYZ-OyKg36b_=VPmbBK0LSiieq1pgtXUy4OV2+KrR_g@mail.gmail.com>
 <6e929f78-ab82-434b-a553-6e56d38fcfcc@kernel.org>
 <CAD14+f3CQr2FgUc8Ut6=O0gOd6cAmYyadSNBt9SVnishdzc4kQ@mail.gmail.com>
 <193b95bc-4148-43eb-9a7a-d501ae5d95c6@kernel.org>
In-Reply-To: <193b95bc-4148-43eb-9a7a-d501ae5d95c6@kernel.org>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Thu, 10 Apr 2025 00:08:03 -0700
X-Gm-Features: ATxdqUFFVomHLpUPcYJpV6JcyCPgKi3xmWV4ReE4Ap3iVxnJ5bwOcy3ZH9__P3c
Message-ID: <CAD14+f18dXBLKK7nGiGt1rhtxPWVHXJ9wJzoaJjhNiPP_o3DUg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u2m1N-00030v-RM
Subject: Re: [f2fs-dev] Resize metadata corruption
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
Cc: uplinkr@airmail.cc, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBBcHIgMTAsIDIwMjUgYXQgMTI6MDDigK9BTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Cj4gT24gNC8xMC8yNSAxMzo1NywgSnVoeXVuZyBQYXJrIHdyb3RlOgo+ID4g
SGkgQ2hhbywKPiA+Cj4gPiBPbiBXZWQsIEFwciA5LCAyMDI1IGF0IDEwOjUy4oCvUE0gQ2hhbyBZ
dSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Pgo+ID4+IE9uIDQvNi8yNSAxNjozMCwgSnVo
eXVuZyBQYXJrIHdyb3RlOgo+ID4+PiBIaSBhbGwsCj4gPj4+Cj4gPj4+IEkgYWxzbyBlbmNvdW50
ZXJlZCBzb21ldGhpbmcgc2ltaWxhciBhIHdoaWxlIGJhY2sgd2l0aCByZXNpemluZyBidXQKPiA+
Pj4gZGlkbid0IHJlcG9ydCBpdCBhbmQganVzdCBtYW51YWxseSBtaWdyYXRlZCB0aGUgZmlsZXMu
Cj4gPj4KPiA+PiBIaSBKdWh5dW5nLAo+ID4+Cj4gPj4gRGlkIHlvdSBkZXZlbG9wIGFuIGluZGl2
aWR1YWwgdG9vbCB0byBtaWdyYXRlIHNwZWNpZmllZCBpbm9kZSB0byB0YXJnZXQKPiA+PiBibG9j
ayBhZGRyZXNzPwo+ID4KPiA+IE5vcGUuIEFuZCBuZWl0aGVyIGRpZCBAdXBsaW5rciB1c2UgYW55
IGN1c3RvbSB0b29scyB0byBtZXNzIGFyb3VuZCB0aGUKPiA+IGYyZnMgcGFydGl0aW9uLgo+Cj4g
T2gsIHNvIGhvdyBkaWQgeW91IG1pZ3JhdGUgZmlsZXMgbWFudWFsbHk/CgpZb3UgcmVtZW1iZXIg
dGhlIGV4dGVuZGVkIG5vZGUgYml0bWFwIGZpYXNjbyA6KQpBZnRlciB0aGF0LCB3aGVuZXZlciBJ
IHJ1biBmc2NrIChvciBpbiB0aGlzIGNhc2UsIHJlc2l6ZSksIEkgd3JhcCB0aGUKZW50aXJlIHJh
dyBibG9jayBkZXZpY2UgdG8gYSBkbS1zbmFwc2hvdCBzbyB0aGF0IG9yaWdpbmFsIHN0YXlzIGlu
dGFjdAphbmQgcnVuIGlmIG9uIHRvcCBvZiB0aGUgZG0sIHNvIHRoYXQgSSBkb24ndCBydW4gaW50
byBjb3JuZXIgY2FzZXMuCgpXaGVuIEkgd2FzIG1pZ3JhdGluZyBteSBwZXJzb25hbCBmMmZzIHNl
dHVwIHRvIGFub3RoZXIgU1NELCBJIGhhZApzaW1pbGFyIHJlc2l6ZS9mc2NrIHdhcm5pbmdzL2Vy
cm9ycy4gKEkgc2hvdWxkJ3ZlIHJlcG9ydGVkIHRoaXMgYmFjawp0aGVuLCBzb3JyeS4pClNvIEkg
ZGVjaWRlZCB0byBqdXN0IHJzeW5jIHRoZSB3aG9sZSBwYXJ0aXRpb24gYWZ0ZXIgbW91bnRpbmcg
aXQgYW5kCm1pZ3JhdGUgdW5kZXIgVkZTIGFuZCBub3QgcmlzayB0aGUgcG90ZW50aWFsIGNvcm5l
ciBjYXNlLgoKU28gZm9yIG15IGNhc2UsIGl0IHdhcyBiZWZvcmUgdGhlIGRhbWFnZSB3YXMgZG9u
ZSAod2l0aCBkbS1zbmFwc2hvdCkKdW5saWtlIEB1cGxpbmtyLgoKPgo+ID4KPiA+Pgo+ID4+PiBJ
IGFzc2lzdGVkIGhpbSB0byBlbnN1cmUgdXNpbmcgdGhlIGxhdGVzdCBrZXJuZWwvZjJmcy10b29s
cywgYnV0IGhpcwo+ID4+PiBtZXRhZGF0YSBzZWVtcyBwcmV0dHkgYmFkIHJpZ2h0IG5vdyBhbmQg
SSBzdWdnZXN0ZWQgaGltIHRvIGFzayB0aGUKPiA+Pj4gbWFpbGluZyBsaXN0IGRpcmVjdGx5Lgo+
ID4+Cj4gPj4gSSBjaGVja2VkIHRoZSBsb2csIEkgZ3Vlc3MgaXQgYWN0dWFsbHkgc2VlbXMgcHJl
dHR5IGJhZC4uLiBJIGd1ZXNzIHdlCj4gPj4gbmVlZCB0byBmaW5kIG91dCB0aG9zZSBmaWxlIHdo
aWNoIGhhcyBub3QgYmVlbiBtaWdyYXRlZCBjb3JyZWN0bHksIGFuZAo+ID4+IHRyeSB0byBjb3Jy
ZWN0IHRoZW0sIG1heSBiZSB3LyBhIG5ldyB0b29sLgo+ID4KPiA+IFllYWgsIGhhdmluZyBmc2Nr
LmYyZnMgc2VnZmF1bHQgbWlkLXdheSBwb3N0IHJlc2l6ZSB3b24ndCBoZWxwIGVpdGhlci4KPiA+
Cj4gPj4KPiA+PiBUbyBKYWVnZXVrLCBhbnkgdGhvdWdodHMgYWJvdXQgdGhpcyBwcm9ibGVtPwo+
ID4+Cj4gPj4+Cj4gPj4+IFRoZSBVUkwgdGhlcmUgc2hvdWxkIGJlIGh0dHBzOi8vYXJ0ZXI5Ny5j
b20vLmYyZnMtMjAyNTA0MDYvZnNjay5sb2cgLAo+ID4+PiBhIGxpdHRsZSB0eXBvIHRoZXJlLgo+
ID4+Cj4gPj4gVGhhbmtzLCBJIGRpZG4ndCBub3RpY2UgdGhpcyBwcmV2aW91c2x5Lgo+ID4+Cj4g
Pj4+Cj4gPj4+IENhbiB3ZSBoYXZlIHNvbWUgc29ydCBvZiBDSS9hdXRvbWF0ZWQgdGVzdGluZyBm
b3IgdGhlIHJlc2l6aW5nIGFzIHdlbGw/Cj4gPj4KPiA+PiBBZ3JlZWQsIHdpbGwgd29yayBvbiBz
b21lIHRlc3RjYXNlcyBmb3IgcmVzaXplLmYyZnMgd2hlbiBJIGdldCBzb21lIGZyZWUKPiA+PiBz
bG90cy4KPiA+Cj4gPiBTaG91bGQgd2UgbWFyayB0aGlzIGV4cGVyaW1lbnRhbCBmb3IgdGhlIHRp
bWUgYmVpbmc/Cj4KPiBBZ3JlZWQuCj4KPiBUaGFua3MsCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+
ID4+Cj4gPj4gVGhhbmtzLAo+ID4+Cj4gPj4+Cj4gPj4+IFRoYW5rcy4KPiA+Pj4KPiA+Pj4gT24g
U3VuLCBBcHIgNiwgMjAyNSBhdCAxOjI24oCvQU0gdXBsaW5rci0tLSB2aWEgTGludXgtZjJmcy1k
ZXZlbAo+ID4+PiA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ+IHdyb3Rl
Ogo+ID4+Pj4KPiA+Pj4+IEhlbGxvIGV2ZXJ5b25lLAo+ID4+Pj4KPiA+Pj4+IEkgYW0gaGF2aW5n
IHRyb3VibGUgd2l0aCBGMkZTLiBTcGVjaWZpY2FsbHksIEkgYmVsaWV2ZSBtZXRhZGF0YSBnb3QK
PiA+Pj4+IGNvcnJ1cHRlZCB3aGVuIEkgcmVzaXplZCBpdC4gSSBoYXZlIGEgNTEyIEdCIGRyaXZl
LiBNeSBGMkZTIHBhcnRpdGlvbgo+ID4+Pj4gd2FzIGFwcHJveGltYXRlbHkgbG9jYXRlZCBvbiAz
NjktNDk3IEdCICgxMjggR0Igc2l6ZSkuIFVzaW5nIEdQYXJ0ZWQsIEkKPiA+Pj4+IHJlc2l6ZWQg
aXQgdG8gMC41LTQ5NyBHQi4gV2hpbGUgdGhlIHBhcnRpdGlvbiByZXNpemluZyB3ZW50IHRocm91
Z2gKPiA+Pj4+IHN1Y2Nlc3NmdWxseSwgZmlsZXN5c3RlbSByZXNpemluZyBpbml0aWFsbHkgZmFp
bGVkIHdpdGggIk1vdW50IHVuY2xlYW4KPiA+Pj4+IGltYWdlIHRvIHJlcGxheSBsb2ciLiBJIGhh
dmUgZG9uZSB0aGF0IGFuZCByZXRyaWVkIHJlc2l6aW5nLgo+ID4+Pj4KPiA+Pj4+IEFmdGVyd2Fy
ZHMsIGhvd2V2ZXIsIGZzY2sgc3RhcnRlZCBnaXZpbmcgb3V0IGEgbG90IG9mIGVycm9ycywgYXQg
b25lCj4gPj4+PiBwb2ludCBpdCBhc2tlZCBpZiBJIHdpc2hlZCB0byByZXN0b3JlIGxvc3QgZGF0
YSwgd2hpY2ggSSBhZ3JlZWQgdG8uIExvZ3MKPiA+Pj4+IHNwZWNpZmllZCBhIGxvdCBvZiBteSBm
aWxlcyAod2hpY2ggSSBjb3VsZCB0ZWxsIGJ5IGZpbGVuYW1lcykgYW5kCj4gPj4+PiBtaWQtd2F5
IHRocm91Z2ggdGhlIHByb2Nlc3MsIGl0IHNlZ2ZhdWx0ZWQuIE5vdywgd2hlbiBJIHJ1biBmc2Nr
LCBubwo+ID4+Pj4gZmlsZXMgYXJlIGFza2VkIHRvIGJlIHJlc3RvcmVkLCBhbmQgaXQgY29tcGxl
dGVzIHN1Y2Nlc3NmdWxseS4gSG93ZXZlciwKPiA+Pj4+IHdoZW4gSSBhdHRlbXB0IHRvIG1vdW50
IGl0LCBJIGdldCBhbiBlcnJvciBzYXlpbmcgIlN0cnVjdHVyZSBuZWVkcwo+ID4+Pj4gY2xlYW5p
bmciLgo+ID4+Pj4KPiA+Pj4+IENvdWxkIHNvbWVvbmUgaGVscCBtZSByZXN0b3JlIG15IG1ldGFk
YXRhIChhdCBsZWFzdCwgbG9uZyBlbm91Z2ggdG8KPiA+Pj4+IGV4dHJhY3QgbXkgZmlsZXMpPyBU
aGFua3MuCj4gPj4+Pgo+ID4+Pj4gZG1lc2cgbG9nczoKPiA+Pj4+Cj4gPj4+PiBbICAgOTYuMTg0
MTI3XSBGMkZTLWZzIChudm1lMG4xcDUpOiBNaXNtYXRjaCB2YWxpZCBibG9ja3MgNzY5IHZzLiA2
OAo+ID4+Pj4gWyAgIDk2LjE4ODA1MF0gRjJGUy1mcyAobnZtZTBuMXA1KTogRmFpbGVkIHRvIGlu
aXRpYWxpemUgRjJGUyBzZWdtZW50Cj4gPj4+PiBtYW5hZ2VyICgtMTE3KQo+ID4+Pj4KPiA+Pj4+
IGZzY2suZjJmcyAtLWRyeS1ydW4gLWQgMyBsb2dzOiBodHRwczovL2FydGVyLmNvbS8uZjJmcy0y
MDI1MDQwNi9mc2NrLmxvZwo+ID4+Pj4KPiA+Pj4+Cj4gPj4+PiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4+Pj4gTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKPiA+Pj4+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4g
Pj4+PiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCj4gPj4+Cj4gPj4+Cj4gPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gPj4+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4g
Pj4+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gPj4+IGh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPiA+
Pgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
