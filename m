Return-Path: <SRS0=iBya=AU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE2C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:08:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12ABD20739;
	Thu,  9 Jul 2020 01:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="clgKge9l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bJM9rU62";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUDCIKGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12ABD20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jtL2y-00088v-B3; Thu, 09 Jul 2020 01:08:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1jtL2w-00088k-Gl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Jul 2020 01:08:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9p8A15AqAW3/4x69j3zHQIbmUxWZ5XRdsvYgz8fpSzg=; b=clgKge9lQaXpk65x5JzSYvPFlM
 RzHPGX4iijnvaue4OLZmhkao5ypqjLRcDYWL62+uANeAnoZBN/h2wu8RK00cZfi2+EAy4xzLZbYJq
 sVFmnuatOwAUxErKpGcQ97tGa/MT0B3wsb48UySBKwaPXuJSCTCqvzrWUwWJ/tJlZ3pg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9p8A15AqAW3/4x69j3zHQIbmUxWZ5XRdsvYgz8fpSzg=; b=bJM9rU62WwvoVuBGlrw5H0yKcX
 rKC0vJLgxHmo1tJAGmKwGq2ZehFGuy0qMt1f6Xi77QS9ITmMUV1dm7JIjX3dsAfdsbN+7vYKeihOK
 /Uh9amioKzektBNCQLm+fmEKF7fK6VQJbYR8HJVGnVwL8mbiRxaYBuFzdEOxllktIhU4=;
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jtL2v-00EefK-0O
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Jul 2020 01:08:18 +0000
Received: by mail-lj1-f194.google.com with SMTP id e4so434871ljn.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2020 18:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9p8A15AqAW3/4x69j3zHQIbmUxWZ5XRdsvYgz8fpSzg=;
 b=dUDCIKGyVGWqhjw5zNvQy07diR89AtZJdj1roS3qHcCVKZ/NL61/ygPihQnA5u8FWp
 tr3Dh5Ry/EkrnbBfDiYMWQAQeJOWkgbZleGn5xGKQQ1sXwMahvkmQIxdyXIdNoZs13Yb
 LqYX88bOuQi58aH98ZrSCi6L2kAyLqvTx1uZk2tAQo/w6Xvjts2UJu8kLld0QenduLS3
 7jt7E5ygqRxZPSn3SQwqvIv862ba1GbqFAmo4WfIxQngVaYCzGXQyxxAWlNZES7Iqv3O
 B96vxCyXGaB9MjTSevPXNJl+ijP1N+oAuGg0cezmj7k4mpGznUD3xqavDvkZev8J8rNQ
 AwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9p8A15AqAW3/4x69j3zHQIbmUxWZ5XRdsvYgz8fpSzg=;
 b=OQNsG5eXLe5FZJY7scuIBebwdMF9hJU5Zr+UF0CHWCe6hGdXpxdfUPinNEI3BQ+c0V
 TLq8baZ0Pv0B+C/Wkk0lGCt+WXNog2y7l6ZZpEhk+rXY6gZYML3IHg9hatppR4C14+0Z
 lBlhbFS7uRiPVbD7SdBsz+tK/fAXzypYUI6mn1ZENcyTvYfqTK35ovFkZvokV2CjziIW
 zeocaGBia0VtF9+s4QXqmzdHeIyndaOfaQSyZVSOYj7tY7e/tlv7o9f4ld1THcMp2VSz
 6qVTr2gjZUqt3v1+lbMYmxy8LN1Hm4FawbegiBdspSC5CaN+ZnSOBZX2crlmQtLq09Rv
 shtg==
X-Gm-Message-State: AOAM532d11/dGhpTtjiZyi5j1Xnl0x199TLB2eCERiUY4BtW6X+CT7xR
 cEEQYaJy/FufznZlGGoV2eqwL/Gcmla9ortl3E4=
X-Google-Smtp-Source: ABdhPJy26n9tOY2lSGWcseACx3qTHNw3D1259rQFhSnb/5ICl4BFpXDAaJGLWWqV735TrNAgrG2jwha97ufK1F1gJIA=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr33489279ljk.262.1594256890278; 
 Wed, 08 Jul 2020 18:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200703065420.3544269-1-daeho43@gmail.com>
 <20200703141359.GA2953162@kroah.com>
 <CACOAw_yweR--34vBXBV07xEGxGhO2r9o_XYVw6h9dMP=C6zp5Q@mail.gmail.com>
 <20200708100527.GA448589@kroah.com>
