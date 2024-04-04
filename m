Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76F0CD1288
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:53:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rsT9C-0001EW-V6;
	Thu, 04 Apr 2024 19:53:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rsT9A-0001E6-DG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Apr 2024 19:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y91C08Mc6Rlym0gl9NzU95QfKkuIxf+2dktRYRPE2ZE=; b=jLkQiOsoIgkMBmJwWv8Ukpmwlm
 QDcGtwUKwvYHvFDJt107DkovsdASbXK0TuxZFpzbzCsUx+eWcz33MmcrfUaKoBKjcnFK5IWxwKDni
 hEhMjf1TpOUxa32VJP3mXDz33Bn2YycV/BQXI8zExRCtXQoWkyqTtFSbnEr5IjMV7soc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y91C08Mc6Rlym0gl9NzU95QfKkuIxf+2dktRYRPE2ZE=; b=a
 rYU+ZyPMN7dIXeBqk6It5GYArI+cFn1cKWGM8Lj24Q7xbmrkomqnrqaFA3jkdejRB5EA+h/vGVS6b
 gmJgCLzk4XjcI5ufr4bsJ0CLOtXPTRLhu2cPLlvD/GAZ4fIa3VXvK9sTY3NKH0gDsA6qj2C8+SE1x
 kzOTk67JlpxU0nPs=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rsT96-0003qa-8a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Apr 2024 19:53:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4C65BCE346E;
 Thu,  4 Apr 2024 19:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78796C43390;
 Thu,  4 Apr 2024 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712260379;
 bh=ieg3chWZv+yjKObSx+3pR+vukItMhYCKSo8GVacn5UQ=;
 h=From:To:Cc:Subject:Date:From;
 b=sBVqG7gizLXMXmHsu/0hQ7s1fzGrQCPlyq+YBxYYu8hqF/k9B2fd1V8gu39r52jj9
 zULIHj0khYLtaVIZc2wjgOuDKJMFbaMpaYTxplMkh215mWwHdnkNA7SXjvqphMdJpP
 3/P93Z2MZc8lY+8zNrINgnXr70YuVkPC1jdlYuyyElqdLXCttoUHxJzTdLAKthXU+V
 +lZsDY/lEgUBGvA+xDzQwWFBfhSwLDoIxRKh37x82QKqRjilOEEPo6Wkwvl16Z+Y2/
 cTMuuk6wM2v1r7vb95eiIzypYs+vCyqplg3vkFxBIg612uWn+AOK62qM00lw97j+vE
 uKJFzRlYpzCVA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  4 Apr 2024 19:52:54 +0000
Message-ID: <20240404195254.556896-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
MIME-Version: 1.0
X-Headers-End: 1rsT96-0003qa-8a
Subject: [f2fs-dev] [PATCH] f2fs: don't set RO when shutting down f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 =?UTF-8?q?Light=20Hsieh=20=28=E8=AC=9D=E6=98=8E=E7=87=88=29?=
 <Light.Hsieh@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

U2h1dGRvd24gZG9lcyBub3QgY2hlY2sgdGhlIGVycm9yIG9mIHRoYXdfc3VwZXIgZHVlIHRvIHJl
YWRvbmx5LCB3aGljaApjYXVzZXMgYSBkZWFkbG9jayBsaWtlIGJlbG93LgoKZjJmc19pb2Nfc2h1
dGRvd24oRjJGU19HT0lOR19ET1dOX0ZVTExTWU5DKSAgICAgICAgaXNzdWVfZGlzY2FyZF90aHJl
YWQKIC0gYmRldl9mcmVlemUKICAtIGZyZWV6ZV9zdXBlcgogLSBmMmZzX3N0b3BfY2hlY2twb2lu
dCgpCiAgLSBmMmZzX2hhbmRsZV9jcml0aWNhbF9lcnJvciAgICAgICAgICAgICAgICAgICAgIC0g
c2Jfc3RhcnRfd3JpdGUKICAgIC0gc2V0IFJPICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtIHdhaXRpbmcKIC0gYmRldl90aGF3CiAgLSB0aGF3X3N1cGVyX2xvY2tlZAog
ICAgLSByZXR1cm4gLUVJTlZBTCwgaWYgc2JfcmRvbmx5KCkKIC0gZjJmc19zdG9wX2Rpc2NhcmRf
dGhyZWFkCiAgLT4gd2FpdCBmb3Iga3RocmVhZF9zdG9wKGRpc2NhcmRfdGhyZWFkKTsKClJlcG9y
dGVkLWJ5OiAiTGlnaHQgSHNpZWggKOisneaYjueHiCkiIDxMaWdodC5Ic2llaEBtZWRpYXRlay5j
b20+ClNpZ25lZC1vZmYtYnk6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Ci0tLQog
ZnMvZjJmcy9zdXBlci5jIHwgMTEgKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zdXBlci5jIGIv
ZnMvZjJmcy9zdXBlci5jCmluZGV4IGRmOTc2NWI0MWRhYy4uYmE2Mjg4ZTg3MGM1IDEwMDY0NAot
LS0gYS9mcy9mMmZzL3N1cGVyLmMKKysrIGIvZnMvZjJmcy9zdXBlci5jCkBAIC00MTM1LDkgKzQx
MzUsMTYgQEAgdm9pZCBmMmZzX2hhbmRsZV9jcml0aWNhbF9lcnJvcihzdHJ1Y3QgZjJmc19zYl9p
bmZvICpzYmksIHVuc2lnbmVkIGNoYXIgcmVhc29uLAogCWlmIChzaHV0ZG93bikKIAkJc2V0X3Ni
aV9mbGFnKHNiaSwgU0JJX0lTX1NIVVRET1dOKTsKIAotCS8qIGNvbnRpbnVlIGZpbGVzeXN0ZW0g
b3BlcmF0b3JzIGlmIGVycm9ycz1jb250aW51ZSAqLwotCWlmIChjb250aW51ZV9mcyB8fCBmMmZz
X3JlYWRvbmx5KHNiKSkKKwkvKgorCSAqIENvbnRpbnVlIGZpbGVzeXN0ZW0gb3BlcmF0b3JzIGlm
IGVycm9ycz1jb250aW51ZS4gU2hvdWxkIG5vdCBzZXQKKwkgKiBSTyBieSBzaHV0ZG93biwgc2lu
Y2UgUk8gYnlwYXNzZXMgdGhhd19zdXBlciB3aGljaCBjYW4gaGFuZyB0aGUKKwkgKiBzeXN0ZW0u
CisJICovCisJaWYgKGNvbnRpbnVlX2ZzIHx8IGYyZnNfcmVhZG9ubHkoc2IpIHx8CisJCQkJcmVh
c29uID09IFNUT1BfQ1BfUkVBU09OX1NIVVRET1dOKSB7CisJCWYyZnNfd2FybihzYmksICJTdG9w
cGVkIGZpbGVzeXN0ZW0gZHVlIHRvIHJlYWRvbjogJWQiLCByZWFzb24pOwogCQlyZXR1cm47CisJ
fQogCiAJZjJmc193YXJuKHNiaSwgIlJlbW91bnRpbmcgZmlsZXN5c3RlbSByZWFkLW9ubHkiKTsK
IAkvKgotLSAKMi40NC4wLjQ3OC5nZDkyNjM5OWVmOS1nb29nCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
