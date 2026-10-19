Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D73CCF2D6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qta/2zMWhtz72+AEQmB8N1zSWHKJ6Qb/cvSd4RMjcdg=; b=FltFnO5kClUQ3Y60ROmfvV/zfS
	rPI+qK88hOrD2t5v5e0zIADPKVUG6qVAO8evh0OrBof6R68i7XVoYtKbKV1vaCEGX3KcZgc0P78AG
	BVwEP6hakPzk+I4fJBmCNZM/qXfrW5Sj7T71/XB8SgD/BalauMZ1vP6I5SsWruB4gJBQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xImR6-00022y-0D;
	Mon, 19 Oct 2026 12:25:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kaixuanli0131@gmail.com>) id 1xImR5-00022s-7V
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=izRbEgIyPWWKRcko0zVkagJHIxL5p1T5W1BrUUvaYlY=; b=W4Moego39JlpCO+eZqnxka4ucg
 DPz3CYlR2Fwsdnn722jKG6zg8E1qacRAgwcQr+D5ldc2iSNguaDrnm0flLjVvT8TywpGqFKihXgwe
 osHJxOg3zwrbLPaD5LjWQAHixE51MMZF6a0/ymy12G/sKBc8klNIQcECXKcDgTXE83Zk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=izRbEgIyPWWKRcko0zVkagJHIxL5p1T5W1BrUUvaYlY=; b=iKgAIAVuyUDhW5RLZhN6tvre43
 sR/5pslRGJe2GTTxeUzYkZ6G440aUiwLhhe9nFdQy7JxbHNBu9YtNjuSH8wwP9bmSIqUhwTKckwVl
 hXtEr4XB7Fuh/8JeY7Ctt+4FieR2e1CMxN/DPm2BKRkDVQkYVyko83JBY8sMHOTr4Pl8=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xImR1-0006bU-6S for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:25:48 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1665764f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 05:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792412741; cv=none;
 d=google.com; s=arc-20260327;
 b=sHS4T//qV8mneh9HXoDAu6wqmNHBdFfqqnmNv3NdY7h4r8uY3bJJvWG0mNx18csxua
 FIvcEQzHdX9ViQ7UouyB4qanVzc4PrNo06v5YS6AkU/ZKq27Kc0XS7jsG8vJmfOWgfg9
 UdKoBYOUQc94EXYyHXYJg5MyMQlckWxk62WcQXd7F8WtGm3lsALiEJpit7TDD7OxTF/a
 5vqAEdgPzUuP/isExYMUIMT5qA88oOuYgUCCiHbUez39XO1YEnQeoLILoL1vcni/NlHb
 x+S71IssE5TkFC9IucTwmlSfe/WrlEKss7wleI7ER4uZuiiRclfNM4JxAGF7gUg9dkU8
 vGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=izRbEgIyPWWKRcko0zVkagJHIxL5p1T5W1BrUUvaYlY=;
 fh=Bk5dCxNVc17aigniA+OjRuVX1fUQbMDebjHtPDzbA+E=;
 b=YyEPsckKc9qGbL16CbUYbO00/fg/G5xjT73oHqums20FfKDXFSe6Grn5sCzwhvRacL
 R+FYPhf0MDyF+If2U1VcZcYAyNidhbwgAMYdd3IwkKNi1qv9E62LhUcRUoo5kEU/8G+M
 WWbp8Kcj2noQKD7ALGfL8xFtz6J41Yy2OKe89rTcd2XTErx5OB0cb4SRufGs7i41776p
 TsU/kRK5yyV/mb0HeFP4TXIgsXempSZ5a5hMe7RR51wEAxR2KKK4qUCW1RmJ6XN/L3os
 VjfflySZSngvRSGNTtiKyvlR3pqpoa9WW1wzKP0rInnCbDIxSqhcq2mWNrrGLswWeB5Q
 usuA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792412741; x=1793017541; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=izRbEgIyPWWKRcko0zVkagJHIxL5p1T5W1BrUUvaYlY=;
 b=VPDrPdcIey3b6XFDHEM6/cp9hyVYZYdMhAZzWAZOoe9613t8pCXpZBQEaPRrFlulvQ
 4Dj/ifo7E2OG8QLegxRsgMuPRWay+6sCjdS3eVaFRLpPPoWxiX7WJ2WMR8VXCLEmQIMT
 Mw9JA84z8DGENb+TYo97xlLZKN9u+AkjGQwxPT0mDqbktVvx6D2a9T18FXjAU3xOc327
 6dsTmJUtaGO+LtZHumHYj41oN9NTmHZ+g6CkT+u8iNa2KXZM0mnMLVkyAbFE3ZNP1tII
 EYyJQ+88FfpJPDTdiluObw9UccnguUE/rv0n9LomvreiMPwkPbKV67yLVB7mWjLcdKB8
 zRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792412741; x=1793017541;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=izRbEgIyPWWKRcko0zVkagJHIxL5p1T5W1BrUUvaYlY=;
 b=Jm7CbaWecF16ofPQu7idV5ZX2+4ALS8TuT4c0RajXejUNj5HCSystUSNq5XBS8md5l
 uSsuJ9fDivZLOym6hqRI2P6T9AWI+1TSdYYmzIjLmPVB2j7rq40zBI9zW097hPs/MS/c
 ZQaZUyN16PKXRiQkMXYFQmp15gLhNfZJybtMejGbASyrOCHLP4C1XNhmj5Z7lK93CCnl
 LFS2d4JWtn5EjIibQkzvRCiewZPr3GGmvnCMTxqNOhm5iUj1CdaOBERm1aWpHA0C29zT
 qcdbDbfdVF3gLGtHwQfKI6qDDDTO7JhHM0jDRRGmtljxH2gcsy/dvC8X8shGh5xMYt3U
 N8rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz08nGdORZ2cxpxG16OpqGQluIzjeaWozJTURbxhPOKMUtAxElo/HmlbIdYKY2JBhRLsuEjElafSA2kD45TFVys@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK3fXIcFBdD3b+V/9mCkBqBuKUdS11O+VpkQXcQYCxCoN+Q/Bq5
 lITbJ+4J71NYOVa8JglHW3aiJJ8iCbxXPmf4EvGgKhBSBQXUUFK/zQmRPoQMSfBBBYbVcY21jEh
 eaETtiFDd47Us1iUr7eiyxzzqwCbJ3Lo=
