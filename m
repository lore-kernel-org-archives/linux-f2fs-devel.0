Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C1BCC6B16
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chukd7HL85PF4ZqvLIXitNlx+3aKVEMylWdZ6kaAxIs=; b=NQGvuxvzskB79Jc8RLsRQ3OFQo
	567SvMwwGB6fK3plgB8Hj8qoDQ6q8iCUZ1ic1e96jjCldQzMdmMsNBfhJVyfeR11g1TdZcKLXcmfK
	tREXkTHrX5knwyYBLa7nYZEt/je7p7jnfipYQmzGrrls/G41V1QWdm3oXzt7GSgOYF2c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGepl-0007va-Vi;
	Tue, 13 Oct 2026 15:54:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGepl-0007vU-1p
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 15:54:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rUxAHLiVJ++sul2Jm66JmrePRs+RfbOvzGxUS+GnQIw=; b=CorCR9vebm2J3jf229G4IWoqtS
 2KL518R4WyO9Jwhvqokx0UCCHQ5DCXnpz7c7ebLf8RA5dTwvLinb17dbIsu8XWjkwMDS5nbgT7bGL
 SQ/ugPneeTZhQMLM2SCGeQI4tsxLfjiXs8TyVyc6yftpFZCfzpa+LwkLgGQDTyB6NHmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rUxAHLiVJ++sul2Jm66JmrePRs+RfbOvzGxUS+GnQIw=; b=Cr0At9htydyqVCMsJLUDfjTW6Y
 P7Uu3RWDMvUJGbRYee0SzXDNPIH1D3o4s3NoYRA92rPXzoOdDOcl5kZ3mN1NC516GtSfnn0+tcwjl
 CIwoXPjHrWV6jnLxFHLKAROssBZeAe+/A6e9lOmu50bWwrr0Mi7MHOvTrf6xTu6TUgos=;
