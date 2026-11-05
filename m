Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB226082BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SBmEh85K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HfEWfo0N;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WrL/wTW3;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZtIUNGm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:To:Message-ID:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JMy1pI3RWXx/8jrUSxIbp38IDNRv2r6vMKOuXG0yqEY=; b=SBmEh85KC1MIpw3cN25gHrn5LH
	RYBDmdbmP522ZG3PqUqolhlJQ0OlOPcQX7ZY/Uk6lqmPzJg8pj+IXa033hL5E0IV5SDeKuNsp/0Q3
	tn5KZ0kFlW+YsUlq3I0cUTnuIDsbWI888mEJJ69+NmS4nDy3591fyoj9Fm0SV6OwYz84=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOwBm-0000000086l-0I7u;
	Thu, 05 Nov 2026 12:03:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <sashiko-bot@kernel.org>) id 1xOwBl-0000000086e-0DJm
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:03:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Cc:To:Reply-To:Subject:From:Message-ID:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=Gxcc1zkOY+57hokzq0GfoH/NV2UvZQZwh78R+8IWvrU=; b=HfEWfo0NDFR+
 FgIDOgFWGPezOsz1cbyVPGVs/AXp8aeA1eVgAZGYRnh8O/yhl57sl8kDToECSCVKnhR6IxnuGIccu
 UX8CYOXdn3CFpjVlGQO7UREN+qfubRTcl4w2LPgaMLa/lHvm0alVequxj9gXKMNhHxQOb1tf//PO4
 yz68g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:
 Reply-To:Subject:From:Message-ID:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gxcc1zkOY+57hokzq0GfoH/NV2UvZQZwh78R+8IWvrU=; b=WrL/wTW39JXnkGVRnyoEbAMxkP
 evUSKU5d4mNnBaZ0QAJXNrE6YIpQF1e/65YH3n3Nn0d70iXvaRHMvCSiytDf8X6AKBE5dWmtMbAlA
 sB/H+P0yPPgBO4T/J0Gp3AHAeSPw08kqZZrjcYx+XjOsdfIGsRpPxy267b8AfuXZcrEk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOwBj-000000007u2-2SUT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:03:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF18E60ED9;
 Thu,  5 Nov 2026 12:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA371F0093A;
 Thu,  5 Nov 2026 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793880201;
 bh=Gxcc1zkOY+57hokzq0GfoH/NV2UvZQZwh78R+8IWvrU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mZtIUNGmeIXB62Pt6CTlcMa0HybTCPRuGs9LHX5kxBRSqu3+/AJ+PiG+Js/v6qpKc
 l9pKVw+LXxK34u/SR1heVXq1fXspTx9s+Yi+bMgfxDelZwKsn7ZB8wg56sM/gCWCF+
 NZkEEz6sg5ZS0bgZTg+GZVPA/JDKcu5M6M441RgonGnXn+3hjnQGihrrmtQwKFXLq6
 tQY1eonI9bsPBylkv5FGA35h7yf7BgKT5cYgj5j3CHkZLF694OrS4pYE7Z8CnV2Pa3
 /MmP7a52c8pV12rSK8BgEsk5AknxLMpRI/Q7cTtaqzFQUssAVjWY+8SJ/K//noe6EL
 UBwSGwIxL7P9Q==
Message-ID: <sashiko-outbox-198985@kernel.org>
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>, ebiggers@kernel.org, hch@lst.de,
 fsverity@lists.linux.dev, dsterba@suse.com
