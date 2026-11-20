Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02C606A630
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=INwuy2sA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LWKnSVyT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vm0/8pvm;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TiA7FmQN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=3omoBSPX6f4/DUly4e4cBe9nqff7YTkFprbk3gf105A=; b=INwuy2sAQc5QYWCJeMnCTVFjbU
	2fYz1VviyYdn1j4s1xh2C6hT/XAYntfUbJ2GLwbfBwXH144jPHemmfdrFuHTnIKyegepC9Fu4rYWY
	p8w0XT14k+F/+MKC20c26bpDRULxkRwhBjmIcGoj8uCzB+igcl1begJU4FjPcfetH7Kg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xURjP-000000005Qf-3TbD;
	Fri, 20 Nov 2026 16:44:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <BATV+de1156368b985c5aa289+8489+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1xURjO-000000005QZ-0wv6
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mD5J0pRczEgNvhN4q/+TpB36xpd0+3c/0OdpcRtKnHY=; b=LWKnSVyT5xnktg8RfLsGDjoE3p
 DCZbpSrO698imcusdxJZaP0LfCwev9MzpYjuPW8SOUpETLGzGeQ/t7zSl+YXHmSpNa04a+fMObAc3
 oUpEeELjlQAACWSb7GexGN8eWzLdydfq2ZXnkHjmjPvWUz/7FqYftaFTNP4blfI3sYzw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mD5J0pRczEgNvhN4q/+TpB36xpd0+3c/0OdpcRtKnHY=; b=Vm0/8pvmZzN+fdrNJQSsFyAhg/
 4oXTnKi7i8cU5JHsN6ExZr9JjsZSJR7kw9njB/INyE+pK061ysuCyiW351t/p0mAoa28Xhgf+9QW7
 I106G4DfVM79+CjYWaD85L3uFf1P6Dw2iKhjevqBX9CrWA5Sn6+UJFDdoiEaeDtUi+34=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xURjN-000000003V2-1h4H
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=mD5J0pRczEgNvhN4q/+TpB36xpd0+3c/0OdpcRtKnHY=; b=TiA7FmQNItcckq2QxPbVkvOHJs
 na+dnA3pWdEUev1B/jkGvouhqSE6VAFHHaAr7Flm4qZlm9vCo6zvv/OXRMgBHlWU3yJJk+x8lzd7Y
 ScX/lMhKaZlXJZ+zO30Ckc0xsZWLUarVTnKVNF5XgUrrp6NrXrXeKZj88Q+OQrXeDtlMjvxx5j7rt
 gJJonHI//DKoSAA5WcqlPSwzxn8OxyJPlHRx5NUqDae1ZxgQG9xCplr6vMz2Hdln505ZZCKJfYbyO
 hExO4v67ImntEuSeFxTRNVqVHxIm8L0fp9TBKx9YvV2YCRlvwUM+fL4V3Yccn1cfIr9+RXfM1rQAk
 lYQGNGJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red
 Hat Linux)) id 1xUR9S-0000000FW7F-2vVK;
 Fri, 20 Nov 2026 16:07:52 +0000
Date: Fri, 20 Nov 2026 08:07:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <awBwVtp4y_bYK7fn@infradead.org>
References: <20261112143355.2923939-1-jprusakowski@google.com>
 <20261112143355.2923939-6-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261112143355.2923939-6-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Score: -0.1 (/)