Received: from mail-lf1-f43.google.com ([209.85.167.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGepj-0008N1-NO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 15:54:32 +0000
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5bcf21cfbdaso1840285e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 08:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906865; cv=none;
 d=google.com; s=arc-20260327;
 b=p7boWkYaMmDGboH5ZKz2US0qhMFzfld145l6AY0Aa15lUQMHzJZPr0RfsdCmb878F8
 7pQ6FYKDCsMoEZIL7HXraIn4MYIRCnpN1oea0lCxjZB2B7LJLONO2BTbvZ15xrbUVqKd
 E9skhewEHtCf9FtosuPSjV6QVhHVEv86H9M375czj586urVhAultyooUkzd5rn3LEREU
 1imXzNQj0fFIN5Bsan/ybf2Hlcj4jYf+Yo9g5zOqt2MBSSM2qkUNbApjbR/urN+iSDzX
 P6I07rmQnugPQCXl889eqzhA65szi/u3JhhNwFDhvzMFMz8hLdqXNyE47HNCPcfiaOod
 0kkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rUxAHLiVJ++sul2Jm66JmrePRs+RfbOvzGxUS+GnQIw=;
 fh=GAn8qEo9j8Q5iuSEgeIwSKy+wwWAhHXz2xRdBVbX3jo=;
 b=rqghu4S7dHjoGh3UQW3B0uLEon7245TT1OZSV1ahuD1S/WHrYoV+hD8B6u7qk9GRwz
 mwMjNjZzR0jKbQO89qfTPD3CrR2Lb/TMmmMZp6jFvhlgNMFa2N0XmlZgMpywyh9EHbSW
 0Pqoct2z+CE5hldv/1YkpFHda/W0SxvxOwADKFusJ5yKcUSfP2NE70eo1pjsarkRv65y
 i8HoBY8rJT4f+nCF2qyepdkuiOBI21/dnAn9QbzV2g4N/TGv+yB7ZrHoh0b4zZmPvL50
 Ubq4F6wNHDX7Oa44uiDBs1ukxETka/uEjF3QdT/scR0DwUch3A0e6w1olnjC5MRlHGhP
 XXUQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791906865; x=1792511665; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rUxAHLiVJ++sul2Jm66JmrePRs+RfbOvzGxUS+GnQIw=;
 b=r2Wd3bF2WYLwghtcYcupxPOFtOm3CPEPTYOmtmOtaqD8hXIfqJCU45PYprZlWZWd+C
 YBJcarojkezHjuj0xo6BRrU4rO3OraDSofZxn5P89nBnvyFOssBWgF8DouMwCEaKs+uI
 M3Ai+niaALquw/0v6CaGXjr413JYEhovPCa85/E1AEXy4Y5vxFXGSQnz5kQ5TpxyyEt0
 ISsTqp1giBIppcbOB5Z1vErcIIOX6EKo/S/OWIHMzPY11is0DgCMBr0+BVtQ/zow5r3p
 54USbv7jxfp83TZMLJEicmLjtibeVI2p3rndYDatLuRo09APlcFNqs2TBXJtOSe8Tacq
 zb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906865; x=1792511665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rUxAHLiVJ++sul2Jm66JmrePRs+RfbOvzGxUS+GnQIw=;
 b=0LTERWPToAaVHjBMQZy303I7KMF/WaIwNC9re6wD7jRdW/SrEuHq9HfrCS6YnDehUC
 eDlmrfYblCwu5W9c2UiPdkax688bS3bdiMNK08k5RfPhZDWHSCw9/249apOFgnK4z7N0
 mgaJyppm3b4lakO/2XUyy4kWe/wlPt+8gK6s+fosolYxMMUQa0LNhRc9uNgyZcxx8bki
 VTAZi0uVR49Kx7DVbvzx1I3NtOGHlVAbTCyKrLrfchmNzmtoBe/SIsCf5ge0q4M69B+d
 UL9u/7ugrNC/G9AGRAE7gA49Y+BakVyZjHqw4SKjAqS0XvTQmtDzXtghAKWWvn069wyp
 aNrQ==
X-Gm-Message-State: AFq9FYJPZ3FAbCiMCkHt9LA4oJyuae6+lJisynLYtBbcx6WjfDyFLb+X
 7b6NhY3rEXHXAsz77cMBvFv0yt+B8iJ5zZF8g5oKH5Hg6yb4rVdaxhDi1RxOx2K9WR2K0dziv8f
 pWuLe/CGDtbZrytctJ8OCnCFtwG4tlwg=
X-Gm-Gg: AYBFou2iLW+BnrbglCrQT39sec9wH3ydB4TlsMZFJunikVt/Vp97FVRDkjoz6CTMk/t
 mC8jZgQ16tvlYuM3WA6y/Fp5LJ7LTtjEVYleKvJoFI7jOH+klLO/TmI8Gek2y8XPUnOB3XOBwGv
 k/tkCgR7sYhPYDQKrItC2iDbUwO7qqSk/wtCIXAuyGuORzLECObZv+ccP5dD8ivmey7fh78QNHs
 s95Xr5PRkdRgoh95U5XCDnfbAG0YijL+cu12jvY9MfwGpo/ww00EgJ+QyR2NChkhKOUkFc84H5w
 FqF24OI4+uOKy2fNBl6/usEq3cwNezUztwcKSu1P+mhQx0KOAvsVlLLhz7ymzkkmob1XWZZ6mwG
 3NdyDN+jWmqLK6cs5VaQ+sublrGtrc4vCCL3G9u7C8A==
X-Received: by 2002:a05:6512:31d5:b0:5bb:783a:72ac with SMTP id
 2adb3069b0e04-5bcde6bb5a5mr4986583e87.16.1791906864747; Tue, 13 Oct 2026
 08:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261002064853.37782-1-jsjlee1020@gmail.com>
 <00c340f7-723c-4b17-a5db-17906ff2951a@kernel.org>
In-Reply-To: <00c340f7-723c-4b17-a5db-17906ff2951a@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 13 Oct 2026 08:54:12 -0700
X-Gm-Features: AclHuK84zuthNMqO_uZ7SbPD7zr3eQ0a1qCPHQBjSLYBMoqOxjJUiOKfXvqHEl0
Message-ID: <CACOAw_zm0yaC_8eyjiyC+bB-S=hfbOdNcNgSV-VnbPam6r-zAw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGepj-0008N1-NO
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid unnecessary reads in
 f2fs_update_meta_block()
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

T24gU3VuLCBPY3QgMTEsIDIwMjYgYXQgMTo0MeKAr0FNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiAxMC8yLzI2IDE0OjQ4LCBTZW9uZ2phZSBKZW9uZyB3cm90ZToKPiA+
IFdoZW4gdGhlIHBhY2tlZCBTU0EgZmVhdHVyZSBpcyBlbmFibGVkLCBmMmZzX3VwZGF0ZV9tZXRh
X2Jsb2NrKCkKPiA+IHVzZXMgZjJmc19nZXRfbWV0YV9jYWNoZV9yZXRyeSgpLCB3aGljaCByZWFk
cyB0aGUgdGFyZ2V0IGJsb2NrIGZyb20KPiA+IGRpc2sgaWYgdGhlIGNhY2hlIGVudHJ5IGlzIG5v
dCB1cHRvZGF0ZS4KPiA+Cj4gPiBIb3dldmVyLCBmMmZzX3VwZGF0ZV9tZXRhX2Jsb2NrKCkgb3Zl
cndyaXRlcyB0aGUgZW50aXJlIGZpbGVzeXN0ZW0KPiA+IGJsb2NrIHdpdGggbWVtY3B5KCksIHNv
IHRoZSBleGlzdGluZyBjb250ZW50cyBhcmUgbm90IG5lZWRlZC4KPiA+IFBhcnRpYWwgdXBkYXRl
cyB0byBwYWNrZWQgU1NBIGJsb2NrcyBhcmUgaGFuZGxlZCBzZXBhcmF0ZWx5IGluCj4gPiB3cml0
ZV9zdW1fYmxvY2soKS4KPiA+Cj4gPiBVc2UgZjJmc19ncmFiX21ldGFfY2FjaGUoKSB1bmNvbmRp
dGlvbmFsbHkgdG8gYXZvaWQgcmVhZGluZyBibG9ja3MKPiA+IHRoYXQgd2lsbCBiZSBmdWxseSBv
dmVyd3JpdHRlbi4gQWxzbyByZW1vdmUgdGhlIGVycm9yIGNoZWNrLCBzaW5jZQo+ID4gZjJmc19n
cmFiX21ldGFfY2FjaGUoKSByZXRyaWVzIGFsbG9jYXRpb24gZmFpbHVyZXMgaW50ZXJuYWxseSBh
bmQKPiA+IGRvZXMgbm90IHJldHVybiBhbiBlcnJvciBwb2ludGVyLgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNlb25namFlIEplb25nIDxqc2psZWUxMDIwQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4g
ICBmcy9mMmZzL3NlZ21lbnQuYyB8IDggKy0tLS0tLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9mMmZz
L3NlZ21lbnQuYyBiL2ZzL2YyZnMvc2VnbWVudC5jCj4gPiBpbmRleCA3OTRlMGQ5OWZjN2MuLjUx
ODU4ZjY0ZTQzZSAxMDA2NDQKPiA+IC0tLSBhL2ZzL2YyZnMvc2VnbWVudC5jCj4gPiArKysgYi9m
cy9mMmZzL3NlZ21lbnQuYwo+ID4gQEAgLTI4NDQsMTMgKzI4NDQsNyBAQCB2b2lkIGYyZnNfdXBk
YXRlX21ldGFfYmxvY2soc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ID4gICB7Cj4gPiAgICAg
ICBzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2sgKmVudHJ5Owo+ID4KPiA+IC0gICAgIGlmICghZjJm
c19zYl9oYXNfcGFja2VkX3NzYShzYmkpKQo+ID4gLSAgICAgICAgICAgICBlbnRyeSA9IGYyZnNf
Z3JhYl9tZXRhX2NhY2hlKHNiaSwgYmxrX2FkZHIpOwo+ID4gLSAgICAgZWxzZQo+ID4gLSAgICAg
ICAgICAgICBlbnRyeSA9IGYyZnNfZ2V0X21ldGFfY2FjaGVfcmV0cnkoc2JpLCBibGtfYWRkcik7
Cj4gPiAtCj4gPiAtICAgICBpZiAoSVNfRVJSKGVudHJ5KSkKPiA+IC0gICAgICAgICAgICAgcmV0
dXJuOwo+ID4gKyAgICAgZW50cnkgPSBmMmZzX2dyYWJfbWV0YV9jYWNoZShzYmksIGJsa19hZGRy
KTsKPgo+IERhZWhvLAo+Cj4gIEZyb20gY29kZSBzaWRlLCBJIGZlZWwgdGhpcyBpcyBjbGVhbi4K
Pgo+IEJ1dCwgY291bGQgeW91IGRvdWJsZSBjaGVjayB0aGlzIGNsZWFudXA/IGluIGNhc2UgaWYg
d2UgaGFuZGxlIHRoaXMKPiBpbnRlbnRpb25hbGx5IGluIG9yaWdpbmFsIHBhdGNoIGZvciBzb21l
dGhpbmcuCj4KPiBUaGFua3MsCgpMb29rcyBnb29kIHRvIG1lLiBUaGFua3N+Cgo+Cj4gPgo+ID4g
ICAgICAgbWVtY3B5KGNhY2hlX2FkZHJlc3MoZW50cnkpLCBzcmMsIEYyRlNfQkxLU0laRShzYmkp
KTsKPiA+ICAgICAgIGYyZnNfbWFya19jYWNoZV9kaXJ0eShlbnRyeSk7Cj4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
