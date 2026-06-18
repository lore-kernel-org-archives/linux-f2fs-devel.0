Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A982CCD98DE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqG2LJC5ysGjWVftA7+YZIxiO22bzxi/Q261chutZZo=; b=UtgKdO/YAKOgMpkjyUfScAsbjl
	Qc5lMu4tZ7GpWNka+F9NKgrhsIBV/i2UpTPL17Mhoj7qNmp5OgnL1zVUKRvwGS5E0YFCh7RumqQst
	tMiiUE70whbEyXWC2cQk/In5AwxlJ/PAc4UpS0+9wasll27if+Kw7/42/0VuE1CJwADE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wa3bC-0001u0-Vh;
	Thu, 18 Jun 2026 03:39:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wa3b0-0001tm-IE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 03:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=; b=ap/EgtUZioyiTnxtUqBF6J8nIZ
 jQv0XxV2P4uDel2q8hkCZjjcB8SIvtiQy+5k3OJzGOnEoU2F4OA9wk5s/Mj6ooRubHNRYcD98lBr9
 vtqrKCpurZ1aZI3rekaPhEh9p1ioB3MPhhGcl5ouSJWhXdPvhzlYvdNUgHWVR2EgiEaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=; b=LgPx04c1N5SJ6XFrXnwU2j+Xlr
 Fn7OIW+XWJFW+XOSe6YymGzGSfvJkl4JJ0B0c3x9s/ZpVcqdsx+YokKdchuEZgF3XCJKt+iEhmxWN
 1ZXSZq7Bkuj7NdNnmWUKSvmfyTjFSSYNmsgRI85cu2B+/gFrpDdrmbLBv9juUz3wlCBQ=;
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wa3ay-0008M1-6t for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 03:39:14 +0000
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aa68d9d56fso628539e87.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 20:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781753944; cv=none;
 d=google.com; s=arc-20240605;
 b=Ki5AkuezKLv8upm894IauFebDCRJxb2ho2q3iDAoFFHOExxN4o41ckzyTm27MM/Qbd
 ty9LbZVUjxgvEkgd1RsGOnXfGIArETvMMOU3JAGbHKSrXwLDlZuCZxPE/WwjFxSMIGtX
 xzKa+29Q0WZur/5wOSuphqQHSKFcpdIqevyoIXSXUIyjiA6wdESpWUSSF4KeVZ5Fi7KS
 lyAPzG9vfLBfxN6f1DSg0fNUxn+Np8mdGjB4LNjsVVIgGYqTi0UF9PiYIVLbKjKak6vM
 xo5LRMHjY6IAS7tOVCwfMVRKtk4cCATra5iDJnU/Dkaf9Rms+sXYZzmMjkRIaHk+eema
 vlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=;
 fh=AgjrWcYMTkj2xB0T12vKcqCs1BDIVLgvOX3B2BopvbY=;
 b=Uctoha7BoIhVYrOoCsKGRXkolTE6hUnsPj4CiEDyEynKUN3tVH8BKQJPk3ytE3qOJy
 JIWlyzoaEEeyt0trithvxW5aF8tow4T43hf/wEn53RlNU7D45iUQL6OCpa4W8vmIrOF0
 3xiFmeTe2H3/x7WIwG/qR9KDFtcp6btKyI7kwBKk9RJ7dG1XiYLHimlsEVMgMGqiSt9i
 LD8h7yDloPStwsbyofSfwRYmLoBLePN+4USZ5Yg/SbbcbdSfoyIuJ+hhe4ThVU4+Nvur
 iHW+CFo4ChOLwhKCsf7QHBCWVIYk6AsZmtFfCvKrTM9F3KiKsdJpbq7+33W8/hObsWZV
 CASA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781753944; x=1782358744; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=;
 b=nYBLBTvsD+BdoRa9OViz0S4J42ZP390VWI0FGkAUCBNu9dwB3nlFRpeEJX0Wg0Vi0T
 FZudta/EdUJbmdzDFQAmnXZ/ohl7Y/886eIwqbeEP0dxxbnWgSv7TUPcuxQnNMKS+9ii
 wuDq2diyzu4X26eBStzAsILSgEdC8MqaLp9lOcyY8YpeXhDPHdH3Y8lWBddUs8Le0iva
 mkmoqXPA0dAmNXUh7N/ekEHCyzVdPx6zwYiSguDMLcVri+fPGoDTfi6udAg//D9xnWx1
 0inPcH8WVpxjaNowRTpqom27z8o5ub11ywiNMAS9dLL+i28sHSvO6R0Qmqj31XzZ7aVL
 99iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781753944; x=1782358744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=;
 b=Uk/LFTiRJimfQUnZF+rDw1fdQkfD4cR+qBdhfEag9FGEfjYQg+djCalslzVyi77TXj
 QQCC2v2lqan09+01olL+GpyZpJ52KFBJp33fQfnXNPmnWqzweb7xFQiilICgMvmh1WI4
 HKUlAgnAirIAXDwou60bdP9Frk50LCVCSZuMyV64ccK68NzNUBLU6EOriV/Uq0t77RBX
 4LydAhJxNAABA0PSZRMza+fOGgbRWTiY2DrHoLBHxVCJZnJLz0Jv/0conT0ZyMIsEiMq
 Afpv2lpcXCut6jT65+X6az7ak8wDetNIyAsgg3HL0S2atqEd6UvP1Hwo+GjnVWfYo3TG
 Kz+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eztn150tJUpGzVcWk3qF3P/GJ1JOePObptuNCzISHnSL7dKhMdylczTQtxGbxYZSdSHW1vxnmfT5LhwGUYBiV@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyxd+2LsBO9xCQhpBGWmy4BUdIsLamDcAjTEL9ueXyBoxRwkNOu
 FqQAXa5QSaqq7/lZxu35p2GTSNOZvZxcw8e38Ks8egPIUYU88tc+/EQffr9OGue61FKsnoGUfmP
 xG5d5dABQWsY6P5Bg2JGxpGIm80Sjfv0=
