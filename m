Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7ECD6CFAA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 00:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ML7jswcj+F0Rj9J21yqD/dJ9hDAGLVdJN50gVctivYI=; b=bKE14YXWsXB1rmSkDNmJVygnJq
	JsDMwn8qj7THFChfHYe28+gded0n2BIVRv5S2Aat5x00uSVtkE+3lLXhgH61UjdT1xKqJOto5Pngs
	Nwqazi64XBzNG+4sGB7waHnTPoQraE4wI7jq8dRepr1ojSDU51ub54I5dP5H9h/y78Zk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj5GH-0002bc-Up;
	Fri, 23 Jan 2026 00:42:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vj5GG-0002bW-ES
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 00:42:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xgWvvlv97XmV6MO0GyIlr92+QKi4T/0/A4eb7MkBRos=; b=NjuqZ5pPgCXxnvS4rKq2p83kPh
 Ki7o5WY763b3LDnbEAhOKe9Sy/upJJzCrfLrWYcv8eJJXhHaBtC4NrEkg1OEiUV7gnUAFw7ym4lYg
 DtgojnuVykrn/qLQ0DGYtKo3wep2z2VdngS/rVDmslbUZN24yrDXj5K4GZH5SOIiKVyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xgWvvlv97XmV6MO0GyIlr92+QKi4T/0/A4eb7MkBRos=; b=XWfr825kmQzjc8m5u/bJsuxL6r
 Po0GzLs0OyiIXXBXubcb1vVRBXhTOlaSYJKTJkMvjS3LtgXCIBa66WjddcYy2gE5HgXeGw5sfVVxC
 tZ+uWqQRDSAvaVvDaqWbiIWkb845HG5WG+N3nSNAIITaxahSt+byVBNQHacZr1AmbVis=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj5GF-0004KT-OH for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 00:42:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5293544054;
 Fri, 23 Jan 2026 00:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A409C19422;
 Fri, 23 Jan 2026 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769128961;
 bh=YxGwcerMm4XsXjm+1niJ1WYBTECA2bIMf19KywNaCDg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ShZI1/yNzfRZmu3sAjPE26FJHVCzdjNlR+PLLp4IBIjapKolYcMC/p/AzlQi8kHOy
 E6N/2W2E5pbB7ftb730Cw4JH/VlIVqvxbnyT1of+3pueWWa9Uliru6CZhIiNC88aWu
 VqzFK4TQxalFuLYdfa7Gk1bYZr2eTNdyfe6gSwFV/oQuP8DRhWTVOPyO0H6/XntitM
 tBUss/brfrvJZRVZ5OZuEX1lA9AjU+iqu/0VZA+qg0XEwsarVMGki7cWdIvd9MnvDN
 8t5ul/t6LL2uITv0UmRDtXRalCIU4WNFGdULXYG+BjWbMjHexyK30Qy9s4VGX+KALh
 C96ziga6Ri68w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 37676F40068;
 Thu, 22 Jan 2026 19:42:39 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 19:42:39 -0500
X-ME-Sender: <xms:_8NyacyT6qdzAUxIj7fj3Nsl5-8VCaqp1T4qK26YUXr5Y2aLA_2NeQ>
 <xme:_8NyabEJSUOtxd1CnvO613uISWenl61hqckxjKSALI97Y6gbT7BTG5imlp1tVtD5E
 dZmK-v-K3MOUkKiTHhKdFXjV_m_beGWUd8A8yfrOFy-NV1DzTUMBrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
 khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
 hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
 hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
 leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
 hilhdrtghomhdpnhgspghrtghpthhtohepfeefpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
 hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
 lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
 gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_8Nyae8fZEj0DQVrfCxr0FyILU_fNTywtQD_OdmOVcWNU77PmfI2QA>
 <xmx:_8NyaVi4xh0mDAqTYl6Aak7mh9kYy0ReitnlyVgR-YCNKQ747f-2xw>
 <xmx:_8Nyac8j6VWHBiYHUbMz1HkDlTHqHH88I_1l7dpKX9shblHKGUUhGQ>
 <xmx:_8NyaZQERqfU2S5JiAxoVvJLMQM2fwqj5pfagVYnH43qwMV8tHCRpg>
 <xmx:_8NyaXduDdH_fuVXwK1_-Pl2iicEZJxM3cCk9MYctO41spFo2tlD5lzS>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id F0153780076; Thu, 22 Jan 2026 19:42:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A--SnukTeK5R
Date: Thu, 22 Jan 2026 19:42:15 -0500
To: "Darrick J. Wong" <djwong@kernel.org>
Message-Id: <bb2bb55c-6078-4494-9851-c684dfd9aa8c@app.fastmail.com>
In-Reply-To: <20260123002646.GL5945@frogsfrogsfrogs>
References: <20260122160311.1117669-1-cel@kernel.org>
 <20260122160311.1117669-2-cel@kernel.org>
 <20260123002646.GL5945@frogsfrogsfrogs>
X-Headers-End: 1vj5GF-0004KT-OH
Subject: Re: [f2fs-dev] [PATCH v7 01/16] fs: Add case sensitivity flags to
 file_kattr
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@manguebit.org>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Shyam Prasad N <sprasad@microsoft.com>,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, glaubitz@physik.fu-berlin.de,
 Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Christian Brauner <brauner@kernel.org>, Theodore Tso <tytso@mit.edu>,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, Hans de Goede <hansg@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgpPbiBUaHUsIEphbiAyMiwgMjAyNiwgYXQgNzoyNiBQTSwgRGFycmljayBKLiBXb25nIHdyb3Rl
