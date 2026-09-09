Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C6C79FBB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0mtp7q859+4PuovblAhtvZxUkuXZaf0LsK6GZXIjE0w=; b=LAIe4q025K3utqWQwOMw5ht0E9
	wXibRNVF0HwlN2ZqIWPqK2dAibUCtgbROG9S1gO4Z4q6GwGm4cT3rdyQocCimrRHulUJpVjTGmlyw
	RmbRD9b5S17dTCBbzzgBlckG5UN/EkjGWMbjPhN2MkfPo/J/6j4BOSdjsQ8PMSnCPVxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4PlH-0006Nr-4I;
	Wed, 09 Sep 2026 21:23:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4PlG-0006Ni-45
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 21:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=US8zWj9mKFEyBh21kpnWF7MhWmXE0I2q79W2pu8+6M8=; b=eBw7ve2BfKXVnZ0k1f6abBIFKz
 2L9uTgCeZVTyB+8/Dt+0keqbRLcqDwitmXiWLql7Tp02+I/uE7idIHQw0jE/2epB2Nlr5p8DTrl0U
 h+TojLKu10JTnQJpATy3sxb1ZBUBrbTZ0FU/EEfUvONZr4sUMjcUPsRV+q2nvj8SuiA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=US8zWj9mKFEyBh21kpnWF7MhWmXE0I2q79W2pu8+6M8=; b=YW6/+zO1tYAPKp+mVEV+GfWBQB
 xwldTF1nrI8tXn9ZiQ3ethpfsNOPYb6EuI9GyXs6a5Ue9UbuIs/RwQONGx40lOXXSxsFJa8zbsoXZ
 VaejZQBypogXLAUPaydbq4bc7CPrDY12G0YDIRkHkd+GtmwMdcIZTPW6+MrC61Jg64uQ=;
