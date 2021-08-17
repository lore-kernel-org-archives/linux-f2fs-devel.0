Return-Path: <SRS0=6Xs1=NI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33350C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:16:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24C060EE4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E24C060EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFmma-0000CB-L1; Tue, 17 Aug 2021 00:16:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1mFmmZ-0000C3-A6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:16:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R2oFj40HUhFDutLLIi8myg/W2zZbCjkEaAkG5TC2kTU=; b=O+PP3Y6vrSGt1Z1ZnhmjWPHZ0O
 sTMnIEXQ/mUDOkrBuS+DQXT7Ja6TxMStgjPYmIehz0tHPvDhRoOgUPBqfLxRTKMQam3sAGCITpjrb
 z4DpQJh1pQwVPeC9n1LKbwPO0uYYIpvsKxcpFRvGJ1S1lm4ah+trIxq+cIiofcDCyo9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R2oFj40HUhFDutLLIi8myg/W2zZbCjkEaAkG5TC2kTU=; b=DPsMBtu3tD6CujmnAXXmjyYlED
 wpyfrTEDkLhwzzN8Z+uVLLR0ISnjnDI795krBIQitFRR/dT+AEhhRvdbGxcNp0GnCtOz14E5Q4Ckz
 V3E0wzHBN+LzTweXdNAY2brPbnsu6r2xEzzccqqLNj5LjDkw2Bgy1XQ+IACCpvdFtzg0=;
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFmmU-0005Vq-C1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:16:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A97B60F39;
 Tue, 17 Aug 2021 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629159385;
 bh=KG4aBz3LsYlQoj4ZmeJ8bEqC+SJgiUisze7eXuaacNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FH21FE+LDI3lyirYFQijw7ZRz0nDvutSJqqu4l7oDJW0uI5WqA0yzgFjJMbKUGf/R
 l2FmB9sYbVeuC8J0cBjwDOjmK3haT9rq+8hUDnNdKUizhmoMNufsWg3rkoTVwRIzk3
 3AnVZVR4inSti0ydlAddPzmoE/2tBuKWCC1+8HyMHjZP26suketwsTBdXJ87PhEDZY
 WaoWbGtUBUDcckPN+zD1qzg1zqoBeEAjSxAcKoGYx6f0WXDKclYTyZOyXShsah2d9g
 Zx/TjFr5FBhNsXHq2jOA4/9oIig53WsOYpd81YFqSL7j7hNpXhKf8hTEBY1Hzvd9WC
 MbBqKVIQs5SJQ==
Date: Mon, 16 Aug 2021 17:16:24 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Message-ID: <YRr/2DM84TishToA@google.com>
References: <af34f9cd-8972-583b-bae2-f11fe9058e63@kernel.org>
 <AGwAWQBVD3NfsYDCdBIWb4qP.3.1629094420548.Hmail.frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AGwAWQBVD3NfsYDCdBIWb4qP.3.1629094420548.Hmail.frank.li@vivo.com>
X-Headers-End: 1mFmmU-0005Vq-C1
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add sysfs nodes to get discard
 information
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMDgvMTYsIOadjuaJrOmfrCB3cm90ZToKPiA+Pj4+IEkndmUgYWRkZWQgbmV3IHN5c2ZzIG5v
ZGVzIHRvIHNob3cgZGlzY2FyZCBzdGF0IHNpbmNlIG1vdW50LCB3aGljaAo+ID4+Pj4gd2lsbCBo
ZWxwIHVzIGFuYWx5emUgd2hldGhlciB0aGUgcGVyZm9ybWFuY2UgcHJvYmxlbSBpcyByZWxhdGVk
IHRvCj4gPj4+PiBkaXNjYXJkLgo+ID4+Pj4KPiA+Pj4+IGlzc3VlZF9kaXNjYXJkICAtIFNob3dz
IHRoZSBudW1iZXIgb2YgaXNzdWVkIGRpc2NhcmQKPiA+Pj4+IHF1ZXVlZF9kaXNjYXJkICAtIFNo
b3dzIHRoZSBudW1iZXIgb2YgY2FjaGVkIGRpc2NhcmQgY21kIGNvdW50Cj4gPj4+PiBkaXNjYXJk
X2NtZF9jbnQgLSBTaG93cyB0aGUgbnVtYmVyIG9mIGNhY2hlZCBkaXNjYXJkIGNtZCBjb3VudAo+
ID4+Pj4gdW5kaXNjYXJkX2Jsa3MgIC0gU2hvd3MgdGhlIG51bWJlciBvZiB1bmRpc2NhcmQgYmxv
Y2tzCj4gPj4+Cj4gPj4+IFdlIGhhdmUgZXhwb3J0ZWQgdGhlbSBpbiBkZWJ1Z2ZzLCBjYW4geW91
IHVzZSB0aGF0Pwo+ID4+Pgo+ID4+PiBUaGFua3MsCj4gPj4gCj4gPj4gQnV0IG5vdyBBbmRyb2lk
IGlzIGZvcmJpZGRlbiB0byBvcGVuIGRlYnVnZnMsIGFuZCBpbiBmYWN0IHdlIGhhdmUgbm90Cj4g
Pj4gb3BlbmVkIHRoaXMgY29uZmlndXJhdGlvbiBmb3IgYSBsb25nIHRpbWUuCj4gPgo+ID5XZXJl
bid0IHRoZW0gYmUgdXNlZCBmb3IgZGVidWcgcHVycG9zZT8gY2FuIHlvdSBwbGVhc2UgZXhwbGFp
biBtb3JlIGFib3V0Cj4gPnlvdXIgdXNlIGNhc2U/Cj4gCj4gRHVyaW5nIGxvbmctdGVybSBhZ2lu
ZyB0ZXN0IG9yIG5vcm1hbCB1c2UsIHNvbWV0aW1lcyB0aGVyZSB3aWxsIGJlIHBlcmZvcm1hbmNl
Cj4gZGVncmFkYXRpb24gcHJvYmxlbXMuIEl0IG1heSBiZSBjYXVzZWQgYnkgc3RvcmFnZSwgb3Ig
aXQgbWF5IGJlIGNhdXNlZCBieSB0aGUKPiBmaWxlc3lzdGVtLiBGb3IgZXhhbXBsZSwgdGhlIGZp
bGVzeXN0ZW0gYWNjdW11bGF0ZXMgYSBsYXJnZSBudW1iZXIgb2YgdW5kaXNjYXJkCj4gIGJsb2Nr
cy4gQWx0aG91Z2ggdGhlcmUgaXMgc29tZSByZW1haW5pbmcgc3BhY2UsIHRoZSBhbmRyb2lkYmVu
Y2ggdGVzdCB3aWxsCj4gc2hvdyBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbi4gVGhlcmVmb3JlLCBp
dCBpcyBuZWNlc3NhcnkgdG8gZXhwb3J0IGluZm9ybWF0aW9uCj4gcmVsYXRlZCB0byBkaXNjYXJk
IHNvIHRoYXQgd2UgY2FuIGNvbmZpcm0gdGhpcyBzaXR1YXRpb24uCgpJIHRoaW5rIHlvdSBjYW4g
bW91bnQgZGVidWdmcyBmb3IgdGhhdCBjYXNlPwoKPiAKPiBUaHgsCj4gCj4gCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
