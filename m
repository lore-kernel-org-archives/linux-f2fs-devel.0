Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AC9C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-Id:MIME-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vEnEcJluwsKreAKQdg9SrKOnAH/LMkePL+9H790hEOI=; b=MuX2GP3oTzWlmXGIoSUwZiY1Zz
	u0tHkkzlNNpzQeEukxLsi6OpUnMpxemyRx2SaE3qFBxf3PBWQ/+qNaVniVJjkk65psQP1C7B4v8Rl
	wprOfXxbUX5YlUY/Q3ssMuGr9c18DQwkEXDkrRFE4C7Smg/tE8CEZGYgRYjQB1wJU5vs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3Xdl-0002Uj-54;
	Mon, 07 Sep 2026 11:35:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <devnull+jiucheng.xu.amlogic.com@kernel.org>)
 id 1x3Xdk-0002Tk-94 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding
 :Content-Type:MIME-Version:Subject:Date:From:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7sSDCoB91ASna/05eZgMSogQ6UNADOSaP/oUmNw2ANI=; b=Pa2U19xdXEMsCSCQC7I8LJ70hl
 2jwWB8hwDzTDW9bsrDRcIYUho0NdvA1EbtUq4tneinGH4hEcNjwA9TE/KZSBl2H/mCJ07rrW23aYp
 2a0RuuCKHaIMH36gsdW5S8R4r8IAqOcuUMzKNTRTjQLJhLtqkH2GzsMNyn2kgBNWcPko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7sSDCoB91ASna/05eZgMSogQ6UNADOSaP/oUmNw2ANI=; b=VHJxQVXY4bstwz6RODgrF9zCJ/
 O0avX5nFtQRV7Af3n/nxloFy+mhyV8mQ/MJUmbdNTk+TD4Whb5qEr0ZvvlpGYTySEoub0Ts64/2O5
 67whHqadr1a0a5NG/bMxigY6QJu29wAEsXENasWwx9hTCYJZHcoupag5kppXqY150xOs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3Xdg-0006zB-IA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:35:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 280E940978;
 Mon,  7 Sep 2026 11:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00246C2BCC7;
 Mon,  7 Sep 2026 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788780947;
 bh=tStPoEn07LYFbvgkThuMKLxe/CTLKb5WMfGxLDYBQB4=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Bdh6ZQIamQ0q9W+LnEf0nPfBNrFSfLM9oZX3CXfd9NglLonCbQfHrw3uudK5kxf0o
 f5Cvf3E/Uu/JLD9hjPSW3IxUmHHEmjiz370bzCoPHipknCi+2kc7T8NepQL1Jh7YAn
 EPcGE3ApCuPBSE1As37Dv8onH8MO8wPRQhYUoBctnXPt7KoTn4LqVXisxR274fJ2d4
 CieERsibq4wH0DnHXY0+x7uL6hVEcJ8m+WIfBocT+ov/jijumfdflUNsfZpU0Ch1TA
 3rdBRJnW21S9HrzIJXN2AomNpP/p1Ha9JFMLcpblv1DyHAY8P+jZKsWc+gJe0Ez5Z4
 BpnO32p1NlsDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CEED5C79F9E;
 Mon,  7 Sep 2026 11:35:46 +0000 (UTC)
Date: Mon, 07 Sep 2026 19:35:42 +0800
MIME-Version: 1.0
Message-Id: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAI2hnmoC/03MQQrCMBCF4auUWRvJjBqDq95DugjpmA7YRhIJS
 sndjcWFy//B+1bInIQzXLoVEhfJEpcWuOvAT24JrGRsDaTJaItWxSRBFjVyUZqtNwcmPJ4ctMM
 j8U1eG3YdWk+SnzG9N7vgd/0xZP6ZggqVJ6QzOkuode/mewzi9z7OMNRaP6PQm9qmAAAA