In-Reply-To: <20200708100527.GA448589@kroah.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 9 Jul 2020 10:07:59 +0900
Message-ID: <CACOAw_zKK7oD+w2R-0OQGFvS5EUvWWTmyWvdTJZAqrLxHH1w5Q@mail.gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
X-Headers-End: 1jtL2v-00EefK-0O
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add symbolic link to kobject in
 sysfs
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

SSB0aG91Z2h0IGl0J3Mgd29ya2luZyBmb3Igb3VyIHN5c3RlbS4gQnV0IGFzIHlvdSBzYWlkLCBp
dCBtaWdodCBiZQpub3QgdHJ1ZSBmb3Igb3RoZXJzLiBJIGdvdCB5b3VyIHBvaW50LiBQYXJ0aXRp
b24gbGFiZWwgd291bGQgYmUgYQpncmVhdCBpZGVhIGZvciB1cy4KClRoYW5rIHlvdSBmb3IgeW91
ciBjb21tZW50IQoKMjAyMOuFhCA37JuUIDjsnbwgKOyImCkg7Jik7ZuEIDc6MDUsIEdyZWcgS0gg
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPuuLmOydtCDsnpHshLE6Cj4KPiBPbiBNb24sIEp1
bCAwNiwgMjAyMCBhdCAwODo0NzowN0FNICswOTAwLCBEYWVobyBKZW9uZyB3cm90ZToKPiA+ID4g
Tm8gRG9jdW1lbnRhdGlvbi9BQkkvIGVudHJ5IGZvciB5b3VyIG5ldyBzeXNmcyBmaWxlL2xpbms/
Cj4gPgo+ID4gVGhpcyBpcyBmb3IgYWRkaW5nIGEgc3ltYm9saWMgbGluayB0byBhIHByZS1leGlz
dGVkCj4gPiAvc3lzL2ZzL2YyZnMvPGRpc2s+IGRpcmVjdG9yeSBhbmQgaXQgbWVhbnMgL3N5cy9m
cy9mMmZzLzxtb3VudD4gcG9pbnRzCj4gPiB0byAvc3lzL2ZzL2YyZnMvPGRpc2s+LiBJIGFscmVh
ZHkgYWRkZWQgdGhlIGRlc2NyaXB0aW9uIG9mIHRoaXMgaW4KPiA+IERvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvZjJmcy5yc3QuCj4KPiBPaywgYnV0IHRoYXQncyBub3QgdGhlIHN0YW5kYXJkIGxv
Y2F0aW9uIGZvciBzeXNmcyBmaWxlIGRvY3VtZW50YXRpb24uCj4KPiA+ID4gQW5kIHdoYXQgZG9l
cyB0aGlzIGhlbHAgd2l0aD8KPiA+Cj4gPiBTb21lIHN5c3RlbSBkYWVtb25zIGluIEFuZHJvaWQg
YWNjZXNzIHdpdGggdGhlIHByZS1kZWZpbmVkIHN5c2ZzIGVudHJ5Cj4gPiBuYW1lIGluIHRoZSBq
c29uIGZpbGUuIFNvIHdoZW5ldmVyIHRoZSBwcm9qZWN0IGNoYW5nZXMgYW5kIHRoZQo+ID4gcGFy
dGl0aW9uIGxheW91dCBpcyBjaGFuZ2VkLCB3ZSBoYXZlIHRvIGZvbGxvdyB1cCB0aGUgY2hhbmdl
cyBhbmQKPiA+IG1vZGlmeSAvc3lzL2ZzL2YyZnMvPGRpc2s+IG5hbWUgaW4gdGhlIGpzb24gZmls
ZSBhY2NvcmRpbmdseS4KPgo+IFRoYXQncyB3aGF0IHBhcnRpdGlvbiBuYW1lcyBhcmUgZm9yLCB5
b3Ugc2hvdWxkIG5ldmVyIGRlcGVuZCBvbiBhCj4gInJhbmRvbSBudW1iZXIiLgo+Cj4gPiBUaGlz
IHdpbGwgaGVscCB0aGVtIGFjY2VzcyBhbGwgdGhlIGYyZnMgc3lzZnMgZW50cmllcyBjb25zaXN0
ZW50bHkKPiA+IHdpdGhvdXQgcmVxdWlyaW5nIHRvIGtub3cgdGhvc2UgY2hhbmdlcy4KPgo+IE5v
LCBwbGVhc2UgdXNlIGEgcGFydGl0aW9uIG5hbWUsIHRoYXQgaXMgdGhlIG9ubHkgd2F5IHRvIGFs
d2F5cyBrbm93IHlvdQo+IGFyZSBtb3VudGluZyB0aGUgY29ycmVjdCBwYXJ0aXRpb24uICBZb3Ug
aGF2ZSBjcmVhdGVkIGEgcmFuZG9tIG51bWJlcgo+IGhlcmUgdGhhdCBtaWdodCwgb3IgbWlnaHQg
bm90LCBjaGFuZ2UgYmV0d2VlbiBib290cyBkZXBlbmRpbmcgb24gdGhlCj4gb3JkZXIgb2YgdGhl
IGZpbGVzeXN0ZW0gYmVpbmcgbW91bnRlZC4gIEl0IGlzIG5vdCBwZXJzaXN0YW50IG9yCj4gZGV0
ZXJtaW5pc3RpYyBhdCBhbGwsIHBsZWFzZSBkbyBub3QgdHJlYXQgaXQgYXMgc3VjaC4KPgo+ID4g
PiBJZiBpdCdzIHJlYWxseSBuZWVkZWQsIHdoeSBkb24ndCB3ZSBkbyB0aGlzIGZvciBhbGwgZmls
ZXN5c3RlbSB0eXBlcz8KPiA+Cj4gPiBUaGlzIGlzIGZvciB0aGUgZGFlbW9uIHRvIGNoYW5nZSB0
aGUgbW9kZSBvZiBvbmx5IEYyRlMgd2l0aCB0aGUgcG93ZXIKPiA+IGhpbnQgb2YgQW5kcm9pZC4K
Pgo+IEFnYWluLCB0aGUgcG9pbnQgaXMgdGhhdCBhIGZpbGVzeXN0ZW0gdHlwZSBpcyBub3QgdW5p
cXVlLCB0aGlzLCBpZgo+IHJlYWxseSByZWFsbHkgbmVlZGVkLCBzaG91bGQgYmUgYW4gYXR0cmli
dXRlIGZvciBBTEwgZmlsZXN5c3RlbSB0eXBlcywKPiBmMmZzIGlzIG5vdCBzcGVjaWFsIGhlcmUg
YXQgYWxsLgo+Cj4gUGxlYXNlIGRvIG5vdCByZWx5IG9uIHRoaXMgbnVtYmVyIGV2ZXIgYmVpbmcg
dGhlIHNhbWUgYWNyb3NzIGJvb3RzLAo+IGJlY2F1c2UgeW91ciBjb2RlIGlzIHN1Y2ggdGhhdCB5
b3UgY2FuIG5vdCBndWFyYW50ZWUgdGhhdC4KPgo+IEFuZCBhZ2FpbiwgaWYgeW91IHJlYWxseSB3
YW50IHRvIGtub3cgdGhlIHBhcnRpdGlvbiB5b3UgYXJlIG1vdW50aW5nCj4gcmVhbGx5IGlzIHRo
ZSBwYXJ0aXRpb24geW91IHRoaW5rIHlvdSBhcmUgbW91bnRpbmcsIHVzZSB0aGUgcGFydGl0aW9u
Cj4gbGFiZWwgbmFtZSwgdGhhdCBpcyB3aGF0IGl0IGlzIHRoZXJlIGZvciwgYW5kIGlzIHdoeSB3
ZSBoYXZlIGJlZW4KPiByZWx5aW5nIG9uIHRoYXQgZm9yIGRlY2FkZXMuICBBIG5ldyBzcGVjaWFs
IHBlci1maWxlc3lzdGVtLWF0dHJpYnV0ZQo+IHRoYXQgaXMgc2VtaS1yYW5kb20gaXMgbm90IHRo
ZSBjb3JyZWN0IHNvbHV0aW9uIGZvciB0aGUgcHJvYmxlbSB5b3UgYXJlCj4gZGVzY3JpYmluZyBh
cyBmYXIgYXMgSSBjYW4gZGV0ZXJtaW5lLgo+Cj4gdGhhbmtzLAo+Cj4gZ3JlZyBrLWgKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRl
dmVsCg==
