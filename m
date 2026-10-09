Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED11CCA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7TjkihlYAUaVcd4VEvR+A1wqQNqOFYIrXJtItYB3Mc=; b=QL0BJSIkePtqBzwlD8JAF7GS22
	Q7tgc0Em4VVeDi/AzZPYfh8dOmJwwQojzG2siaA6ez0ka2CJyKQ3b7zgp1+eJgGctgvcc7ypY94nf
	N6eLX0xtNS+xASTt2oTpZOHHmpQ798WAC8Ugv2169LjwXs1TZ6b5Z2ixDjZ6N5bRkRk8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFCDz-0003kM-CR;
	Fri, 09 Oct 2026 15:09:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xFCDy-0003kF-6e
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A/HDEM6SAMd1TqfEczfv3U/biPTo6BFTefjmZrIo9H4=; b=hJJobMwqY+ZrfUU/bk3n72IGFm
 L7Va4wHD7z51ClLZt+4ybM284Z97aouHonKdBm2K7BtYWfWsmn/QEsIL6iEr1PUCJ9kaAWhaVPudp
 JVq5R36DIu7AtfLFN+EV/vtfq1Hxq/Glof2Xd89SFh/U1ft9YRU4JGd/wtm6upgEERp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A/HDEM6SAMd1TqfEczfv3U/biPTo6BFTefjmZrIo9H4=; b=EShQDhWRO7j9u5ASfwpGtkAanC
 yepHZtMbvUn7rnKFrOyzWpFFow7wwpayvcMz/30nqV3vI/mIuO5ZPfAVcZux+in4m09EIciHyJC7W
 gMe8B7sUS2U/DeOv8xl73VdgxNx216kQWHF9bcZXl1fSkNRRj+BErfhmJAz1bb4W+Cmc=;
