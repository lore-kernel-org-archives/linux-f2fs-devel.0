Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A485C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sc77wTB5XYtyLps5gBaxpD8rJ6Q6ShDQ17hUVjLjTc=; b=mXs/q3seyo4jTvJdnKk1OPtR+7
	It+EZ+N8wTEaFWzLwyhEIdaZaFZV+19FGShq45YZhBKUUeoXaPLMiu/O4ns+zrZpmqrWvbprCILcE
	wFThs2qMHj30PB+PkWpBQXgmkQl/zxL1uAS/WuN/7By/xkA2WcOPqu61Jt0Vr84tyQaE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4OrN-0005MK-OB;
	Wed, 09 Sep 2026 20:25:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4OrM-0005ME-UY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 20:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=POC2lH7mwvKdL69yA96ciVwerPravqqkSKDADdthXkA=; b=nTfHpvbsecQWe/VFvxlYcqCg9e
 tOEsnj78b647IcPU0Dgsdu9Kuv7248ywryI24DxQHD3it/V2/p3ahZBTc0mcOOqZw7Ikq4RWhK1QM
 frO8RGqcRABJ47/ZdGbAjPjdvQAJUYeTxMJNr9fRp5OelfeQ8YOrdimLNR98beE+bo2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=POC2lH7mwvKdL69yA96ciVwerPravqqkSKDADdthXkA=; b=jPf/+TbnIhBiSdnTpkXuNtYg7g
 HaNXbG+mpPO9zi1nG0HYmAKyPjFcy5JCPOCqKpTOfhgXWROs5rhttzP5yZB9ezXwhnBe/XKWx4m25
 8jEH9n3Tsmezzef07O20JMtCB/6Cv0PZRXuiHsBf7hY24ddn0LxdMT4ApF7KT2XiFY7Y=;
Received: from mail-lf2-f12.google.com ([74.125.229.204])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4OrM-0006jC-9r for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 20:25:33 +0000
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b76668f4ddso492344e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 13:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788985525; cv=none;
 d=google.com; s=arc-20260327;
 b=IsEVKP/3fPRQpYmqrCSlVbDDiq5CUCamA5u3kcSnKedLb99m95E1mgxQQTtBm5bSE4
 DL18Vhion/TNQumARbMrsOM8d9qZsAQdhb2mAKHVnMP5jzCNPxZzgWs5VWCFmT/iFSBW
 DbMCXzVyLst8EUprji6OiaXIKPcdWaWxoBFI2vXSW7UO4REadjEy52MQ0CvioGmWua2/
 PHIzd0pbo+PIhcffu+vDGnUQr9m+Cy/J2ZwojcseNKpHIhSmF04eetGXBfhTzucFkqX6
 3oqQ2/1aD6NQkabNOt3J2y9t2LTeKmnuzQpil9/IkKsynB9p44ds489SKErMAg4Z8Ji9
 8nMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=POC2lH7mwvKdL69yA96ciVwerPravqqkSKDADdthXkA=;
 fh=+M/uK38pvpbeJdbqaxaR6Gnoym550ur/jRj04h6RBLI=;
 b=qVqj4CGaJGl8271SWzIBi9WmVt0bBRue07K07wONH0sVbH2IM+Dy0BER1IL+d4kfQp
 yyvkARiaVie5ps150p/dGUoTbRn+cJFlNGJO3ZG7SVvG6FG25mayIs6hvtPVrhlowBwZ
 bl8V9vIZRG/EKIuAbpHR2A73wGrQjQnq60rYOLA5hn63QRkZ08l1nVu2B9mYCfbctQkU
 qFb7+Xadskbz+6RJKqEKW6f1UV3ntwD83tC8E0B4bU5GEJuBpdklo5lkS08joh2QrkSB
 t0vO5HmAkcDmPN/PNEJjD6AHe/gB+UquNMJqdeJHX94XvSA5PS+dEN1JxIEDWejG0qM9
 j7yQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788985525; x=1789590325; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=POC2lH7mwvKdL69yA96ciVwerPravqqkSKDADdthXkA=;
 b=PqwukzdINNiR480MjzJLlIy35G21e+S6qZLG01/++Jd6tU+LOGcLkMmpEVp29PfFVb
 W5qTXyeaPv28ylxP3fRmTs4OeoCw+Otvz42W/lNvlrDENZBZ5Vx0D65VAoHgv8TyRnpG
 00CPRDKdr9vq03GochiqtOHR+6nRindemm2zC6ZUtKQbBFgI7ioDd1JJAqhJYKI66jTg
 70r9T2OAdi2LiasvYN+TBJ06P0lxW25kbrr52ZlMu+ZLlqPFgtYjPC3v4fAjoIJhmQio
 sWS2ij0XCcbgpaiD5kIzUCcpyhKwCX4/pyT6JdkMZJ0IC1BxoaANrplFjMPF2sqBUgYf
 YURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788985525; x=1789590325;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=POC2lH7mwvKdL69yA96ciVwerPravqqkSKDADdthXkA=;
 b=etIHPmidINvs3M6n8slmwQyvd44wnbAJKSLYxtimk+oUptYen0QIXXNjJfEJPR3vkE
 9ujvbQwfpXPS/0y4/5f2VRSH9pqUitChFZNKIUEOjnCdKNkP5CRmLhRtFbzf9aI9Gazq
 VCsupHCN3iNFM7+tPQahnNiriaya82f+OSGd4V9DyqolR4jXRg14wuSxL3vzUHscwhNN
 tWmYwJ5Foujfkyf3TTq/Li94rntdnl9d5fs4TCTpHlmS77OWO0Ju5cXx7kX8/5c2G9zZ
 axaMs2pVQ8ads32s0Ojb+xN/t1Q6G4/jOuJhwKYA511l6Uc9IQLfl92xylcT1AbUh+So
 yICw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK5qIq+Md5Z/wWqGa/5AeYWcqewr5K1JMaikCUBZq+N90OMf9sBOfHXb/yso9U4G0Qv8EbkLZI7wx1M27ga+Aq@lists.sourceforge.net