X-Gm-Gg: AYBFou3c6qOX0vi7C/pfPd5Aw7XDh2hFnWfTlyKuzm21Ce4jUqJYfuWMkSE43BzYfr9
 s+gMWitQVx4en43eKQ0xDve5gA2tgf2YlXwikcPAjiIj2lmVNOOdPfn+9bELsjlo6ID0umWZaUz
 kuvAToT8vvyu2Rly33aSDek9rDKPJlt0wznInv6zGHxNObmf58OcPaVap7j36zjRIBByXKDTX1I
 XKwnACQbWhYmmNps7jhuMhswHkMmyBF70ptRMk08i24O5UKaYnu5h1wMaQlfIurx7uYG1uweluO
 x+mjGvX8QaLfdoY8SdJUa/d4yZtZOE/EUwkjIbzQnPxg/GlCiF2CySw=
X-Received: by 2002:a05:6000:4006:b0:48e:314:f9f2 with SMTP id
 ffacd0b85a97d-48e0797597bmr14581593f8f.8.1792412740313; Mon, 19 Oct 2026
 05:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
 <9efd2ca3-ae57-428c-97c7-bc2300ba9a42@kernel.org>
In-Reply-To: <9efd2ca3-ae57-428c-97c7-bc2300ba9a42@kernel.org>
From: Kaixuan Li <kaixuanli0131@gmail.com>
Date: Mon, 19 Oct 2026 20:25:29 +0800
X-Gm-Features: AclHuK-9jqQcebO3EVLU5aDDPix8kSEJVlaRit2v8EyHo0TC60WVCoivxD53614
Message-ID: <CAGVefVXTsrxW7BeGvvg2-VUUsP57LSmamZJxffKdrg--_yPfyQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xImR1-0006bU-6S
Subject: Re: [f2fs-dev] [PATCH] f2fs: bound the SIT/NAT bitmaps by the
 checkpoint pack
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMTAvMTQvMjYgMTQ6MTQsIENoYW8gWXUgd3JvdGU6Cj4gSXQgbG9va3MgdGhlIG92ZXJmbG93
IGlzc3VlIGV4aXN0cyBzaW5jZSB0aGUgYmVnaW5uaW5nLCB3L28gYzc3ZWM2MWNhMGE0LAo+IHtz
aXQsbmF0fV92ZXJfYml0bWFwX2J5dGVzaXplIHdhcyBub3QgY2hlY2tlZCBhdCBhbGwsIGM3N2Vj
NjFjYTBhNCBqdXN0Cj4gYWRkZWQgcGFydGlhbCBjaGVjaywgc28gaG93IGFib3V0Ogo+Cj4gRml4
ZXM6IDM5YTUzZTBjZTBkZiAoImYyZnM6IGFkZCBzdXBlcmJsb2NrIGFuZCBtYWpvciBpbi1tZW1v
cnkgc3RydWN0dXJlIikKPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcKCkFncmVlZCwgbm90aGluZyBi
b3VuZGVkIHRoZW0gYWdhaW5zdCB0aGUgYWxsb2NhdGlvbiBiZWZvcmUgYzc3ZWM2MWNhMGE0CmVp
dGhlci4gSSdsbCBzZW5kIHYyIHdpdGggdGhlIEZpeGVzIHRhZyBjaGFuZ2VkLCBDYyBzdGFibGUs
IGFuZCB5b3VyClJldmlld2VkLWJ5LiBUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpLYWl4dWFuCgoK
T24gV2VkLCBPY3QgMTQsIDIwMjYgYXQgMjoxNOKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA5LzE5LzI2IDIxOjA5LCBLYWl4dWFuIExpIHdyb3RlOgo+ID4gc2l0
X3Zlcl9iaXRtYXBfYnl0ZXNpemUgYW5kIG5hdF92ZXJfYml0bWFwX2J5dGVzaXplIGFyZSB1c2Vk
IGFzIG1lbWNweQo+ID4gbGVuZ3RocyBpbnRvIGFuZCBvdXQgb2Ygc2JpLT5ja3B0LCB3aGljaCBp
cyBzaXplZCBmcm9tIGNwX3BheWxvYWQgYWxvbmUsCj4gPiBhbmQgbm90aGluZyBjb21wYXJlcyBl
aXRoZXIgbGVuZ3RoIGFnYWluc3QgdGhhdCBhbGxvY2F0aW9uLgo+ID4KPiA+IHNhbml0eV9jaGVj
a19ja3B0KCkgaGFzIGNoZWNrZWQgdGhlc2UgdHdvIGZpZWxkcyBzaW5jZSBjNzdlYzYxY2EwYTQs
IHdoaWNoCj4gPiBhZGRlZCB0aGVtIGFmdGVyIGEgY3JhZnRlZCBpbWFnZSBvdmVycmFuIGJ1aWxk
X3NpdF9pbmZvKCkuIFRoYXQgY2hlY2sgdGllcwo+ID4gZWFjaCBsZW5ndGggdG8gYSBzZWdtZW50
IGNvdW50OyBpdCBuZXZlciBjb21wYXJlcyBlaXRoZXIgYWdhaW5zdCB0aGUKPiA+IGFsbG9jYXRp
b24sIHdoaWNoIGlzIHRoZSBoYWxmIHRoaXMgYWRkcy4KPiA+Cj4gPiBNb3VudGluZyBvdmVyLXJl
YWRzIGluIGJ1aWxkX3NpdF9pbmZvKCkgYW5kIGJ1aWxkX25vZGVfbWFuYWdlcigpLCBhbmQgdGhl
Cj4gPiBmaXJzdCBjaGVja3BvaW50IHdyaXRlcyB0aGUgc2FtZSBsZW5ndGhzIGJhY2sgdGhyb3Vn
aCB0aGUgc2FtZSBwb2ludGVycywKPiA+IHNvIHRoZSBvdmVyLXJlYWQncyBjb250ZW50cyByZWFj
aCB0aGUgb24tZGlzayBjaGVja3BvaW50LiBBbiB1bm1vdW50IGlzCj4gPiBlbm91Z2g7IHRoZSBm
aWxlc3lzdGVtIGRvZXMgbm90IGhhdmUgdG8gYmUgdXNlZC4KPiA+Cj4gPiBCb3VuZCBib3RoIGVu
ZHMgdGhlIHdheSBfX2JpdG1hcF9wdHIoKSBsYXlzIHRoZW0gb3V0LiBUaGUgdGhyZWUgYnJhbmNo
ZXMKPiA+IGRpZmZlciwgc28gYSBzaW5nbGUgc3VtIG9mIHRoZSB0d28gbGVuZ3RocyB3b3VsZCBz
dGlsbCBhZG1pdCBhIHNtYWxsCj4gPiBvdmVyZmxvdyB3aGVuIGNwX3BheWxvYWQgaXMgbm9uLXpl
cm8uCj4gPgo+ID4gRml4ZXM6IGM3N2VjNjFjYTBhNCAoImYyZnM6IGZpeCB0byBkbyBzYW5pdHkg
Y2hlY2sgd2l0aCB7c2l0LG5hdH1fdmVyX2JpdG1hcF9ieXRlc2l6ZSIpCj4KPiBJdCBsb29rcyB0
aGUgb3ZlcmZsb3cgaXNzdWUgZXhpc3RzIHNpbmNlIHRoZSBiZWdpbm5pbmcsIHcvbyBjNzdlYzYx
Y2EwYTQsCj4ge3NpdCxuYXR9X3Zlcl9iaXRtYXBfYnl0ZXNpemUgd2FzIG5vdCBjaGVja2VkIGF0
IGFsbCwgYzc3ZWM2MWNhMGE0IGp1c3QKPiBhZGRlZCBwYXJ0aWFsIGNoZWNrLCBzbyBob3cgYWJv
dXQ6Cj4KPiBGaXhlczogMzlhNTNlMGNlMGRmICgiZjJmczogYWRkIHN1cGVyYmxvY2sgYW5kIG1h
am9yIGluLW1lbW9yeSBzdHJ1Y3R1cmUiKQo+IENjOiBzdGFibGVAa2VybmVsLm9yZwo+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBLYWl4dWFuIExpIDxrYWl4dWFubGkwMTMxQGdtYWlsLmNvbT4KPiBPdGhl
cndpc2UsIGl0IGxvb2tzIGdvb2QgdG8gbWUuCj4KPiBSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hh
b0BrZXJuZWwub3JnPgo+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
