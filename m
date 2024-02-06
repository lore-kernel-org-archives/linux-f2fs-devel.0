Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B92C48286
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Feb 2024 05:58:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rXETV-0000FN-0V;
	Tue, 06 Feb 2024 05:58:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1rXETT-0000FG-Qg
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Feb 2024 05:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=37SRj3V5WCLVhgLQFuxLAmj/CKN5zZ9vlMu2l5q/YAA=; b=QtVG2Wl9FdHZ9RYvO7C68qWDdc
 Vo13Lym0UdbZ53U7LAtlp//DAIMrEuVOocNMcuzPe7wCe4Eaj30FIVf3qd5BIb8ozh+cQXnEbvDKI
 6uG1ZHBNwsqyMjyTtkQDJRV2z5uZw0cfiG6n759e+o0UzoQy/vaDS8sLRi+vZEPIZpGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=37SRj3V5WCLVhgLQFuxLAmj/CKN5zZ9vlMu2l5q/YAA=; b=j7pYIG8Qzk/gVFopEtK4a5KNtE
 RwSdjsD8CUt1rdhyMEAFgBAf41bWnl6Rp9uwH5XbEyjqJ8aTZpRngoyEbUu6GI+Qoca5X15gEFgSs
 wXLGPx+yJnDj18D8ns05t9Dh/WDYekQ4DvavzUVcZeAXGjDYEvIZgQ1lj7VL1ngqIdGI=;
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rXETS-0003Hu-HV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Feb 2024 05:58:27 +0000
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so399137a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Feb 2024 21:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707199096; x=1707803896; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37SRj3V5WCLVhgLQFuxLAmj/CKN5zZ9vlMu2l5q/YAA=;
 b=henIw+R+7yM2sKrDPL625aX/Zo5RNtXwRvLxg34dHG/zopEiKq62EsQu0rAIBK+afC
 uVR2uNn8CYdl2SOQejMl34dEGwq8XOmzy5y+uYQW46MXEW8asKfA3z9aSfbWfTeiYl0F
 UJN6lMEUNY1jyJUCPfqby/0Jx0D/2G6RoBubFbfgJRUMA1aa4jGzFZyMA6XnHmnQRbGu
 OwZTlwXx4lDD8E/U6h99fl3JNksgSpMwa81xrjCuEVPetXwva4Cwrl7D67TIH1lngri8
 MT6hYRAoiPYVvdnSnY59ZqK9+fsPJZDxuUd8XjOnC6kwBjY55QyxKaFIYjU1N5FCHeCX
 /4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707199096; x=1707803896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37SRj3V5WCLVhgLQFuxLAmj/CKN5zZ9vlMu2l5q/YAA=;
 b=X4VvCzk623zxpJQL6CmmwZaiJr9Uf03DlU31FzQz6N4XyuGoKhf50nL/LRvqFuZ4gN
 42A8kwyLk1Xg65yHNnvbRVAVOcXm5Ok1uNsEX82855spT5KwYvUX6UuXQEALrQjVrJ7T
 Vr+byUxa6iuQ4F680HnEFguYIdmRRKiEbB6kQ0qvJ6UkTZgV0craEy3aUMIZ/VJjXUxZ
 OyE6Bl4IoWRe4K4oGj0wogox/ysBQF58aviSXp/LAev3ttPXRowpQO8afDDGpGerbhCx
 YDYkd2lYk6zCQqOpyX6hr/pEaxoh/6QTGPW2GXP5RFz4N9ymaEX1MgaFtgqtv09mYI9t
 2hkg==
X-Gm-Message-State: AOJu0YwX6xfmULtc2I01yCtkPsvJpUtfxh5YiH0bG9A9MBQ4stXyAThk
 NaVLk/CeF0+J4jMTW2NO6yeu8UVmkakIAAssIrvoEZRtvfu7X/UuebgEdmTuXJmKcG6DV6E4l2c
 msUPZZkoYBTgz89qV743+z7BSw1M=
X-Google-Smtp-Source: AGHT+IGDo18AFJzHyBqAN82N1ANueKAASCsDKhpE72pjl7nhu5Q+7HX+a1/HlotJGde4S/sbGdFvgvLqzYWzDU6ufak=
X-Received: by 2002:a50:d59d:0:b0:55f:c4e9:60df with SMTP id
 v29-20020a50d59d000000b0055fc4e960dfmr7804341edi.20.1707199095565; Mon, 05
 Feb 2024 21:58:15 -0800 (PST)
MIME-Version: 1.0
References: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com>
 <ZcGkZslfFLP8wqUr@google.com>