X-Change-ID: 20260818-origin-dev-0e8c63e2145a
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788780945; l=2497;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=YNrmwUC6hZBgGF3yjLDcDf3MEef/HpM3lXoE8cXM+oc=;
 b=2QKUyokgLLcsjxunR6k7wQ0huDmzz9QlttyBun5ZhJCS8hhFtf0fT5/2MtvQZv6XkjvH1SZt1
 xqgZwn86I2+BJAHh+YZhlRgzQj05jHztIJ+/JhOUkSZjkvKltWETVXa
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Headers-End: 1x3Xdg-0006zB-IA
Subject: [f2fs-dev] [PATCH] f2fs: force out-place update for all writes on
 compressed file
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
From: Jiucheng Xu via B4 Relay via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: jiucheng.xu@amlogic.com
Cc: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>,
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 tao.zeng@amlogic.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RnJvbTogSml1Y2hlbmcgWHUgPGppdWNoZW5nLnh1QGFtbG9naWMuY29tPgoKRm9yIGNvbXByZXNz
ZWQgZmlsZSwgY29tcHJlc3NlZCB3cml0ZSBtYXkgZmFpbCBhbmQgZmFsbCBiYWNrIHRvIHJhdwp3
cml0ZS4KCi1UaHJlYWQgQSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LSBUaHJlYWQgQgogIC0gZjJmc193cml0ZV9tdWx0aV9wYWdlcyAgICAgICAgICAgICAgICAgICAg
ICAgICAgLSBmMmZzX2Rvd25fd3JpdGUoJnNiaS0+Y3BfcndzZW0pOwogICAtIGYyZnNfd3JpdGVf
Y29tcHJlc3NlZF9wYWdlcyAgICAgICAgICAgICAgICAgICAgLSAuLi4KICAgIC0gZjJmc190cnls
b2NrX29wICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gLi4uCiAgICAgLSBmMmZzX2Rv
d25fcmVhZF90cnlsb2NrKCZzYmktPmNwX3J3c2VtKTsgICAgICAtIC4uLgogICAtIGYyZnNfd3Jp
dGVfcmF3X3BhZ2VzICAgICAgICAgICAgICAgICAgICAgICAgICAgLSAuLi4KClRocmVhZCBCIGFj
cXVpcmVzIHRoZSBsb2NrIGZpcnN0LCB3aGljaCBjYXVzZXMgVGhyZWFkIEEgdG8gZmFpbCBsb2Nr
CmFjcXVpc2l0aW9uIGFuZCBmYWxsIGJhY2sgdG8gcmF3LWRhdGEgd3JpdGUuCklQVV9GT1JDRSBp
cyBlbmFibGVkIG9uIHNtYWxsLWNhcGFjaXR5IHN0b3JhZ2UgZGV2aWNlcyAoPCAxNkdCKSwKc28g
ZjJmc193cml0ZV9yYXdfcGFnZXMoKSBvdmVyd3JpdGVzIHRoZSBvcmlnaW5hbCBjb21wcmVzc2Vk
IGRhdGEKaW4tcGxhY2UuCgpUaGUgaW4tbWVtb3J5IG5vZGUgaGFzIGJlZW4gdXBkYXRlZCB3aXRo
IHJhdy1kYXRhIGFkZHJlc3Nlcywgd2hpbGUgdGhlCm5vZGUgbWV0YWRhdGEgc3RvcmVkIG9uIGVN
TUMgc3RpbGwgcmVtYWlucyBpbiBjb21wcmVzc2VkIHN0YXRlLgpJZiBhIHBvd2VyLWN1dCBvY2N1
cnMgYmVmb3JlIHRoZSBub2RlIGlzIGZsdXNoZWQgdG8gZGlzaywgb24tZGlzawppbmNvbnNpc3Rl
bmN5IGFyaXNlczogZGlzayBkYXRhIGlzIHJhdywgeWV0IG1ldGFkYXRhIHRyZWF0cyBpdCBhcyBh
CmNvbXByZXNzZWQgY2x1c3RlciwgbGVhZGluZyB0byBkZWNvbXByZXNzaW9uIGZhaWx1cmUuCgpU
byBlbGltaW5hdGUgdGhpcyByaXNrIGNvbXBsZXRlbHksIGZvcmNlIG91dC1wbGFjZSB1cGRhdGUg
Zm9yIGFsbAp3cml0ZSBvcGVyYXRpb25zIG9uIGNvbXByZXNzZWQgZmlsZS4KClNpZ25lZC1vZmYt
Ynk6IEppdWNoZW5nIFh1IDxqaXVjaGVuZy54dUBhbWxvZ2ljLmNvbT4KLS0tCi0gTGluayB0byB2
MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDgyNi1vcmlnaW4tZGV2LXYxLTEtYzIx
MjcxYTgyMTAwQGFtbG9naWMuY29tCi0tLQogZnMvZjJmcy9kYXRhLmMgfCAxMCArKysrKystLS0t
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKaW5kZXggNmFlMGViMzdkMjBm
OTZlZDUxYTgxMjRmNTliYTkwZGFiZjYzMmZiNS4uYWFlZWE1NjFkY2QzMDY4MWI5YjM3ZjJmNmYw
NDkzZWQ1OGVjMmZlMCAxMDA2NDQKLS0tIGEvZnMvZjJmcy9kYXRhLmMKKysrIGIvZnMvZjJmcy9k
YXRhLmMKQEAgLTI5NzMsMTAgKzI5NzMsMTIgQEAgYm9vbCBmMmZzX3Nob3VsZF91cGRhdGVfb3V0
cGxhY2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGYyZnNfaW9faW5mbyAqZmlvKQogCQly
ZXR1cm4gdHJ1ZTsKIAlpZiAoZjJmc191c2VkX2luX2F0b21pY193cml0ZShpbm9kZSkpCiAJCXJl
dHVybiB0cnVlOwotCS8qIHJld3JpdGUgbG93IHJhdGlvIGNvbXByZXNzIGRhdGEgdy8gT1BVIG1v
ZGUgdG8gYXZvaWQgZnJhZ21lbnRhdGlvbiAqLwotCWlmIChmMmZzX2NvbXByZXNzZWRfZmlsZShp
bm9kZSkgJiYKLQkJRjJGU19PUFRJT04oc2JpKS5jb21wcmVzc19tb2RlID09IENPTVBSX01PREVf
VVNFUiAmJgotCQlpc19pbm9kZV9mbGFnX3NldChpbm9kZSwgRklfRU5BQkxFX0NPTVBSRVNTKSkK
KwkvKgorCSAqIHJld3JpdGUgbG93IHJhdGlvIGNvbXByZXNzIGRhdGEgdy8gT1BVIG1vZGUgdG8g
YXZvaWQgZnJhZ21lbnRhdGlvbi4KKwkgKiBJZiBJTyBjb21lcyBmcm9tIGNvbXByZXNzZWQgd3Jp
dGUgcGF0aCBhbmQgZmFsbGJhY2sgdG8gcmF3IHdyaXRlLAorCSAqIGZvcmNlIG91dOKAkXBsYWNl
IHRvIHByZXZlbnQgbWV0YWRhdGHigJFkYXRhIGluY29uc2lzdGVuY3kuCisJICovCisJaWYgKGYy
ZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSkKIAkJcmV0dXJuIHRydWU7CiAKIAkvKiBzd2FwIGZp
bGUgaXMgbWlncmF0aW5nIGluIGFsaWduZWQgd3JpdGUgbW9kZSAqLwoKLS0tCmJhc2UtY29tbWl0
OiAwYTE3MDNlYmEyMzcwN2UzYjJlZGZhMmEyMzI5MzUyZTdhYmMwZmZhCmNoYW5nZS1pZDogMjAy
NjA4MTgtb3JpZ2luLWRldi0wZThjNjNlMjE0NWEKCkJlc3QgcmVnYXJkcywKLS0gCkppdWNoZW5n
IFh1IDxqaXVjaGVuZy54dUBhbWxvZ2ljLmNvbT4KCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