Received: from mail-lj1-f170.google.com ([209.85.208.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4PlF-0008F2-8u for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 21:23:18 +0000
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-3a1f75277f3so45555311fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 14:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788988990; cv=none;
 d=google.com; s=arc-20260327;
 b=TJd/LSPZdg8i82XJSJPQFMsuqx31N8KcBSkVmHfXVGd3XPyLMnxbsdGJPYIv86oofb
 EaOr45x124hziA+oJNYzzumS93U53ey+zjBIOD9V5ZmyVaOM4EE8LS3T5vKJkchvCck6
 jcvX6Nr1ASY4grYAXoIz0PhQBajIF4ReswoIrZ0kjL8/BPWLEPjAFI5zu/nvtd9i3i2q
 x8Wi/TyVfFaROfHhNX1pckUfA8ul874ZdNxJFAal11mBDFYkLdBnuAFeHRPEYMP/mvnA
 2naOXrOoskXEIbE2f0uzeFwxWYrERsX6AZHYHltixodsBy+Hd9V8AfF+sDsZ36FWr1Fa
 lwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=US8zWj9mKFEyBh21kpnWF7MhWmXE0I2q79W2pu8+6M8=;
 fh=qFZYuL+4x0FExhvrZU4/1+Y53MyrUl59ufSZ68D0m4Y=;
 b=dLTKScIBhMir7i/gmK1gNt/5OhQb5NDYbPMF9vhGohC1I5ocEd27iuK1P79qJb4MIk
 CAukeXsG0dJpqAZLGO6PzDYBpByHQY7ShbrXmfTrM0DJeMqOIXN+VvqnZCVNQbjU/p1k
 iITrEOGeAPaEEP5mGOR62P+5gK0hAfJcflx1pNu6NeW8jDTjVrs77ldadJ9Eqb1SJUmc
 LBR4Ye/kFR6fHSUfXsIDajDGkP3K3++tzA+jO/GjpGPtZefNXloSHZf0oG/DbnPl0iW4
 NUH3hspx7Z7030IPC7XEyWSeecNc+TV0aXQ7jyb1B6wZqSndRVnzkzJGe2qbKFX0Wg7U
 mm2w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788988990; x=1789593790; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=US8zWj9mKFEyBh21kpnWF7MhWmXE0I2q79W2pu8+6M8=;
 b=hCeFUYVFbcP+u1TVlRnwUZ6AbdN40jOn+KERVdpyA9XJFOV3d9TeOd8lICLd4JWWEB
 Mr6kdiAIhf+f7RQb7wJL7sXjlcr11libt7ZTfbnrAzcc7IzkvYzaxqnZpQWEtgi6K5D5
 lnh0D3nDipUKgpxOYCmVFXA/kGv3atbutqZ33P3Dop8iiA7RZwSAJLfOeek3kKP8KOmn
 89HJdqg2n/o0txgosrxNR2CaX3BgMo8pTNKl1xoF50FuKLytdBH5RfYAT9H5/Y3W5/WO
 VUorC84IHJCilJ50iYkG92cR9KiV3fniAfcTDMet1gX/c0gJg6txT0JOAyKkCpZEI2Zc
 DsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988990; x=1789593790;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=US8zWj9mKFEyBh21kpnWF7MhWmXE0I2q79W2pu8+6M8=;
 b=Uq08k2mk82VSi1yw+wyurY/2xduf5YX99QdQStUHM+0+sjO/L+Q7l+2O/fjxtMmkBB
 frURZljKJVC2XHNtnllstymKL58cY1hb294cbC3YyrAlRTar71f/i2G8dqI9o968uJ30
 Dncpc6g1EO4gkMMOfQ23RTF6Fr3mUTRMQLuxJDBUq3qdTPFeAc7C7oFloPIaqzMkN3ft
 IRoCsEM2yKktisL+r9AIuz+delRQpOmHTYd9bgEL0D7662TSFwoskxVG4Hocot05OB7V
 YIUVRgxGArOz3+0QzN4zNGADFRsfZmxGX5QGOyAB0cAHopaFMGARmzBo2q6iv6gGmcyR
 CYWA==
X-Forwarded-Encrypted: i=1;
 AKwUvByb74loGs3uz4KYtypp/sfJhmE+NVVaBC5cdpIJlVEEO2QEUvz/lcpooaWwKqQ50X91Bdw/5MJiKHx2lCJTTETQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mUxW3tigZVcgMeT11P6/CAneXZfnnpoVQGzL7HtILj2p8jTcl2
 uvg1gTVWeqzzIhH6XmZ0f3A4mLFDbXE8PwqPfGydi+gRt6g8UrD4kibTwnAqu9u8SSWojujsZqC
 g28wmdN7IOHgwBUH5Tqn+iffLP9FvMqk=
X-Gm-Gg: AYBFou3PP+RVr5Oya16LEV3IbId8EV33G8PjbEXcaLUHg90Di7dF/hjDzDNRTeo849U
 NrXQgmG/YGcr0axYq08WIuInuyre5cFBYutmjwexlkwuHCxQrDLd53+oEmm7/mwUB2vgPddiN+h
 QhMMBzQW49apyY/3GoGjUaOXV71PuOGNye2TW16QcDe8LiCBPJeNMQcCEIC+BGzP7jybObRxbYB
 H7ZGQZJfn74mVee06dm2Y/W8iMA7YAUZwNUNN2vQSug5rXpiR75hWxuM78ZrFKtiwsD8Mv08Uhc
 6e/i0PN33eqgilw0CInjlkqsEpF/foH4eIcpzjPoHNovC0nMtgtC1TGqiCQVpA+DspOzRphHbB1
 58i8eEYOSIHyxCT50DVstTxT6zLSpRllk+rHhRgmkbo8A
X-Received: by 2002:a05:6512:15a1:b0:5ae:ba27:ee63 with SMTP id
 2adb3069b0e04-5b616ede852mr6358407e87.7.1788988990244; Wed, 09 Sep 2026
 14:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <eecd3a49-d252-4d36-9e5a-44ac3eb02108@kernel.org>
 <20260907073434.2349510-1-zhaonanzhe@xiaomi.com>
 <823eac07-808f-4b8e-a289-538ace853e12@kernel.org>
In-Reply-To: <823eac07-808f-4b8e-a289-538ace853e12@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 14:22:56 -0700
X-Gm-Features: AcwNN1X0kWA6yWGZIATCJuPe5tnvFy9mHoLYQ3LXaMSsN-0tKkm2wMGCt11s7rA
Message-ID: <CACOAw_yyCJO+r+N18YfDJie2zLDKGQa4nD8s=w=gb+NK+mX2yA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x4PlF-0008F2-8u
Subject: Re: [f2fs-dev] [PATCH 06/14] f2fs: prepare mmap write faults for
 large folios
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBTZXAgOSwgMjAyNiBhdCAxMjozN+KAr0FNIENoYW8gWXUgdmlhIExpbnV4LWYyZnMt
ZGV2ZWwKPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToKPgo+
IE9uIDkvNy8yNiAxNTozNCwgTmFuemhlIFpoYW8gd3JvdGU6Cj4gPiBPbiBUaHUsIDI3IEF1ZyAy
MDI2IDIwOjM2OjAyICswODAwLCBDaGFvIFl1IHdyb3RlOgo+ID4+IFdlIG9ubHkgbmVlZCB0byBj
YWxsIGYyZnNfZ2V0X2Jsb2NrX2xvY2tlZCgpIGZvciB2bWYtPnBhZ2U/Cj4gPj4KPiA+PiBIaSBC
YXJyeSwgY291bGQgeW91IHBsZWFzZSBoZWxwIHRvIGNvbmZpcm0gdGhpcz8gT25seSB2bWYtPnBh
Z2UgY29udGFpbiBkaXJ0eQo+ID4+IGRhdGEsIHJhdGhlciB0aGFuIHdob2xlIGxhcmdlIGZvbGlv
IGNvbnRhaW4gZGlydHkgZGF0YT8KPiA+Cj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuIEhlcmUg
aXMgdGhlIHdyaXRlLWZhdWx0IHBhdGggb24gY3VycmVudAo+ID4gbWFpbmxpbmUgKG1tL21lbW9y
eS5jKToKPiA+Cj4gPiBkb19wdGVfbWlzc2luZygpICAgICAgICAgICAgICAgICAgICAgICAgICBt
ZW1vcnkuYzo0NTYxCj4gPiAgIC0+IGRvX2ZhdWx0KCkgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtZW1vcnkuYzo1OTY0Cj4gPiAgICAgLT4gZG9fc2hhcmVkX2ZhdWx0KCkgICAgICAgICAgICAg
ICAgICBtZW1vcnkuYzo1OTE0Cj4gPiAgICAgICAtPiBfX2RvX2ZhdWx0KCkgLT4gZmlsZW1hcF9m
YXVsdCgpICA6IGZhdWx0IGluIGZvbGlvIChtYXkgYmUgMTZLQikKPiA+ICAgICAgIC0+IGRvX3Bh
Z2VfbWt3cml0ZSh2bWYsIGZvbGlvKSAgICAgIDogcGFnZV9ta3dyaXRlIE9OQ0UgcGVyIGZvbGlv
IChtZW1vcnkuYzo1OTM2KQo+ID4gICAgICAgICAgLT4gdm1hLT52bV9vcHMtPnBhZ2VfbWt3cml0
ZSh2bWYpICBtZW1vcnkuYzozNjg0Cj4gPiAgICAgICAtPiBmaW5pc2hfZmF1bHQoKSAgICAgICAg
ICAgICAgICAgICBtZW1vcnkuYzo1NjE3Cj4gPiAgICAgICAgICAtPiBzZXRfcHRlX3JhbmdlKCkg
ICAgICAgICAgICAgICBtZW1vcnkuYzo1NTU4Cj4gPiAgICAgICAgICAgICBpZiAod3JpdGUpCj4g
PiAgICAgICAgICAgICAgICAgZW50cnkgPSBtYXliZV9ta3dyaXRlKHB0ZV9ta2RpcnR5KGVudHJ5
KSwgdm1hKTsgICBtZW1vcnkuYzo1NTc1Cj4gPiAgICAgICAgICAgICBzZXRfcHRlcyh2bWEtPnZt
X21tLCBhZGRyLCB2bWYtPnB0ZSwgZW50cnksIG5yKTsgICAgICBtZW1vcnkuYzo1NTg2Cj4gPgo+
ID4gU28gcGFnZV9ta3dyaXRlIGlzIGVudGVyZWQgb25jZSBwZXIgZm9saW8sIGFuZCBhZnRlcndh
cmRzIHRoZSBQVEVzIG9mCj4gPiBhbGwgc3VicGFnZXMgYXJlIGluc3RhbGxlZCB3cml0YWJsZSBp
biBvbmUgZ28gLSB3cml0ZXMgdG8gb3RoZXIKPiA+IHN1YnBhZ2VzIG9mIHRoZSBzYW1lIGZvbGlv
IHdpbGwgbm90IGZhdWx0IGFnYWluLiBUaGF0IGlzIHdoeQo+ID4gZjJmc192bV9wYWdlX21rd3Jp
dGUoKSBwcmVhbGxvY2F0ZXMvbWFya3MgZGlydHlfbGVuIHJhdGhlciB0aGFuCj4gPiBoYW5kbGlu
ZyB2bWYtPnBhZ2Ugb25seS4KPiA+Cj4gPiBJJ2xsIGFkZCBhIGNvbW1lbnQgaW4gZjJmc192bV9w
YWdlX21rd3JpdGUoKSBpbiB0aGUgbmV4dCB2ZXJzaW9uIHRvCj4gPiBtYWtlIHRoZSBwb2ludCBj
bGVhci4KPgo+IEkgc2VlLCB3ZSdkIGJldHRlciBsaW1pdCB0aGUgdXBwZXIgYm91bmRhcnkgb2Yg
Zm9saW8gb3JkZXIgaW4gb3JkZXIgdG8gYXZvaWQKPiBsYXJnZSB3cml0ZSBhbXBsaWZpY2F0aW9u
LCBzaW5jZSBldmVuIHVzZXIgb25seSB3cml0ZSA0ayBwYWdlIHZpYSBtbWFwLCBpdCB3aWxsCj4g
ZGlydHkgZW50aXJlIGxhcmdlIGZvbGlvLCBJSVVDLgo+Cj4gVG8gSmFlZ2V1aywgRGFlaG8sIGFu
eSBjb21tZW50cz8KPgoKSGkgQ2hhbywgTmFuemhlLAoKSSBhZ3JlZSB3aXRoIENoYW8uIFRoZSB3
cml0ZSBhbXBsaWZpY2F0aW9uIGNhdXNlZCBieSBiYXRjaC1pbnN0YWxsaW5nCndyaXRhYmxlIFBU
RXMgaW4gZmluaXNoX2ZhdWx0KCkgaXMgaW5kZWVkIHNldmVyZSBmb3IgZmxhc2ggc3RvcmFnZSAt
IGEKc2luZ2xlIDRLQiBzdG9yZSBjYW4gZWFzaWx5IGFtcGxpZnkgdG8gNjRLQiAoMTZ4KSBvciAy
TUIgKDUxMngpIG9mCmRpc2sgd3JpdGVzLgoKSGVyZSBpcyBteSBzdWdnZXN0aW9uIGZvciBvdXIg
c2hvcnQtdGVybSBhbmQgbG9uZy10ZXJtIHBsYW46CgpTaG9ydC10ZXJtOgoKQ2xhbXAgbWF4IGZv
bGlvIG9yZGVyOiBSZXN0cmljdCB0aGUgbWF4aW11bSBmb2xpbyBvcmRlciBmb3Igd3JpdGFibGUK
ZmlsZXMuIFRoaXMgY2FwcyB0aGUgd29yc3QtY2FzZSB3cml0ZSBhbXBsaWZpY2F0aW9uIHdoaWxl
IHN0aWxsCnByZXNlcnZpbmcgYmF0Y2hpbmcgYW5kIENvbnRQVEUgYmVuZWZpdHMuClNlbGVjdGl2
ZSBzcGxpdF9mb2xpbygpOiBJZiB3ZSB3YW50IHRvIGFsbG93IGhpZ2hlciBvcmRlcnMgKGUuZy4g
PgoxNktCKSBmb3IgcHVyZSBidWZmZXJlZCBJL08sIHdlIGNhbiBjb25kaXRpb25hbGx5IGNhbGwg
c3BsaXRfZm9saW8oKQppbiBmMmZzX3ZtX3BhZ2VfbWt3cml0ZSgpIHRvIGZhbGwgYmFjayB0byBv
cmRlci0wIHVwb24gc2hhcmVkIG1tYXAKd3JpdGUgZmF1bHRzLgpMb25nLXRlcm06IFRoZSBmdW5k
YW1lbnRhbCBzb2x1dGlvbiBiZWxvbmdzIGluIG1tLiBJIHRoaW5rIHRoZSBDUFUgTU1VCmFscmVh
ZHkgdHJhY2tzIGRpcnR5IHN0YXRlcyBwZXItUFRFLgpPbmNlIHRoZSBvbmdvaW5nIG1tIHByb3Bv
c2FscyBmb3IgUFRFIGRpcnR5IGhhcnZlc3RpbmcgbGFuZCBpbgptYWlubGluZSwgRjJGUyBjYW4g
c2ltcGx5IHF1ZXJ5IHdoaWNoIHN1YnBhZ2VzIHdlcmUgYWN0dWFsbHkgZGlydGllZAphdCB3cml0
ZWJhY2sgdGltZSByYXRoZXIgdGhhbiBwcmVtYXR1cmVseSBkaXJ0eWluZyB0aGUgd2hvbGUgZm9s
aW8gaW4KcGFnZV9ta3dyaXRlKCkuCgpVbnRpbCBtbSBnYWlucyBzdWJwYWdlIGRpcnR5IHRyYWNr
aW5nIGZvciBtbWFwLCBjbGFtcGluZyB0aGUgZm9saW8Kb3JkZXIgKGFuZCBvcHRpb25hbGx5IHNw
bGl0dGluZyBoaWdoIG9yZGVycyBvbiB3cml0ZSBmYXVsdCkgaXMgdGhlCm1vc3QgcHJhY3RpY2Fs
IHdheSBmb3J3YXJkLgoKVGhhbmtzLApEYWVobwoKPiBUaGFua3MsCj4KPiA+Cj4gPiBUaGFua3Ms
Cj4gPiBOYW56aGUKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QK
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