X-Gm-Message-State: AFuF++luU9/15OifGigWpMT+yCI9KvvdDkNs9nPjxgWIhYVSg0p1mOj7
 6J3hFJJkdGv8TuA1nDHKY4BKsAMbMUy7aBIPqnsC3lpyvpFSqfpBq/W05P+1JAnECEcI0eLOc+z
 RsBBm/adJtknv+u98oY/obz8kCmjJNJM=
X-Gm-Gg: AYBFou16Wih3EK9X05aN02Itq7a3UFPyoKpGx1KemRrVefcnx8CgeWiMruFkFiLvp2X
 jfqHp9CeUbQNLOtROXHXMnjomEwl7uchfIrXFs/ibMqTAM1gRvVmsUlHxB0oamIgcAgSjuVpVXV
 2oXCBHtzzIpUEpJjQ48lyGk4IKQFgYtGi5rj6n81odBDUV2HDnyRxzMqMqck2TMoXgJ6MVRJ07Y
 gVQccmf2IkQBvURu49keD/83vw/wcqJAkNi1GRfQygX7heg1Pj2W6wS/aa9qt9JIQuBlOlS0oDY
 gYKwuaSdzQ9dca51K+Fnt7uOzCQ8Foq3Whs9FbQxi0POEG9LPGA89Eu4blrSGg132eGIuOWorUC
 3McOJ2cc9QtkETIRRV7FIBgVt94Sv/yRLU1HRWt3Zd2m3
X-Received: by 2002:a05:6512:10cd:b0:5b7:6665:1028 with SMTP id
 2adb3069b0e04-5b89a2fba43mr201759e87.9.1788985525096; Wed, 09 Sep 2026
 13:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
 <20260907093123.2438228-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20260907093123.2438228-1-zhaonanzhe@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 13:25:12 -0700
