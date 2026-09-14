Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875A7C88E6A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jK0hHWZAZ+dNr+mid+uEgYWTtIOp/hejDp0IgRrnEcM=; b=Yncf13NwxfjFGZJM+JBWJd9Hvv
	Z6B3Agbw6Oe4BCzlZ04Sa6qCOzxhbFOcFW6dz7azj0v7i7f1BJ3u0f2OWL//+h+zINw7/1Kd2PHmq
	5kM9JZYiOA80TtiUquHD3vjpRZ6dsG30TIqZ/I4WaKoEFbX1IOqs4VIIz7hyxT0XeMlQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x62sS-0004hI-FI;
	Mon, 14 Sep 2026 09:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x62sR-0004h6-Cr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 09:21:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wwrq1AQ7AQhYuiO/PQ/FAIrBktVWNjfbFAJiCq17zCs=; b=ZRKdW2CEk8CXWfdoHSQidG6MfW
 zoC3zY9IByKwolkSrLPjXckPaULEGadihXrlvUHl7qwut23TIHP8P7o/0CLbuJoZiLT7yPhDi28IV
 SqWKkQNGDgpsGAKspwX8ZiAp1uXSRwZq1ZxaJnjJl7N7HTxdMTEhn/vIEf9vI5YQ8548=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wwrq1AQ7AQhYuiO/PQ/FAIrBktVWNjfbFAJiCq17zCs=; b=gVX9nAwiP/wJ72JL5Xk1IQ+dJJ
 v5IOIm5gOSoh2noBAJSPs/LnvP1py2lAVvEIdf6m1mMdUbe2bdb2Fk1HdXcbkGomuUPmOJkUaHjqb
 1lhCwJE3y8EBemiG17u5Tgrm2I4H+hFNL6uiGTiNVWNFsc1Afcy1VkiLXDF3q7KVjTso=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x62sR-0007dF-JP for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 09:21:28 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48435ae9ca4so238573f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 02:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377681; cv=none;
 d=google.com; s=arc-20260327;
 b=SU28K3Gl1hpRViAlB9m0MYwS19fMKESqwZjac0Bt83L3duuJlRhOtZxPC2W7UMKn1T
 r8hnRZnMvQCPQ33vjwNrir5hn660t/KHoJxPoavcZO2sjDbWXXf9iDNEbb+ZZyEHrdR8
 L8peOqU11UMcmtatHwISi8Tr/UUAnkhz+pAaPHD0GxSL4CamlpwmQi2LR62h3G6dnwk7
 adIHax1pX6qkVfvvUHCe9AL7DW+Sz0OVoAxCG+AuKaKba0QF+r9MrS1GAvrgw177CYYY
 i972goRwIEWT32SfuzK7m110Pk9dOshS/svVMjL/zt3gQXlB/DGOR+zE2GBS/jIjGag1
 SBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wwrq1AQ7AQhYuiO/PQ/FAIrBktVWNjfbFAJiCq17zCs=;
 fh=5dSvfhE3P8sV5vhQ5ip5xw9HSu/rlX4iNwfN4/R7Rt8=;
 b=nuff90OtyE1fQ/EUh9KZDqEwhYBgMtgBW3+LW/CffS3EDfdh8r3SagnFKIKceDFi5Y
 5Swv82X0w6eLB+iuAoAa8xHc+jwN/d+5gb0CmSU0PrZVKg6yjZ7yKllUT6qmjdQIxjeC
 0bGAH5O1nbJmo7et8YlnX4sVYerBS9sJLrvLGT4bU4r5ermGU/VEt4ecVhcR0FcQ1Fht
 yjlMSrHsS6nUzpZMtt9yleGYv2nfPGjstyq3+htEzlXcj9YJS0Uz3c/7nrRAE/P0SsFW
 r3KeKKW2uAq5EASvekSiLorhiaOCd04XVhx//2xi5iUDuoiFEgsuFzSL5enXzO69h/yg
 LQag==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789377681; x=1789982481; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wwrq1AQ7AQhYuiO/PQ/FAIrBktVWNjfbFAJiCq17zCs=;
 b=IwHOWA3CzP1LpqMJEmoR7eb3+kbzIeLJoVny1mbyTc83Yke9zhrCHjWa9ofMTKkkVm
 DNBWSqokrxB1AGogYDilxqyrWjuXj5O8MW43VkLl0vixIHdxXJGU7drKHdPQCIxTux7y
 idHMY4gzqYGDVMcV4BLXz0LX5FbMedUjWXKlfitPfof7n9l6LSNz+JIt9v83uUB6EBea
 6HkOm42vt7fzapWk0M1HsNTiiZTfw1IlCmbWgjbCS85NGoIIbj8TWn/J/QVNh7ua++eC
 I5e8qTGyTXkJNvZVBLeRukDNWP4xgRpC0cEvpkxC6qLoajPdXuZIV45OuBVaxfnLwDYa
 UwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377681; x=1789982481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wwrq1AQ7AQhYuiO/PQ/FAIrBktVWNjfbFAJiCq17zCs=;
 b=SiGev9+tO502NKTazglkSfemHxJgox2u6AyKSDho1KqE8BIoiWJNn79tt2ALRR0Waj
 hrwjH/MoGFq9GSJRF+bo2JaUwIDFxddGBaMTv4nc6TmLLlYf6h8oNWJ0vi98AZxOsHID
 f4lHm6yv4xk+aa4pVtyptCJaM8RLVdu+JNvr57av0LyQ+tSPYHG+nQmC+Y0cz1S1qyMq
 4kua3SnPVVeIR9D+cTgIoWcLTahe6HybAFK7jER027xETaKFGgGPdj2N8ck+jyvjXSCY
 Uom1oSgIVwn/djI7pek5NTBl3ZAyAouV0N4bD1Fereu7SJ90U0vLP7wBsTxNoA/B0xm3
 kGRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwC+CM1dv2KOsioNulL6CY9gH1ana3xkmebSsnbx644budPCKFUugOSRk6LF6yeDZrYZJif2WONJLGpnwYXqA5P@lists.sourceforge.net
