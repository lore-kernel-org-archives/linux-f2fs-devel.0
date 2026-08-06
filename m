Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83918C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1KWk32i7KFc/A7Fj9YR77ehKkLbdlZE3OxNzvNDSOo=; b=bj+z1l6smrdv439VaOlkLQ8RNO
	b54ayPg/w5cpnDocvwlIe8lkZfj/LQPbnjM63b776lJJbBsV0ryXOxLpI+lfU7PSjIunHV2Mt+Wzv
	Dn8DT+HcP4c7g6WahdwJhIHgKj+xzdtaIMl11NATC9uiYfLtt5L2IyFY/a3wtVMiR4ok=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wro4c-00050a-H6;
	Thu, 06 Aug 2026 02:43:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wro4a-00050U-PD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VvF43tSz7wwDuasCawSQVfqt2rfdFjc4yUPz7UYUWkI=; b=HFuGzjVzHh+WKxruaKvUtZ9tgE
 ToYjXW+uCheB58Gu1lrLjJ9soLCYwwpnMNfhe1zOpvFgfhMpxhc/PaNfvJVlJyQKreWJZzeLh7c5W
 FMdsp0TStSLK4GwGUX2PXualFPMUlgY7sIOQJLpPOwsMz/WpbTcCCxg2BLyJ9LIUrOzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VvF43tSz7wwDuasCawSQVfqt2rfdFjc4yUPz7UYUWkI=; b=JepdjyfACr4LVHKDolR4QuSUU7
 6gmLv3d30Qr2uF/8CnS6VSjm5C8/+Vw7yogfOC53zoFCxjDZUm0Cpph2ufEmB4TblJdRC9dSXyfNY
 tEmOgchz5tC6jRQmlZeRpjRXGKOdgok7qXcVQLnoOA/iiEycDLxbKZDZ8iGiTb5nJcpw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wro4b-0002hK-DG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:43:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83AE641AFC;
 Thu,  6 Aug 2026 02:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401F01F000E9;
 Thu,  6 Aug 2026 02:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785984180;
 bh=VvF43tSz7wwDuasCawSQVfqt2rfdFjc4yUPz7UYUWkI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=D+tuhEgF1O9MbzUEk5YSkzwGdiPaUu+EMqNUbOO3/MLXIzwtS+OR55sFExFv+UUeC
 9I7ZNDVeWnSXDTH7MlP40Jnmnel2cszcUvX5VX1V/ZjyjxWu45N4wDr0vWYnSaiZsN
 MZ3/qy7+uI6NUhyhI1KxovaHhRBWn/UfHphfCcbQP67RzRGJb9ELjNQvMINCHxEJZO
 +Wm2FLAM/XBPsrGdE42XPuWClihHLUHlKbJHYe0aj4JR6GlFzqFZSyF7ioOPIosctm
 1Brv0ogt9xHw7zgQe/6mCJWnNIohcfTfpbM/uKRCp+8xvaqWrPI2egPIROn5dlFQEo
 qUPTrHqRQwcTA==
Message-ID: <246b5851-2cca-4ea8-b050-3cf9e5c76917@kernel.org>
Date: Thu, 6 Aug 2026 10:42:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260730154618.2166947-1-daeho43@gmail.com>
 <8b643643-17d5-4c80-9548-c8dc461c9d2d@kernel.org>
 <CACOAw_ynod+nrwrqfoqLK4NOPvVTHoG+3z5FFcF-YByJ7uUEzw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_ynod+nrwrqfoqLK4NOPvVTHoG+3z5FFcF-YByJ7uUEzw@mail.gmail.com>
