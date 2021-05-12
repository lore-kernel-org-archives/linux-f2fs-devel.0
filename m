Return-Path: <SRS0=WM5+=KH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD694C4363C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 May 2021 12:52:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A9A61139
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 May 2021 12:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9A61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lgoLH-0000dS-9T; Wed, 12 May 2021 12:51:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <mchehab@kernel.org>) id 1lgoL9-0000d5-Hq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 May 2021 12:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BxVouT/FQirjdWqbc1p/JoJbJ6eeT1pp21WfHotnz5o=; b=Ane0SDWKzlUGGR/kWEbLDQoPey
 a9ezIz4EQueoUK/AHvgZBTnsZ9Wsld6oFnt+knp8LXt50CCmlTEjEB9pcMx9r0bgZjURe0SLCw3GI
 dz/g0G/AG42mwyZzN3VmzugBOJ4jDeq/BVUrGjKKTri6r1sxRECw4jIXTkIT7HXXeoTw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BxVouT/FQirjdWqbc1p/JoJbJ6eeT1pp21WfHotnz5o=; b=cSbBMfseJvXRT0eqixNRU1+jBm
 nmC9AR5YbDkmMmnRJX2mXYB/9WvFriUuaQhPy3Lm/cJGFsnN811P2GTMc0Re5/S8ThzeVwiLeQhvd
 FsooAAyoAvfKEG4ZN1651uyRl2mbIC9DvEoXE7PKtoEKQWaa36E+rZeWFTSqHJ8ySfuk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lgoL5-0006bD-UM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 May 2021 12:51:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF70A6143C;
 Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620823902;
 bh=tgsrpZJ6N5rETloYOqMrjBzRY130AS2XXGVAZv8/Jvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KV+dVnVDnD3G1y0R+h/Mzw61N5k1bmqkUdAMA1duPn/9iPtAmmd2EIqoLmmV+7njT
 d+jGTmcV5F9kCXU1TviCtYQabgr+LAyaKeqaI35M/e1qJgMbscwLOQxZsycjLF1/fV
 FYmntF/Nx17TSf6kx4tuI8Iui7iPOBPdKjltmp+HcwBNewpXuNjT39nONfRJ/GSBLL
 aDh76zAA47XQOtQgeOhdy3uogMWrpW9oM/1l4F5V80X9NwJF1dF8UaxIDHYI5EuQ9S
 MNdcuGKvdvUlrmDUC25aPSjlcaRLW5OCqrgcuWe9hj5aYSJCa1DSVJ/RNWp7gd4vQm
 nLLcQ8BLOUcRQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1lgoKy-0018hx-QS; Wed, 12 May 2021 14:51:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Date: Wed, 12 May 2021 14:50:22 +0200
Message-Id: <a649acf2e85c739b9c26338c2f96cf9eacbdb1d6.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1lgoL5-0006bD-UM
Subject: [f2fs-dev] [PATCH v2 18/40] docs: filesystems: f2fs.rst: Use ASCII
 subset instead of UTF-8 alternate symbols
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