X-Gm-Message-State: AFuF++nv8nuohA3PFrRKwg7C7IJGmvr2SF0FeqqwG6AiOxOwZW31JhUW
 /mcuqlujkNiBW6GySyPNpggZf1QsgTfq0umSEYcjZF/gMj+zMpYljPPRUF14ltKgLk5t4yvtWrI
 eV07QWrMn9uxG/FuD/mv93xuwVG498gsTuw==
X-Gm-Gg: AYBFou2CpFqO9IllDHetMmRSlj42L43SzxaBsK11vkYTKwZv4JHoUlIjPTwauQZM/D7
 JMy2uHIoa5jnyYoGEit4k6BD+IpDRaSouw0IyRshuBUi68Euvm7oGJxL6YGxmyylk7i4LXM87lm
 z4+CaYQ2M1kmnOWOMin/tY/n2IIWsU3NJapE8ucKQdsNAxSQtRxMn0vuDFMdNKTCZEGnonQUQJo
 /ut6IV1JW3+VN6ecEG6g2HcbZM8/VUFZ87urWG5f9fSL0wB9J81jjKwQTslmI+ktvJWHKTICXXG
 Ho+xSukybojW6j94ImSJWClq5bebdBxdVz+p9NnIOwF72CVGtHCIDqsl
X-Received: by 2002:a05:6000:41da:b0:486:f76c:dacc with SMTP id
 ffacd0b85a97d-48702b0cf11mr1814548f8f.4.1789377680703; Mon, 14 Sep 2026
 02:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260911232405.1815804-1-chao@kernel.org>
 <20260911232405.1815804-3-chao@kernel.org>