X-Headers-End: 1wro4b-0002hK-DG
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: support dynamic reserve/release for
 device aliasing
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC82LzI2IDAwOjQzLCBEYWVobyBKZW9uZyB3cm90ZToKPiBPbiBUdWUsIEF1ZyA0LCAyMDI2
IGF0IDY6MjDigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBPbiA3
LzMwLzI2IDIzOjQ2LCBEYWVobyBKZW9uZyB3cm90ZToKPj4+IEZyb206IERhZWhvIEplb25nIDxk
YWVob2plb25nQGdvb2dsZS5jb20+Cj4+Pgo+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgZHluYW1pYyBt
YW5hZ2VtZW50IGZlYXR1cmUgdG8gdGhlIGV4aXN0aW5nIGRldmljZQo+Pj4gYWxpYXNpbmcgZnVu
Y3Rpb25hbGl0eS4gSXQgYWxsb3dzIHVzZXJzIHRvIGR5bmFtaWNhbGx5IHJlc2VydmUgb3IKPj4+
IHJlbGVhc2Ugc3BlY2lmaWMgZGV2aWNlcyBmcm9tIHRoZSBmaWxlc3lzdGVtJ3MgZnJlZSBwb29s
IGF0IHJ1bnRpbWUKPj4+IHRocm91Z2ggbmV3IGlvY3Rscy4KPj4+Cj4+PiBUbyBzdXBwb3J0IHRo
aXMsIHRocmVlIG5ldyBpb2N0bHMgYXJlIGludHJvZHVjZWQ6Cj4+PiAtIEYyRlNfSU9DX1JFU0VS
VkVfREVWX0FMSUFTOiBUaGlzIHJlY2xhaW1zIHRoZSBzcGFjZSBvY2N1cGllZCBieSBhCj4+PiAg
IGRldmljZSBhbGlhc2luZyBmaWxlLiBJdCBmaXJzdCBwZXJmb3JtcyBhIGNhcGFjaXR5IGNoZWNr
LCByZXNldHMgR0MKPj4+ICAgdmljdGltIGluZm9ybWF0aW9uIGZvciB0aGUgdGFyZ2V0IHJhbmdl
LCBtYXJrcyB0aGUgc2VnbWVudHMgYXMgaW4tdXNlCj4+PiAgIHRvIHByZXZlbnQgbmV3IGFsbG9j
YXRpb25zLCBhbmQgdGhlbiB0cmlnZ2VycyBHQyB0byBtaWdyYXRlIGV4aXN0aW5nCj4+PiAgIHZh
bGlkIGRhdGEgb3V0IG9mIHRoZSByYW5nZS4gRmluYWxseSwgaXQgcmVzZXJ2ZXMgdGhlc2UgYmxv
Y2tzIGluIHRoZQo+Pj4gICBTSVQgdG8gZWZmZWN0aXZlbHkgZXhjbHVkZSB0aGUgZGV2aWNlIGZy
b20gdGhlIHVzYWJsZSBjYXBhY2l0eS4KPj4+Cj4+PiAtIEYyRlNfSU9DX1JFTEVBU0VfREVWX0FM
SUFTOiBUaGlzIHJlbGVhc2VzIHRoZSByZXNlcnZlZCBzcGFjZSBvZiBhCj4+PiAgIHByZXZpb3Vz
bHkgcmVzZXJ2ZWQgZGV2aWNlIGFsaWFzaW5nIGZpbGUuIEl0IHRydW5jYXRlcyB0aGUgYmxvY2tz
Cj4+PiAgIGFzc29jaWF0ZWQgd2l0aCB0aGUgZmlsZSwgd2hpY2ggbWFrZXMgdGhlbSBhdmFpbGFi
bGUgZm9yIGdlbmVyYWwKPj4+ICAgZmlsZXN5c3RlbSBhbGxvY2F0aW9uIGFnYWluLgo+Pj4KPj4+
IC0gRjJGU19JT0NfR0VUX0RFVl9BTElBU19TVEFUVVM6IFRoaXMgcmV0cmlldmVzIHRoZSBjdXJy
ZW50IGFsaWFzaW5nCj4+PiAgIHN0YXR1cyBvZiBhIGRldmljZSBhbGlhc2luZyBmaWxlLCByZXR1
cm5pbmcgd2hldGhlciB0aGUgZmlsZSBpcwo+Pj4gICByZWxlYXNlZCAoaW5hY3RpdmUgYWxpYXMp
IG9yIHJlc2VydmVkIChhY3RpdmUgYWxpYXMsIHdpdGggYmxvY2tzCj4+PiAgIGZ1bGx5IGFsbG9j
YXRlZCBvbiB0aGUgZGV2aWNlKS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8
ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+PiBSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJu
ZWwub3JnPgo+Pgo+PiBUaGFua3MsCj4gCj4gT2gsIEkgb3Zlcmxvb2tlZCB0aGF0IGVpLmJsayBp
bmNsdWRlcyB0aGUgc2VnbWVudDBfYmxrYWRkciBvZmZzZXQgKHRoZQo+IG1ldGFkYXRhIGFyZWEp
LCBzbyBgZWkuYmxrICUgQkxLU19QRVJfU0VDKHNiaSlgIGluY29ycmVjdGx5IGNoZWNrZWQKPiBh
bGlnbm1lbnQgZnJvbSBibG9jayAwIHJhdGhlciB0aGFuIHRoZSBzZWdtZW50IGFyZWEgc3RhcnQu
CgpPaCwgSSBtYXkgbWlzc2VkIHRoaXMuLi4KCj4gCj4gSSBhbSBnb2luZyB0byBmaXggaXQgdXNp
bmcgdGhlIGBHRVRfU0VHT0ZGX0ZST01fU0VHMCgpYCBtYWNybzoKPiBpZiAoKEdFVF9TRUdPRkZf
RlJPTV9TRUcwKHNiaSwgZWkuYmxrKSAlIEJMS1NfUEVSX1NFQyhzYmkpKSB8fAo+IChlaS5sZW4g
JSBCTEtTX1BFUl9TRUMoc2JpKSkpIHsKPiAuLi4KPiB9CgpMb29rcyBmaW5lIHRvIG1lLgoKVGhh
bmtzLAoKPiAKPiBUaGFua3MsCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