VGhlIGNvbnZlcnNpb24gdG9vbHMgdXNlZCBkdXJpbmcgRG9jQm9vay9MYVRlWC9NYXJrZG93bi0+
UmVTVCBjb252ZXJzaW9uCmFuZCBzb21lIGF1dG9tYXRpYyBydWxlcyB3aGljaCBleGlzdHMgb24g
Y2VydGFpbiB0ZXh0IGVkaXRvcnMgbGlrZQpMaWJyZU9mZmljZSB0dXJuZWQgQVNDSUkgY2hhcmFj
dGVycyBpbnRvIHNvbWUgVVRGLTggYWx0ZXJuYXRpdmVzIHRoYXQKYXJlIGJldHRlciBkaXNwbGF5
ZWQgb24gaHRtbCBhbmQgUERGLgoKV2hpbGUgaXQgaXMgT0sgdG8gdXNlIFVURi04IGNoYXJhY3Rl
cnMgaW4gTGludXgsIGl0IGlzIGJldHRlciB0bwp1c2UgdGhlIEFTQ0lJIHN1YnNldCBpbnN0ZWFk
IG9mIHVzaW5nIGFuIFVURi04IGVxdWl2YWxlbnQgY2hhcmFjdGVyCmFzIGl0IG1ha2VzIGxpZmUg
ZWFzaWVyIGZvciB0b29scyBsaWtlIGdyZXAsIGFuZCBhcmUgZWFzaWVyIHRvIGVkaXQKd2l0aCB0
aGUgc29tZSBjb21tb25seSB1c2VkIHRleHQvc291cmNlIGNvZGUgZWRpdG9ycy4KCkFsc28sIFNw
aGlueCBhbHJlYWR5IGRvIHN1Y2ggY29udmVyc2lvbiBhdXRvbWF0aWNhbGx5IG91dHNpZGUgbGl0
ZXJhbCBibG9ja3M6CiAgIGh0dHBzOi8vZG9jdXRpbHMuc291cmNlZm9yZ2UuaW8vZG9jcy91c2Vy
L3NtYXJ0cXVvdGVzLmh0bWwKClNvLCByZXBsYWNlIHRoZSBvY2N1cmVuY2VzIG9mIHRoZSBmb2xs
b3dpbmcgVVRGLTggY2hhcmFjdGVyczoKCgktIFUrMjAxYyAoJ+KAnCcpOiBMRUZUIERPVUJMRSBR
VU9UQVRJT04gTUFSSwoJLSBVKzIwMWQgKCfigJ0nKTogUklHSFQgRE9VQkxFIFFVT1RBVElPTiBN
QVJLCgpSZXZpZXdlZC1ieTogQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPgpTaWduZWQtb2Zm
LWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+Ci0t
LQogRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9mMmZzLnJzdCB8IDQgKystLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2YyZnMucnN0IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVt
cy9mMmZzLnJzdAppbmRleCA5OTJiZjkxZWVlYzguLmYwYWU0OWE3NjA2YiAxMDA2NDQKLS0tIGEv
RG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9mMmZzLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL2Zp
bGVzeXN0ZW1zL2YyZnMucnN0CkBAIC04Niw4ICs4Niw4IEBAIEZsYXNoIEF3YXJlbmVzcwogCiBX
YW5kZXJpbmcgVHJlZSBQcm9ibGVtCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi0tIFVzZSBhIHRl
cm0sIOKAnG5vZGXigJ0sIHRoYXQgcmVwcmVzZW50cyBpbm9kZXMgYXMgd2VsbCBhcyB2YXJpb3Vz
IHBvaW50ZXIgYmxvY2tzCi0tIEludHJvZHVjZSBOb2RlIEFkZHJlc3MgVGFibGUgKE5BVCkgY29u
dGFpbmluZyB0aGUgbG9jYXRpb25zIG9mIGFsbCB0aGUg4oCcbm9kZeKAnQorLSBVc2UgYSB0ZXJt
LCAibm9kZSIsIHRoYXQgcmVwcmVzZW50cyBpbm9kZXMgYXMgd2VsbCBhcyB2YXJpb3VzIHBvaW50
ZXIgYmxvY2tzCistIEludHJvZHVjZSBOb2RlIEFkZHJlc3MgVGFibGUgKE5BVCkgY29udGFpbmlu
ZyB0aGUgbG9jYXRpb25zIG9mIGFsbCB0aGUgIm5vZGUiCiAgIGJsb2NrczsgdGhpcyB3aWxsIGN1
dCBvZmYgdGhlIHVwZGF0ZSBwcm9wYWdhdGlvbi4KIAogQ2xlYW5pbmcgT3ZlcmhlYWQKLS0gCjIu
MzAuMgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