X-Gm-Features: AcwNN1VitG_oQQkQ0jIqPnt52-lFjuNztNXCTLV1XOP3wKHIcvDioop2798A5cU
Message-ID: <CACOAw_yDKmuxroZRV492UDdLd0ewengiXiM=w6DzekY81f4r+A@mail.gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Headers-End: 1x4OrM-0006jC-9r
Subject: Re: [f2fs-dev] [PATCH 01/14] f2fs: extend folio state for large
 folio write path
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBTZXAgNywgMjAyNiBhdCAyOjMx4oCvQU0gTmFuemhlIFpoYW8gPG56emhhby5zaWdt
YUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCAyNyBBdWcgMjAyNiAxMzo1MTowNiAtMDcw
MCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiArICAgICAgICAgICAgIGZmcy0+cHJpdmF0ZV9mbGFn
cyB8PSBmbGFnczsKPiA+Cj4gPiBJcyB0aGlzIGZpZWxkIHByb3RlY3RlZCBieSBob2xkaW5nIGEg
bG9jayBwcm9wZXJseT8KPgo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4KPiBObywgaXQgZG9lc24n
dC4gVGhhbmtzIGZvciBwb2ludGluZyBvdXQuCj4KPiBJIHdhbnQgdG8gY2hhbmdlIHRoaXMgdXNp
bmcgcGVyLWZpZWxkIGF0b21pYyByZWFkLW1vZGlmeS13cml0ZSBvcHMKPiBpbnN0ZWFkLCB0byBh
dm9pZCB0YWtpbmcgc3RhdGVfbG9jaywgbGlrZSBiZWxvdzoKPgo+IGRpZmYgLS1naXQgYS9mcy9m
MmZzL2YyZnMuaCBiL2ZzL2YyZnMvZjJmcy5oCj4gQEAgZjJmc19mb2xpb19nZXRfcHJpdmF0ZV9m
bGFncygpICAoZjJmcy5oOjI3MTkpCj4gICAgICAgICBpZiAoZjJmc19mb2xpb19oYXNfZmZzKGZv
bGlvKSkgewo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZjJmc19mb2xpb19zdGF0ZSAqZmZzID0g
Zm9saW8tPnByaXZhdGU7Cj4KPiAtICAgICAgICAgICAgICAgcmV0dXJuIGZmcy0+cHJpdmF0ZV9m
bGFnczsKPiArICAgICAgICAgICAgICAgcmV0dXJuIFJFQURfT05DRShmZnMtPnByaXZhdGVfZmxh
Z3MpOwo+ICAgICAgICAgfQo+IEBAIGYyZnNfZm9saW9fc2V0X3ByaXZhdGVfZmxhZ3MoKSAgKGYy
ZnMuaDoyNzMwKQo+ICAgICAgICAgaWYgKGYyZnNfZm9saW9faGFzX2Zmcyhmb2xpbykpIHsKPiAg
ICAgICAgICAgICAgICAgc3RydWN0IGYyZnNfZm9saW9fc3RhdGUgKmZmcyA9IGZvbGlvLT5wcml2
YXRlOwo+Cj4gLSAgICAgICAgICAgICAgIGZmcy0+cHJpdmF0ZV9mbGFncyB8PSBmbGFnczsKPiAr
ICAgICAgICAgICAgICAgaWYgKGZsYWdzKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIF9fYXRv
bWljX29yX2ZldGNoKCZmZnMtPnByaXZhdGVfZmxhZ3MsIGZsYWdzLAo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fQVRPTUlDX1JFTEFYRUQpOwo+ICAgICAgICAg
ICAgICAgICByZXR1cm47Cj4gICAgICAgICB9Cj4gQEAgZjJmc19mb2xpb19jbGVhcl9wcml2YXRl
X2ZsYWdzKCkgIChmMmZzLmg6Mjc0NikKPiAgICAgICAgIGlmIChmMmZzX2ZvbGlvX2hhc19mZnMo
Zm9saW8pKSB7Cj4gICAgICAgICAgICAgICAgIHN0cnVjdCBmMmZzX2ZvbGlvX3N0YXRlICpmZnMg
PSBmb2xpby0+cHJpdmF0ZTsKPgo+IC0gICAgICAgICAgICAgICBmZnMtPnByaXZhdGVfZmxhZ3Mg
Jj0gfmZsYWdzOwo+ICsgICAgICAgICAgICAgICBpZiAoZmxhZ3MpCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgX19hdG9taWNfYW5kX2ZldGNoKCZmZnMtPnByaXZhdGVfZmxhZ3MsIH5mbGFncywK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19BVE9NSUNfUkVM
QVhFRCk7Cj4gICAgICAgICAgICAgICAgIHJldHVybjsKPiAgICAgICAgIH0KPgo+IFBsZWFzZSBs
ZXQgbWUga25vdyBpZiB0aGlzIGxvY2stZnJlZSBhcHByb2FjaCBsb29rcyBhY2NlcHRhYmxlLgo+
CgpQbGVhc2UgZG8gbm90IHVzZSBjb21waWxlciBidWlsdC1pbnMuClBsdXMsIHBseiwgY29uc2lk
ZXIgcmFjZSBjb25kaXRpb24gb2YgdGhlIGZpZWxkIHdpdGggdGhlIG5vbi1mZnMgcGF0aC4KClRo
YW5rcywKCj4gVGhhbmtzLAo+IE5hbnpoZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