In-Reply-To: <ZcGkZslfFLP8wqUr@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 6 Feb 2024 13:58:04 +0800
Message-ID: <CAHJ8P3KVJvNfPhUa07j87irmbjgV8nsuCby2oASTM=QHboWc2A@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1rXETS-0003Hu-HV
Subject: Re: [f2fs-dev] [PATCH 0/3] f2fs: fix panic issue in small capacity
 device
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCBGZWIgNiwgMjAyNCBhdCAxMToxNeKAr0FNIEphZWdldWsgS2ltIDxqYWVnZXVrQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gMDEvMjksIFpoaWd1byBOaXUgd3JvdGU6Cj4gPiBBIHBh
bmljIGlzc3VlIGhhcHBlbmVkIGluIGEgcmVib290IHRlc3QgaW4gc21hbGwgY2FwYWNpdHkgZGV2
aWNlCj4gPiBhcyBmb2xsb3dpbmc6Cj4gPiAxLlRoZSBkZXZpY2Ugc2l6ZSBpcyA2NE1CLCBhbmQg
bWFpbiBhcmVhIGhhcyAyNCBzZWdtZW50cywgYW5kCj4gPiBDT05GSUdfRjJGU19DSEVDS19GUyBp
cyBub3QgZW5hYmxlZC4KPiA+IDIuVGhlcmUgaXMgbm8gYW55IGZyZWUgc2VnbWVudHMgbGVmdCBz
aG93biBpbiBmcmVlX3NlZ21hcF9pbmZvLAo+ID4gdGhlbiBhbm90aGVyIHdyaXRlIHJlcXVlc3Qg
Y2F1c2UgZ2V0X25ld19zZWdtZW50IGdldCBhIG91dC1vZi1ib3VuZAo+ID4gc2VnbWVudCB3aXRo
IHNlZ25vIDI0Lgo+ID4gMy5wYW5pYyBoYXBwZW4gaW4gdXBkYXRlX3NpdF9lbnRyeSBiZWNhdXNl
IGFjY2VzcyBpbnZhbGlkIGJpdG1hcAo+ID4gcG9pbnRlci4KPgo+IFRoZSBnb2FsIGhlcmUgaXMg
dG8gc3RvcCBmMmZzIHdoZW4gaXQgaGl0cyBubyBzcGFjZSB0byB3cml0ZSBhbnltb3JlPwpEbyBu
b3QgbGV0IHRoZSBzeXN0ZW0gY3Jhc2ggbm93ICwgYW5kIGFkZCBzb21lIHNhbml0eSBjaGVjayB0
byBhdm9pZAphY2Nlc3NpbmcgIGlsbGVnYWwgbWVtb3J5Cj4gQW5kLCB3ZSBuZWVkIGYyZnNfc3Rv
cF9jaGVja3BvaW50KCkgYXQgdGhlIGVuZD8KSSB0aGluayBpdCBuZWVkIGluZGVlZC4KdGhhbmtz
IQo+Cj4gPgo+ID4gTW9yZSBkZXRhaWwgc2hvd24gaW4gZm9sbG93aW5nIHRocmVlIHBhdGNoZXMu
Cj4gPiBUaGUgdGhyZWUgcGF0Y2hlcyBhcmUgc3BsaXRlZCBoZXJlIGJlY2F1c2UgdGhlIG1vZGlm
aWNhdGlvbnMgYXJlCj4gPiByZWxhdGl2ZWx5IGluZGVwZW5kZW50IGFuZCBtb3JlIHJlYWRhYmxl
Lgo+ID4KPiA+IFpoaWd1byBOaXUgKDMpOgo+ID4gICBmMmZzOiBjb3JyZWN0IGNvdW50aW5nIG1l
dGhvZHMgb2YgZnJlZV9zZWdtZW50cyBpbiBfX3NldF9pbnVzZQo+ID4gICBmMmZzOiBmaXggcGFu
aWMgaXNzdWUgaW4gdXBkYXRlX3NpdF9lbnRyeQo+ID4gICBmMmZzOiBlbmhhbmNlIGp1ZGdtZW50
IGNvbmRpdGlvbnMgb2YgR0VUX1NFR05PCj4gPgo+ID4gIGZzL2YyZnMvZmlsZS5jICAgIHwgNyAr
KysrKystCj4gPiAgZnMvZjJmcy9zZWdtZW50LmMgfCA5ICsrKysrKy0tLQo+ID4gIGZzL2YyZnMv
c2VnbWVudC5oIHwgNyArKysrLS0tCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQo+ID4KPiA+IC0tCj4gPiAxLjkuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
