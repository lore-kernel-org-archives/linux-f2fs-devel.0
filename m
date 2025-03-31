Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131E3C28B20
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 03:01:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tz5Ov-0001sj-8h;
	Mon, 31 Mar 2025 03:01:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tz5Ou-0001sb-2Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 03:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZYrlbo+vfYkkzipUD2eKhjiwz//+dAu92IlxWbCbjG4=; b=RPig65JIu5mo+TpH5iN4vYkqNW
 zkQTbVmdqFBToS2ropDE13IoVmzgDDDznCozLl3gHsB40vV5MkfY217FRYALu4TYxzJ579/o3VQBh
 Acor5k0Aye/S1nXrZAwITXmFjl/co4ulGEJVSpOwRFA/+5G3nEX+bT5scPAzAiL0tPmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZYrlbo+vfYkkzipUD2eKhjiwz//+dAu92IlxWbCbjG4=; b=H
 79U44rGrJBC5km92aYftlifzc/oPG7zSRWCJ/C0h+bPFiimc1roL14w+Irw8hqUidEINlZA+sxtXo
 vEiShcn4yFeS340DutOD8i39xIHqB8yM7cKszykOF4iPjXvBOJunc25ZAsY1SHSWE4iIkVrX4S26l
 fN0YVFogKkHtScKg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tz5Or-0003Uu-PU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 03:01:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8632D61126
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Mar 2025 03:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B045FC4CEEB;
 Mon, 31 Mar 2025 03:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743390070;
 bh=zjlpH+7NAmZ7JYB+oJsb74be5aYCAZv12EOln1aGszE=;
 h=From:To:Cc:Subject:Date:From;
 b=UzjDIYW+R+/UwpiiM+zVBYYeizqTRZdQoKaurLOU9b/3+OhPoawQu1c0g7kDWMAYb
 205fbf4vR1jVnSsHE5GPXTK1279M7k5OZJl2+HXrafdjynFh3ddrpBzjCr3aiwhTxh
 Z8ArO5Y6FAXgUVd/lRbe5grY/3ugcZTkfldE2CzKcmQlxWXQ1yqozVcFDeg0n+FkS7
 n/7FXH6WaYd1rbcOG+oCN5T4kw8mjYNuyMkj6tV5C25YaOmO3tLqe/SKLTyOmOW7XC
 YaiSL1UR7+zmkFeetvQXRrKX1iaLtsFs0YJA6DDMywfHBb8qRiOd+Wb0SmCRLX2P5a
 JBl5nVXbVVFbQ==
To: jaegeuk@kernel.org
Date: Mon, 31 Mar 2025 11:00:32 +0800
Message-ID: <20250331030034.481423-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
MIME-Version: 1.0
X-Headers-End: 1tz5Or-0003Uu-PU
Subject: [f2fs-dev] [PATCH 1/3] dump.f2fs: support to dump hex of filename
 in dump_dirent()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ZHVtcC5mMmZzIC1iICRibGthZGRyIC1kIDMgL2Rldi92ZGEKCltkdW1wX2RpcmVudDogOTkxXSBi
aXRtYXAgcG9zWzB4Ml0gbmFtZVvinaTvuI9dIGxlblsweDZdIGhhc2hbMHgxOWRkNzEzMl0gaW5v
WzB4NV0gdHlwZVsweDFdCltkdW1wX2RpcmVudDogOTk4XSBuYW1lKGhleClbMHhlMiAweDlkIDB4
YTQgMHhlZiAweGI4IDB4OGYgMHgwXQoKU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJu
ZWwub3JnPgotLS0KIGZzY2svZHVtcC5jIHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnNjay9kdW1wLmMgYi9m
c2NrL2R1bXAuYwppbmRleCBkYzNjMTk5Li42NmQ2Yzc5IDEwMDY0NAotLS0gYS9mc2NrL2R1bXAu
YworKysgYi9mc2NrL2R1bXAuYwpAQCAtOTM3LDcgKzkzNyw3IEBAIHN0YXRpYyB2b2lkIGR1bXBf
ZGlyZW50KHUzMiBibGtfYWRkciwgaW50IGlzX2lubGluZSwgaW50IGVuY19uYW1lKQogewogCXN0
cnVjdCBmMmZzX2RlbnRyeV9wdHIgZDsKIAl2b2lkICppbmxpbmVfZGVudHJ5LCAqYmxrOwotCWlu
dCByZXQsIGkgPSAwOworCWludCByZXQsIGkgPSAwLCBqOwogCiAJYmxrID0gY2FsbG9jKEYyRlNf
QkxLU0laRSwgMSk7CiAJQVNTRVJUKGJsayk7CkBAIC05OTIsNiArOTkyLDExIEBAIHN0YXRpYyB2
b2lkIGR1bXBfZGlyZW50KHUzMiBibGtfYWRkciwgaW50IGlzX2lubGluZSwgaW50IGVuY19uYW1l
KQogCQkJCWxlMzJfdG9fY3B1KGRlLT5pbm8pLAogCQkJCWRlLT5maWxlX3R5cGUpOwogCisJCURC
RygxLCAiJXMiLCAibmFtZShoZXgpWyIpOworCQlmb3IgKGogPSAwOyBqIDwgRjJGU19OQU1FX0xF
TiAmJiBlbltqXTsgaisrKQorCQkJTVNHKDEsICIweCV4ICIsICh1bnNpZ25lZCBjaGFyKWVuW2pd
KTsKKwkJTVNHKDEsICIweCV4XVxuIiwgKHVuc2lnbmVkIGNoYXIpZW5bal0pOworCiAJCWkgKz0g
R0VUX0RFTlRSWV9TTE9UUyhuYW1lX2xlbik7CiAJfQogCi0tIAoyLjQ5LjAKCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