Ogo+IE9uIFRodSwgSmFuIDIyLCAyMDI2IGF0IDExOjAyOjU2QU0gLTA1MDAsIENodWNrIExldmVy
IHdyb3RlOgo+PiBGcm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KPj4g
Cj4+IEVuYWJsZSB1cHBlciBsYXllcnMgc3VjaCBhcyBORlNEIHRvIHJldHJpZXZlIGNhc2Ugc2Vu
c2l0aXZpdHkKPj4gaW5mb3JtYXRpb24gZnJvbSBmaWxlIHN5c3RlbXMgYnkgYWRkaW5nIEZTX1hG
TEFHX0NBU0VGT0xEIGFuZAo+PiBGU19YRkxBR19DQVNFTk9OUFJFU0VSVklORyBmbGFncy4KPj4g
Cj4+IEZpbGVzeXN0ZW1zIHJlcG9ydCBjYXNlLWluc2Vuc2l0aXZlIG9yIGNhc2Utbm9ucHJlc2Vy
dmluZyBiZWhhdmlvcgo+PiBieSBzZXR0aW5nIHRoZXNlIGZsYWdzIGRpcmVjdGx5IGluIGZhLT5m
c3hfeGZsYWdzLiBUaGUgZGVmYXVsdAo+PiAoZmxhZ3MgdW5zZXQpIGluZGljYXRlcyBQT1NJWCBz
ZW1hbnRpY3M6IGNhc2Utc2Vuc2l0aXZlIGFuZAo+PiBjYXNlLXByZXNlcnZpbmcuIFRoZXNlIGZs
YWdzIGFyZSByZWFkLW9ubHk7IHVzZXJzcGFjZSBjYW5ub3Qgc2V0Cj4+IHRoZW0gdmlhIGlvY3Rs
Lgo+PiAKPj4gUmVtb3ZlIHN0cnVjdCBmaWxlX2thdHRyIGluaXRpYWxpemF0aW9uIGZyb20gZmls
ZWF0dHJfZmlsbF94ZmxhZ3MoKQo+PiBhbmQgZmlsZWF0dHJfZmlsbF9mbGFncygpLiBDYWxsZXJz
IGF0IGlvY3RsL3N5c2NhbGwgZW50cnkgcG9pbnRzCj4+IHplcm8taW5pdGlhbGl6ZSB0aGUgc3Ry
dWN0IHRoZW1zZWx2ZXMsIHdoaWNoIGFsbG93cyB0aGVtIHRvIHBhc3MKPj4gaGludHMgKGZsYWdz
X3ZhbGlkLCBmc3hfdmFsaWQpIHRvIHRoZSBmaWxlc3lzdGVtJ3MgLT5maWxlYXR0cl9nZXQoKQo+
PiBjYWxsYmFjayB2aWEgdGhlIGZhIGFyZ3VtZW50LiBGaWxlc3lzdGVtIGhhbmRsZXJzIHRoYXQg
aW52b2tlIHRoZXNlCj4+IGZpbGwgZnVuY3Rpb25zIGNhbiBub3cgc2V0IGZsYWdzIGRpcmVjdGx5
IGluIGZhLT5mc3hfeGZsYWdzIGJlZm9yZQo+PiBjYWxsaW5nIHRoZW0sIHdpdGhvdXQgdGhlIGZp
bGwgZnVuY3Rpb25zIHplcm9pbmcgdGhvc2UgdmFsdWVzLgo+Cj4gSW4gaGluZHNpZ2h0IEkgcmVn
cmV0IG5vdCBhc2tpbmcgZm9yIHRoZSBmaWxlX2thdHRyIGluaXRpYWxpemF0aW9uCj4gY2hhbmdl
IHRvIGJlIGluIGEgc2VwYXJhdGUgcGF0Y2guCgpJZiBJ4oCZbSBhc2tlZCB0byBwb3N0IGFub3Ro
ZXIgcmV2aXNpb24gb2YgdGhpcyBzZXJpZXMsIEnigJlsbCBsb29rIGF0IHNwbGl0dGluZwoxLzE2
IGludG8gdHdvIHBhdGNoZXMuCgoKPj4gQ2FzZSBzZW5zaXRpdml0eSBpbmZvcm1hdGlvbiBpcyBl
eHBvcnRlZCB0byB1c2Vyc3BhY2UgdmlhIHRoZQo+PiBmYV94ZmxhZ3MgZmllbGQgaW4gdGhlIEZT
X0lPQ19GU0dFVFhBVFRSIGlvY3RsIGFuZCBmaWxlX2dldGF0dHIoKQo+PiBzeXN0ZW0gY2FsbC4K
Pj4gCj4+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29t
Pgo+Cj4gVGhlIFVBUEkgY2hhbmdlcyBzdGlsbCBsb29rIG9rIHRvIG1lLiAgQUZBSUNUIHRoZSBm
aWxlX2thdHRyCj4gaW5pdGlhbGl6YXRpb24gbm93IHNlZW0gbGlrZSB0aGV5IGRvbid0IHphcCBm
aWVsZHMgdG8gY29uZnVzZQo+IHZmc19maWxlYXR0cl9nZXQuCj4KPiBSZXZpZXdlZC1ieTogIkRh
cnJpY2sgSi4gV29uZyIgPGRqd29uZ0BrZXJuZWwub3JnPgoKCi0tIApDaHVjayBMZXZlcgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