In-Reply-To: <20260911232405.1815804-3-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 14 Sep 2026 17:21:09 +0800
X-Gm-Features: AcwNN1Xdk7IOQx3K7FUj3F4rWrOzG0Dg5OIl5Rktm3njl4E0IRtFuD-3voufCK0
Message-ID: <CAHJ8P3JSW+y4PK+Zb6HvpnDgYt7uPko5kOVsbn3zRPefd5o98Q@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x62sR-0007dF-JP
Subject: Re: [f2fs-dev] [PATCH v7 02/12] f2fs: cache: initialize meta cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ55pyIMTLml6Xlkajlha0gMDc6MjjlhpnpgZPvvJoKPgo+
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IFRoaXMgcGF0Y2ggaW50cm9kdWNl
cyBtZXRhX2Jsb2NrcyBpbiBmMmZzX3NiX2luZm8gc3RydWN0dXJlLCBpbml0aWFsaXplcwo+IGFu
ZCBkZXN0cm95cyB0aGUgbWV0YSBjYWNoZSBkdXJpbmcgZmlsZXN5c3RlbSBtb3VudCBhbmQgdW5t
b3VudC4KPgo+IEl0IGFsc28gaW50cm9kdWNlcyBoZWxwZXIgd3JhcHBlcnMgZm9yIG1ldGEgY2Fj
aGUgb3BlcmF0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
Pgo+IC0tLQo+ICBmcy9mMmZzL2NhY2hlLmggfCAxMiArKysrKysrKysrKysKPiAgZnMvZjJmcy9k
YXRhLmMgIHwgIDMgKysrCj4gIGZzL2YyZnMvZjJmcy5oICB8ICAzICsrKwo+ICBmcy9mMmZzL3N1
cGVyLmMgfCAxMCArKysrKysrKystCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvY2FjaGUuaCBiL2ZzL2Yy
ZnMvY2FjaGUuaAo+IGluZGV4IDcyZGJmMjZhYjI2ZS4uZDVlZTUxNjkxZmFjIDEwMDY0NAo+IC0t
LSBhL2ZzL2YyZnMvY2FjaGUuaAo+ICsrKyBiL2ZzL2YyZnMvY2FjaGUuaAo+IEBAIC0xOTQsNCAr
MTk0LDE2IEBAIHZvaWQgZjJmc190cnVuY2F0ZV9jYWNoZShzdHJ1Y3QgZjJmc19jYWNoZWRfYmxv
Y2sgKmVudHJ5LCBib29sIGRyb3BfZGlydHkpOwo+ICB2b2lkIGYyZnNfZHJvcF9jYWNoZV9yYW5n
ZShzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2tfbGlzdCAqY2FjaGUsCj4gICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgbGVuLCBib29sIGRyb3BfZGlydHkp
Owo+Cj4gK2ludCBmMmZzX3N0YXJ0X2NhY2hlX3diX3RocmVhZChzdHJ1Y3QgZjJmc19zYl9pbmZv
ICpzYmkpOwo+ICt2b2lkIGYyZnNfc3RvcF9jYWNoZV93Yl90aHJlYWQoc3RydWN0IGYyZnNfc2Jf
aW5mbyAqc2JpKTsKPiArCj4gKyNkZWZpbmUgTUVUQV9DQUNIRShzYmkpICAgICAgICAgICAgICAg
ICgmKHNiaSktPm1ldGFfYmxvY2tzKQo+ICsKPiArI2RlZmluZSBmMmZzX2ZpbmRfbWV0YV9jYWNo
ZShzYmksIGJsa2FkZHIpICAgICAgICAgICAgIFwKPiArICAgICAgIGYyZnNfZmluZF9jYWNoZShN
RVRBX0NBQ0hFKHNiaSksIGJsa2FkZHIpCj4gKyNkZWZpbmUgZjJmc19pbnZhbGlkYXRlX21ldGFf
Y2FjaGVzKHNiaSwgc3RhcnQsIGxlbikgICBcCj4gKyAgICAgICBmMmZzX2Ryb3BfY2FjaGVfcmFu
Z2UoTUVUQV9DQUNIRShzYmkpLCBzdGFydCwgbGVuLCBmYWxzZSkKPiArI2RlZmluZSBmMmZzX3Ry
dW5jYXRlX21ldGFfY2FjaGVzKHNiaSwgc3RhcnQsIGxlbikgICAgIFwKPiArICAgICAgIGYyZnNf
ZHJvcF9jYWNoZV9yYW5nZShNRVRBX0NBQ0hFKHNiaSksIHN0YXJ0LCBsZW4sIHRydWUpCj4gKwo+
ICAjZW5kaWYgLyogX0xJTlVYX0YyRlNfQ0FDSEVfSCAqLwo+IGRpZmYgLS1naXQgYS9mcy9mMmZz
L2RhdGEuYyBiL2ZzL2YyZnMvZGF0YS5jCj4gaW5kZXggZDg2OGI5MzljYWVlLi41OWZlZjIxMzIx
NzcgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9kYXRhLmMKPiArKysgYi9mcy9mMmZzL2RhdGEuYwo+
IEBAIC02NzAsNiArNjcwLDkgQEAgc3RhdGljIGJvb2wgX19oYXNfbWVyZ2VkX3BhZ2Uoc3RydWN0
IGYyZnNfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QgYmlvICpiaW8sCj4gICAgICAgICBpZiAoIWlub2Rl
ICYmICFmb2xpbyAmJiAhaW5vKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKPgo+ICsg
ICAgICAgaWYgKGYyZnNfaXNfY2FjaGVfYmlvKGJpbykpCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBmYWxzZTsKPiArCj4gICAgICAgICBiaW9fZm9yX2VhY2hfZm9saW9fYWxsKGZpLCBiaW8pIHsK
PiAgICAgICAgICAgICAgICAgc3RydWN0IGZvbGlvICp0YXJnZXQgPSBmaS5mb2xpbzsKPgo+IGRp
ZmYgLS1naXQgYS9mcy9mMmZzL2YyZnMuaCBiL2ZzL2YyZnMvZjJmcy5oCj4gaW5kZXggYzBjN2Q1
MWM4MzBmLi44NWM0YmY0MGI0YWEgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9mMmZzLmgKPiArKysg
Yi9mcy9mMmZzL2YyZnMuaAo+IEBAIC0yMTA3LDYgKzIxMDcsOSBAQCBzdHJ1Y3QgZjJmc19zYl9p
bmZvIHsKPiAgI2lmZGVmIENPTkZJR19ERUJVR19MT0NLX0FMTE9DCj4gICAgICAgICBzdHJ1Y3Qg
bG9ja19jbGFzc19rZXkgY3BfZ2xvYmFsX3NlbV9rZXk7Cj4gICNlbmRpZgo+ICsKPiArICAgICAg
IC8qIGYyZnMgaW50ZXJuYWwgY2FjaGUgKi8KPiArICAgICAgIHN0cnVjdCBmMmZzX2NhY2hlZF9i
bG9ja19saXN0IG1ldGFfYmxvY2tzOwo+ICB9Owo+Cj4gIC8qIERlZmluaXRpb25zIHRvIGFjY2Vz
cyBmMmZzX3NiX2luZm8gKi8KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zdXBlci5jIGIvZnMvZjJm
cy9zdXBlci5jCj4gaW5kZXggNmEyZjA5YzYxZGNkLi5iNzMxYjliYjdiNTQgMTAwNjQ0Cj4gLS0t
IGEvZnMvZjJmcy9zdXBlci5jCj4gKysrIGIvZnMvZjJmcy9zdXBlci5jCj4gQEAgLTIwOTQsNiAr
MjA5NCw4IEBAIHN0YXRpYyB2b2lkIGYyZnNfcHV0X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IpCj4gICAgICAgICBpcHV0KHNiaS0+bWV0YV9pbm9kZSk7Cj4gICAgICAgICBzYmktPm1ldGFf
aW5vZGUgPSBOVUxMOwo+Cj4gKyAgICAgICBmMmZzX2Rlc3Ryb3lfY2FjaGUoTUVUQV9DQUNIRShz
YmkpKTsKPiArCj4gICAgICAgICAvKiBTaG91bGQgY2hlY2sgdGhlIHBhZ2UgY291bnRzIGFmdGVy
IGRyb3BwaW5nIGFsbCBub2RlL21ldGEgcGFnZXMgKi8KPiAgICAgICAgIGZvciAoaSA9IDA7IGkg
PCBOUl9DT1VOVF9UWVBFOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgaWYgKCFnZXRfcGFnZXMo
c2JpLCBpKSkKPiBAQCAtNTI2MywxMiArNTI2NSwxNiBAQCBzdGF0aWMgaW50IGYyZnNfZmlsbF9z
dXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMpCj4gICAg
ICAgICBpZiAoZXJyKQo+ICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfcGVyY3B1Owo+Cj4gKyAg
ICAgICBlcnIgPSBmMmZzX2luaXRfY2FjaGUoc2JpLCBNRVRBX0NBQ0hFKHNiaSksIEYyRlNfTUVU
QV9DQUNIRSk7Cm5ldmVyIGZhaWwgbm93Pwo+ICsgICAgICAgaWYgKGVycikKPiArICAgICAgICAg
ICAgICAgZ290byBmcmVlX3BhZ2VfYXJyYXlfY2FjaGU7Cj4gKwo+ICAgICAgICAgLyogZ2V0IGFu
IGlub2RlIGZvciBtZXRhIHNwYWNlICovCj4gICAgICAgICBzYmktPm1ldGFfaW5vZGUgPSBmMmZz
X2lnZXQoc2IsIEYyRlNfTUVUQV9JTk8oc2JpKSk7Cj4gICAgICAgICBpZiAoSVNfRVJSKHNiaS0+
bWV0YV9pbm9kZSkpIHsKPiAgICAgICAgICAgICAgICAgZjJmc19lcnIoc2JpLCAiRmFpbGVkIHRv
IHJlYWQgRjJGUyBtZXRhIGRhdGEgaW5vZGUiKTsKPiAgICAgICAgICAgICAgICAgZXJyID0gUFRS
X0VSUihzYmktPm1ldGFfaW5vZGUpOwo+IC0gICAgICAgICAgICAgICBnb3RvIGZyZWVfcGFnZV9h
cnJheV9jYWNoZTsKPiArICAgICAgICAgICAgICAgZ290byBmcmVlX21ldGFfY2FjaGU7Cj4gICAg
ICAgICB9Cj4KPiAgICAgICAgIGVyciA9IGYyZnNfZ2V0X3ZhbGlkX2NoZWNrcG9pbnQoc2JpKTsK
PiBAQCAtNTU5Niw2ICs1NjAyLDggQEAgc3RhdGljIGludCBmMmZzX2ZpbGxfc3VwZXIoc3RydWN0
IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQo+ICAgICAgICAgbWFrZV9i
YWRfaW5vZGUoc2JpLT5tZXRhX2lub2RlKTsKPiAgICAgICAgIGlwdXQoc2JpLT5tZXRhX2lub2Rl
KTsKPiAgICAgICAgIHNiaS0+bWV0YV9pbm9kZSA9IE5VTEw7Cj4gK2ZyZWVfbWV0YV9jYWNoZToK
PiArICAgICAgIGYyZnNfZGVzdHJveV9jYWNoZShNRVRBX0NBQ0hFKHNiaSkpOwo+ICBmcmVlX3Bh
Z2VfYXJyYXlfY2FjaGU6Cj4gICAgICAgICBmMmZzX2Rlc3Ryb3lfcGFnZV9hcnJheV9jYWNoZShz
YmkpOwo+ICBmcmVlX3BlcmNwdToKPiAtLQo+IDIuNDkuMAo+Cj4KPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1m
MmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCg==