X-Gm-Gg: AfdE7cn8T1XsfJsrkBDxF4AymaITaSWTBgaEbGpyfXDi0N54WfA94cbttPCvqf9yvgb
 fXEBWPsYMvc3CLeh/YAbZw7puICN45a2/xqBc8UW1jqoytb/+HlOSUc5Nidwog9sodmM1u+XR8U
 yH8VrsujnmH/4HJGBkIPKx2sRN44+q3VSHE0isDIH/Vq3C+Kl/o7yjPMGYovUOb5JLbxHP38+Hk
 jWm0A4CMOYmGch8QkLw+8/r2yyb7qRE6RSwdfbf+twPZa5zyA0KueL0dag3EU9DXyFAsYMK7w==
X-Received: by 2002:ac2:51ca:0:b0:5aa:719c:a21c with SMTP id
 2adb3069b0e04-5ad47db1520mr1680794e87.20.1781753943777; Wed, 17 Jun 2026
 20:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
 <ajLi3nLqyS31Y6J4@google.com>
In-Reply-To: <ajLi3nLqyS31Y6J4@google.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 18 Jun 2026 11:38:52 +0800
X-Gm-Features: AVVi8CcgdoCv5inzD3awJAiF2PsHp7vdlxGgu4pq57dsMZoNd6hxUCzgTuyajF0
Message-ID: <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1wa3ay-0008M1-6t
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for
 cp_wait wakeup
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
Cc: geoo115@gmail.com, yangyongpeng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBUaGUgcmFjZSBpcyBiZXR3ZWVuIGRlY19wYWdlX2NvdW50KCkgYW5kIHRoZSBsYXRlciBnZXRf
cGFnZXMoKSBjaGVjazoKICBhbm90aGVyIENQLWRhdGEgd3JpdGViYWNrIGNhbiBiZSBzdWJtaXR0
ZWQgYWZ0ZXIgdGhlIGNvdW50ZXIgcmVhY2hlcyB6ZXJvCiAgYnV0IGJlZm9yZSBnZXRfcGFnZXMo
KSBvYnNlcnZlcyBpdCwgc28gdGhlIHplcm8gdHJhbnNpdGlvbiBtYXkgbWlzcyB0aGUKICBjcF93
YWl0IHdha2V1cC4KCiAgdjYgYWxzbyBhZGRzIGRlY19wYWdlX2NvdW50X3JldHVybigpIGFuZCB1
c2VzIGl0IGluc3RlYWQgb2YgYWNjZXNzaW5nCiAgbnJfcGFnZXMgZGlyZWN0bHkuICBUaGUgd2Fr
ZXVwIGxvZ2ljIGlzIHVuY2hhbmdlZCBmcm9tIHY1LgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtZjJmcy1kZXZlbC8yMDI2MDYxODAzMTAwOC4yNDQ3Mjc5LTEtcWl3ZW5qaWVAeGlhb21p
LmNvbS9ULyN1CgpPbiBUaHUsIEp1biAxOCwgMjAyNiBhdCAyOjA54oCvQU0gSmFlZ2V1ayBLaW0g
PGphZWdldWtAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiAwNi8xNiwgV2VuamllIFFpIHdyb3Rl
Ogo+ID4gZjJmc193cml0ZV9lbmRfaW8oKSBkZWNyZW1lbnRzIHRoZSB3cml0ZWJhY2sgcGFnZSBj
b3VudGVyIGFuZCB0aGVuCj4gPiByZWFkcyBpdCBhZ2FpbiB3aXRoIGdldF9wYWdlcygpIHRvIGRl
Y2lkZSB3aGV0aGVyIHRoZSBsYXN0Cj4gPiBGMkZTX1dCX0NQX0RBVEEgY29tcGxldGlvbiBzaG91
bGQgd2FrZSBjcF93YWl0Lgo+ID4KPiA+IFVzZSBhdG9taWNfZGVjX3JldHVybigpIGZvciBGMkZT
X1dCX0NQX0RBVEEgY29tcGxldGlvbnMgc28gdGhlIHdha2V1cAo+ID4gZGVjaXNpb24gaXMgbWFk
ZSBmcm9tIHRoZSB2YWx1ZSBwcm9kdWNlZCBieSB0aGUgZGVjcmVtZW50IGl0c2VsZi4gS2VlcAo+
ID4gdGhlIGV4aXN0aW5nIGRlY19wYWdlX2NvdW50KCkgcGF0aCBmb3Igb3RoZXIgd3JpdGViYWNr
IGNvdW50ZXJzLgo+Cj4gSXMgdGhlcmUgYSByYWNlIGNvbmRpdGlvbiB0byBkbyB0aGlzPyBJZiBz
bywgY2FuIHlvdSBkZXNjcmliZT8gQW5kLCBJIHRoaW5rCj4gd2UgbmVlZCBhIHdyYXBwZXIgZnVu
Y3Rpb24gaW5zdGVhZCBvZiBjYWxsaW5nIG5yX3BhZ2VzIGRpcmVjdGx5Lgo+Cj4gPgo+ID4gRml4
ZXM6IGUyMzQwODg3NThmYyAoImYyZnM6IGF2b2lkIHdhaXQgaWYgSU8gZW5kIHVwIHdoZW4gZG9f
Y2hlY2twb2ludCBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlIikKPiA+IEZpeGVzOiBjZTI3MzllNDgy
YmMgKCJmMmZzOiBmaXggdG8gYXZvaWQgVUFGIGluIGYyZnNfd3JpdGVfZW5kX2lvKCkiKQo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8
cWl3ZW5qaWVAeGlhb21pLmNvbT4KPiA+IC0tLQo+ID4gIGZzL2YyZnMvZGF0YS5jIHwgMTIgKysr
KysrKy0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEu
Ywo+ID4gaW5kZXggZDgzYTIxOTk4ZWMyLi41OGQyM2ViNzRlYzIgMTAwNjQ0Cj4gPiAtLS0gYS9m
cy9mMmZzL2RhdGEuYwo+ID4gKysrIGIvZnMvZjJmcy9kYXRhLmMKPiA+IEBAIC0zOTIsMTUgKzM5
MiwxNyBAQCBzdGF0aWMgdm9pZCBmMmZzX3dyaXRlX2VuZF9pbyhzdHJ1Y3QgYmlvICpiaW8pCj4g
PiAgICAgICAgICAgICAgIGlmIChmMmZzX2luX3dhcm1fbm9kZV9saXN0KGZvbGlvKSkKPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBmMmZzX2RlbF9mc3luY19ub2RlX2VudHJ5KHNiaSwgZm9saW8p
Owo+ID4KPiA+IC0gICAgICAgICAgICAgZGVjX3BhZ2VfY291bnQoc2JpLCB0eXBlKTsKPiA+IC0K
PiA+ICAgICAgICAgICAgICAgLyoKPiA+ICAgICAgICAgICAgICAgICogd2Ugc2hvdWxkIGFjY2Vz
cyBzYmkgYmVmb3JlIGZvbGlvX2VuZF93cml0ZWJhY2soKSB0bwo+ID4gICAgICAgICAgICAgICAg
KiBhdm9pZCByYWNpbmcgdy8ga2lsbF9mMmZzX3N1cGVyKCkKPiA+ICAgICAgICAgICAgICAgICov
Cj4gPiAtICAgICAgICAgICAgIGlmICh0eXBlID09IEYyRlNfV0JfQ1BfREFUQSAmJiAhZ2V0X3Bh
Z2VzKHNiaSwgdHlwZSkgJiYKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdxX2hh
c19zbGVlcGVyKCZzYmktPmNwX3dhaXQpKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHdha2Vf
dXAoJnNiaS0+Y3Bfd2FpdCk7Cj4gPiArICAgICAgICAgICAgIGlmICh0eXBlID09IEYyRlNfV0Jf
Q1BfREFUQSkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghYXRvbWljX2RlY19yZXR1
cm4oJnNiaS0+bnJfcGFnZXNbdHlwZV0pICYmCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
IHdxX2hhc19zbGVlcGVyKCZzYmktPmNwX3dhaXQpKQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgd2FrZV91cCgmc2JpLT5jcF93YWl0KTsKPiA+ICsgICAgICAgICAgICAgfSBlbHNl
IHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBkZWNfcGFnZV9jb3VudChzYmksIHR5cGUpOwo+
ID4gKyAgICAgICAgICAgICB9Cj4gPgo+ID4gICAgICAgICAgICAgICBmb2xpb19jbGVhcl9mMmZz
X2djaW5nKGZvbGlvKTsKPiA+ICAgICAgICAgICAgICAgZm9saW9fZW5kX3dyaXRlYmFjayhmb2xp
byk7Cj4gPgo+ID4gYmFzZS1jb21taXQ6IGMwYjY1ZjYxMjljN2ZiYjUyNmU5MjFkZDYwMjYxNjUw
ZjFiMmJlZjkKPiA+IC0tCj4gPiAyLjQzLjAKPiA+Cj4gPgo+ID4KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdAo+ID4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiA+
IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