X-Headers-End: 1xURjN-000000003V2-1h4H
Subject: Re: [f2fs-dev] [PATCH RESEND 5/9] f2fs: truncate blocks allocated
 past EOF by a failed direct write
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCBOb3YgMTIsIDIwMjYgYXQgMDI6MzM6NTFQTSArMDAwMCwgSmFuIFBydXNha293c2tp
IHdyb3RlOgo+IFdoZW4gYSBkaXJlY3Qgd3JpdGUgZXh0ZW5kcyBhIGZpbGUsIGYyZnNfbWFwX2Js
b2NrcygpIGFsbG9jYXRlcyB0aGUKPiBibG9ja3MgcGFzdCBFT0YgYW5kIG1hcHMgdGhlbSBpbnRv
IHRoZSBkbm9kZSBiZWZvcmUgdGhlIGJpbyBpcwo+IHN1Ym1pdHRlZC4gSWYgdGhlIHdyaXRlIHRo
ZW4gZmFpbHMsIGlfc2l6ZSBpcyBub3QgdXBkYXRlZCwgYnV0IHRoZQo+IGJsb2NrcyBzdGF5IG1h
cHBlZCBwYXN0IEVPRiB3aXRoIHdoYXRldmVyIHRoZSBkaXNrIGNvbnRhaW5lZCBiZWZvcmUuCj4g
QSBsYXRlciBleHRlbmRpbmcgd3JpdGUgb3IgdHJ1bmNhdGUgY2FuIG1ha2UgdGhlbSB2aXNpYmxl
Lgo+IAo+IGYyZnNfcHJlYWxsb2NhdGVfYmxvY2tzKCkgYWxyZWFkeSBoYW5kbGVzIHRoaXMgZm9y
IGJsb2NrcyBpdAo+IHByZWFsbG9jYXRlcyB3aXRoIEYyRlNfR0VUX0JMT0NLX1BSRV9ESU86IGl0
IG1hcmtzIHRoZSBpbm9kZSB3aXRoCj4gZmlsZV9uZWVkX3RydW5jYXRlKCkgYW5kIGYyZnNfZmls
ZV93cml0ZV9pdGVyKCkgdHJ1bmNhdGVzIGV2ZXJ5dGhpbmcKPiBwYXN0IGlfc2l6ZSBhZnRlciBh
IHNob3J0IHdyaXRlLiBCdXQgdGhlIHByZWFsbG9jYXRpb24gaXMgc2tpcHBlZCBpbgo+IExGUyBt
b2RlIGFuZCB3aGVuIHRoZSB1c2VyIGJ1ZmZlciBjYW4ndCBiZSBmYXVsdGVkIGluLCBhbmQgdGhl
biB0aGUKPiBibG9ja3MgYXJlIGFsbG9jYXRlZCBieSBGMkZTX0dFVF9CTE9DS19ESU8gZnJvbSBm
MmZzX2lvbWFwX2JlZ2luKCkgYW5kCj4gbm90aGluZyB0cnVuY2F0ZXMgdGhlbS4KPiAKPiBNYXJr
IHRoZSBpbm9kZSB3aXRoIGZpbGVfbmVlZF90cnVuY2F0ZSgpIGFsc28gd2hlbiBGMkZTX0dFVF9C
TE9DS19ESU8KPiBhbGxvY2F0ZXMgYSBibG9jayBwYXN0IEVPRiwgYW5kIHRydW5jYXRlIGFmdGVy
IHRoZSB3cml0ZSBpZiB0aGUgZmxhZyBpcwo+IHNldCBhbmQgdGhlIGZpbGUgaXMgc2hvcnRlciB0
aGFuIGludGVuZGVkLiBTa2lwIEtFRVBfU0laRSBmaWxlcywgd2hlcmUKPiB0aGUgdHJ1bmNhdGlv
biB3b3VsZCBhbHNvIGRyb3AgdGhlIGJsb2NrcyByZXNlcnZlZCBieSBmYWxsb2NhdGUoKS4KCk5v
bmUgb2YgdGhpcyBmaXhlcyB0aGUgaXNzdWUgaW4gY2FzZSB0aGUgc3lzdGVtIGNyYXNoZXMgYmV0
d2VlbiB0aGVzZQrRlXRlcHMuICBmMmZzIHJlYWxseSBuZWVkcyB0byBncm93IHVud3JpdHRlbiBl
eHRlbnQgc3VwcG9ydCBvciBmaW5kIHNvbWUKb3RoZXIgd2F5IHRvIG5vdCBhZGQgdGhlIG1hcHBp
bmcgdW50aWwgSS9PIGNvbXBsZXRpb24sIG90aGVyd2lzZSB0aGlzCnJlbWFpbnMgYnJva2VuIGFu
ZCBleHBsb2l0YWJsZS4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
