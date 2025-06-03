Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E49BC5AD49
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jun 2025 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QauEHluiGDZ+Leo5+AMMpIB4039ovkQjWsxL93hEWw4=; b=OnCwcBBEzQdx5BQ2iH9bz+dE0N
	gTNgXST6hrX5vCa9/zOhpS6WkS8zzICvNiVDaMWFAkyI2d8aN5Sjiz4RihzLDkY2tfOWKtEqXR4eC
	kJtc4wAHaXw9PSNVx7aHzCH2scOmUfbGwC3Px8eohrLpMlpSVp1+R+vDsRn5MXlecgLo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uMM2c-0006EF-13;
	Tue, 03 Jun 2025 07:26:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uMM2b-0006E6-4e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 07:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F7Om94twjWpjAqlpR3SUviQZDi6MHBHo8oOJqk7+fZ0=; b=Arhv/QyGU05d06GUnFc/FIXMoS
 wJ53TAj38uPzdKVnGJCQVVoS6pQUeRH8L79QlXLh38AMvfKAmz/g1cV+RoYLxpBEN/1i55oN507jz
 oDj5hfmJ0EuKNYLj2UhNJ0wx3clydk1RNCY/Y5/8flcumQfbCb2ByYGorO0u8xj2BiR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F7Om94twjWpjAqlpR3SUviQZDi6MHBHo8oOJqk7+fZ0=; b=i
 r+CeJXH28Ldk4ETsiWk7oi2HkAt6kx7EsqAu1/9yFQb8dqVKassE2836SXuOyOFmKYRVGG6OZM7zM
 X8osDyOzt0loPFeFCzFFRwDOuDNLoWUzpZDsmQ2CNRXkiB+ogqbXQFyFeSvMEa7IkNGNEjS94fxAV
 A4krdC89Eg8tpWuw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uMM2a-00032i-FY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 07:26:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F7FC444CE;
 Tue,  3 Jun 2025 07:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2848BC4CEED;
 Tue,  3 Jun 2025 07:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748935587;
 bh=G4ClVGpTdTYaeN7Bd8ys8x8zlLFlNlRePHdt96TJQb0=;
 h=From:To:Cc:Subject:Date:From;
 b=ObzGnpO0drCS5nRpSB9g3AacmGr8GgFzlCbG6IZHJjFXO6NCzLp/ftu2cWTGt/249
 srPlNvna9BmKZtjK2Lm6wGHOIDLncOCF8LkwbE0E0ncr4ZuRnIQ4/BPgJZ/ifGprCY
 29rQNCbjqDArnhqMCN8rzaPHVfwwzgQyqfGm+BT5x77v8PGFoJ4JfOeNQJTV0l8jgg
 zfbU9HXIIDXDTaOcbF2jjUgXni/nVL6kaMt3VwBiSl0bOti1AWwHYNme4CARolpm6S
 phmv7L2OC4qwFvjiMBru8mS5DaiJ0V3DwwfCmiBfiI3//EZpoc1C2N8iYWgKc4tRdh
 UCVfVFeVktm/A==
To: jaegeuk@kernel.org
Date: Tue,  3 Jun 2025 15:26:18 +0800
Message-Id: <20250603072618.16171-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1uMM2a-00032i-FY
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix to avoid using uninitialized
 buffer
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ZnNjay5jOiBJbiBmdW5jdGlvbiDigJhjaGtfYW5kX2ZpeF93cF93aXRoX3NpdOKAmToKZnNjay5j
OjM1Mjk6MTc6IGVycm9yOiB2YXJpYWJsZS1zaXplZCBvYmplY3QgbWF5IG5vdCBiZSBpbml0aWFs
aXplZAogMzUyOSB8ICAgICAgICAgICAgICAgICBjaGFyIGJ1ZmZlcltGMkZTX0JMS1NJWkVdID0g
e307CiAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn4KClRoZSByZWFzb24gaXMgRjJGU19CTEtT
SVpFIG1hY3JvIGlzIGRlZmluZWQgdy8gYy5ibGtzaXplLCBsZXQncyB1c2UKY2FsbG9jKCkgdG8g
YWxsb2NhdGUgemVyb2VkIG1lbW9yeSB0byBmaXggdGhpcyBpc3N1ZS4KCkNjOiBEYWVobyBKZW9u
ZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvQGtl
cm5lbC5vcmc+Ci0tLQogZnNjay9mc2NrLmMgfCA3ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mc2NrL2ZzY2suYyBi
L2ZzY2svZnNjay5jCmluZGV4IDRkMDVlMWIuLmJiMzlmOGIgMTAwNjQ0Ci0tLSBhL2ZzY2svZnNj
ay5jCisrKyBiL2ZzY2svZnNjay5jCkBAIC0zNTI2LDcgKzM1MjYsNyBAQCBzdGF0aWMgaW50IGNo
a19hbmRfZml4X3dwX3dpdGhfc2l0KGludCBVTlVTRUQoaSksIHZvaWQgKmJsa3pvbmUsIHZvaWQg
Km9wYXF1ZSkKIAogCXJldCA9IGYyZnNfZmluaXNoX3pvbmUod3BkLT5kZXZfaW5kZXgsIGJsa3op
OwogCWlmIChyZXQpIHsKLQkJdTggYnVmZmVyW0YyRlNfQkxLU0laRV0gPSB7fTsKKwkJdTggKmJ1
ZmZlcjsKIAkJdTY0IGJsa19hZGRyID0gd3BfYmxvY2s7CiAJCXU2NCBmaWxsX3NlY3RzID0gYmxr
X3pvbmVfbGVuZ3RoKGJsa3opIC0KIAkJCShibGtfem9uZV93cF9zZWN0b3IoYmxreikgLSBibGtf
em9uZV9zZWN0b3IoYmxreikpOwpAQCAtMzUzNCw2ICszNTM0LDkgQEAgc3RhdGljIGludCBjaGtf
YW5kX2ZpeF93cF93aXRoX3NpdChpbnQgVU5VU0VEKGkpLCB2b2lkICpibGt6b25lLCB2b2lkICpv
cGFxdWUpCiAJCXN0cnVjdCBzZWdfZW50cnkgKnNlID0gZ2V0X3NlZ19lbnRyeShzYmksIHdwX3Nl
Z25vKTsKIAkJZW51bSByd19oaW50IHdoaW50ID0gZjJmc19pb190eXBlX3RvX3J3X2hpbnQoc2Ut
PnR5cGUpOwogCisJCWJ1ZmZlciA9IGNhbGxvYyhGMkZTX0JMS1NJWkUsIDEpOworCQlBU1NFUlQo
YnVmZmVyKTsKKwogCQlwcmludGYoIltGU0NLXSBGaW5pc2hpbmcgem9uZSBmYWlsZWQ6ICVzXG4i
LCBkZXYtPnBhdGgpOwogCQl3aGlsZSAobGVuLS0pIHsKIAkJCXJldCA9IGRldl9maWxsX2Jsb2Nr
KGJ1ZmZlciwgYmxrX2FkZHIrKywgd2hpbnQpOwpAQCAtMzU0Miw2ICszNTQ1LDggQEAgc3RhdGlj
IGludCBjaGtfYW5kX2ZpeF93cF93aXRoX3NpdChpbnQgVU5VU0VEKGkpLCB2b2lkICpibGt6b25l
LCB2b2lkICpvcGFxdWUpCiAJCQkJYnJlYWs7CiAJCQl9CiAJCX0KKworCQlmcmVlKGJ1ZmZlcik7
CiAJfQogCiAJaWYgKCFyZXQpCi0tIAoyLjQwLjEKCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