Received: from mail-lf1-f49.google.com ([209.85.167.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFCDv-00027v-6G for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:09:27 +0000
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5bcb3726952so2265367e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 08:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791558560; cv=none;
 d=google.com; s=arc-20260327;
 b=f3t3+46PSEDZoZZ4GfzpSeJ/1SpLkBPUMmRymLChfgcHwG21yBofMEf9QDFWH8aseu
 F9AhlJ4gC4dCEMfw8/S8exzTtQIZ07jTN4KmY31RyvaxiWgpaxu7RkVeRSoXlojUWV78
 eaRX4eHv5cpz+MEy0JIps70TRi1XvGWBfk6sB8v2s+W91bQncD2q4KrS1lCC0LKYACs6
 L26dnfJxkSyYaTZQV23xfDnET8Iyl+g+J+Q8nU0Itcno1R/NR5+aI0AdCFr0tpqzZbB2
 YfZlW3LvYDRzJqfWKhNM8XsGRoU6P61RgwBo94MLeK+DSG+D9wRjCwjLfBjvQO01BstF
 I4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A/HDEM6SAMd1TqfEczfv3U/biPTo6BFTefjmZrIo9H4=;
 fh=4HmcKAm+19yRyam0eyM+Q9YXOL2DMSaweEY/n4m3XuU=;
 b=envEFb6baekinIH4yvh6DfmwWDa5j52jbdN+hoOo6gs4SgugQgQZWBbFsVkZ4iM/vn
 CFWiH97z3neux65zXvNsK5s8pBvI4ZaZsJ3dZNEqDdHqs2G3UxHPx92+4htPIjVZ62ao
 whUS8bfepgn7a6SiSGgEHZTnM3GBPoKMjXZbeIdam976FDPjdDpClvcIgarEGde3oxti
 IjIcIQlh4mKx/XsyNnFUA151c+PZTxyhg8d0Nnm87hLZO8McPZts0bxIGDjfw36s7gSX
 qum9Oiw3gBFvxBYk/xhoPDEMV7rSpRU7cgICfqHMoN9Ay8FmDGKopENM4b0/LIN+OMhx
 TTNg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791558560; x=1792163360; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A/HDEM6SAMd1TqfEczfv3U/biPTo6BFTefjmZrIo9H4=;
 b=Dl/3635QZKh7GLXS7ZSX9EJrWBmjJ78V5qldJuoO0hLhkF5XsLmxhGn8BOUpt9RQnu
 vSmldGUHJXQ5TPmWYl95/sFHjAXPhzj1NlGjhBZ0SU6wZV1DBDw+f7U/FjntxZ4GKsPF
 z1PhS4qyPCaOerFOvgaySXT8woYS+XOdB9xKhrQe3kJP2tsfyLzU/Vj+t0pW0GFZRBKG
 /1dYJQzSGfDfsHEdU+ECwU60ekqkL9oLRg/XIROkboSOINzK+8imBiyjjouYhNSBu4lB
 YDsgmH61LWnQXv9a9mDdw7PbSdpRUuq4bzyhjvih6+CQdXGMxBM3AjuX+a/QYGfNy3o0
 prnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791558560; x=1792163360;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A/HDEM6SAMd1TqfEczfv3U/biPTo6BFTefjmZrIo9H4=;
 b=InrbYQN2reVC9AHL0dewZX5pMpwShERTtfKWILHT7cbyX6gTyI0XQaGpkPzSGIV+RP
 JV7raGLvdWlekDcL/9l1oucRwIqlB631Sl8KYd3Yq0M130JTpE6RIqeq10zpqr3kJxQD
 ZcpaKORq+KJa2TbsDlxCPX+O7huu1k9is//G5DIzxDadiy9W52qtFdX04/hzJ1shQs4E
 p3loMGCaSyxXVEGxAbK2ux4/RwvHHjib29EXvI7RB5GKoSCUmtgholoprUtVxsmofp1R
 cGvHwORQq69Al6cqPN6P8RG5+EI3bYKosDqMWRTr5Ii6lE1VRM6Nf0rJ+gRHCGbEvkbC
 fFpA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBTJNDtW+PXsZkZAlHY0Z4JY1DV3fKlpM3wTc6w9ail/UaqoPG87BZkA277T1geTaWcZXuorfr9hgMWVeEiKev@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKuSGf0Uv5oDM+2WHD7AGFn5NKt7MoxaWJuKDge7FTZ6AYahvmn
 xXj2NZKHGHd6yWMIBvZD8joz5wgKbNpOgmwUf4M9m7d9RSvnHUfrGF2vTqfo7S0nCawcHbxdA9L
 sIRDSHTQQ5gfyZHyEGHem5VuXZUccBirI3A==
X-Gm-Gg: AYBFou0mhLBJxIzPFMjwm4uQwNAJTtgBvB9MPoXsgUYr6pooAI9FIWt2aHmp8ARx4Vp
 481B6sju40ioU6lfUY/NYBy0qTepzShrpZwDvcDQwWmGS7TWyvrozvoeH0pNUqY1rJoJKd8KAe0
 nT3HiUwgEN4B5C2Ue7FdHEej4gMWhxkUO76cRB0SuNIgRxe86xOXtCo/imqO1XHAmMnLcuIhEiL
 +S9O1MiRQZchKgfvFgevisLLMEUtK0QI4nfYiANHoIFqF82o77LisShNuK6gMjP7Bc819fu4/HT
 Krxolf0yT6RX5+hpWun+VOBM8QNleuCH4QomFzF6gNNiLZdg+RCVgaj9A06MjQQLFQ4F/4D6bLW
 hKgs2jq3p1dl3atnWAeCXacGqqxDNA/9LsM2+hYrOe4s=
X-Received: by 2002:a05:6512:a83:b0:5bb:42a2:31fa with SMTP id
 2adb3069b0e04-5bcde8d79ecmr856633e87.60.1791558560095; Fri, 09 Oct 2026
 08:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261007223608.2158904-1-daeho43@gmail.com>
 <411bd479-f3ba-48cd-9b96-ec017c685b1c@kernel.org>
In-Reply-To: <411bd479-f3ba-48cd-9b96-ec017c685b1c@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 9 Oct 2026 08:09:07 -0700
X-Gm-Features: AclHuK-b0iOAUVp3Gb3M3uy87PAKMjg-PM45YloYZBWvj1PWu9YXwALNhrlHGRc
Message-ID: <CACOAw_x0ahtE3bdD0TG3FjzbkFzyQYTah-trPVrkmH62AGCAqg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xFCDv-00027v-6G
Subject: Re: [f2fs-dev] [PATCH] f2fs: write the directory inode in fsync
 before checkpoint
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBPY3QgOSwgMjAyNiBhdCAyOjAz4oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
PiB3cm90ZToKPgo+IE9uIDEwLzgvMjYgMDY6MzYsIERhZWhvIEplb25nIHdyb3RlOgo+ID4gRnJv
bTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBmc3luYygpIG9u
IGEgZGlyZWN0b3J5IGlzIGRvbmUgYnkgYSBjaGVja3BvaW50LCBidXQgdGhlIGNoZWNrcG9pbnQK
PiA+IGRvZXMgbm90IHdyaXRlIHRpbWVzdGFtcC1vbmx5IGlub2RlIHVwZGF0ZXMuIFNpbmNlIGNv
bW1pdCA3YzQ1NzI5YTRkNmQKPiA+ICgiZjJmczoga2VlcCBkaXJ0eSBpbm9kZXMgc2VsZWN0aXZl
bHkgZm9yIGNoZWNrcG9pbnQiKSwgc3VjaCB1cGRhdGVzCj4gPiBhcmUgbWFya2VkIHdpdGggc3lu
Yz1mYWxzZSBhbmQgbGVmdCB0byBpbm9kZSB3cml0ZWJhY2sgb24gcHVycG9zZS4KPiA+Cj4gPiBm
c3luYygpIG9uIGEgcmVndWxhciBmaWxlIGNhbGxzIGYyZnNfd3JpdGVfaW5vZGUoKSBmaXJzdCB3
aGVuIHRoZQo+ID4gaW5vZGUgaXMgZGlydHksIGJ1dCBmc3luYygpIG9uIGEgZGlyZWN0b3J5IGdv
ZXMgdG8gdGhlIGNoZWNrcG9pbnQKPiA+IGRpcmVjdGx5IGFuZCBtaXNzZXMgaXQuIFNvIGlmIHRo
ZSBsYXN0IGNoYW5nZSB0byBhIGRpcmVjdG9yeSBvbmx5Cj4gPiB1cGRhdGVkIGl0cyB0aW1lc3Rh
bXBzLCBlLmcuIHVubGlua2luZyBhIGZpbGUgaW4gaXQsIHRoZSBuZXcgbXRpbWUgaXMKPiA+IGxv
c3QgYWZ0ZXIgYSBzdWRkZW4gcG93ZXIgb2ZmIGV2ZW4gdGhvdWdoIGZzeW5jKCkgcmV0dXJuZWQu
IGdlbmVyaWMvNTQ3Cj4gPiBmYWlscyBzb21ldGltZXMgYmVjYXVzZSBvZiB0aGlzLgo+Cj4gSGFz
IDllYzA5ZDVmNGIzMSAoImYyZnM6IGRpcnR5IGRpcmVjdG9yeSBpbm9kZXMgb24gbXRpbWUvY3Rp
bWUgdXBkYXRlIikgZml4ZWQKPiB0aGlzIGlzc3VlPwo+Cj4gVGhhbmtzLAoKT2gsIHllcywgaXQg
ZG9lcy4gSSBtaXNzZWQgdGhhdCBjb21taXQgc2luY2UgSSB0ZXN0ZWQgb24gYSB0cmVlCndpdGhv
dXQgaXQuIFBsZWFzZSBkcm9wIHRoaXMgcGF0Y2guCgpUaGFua3MsCgpUaGFua3MsCgo+Cj4gPgo+
ID4gQ2FsbCBmMmZzX3dyaXRlX2lub2RlKCkgZm9yIGEgZGlyZWN0b3J5IGJlZm9yZSB0aGUgY2hl
Y2twb2ludCwgYXMgdGhlCj4gPiByZWd1bGFyIGZpbGUgcGF0aCBkb2VzLiBUaGUgaW5vZGUgYmxv
Y2sgYmVjb21lcyBkaXJ0eSBhbmQgaXMgd3JpdHRlbiBieQo+ID4gdGhlIHNhbWUgY2hlY2twb2lu
dCwgc28gbm8gZXh0cmEgY2hlY2twb2ludCBvciBmbHVzaCBpcyBhZGRlZC4KPiA+IFRpbWVzdGFt
cC1vbmx5IHVwZGF0ZXMgd2l0aG91dCBmc3luYygpIGFyZSBzdGlsbCBub3Qgd3JpdHRlbiBieSB0
aGUKPiA+IGNoZWNrcG9pbnQuCj4gPgo+ID4gRml4ZXM6IDdjNDU3MjlhNGQ2ZCAoImYyZnM6IGtl
ZXAgZGlydHkgaW5vZGVzIHNlbGVjdGl2ZWx5IGZvciBjaGVja3BvaW50IikKPiA+IFNpZ25lZC1v
ZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPiAtLS0KPiA+ICBm
cy9mMmZzL2ZpbGUuYyB8IDkgKysrKysrKystCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2ZpbGUu
YyBiL2ZzL2YyZnMvZmlsZS5jCj4gPiBpbmRleCA1NmM2ODZiODU4MC4uYjAxMmNjMjIzMDcgMTAw
NjQ0Cj4gPiAtLS0gYS9mcy9mMmZzL2ZpbGUuYwo+ID4gKysrIGIvZnMvZjJmcy9maWxlLmMKPiA+
IEBAIC0zNTEsOCArMzUxLDE1IEBAIHN0YXRpYyBpbnQgZjJmc19kb19zeW5jX2ZpbGUoc3RydWN0
IGZpbGUgKmZpbGUsIGxvZmZfdCBzdGFydCwgbG9mZl90IGVuZCwKPiA+Cj4gPiAgICAgICB0cmFj
ZV9mMmZzX3N5bmNfZmlsZV9lbnRlcihpbm9kZSk7Cj4gPgo+ID4gLSAgICAgaWYgKFNfSVNESVIo
aW5vZGUtPmlfbW9kZSkpCj4gPiArICAgICBpZiAoU19JU0RJUihpbm9kZS0+aV9tb2RlKSkgewo+
ID4gKyAgICAgICAgICAgICAvKgo+ID4gKyAgICAgICAgICAgICAgKiBDaGVja3BvaW50IHdyaXRl
cyBvbmx5IHRoZSBpbm9kZXMgb24gdGhlIGRpcnR5IG1ldGEgbGlzdC4KPiA+ICsgICAgICAgICAg
ICAgICogVGltZXN0YW1wIHVwZGF0ZXMgb2YgYSBkaXJlY3RvcnksIGUuZy4gYnkgdW5saW5raW5n
IGEgZmlsZQo+ID4gKyAgICAgICAgICAgICAgKiBpbiBpdCwgZG8gbm90IHB1dCBpdCBvbiB0aGUg
bGlzdCwgc28gd3JpdGUgaXQgaGVyZS4KPiA+ICsgICAgICAgICAgICAgICovCj4gPiArICAgICAg
ICAgICAgIGYyZnNfd3JpdGVfaW5vZGUoaW5vZGUsIE5VTEwpOwo+ID4gICAgICAgICAgICAgICBn
b3RvIGdvX3dyaXRlOwo+ID4gKyAgICAgfQo+ID4KPiA+ICAgICAgIC8qIGlmIGZkYXRhc3luYyBp
cyB0cmlnZ2VyZWQsIGxldCdzIGRvIGluLXBsYWNlLXVwZGF0ZSAqLwo+ID4gICAgICAgaWYgKGRh
dGFzeW5jIHx8IGdldF9kaXJ0eV9wYWdlcyhpbm9kZSkgPD0gU01fSShzYmkpLT5taW5fZnN5bmNf
YmxvY2tzKQo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbGludXgtZjJmcy1kZXZlbAo=