In-Reply-To: <20261105115532.613467-6-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-6-aalbersh@kernel.org>
Date: Thu, 05 Nov 2026 12:03:20 +0000
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOwBj-000000007u2-2SUT
Subject: Re: [f2fs-dev] [PATCH v2 5/5] f2fs: use I_VERITY_BUILDING instead
 of private flags
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, brauner@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, dsterba@suse.cz,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
 linux-ext4@vger.kernel.org
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6Ci0gW0xvd10gZjJmczogdW5jb252ZXJ0
ZWQgZjJmc192ZXJpdHlfaW5fcHJvZ3Jlc3MoKSBjYWxscyBicmVhayBidWlsZCBpbiBkYXRhLmMK
LS0KCmNvbW1pdCBlNjQ0MzkxYTUxMjdjMzQzNWJmNjY0NTBlNTM5NzVkYzEyOTlmZjYwCkF1dGhv
cjogQW5kcmV5IEFsYmVyc2h0ZXluIDxhYWxiZXJzaEBrZXJuZWwub3JnPgoKZjJmczogdXNlIElf
VkVSSVRZX0JVSUxESU5HIGluc3RlYWQgb2YgcHJpdmF0ZSBmbGFncwoKVGhpcyBjb21taXQgcmVt
b3ZlcyB0aGUgZjJmcy1wcml2YXRlIEZJX1ZFUklUWV9JTl9QUk9HUkVTUyBpbm9kZSBmbGFnIGFu
ZCB0aGUKZjJmc192ZXJpdHlfaW5fcHJvZ3Jlc3MoKSBoZWxwZXIgaW4gZmF2b3Igb2YgdGhlIFZG
UyBJX1ZFUklUWV9CVUlMRElORyBmbGFnCmFuZCBmc3Zlcml0eV9pc19idWlsZGluZygpLgoKPiBk
aWZmIC0tZ2l0IGEvZnMvZjJmcy9mMmZzLmggYi9mcy9mMmZzL2YyZnMuaAo+IGluZGV4IDRmYTRk
ODA0MmY3MDIuLjExZDFjYWRlMTE1MTAgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9mMmZzLmgKPiAr
KysgYi9mcy9mMmZzL2YyZnMuaAo+IEBAIC05MjUsNyArOTI1LDYgQEAgZW51bSB7Cj4gIAlGSV9F
WFRSQV9BVFRSLAkJLyogaW5kaWNhdGUgZmlsZSBoYXMgZXh0cmEgYXR0cmlidXRlICovCj4gIAlG
SV9QUk9KX0lOSEVSSVQsCS8qIGluZGljYXRlIGZpbGUgaW5oZXJpdHMgcHJvamVjdGlkICovCj4g
IAlGSV9QSU5fRklMRSwJCS8qIGluZGljYXRlIGZpbGUgc2hvdWxkIG5vdCBiZSBnY2VkICovCj4g
LQlGSV9WRVJJVFlfSU5fUFJPR1JFU1MsCS8qIGJ1aWxkaW5nIGZzLXZlcml0eSBNZXJrbGUgdHJl
ZSAqLwo+ICAJRklfQ09NUFJFU1NFRF9GSUxFLAkvKiBpbmRpY2F0ZSBmaWxlJ3MgZGF0YSBjYW4g
YmUgY29tcHJlc3NlZCAqLwo+ICAJRklfQ09NUFJFU1NfQ09SUlVQVCwJLyogaW5kaWNhdGUgY29t
cHJlc3NlZCBjbHVzdGVyIGlzIGNvcnJ1cHRlZCAqLwo+ICAJRklfTU1BUF9GSUxFLAkJLyogaW5k
aWNhdGUgZmlsZSB3YXMgbW1hcHBlZCAqLwo+IEBAIC0zNjI3LDEyICszNjI2LDYgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGNsZWFyX2lub2RlX2ZsYWcoc3RydWN0IGlub2RlICppbm9kZSwgaW50IGZs
YWcpCj4gIAlfX21hcmtfaW5vZGVfZGlydHlfZmxhZyhpbm9kZSwgZmxhZywgZmFsc2UpOwo+ICB9
Cj4gIAo+IC1zdGF0aWMgaW5saW5lIGJvb2wgZjJmc192ZXJpdHlfaW5fcHJvZ3Jlc3Moc3RydWN0
IGlub2RlICppbm9kZSkKPiAtewo+IC0JcmV0dXJuIElTX0VOQUJMRUQoQ09ORklHX0ZTX1ZFUklU
WSkgJiYKPiAtCSAgICAgICBpc19pbm9kZV9mbGFnX3NldChpbm9kZSwgRklfVkVSSVRZX0lOX1BS
T0dSRVNTKTsKPiAtfQoKW1NldmVyaXR5OiBMb3ddCkFzIHJlcG9ydGVkIGJ5IFNhc2hpa28gb24g
djEgWzFdLCBkb2VzIHJlbW92aW5nIGYyZnNfdmVyaXR5X2luX3Byb2dyZXNzKCkKYnJlYWsgdGhl
IGJ1aWxkIGluIGZzL2YyZnMvZGF0YS5jIHdoZW4gQ09ORklHX0YyRlNfRlMgaXMgZW5hYmxlZD8K
ClR3byBjYWxsZXJzIGluIHRoZSBsYXJnZS1mb2xpbyB3cml0ZSBwYXRocyBpbiBmcy9mMmZzL2Rh
dGEuYyBzdGlsbCBjYWxsCmYyZnNfdmVyaXR5X2luX3Byb2dyZXNzKGlub2RlKToKCmZzL2YyZnMv
ZGF0YS5jOmYyZnNfd3JpdGVfY2FjaGVfZm9saW9zKCkgewoJLi4uCnJldHJ5OgoJCXBvcyA9IGZv
bGlvX3Bvcyhmb2xpbyk7CgkJZW5kX3BvcyA9IHBvcyArIGZvbGlvX3NpemUoZm9saW8pOwoJCWlz
aXplID0gaV9zaXplX3JlYWQoaW5vZGUpOwoJCXZlcml0eV9pbl9wcm9ncmVzcyA9IGYyZnNfdmVy
aXR5X2luX3Byb2dyZXNzKGlub2RlKTsKCQlwb2ZmID0gMDsKCS4uLgp9CgphbmQ6Cgpmcy9mMmZz
L2RhdGEuYzpwcmVwYXJlX2xhcmdlX2ZvbGlvX3dyaXRlX2JlZ2luKCkgewoJLi4uCglpZiAoIWYy
ZnNfdmVyaXR5X2luX3Byb2dyZXNzKGlub2RlKSAmJgoJICAgICEocG9zICYgKFBBR0VfU0laRSAt
IDEpKSAmJiAocG9zICsgbGVuKSA+PSBpX3NpemVfcmVhZChpbm9kZSkpIHsKCS4uLgp9CgpTaG91
bGQgdGhlc2UgdHdvIGNhbGxlcnMgYWxzbyBiZSB1cGRhdGVkIHRvIHVzZSBmc3Zlcml0eV9pc19i
dWlsZGluZyhpbm9kZSk/CgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9zYXNoaWtvLW91
dGJveC0xOTc5OTFAa2VybmVsLm9yZwoKLS0gClNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8v
c2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTEwNTExNTUzMi42MTM0NjctMS1hYWxiZXJzaEBr
ZXJuZWwub3JnP3BhcnQ9NQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
