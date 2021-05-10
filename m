Return-Path: <SRS0=s44c=KF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14354C43470
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 May 2021 10:27:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA9B61466
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 May 2021 10:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA9B61466
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lg38c-0001mS-Hj; Mon, 10 May 2021 10:27:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mchehab@kernel.org>) id 1lg38Y-0001li-Lz
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 May 2021 10:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/oyIBs9N8cmY76b5zMYcbqKOfEUKwj8m4Nb9lyJMFwY=; b=JyGr448GN5jF5UILnfTCNOeUkW
 Ibf9OdE8rDBdsclT7IF68SILSwp100lgJrDeTDN40lJ7M2l7cQWkMjvJwtJVpKbOMGX7SDOlpMBl6
 3JblbHzMGrLmI2Wp159OlHycPpoAFFIKveqPyVeDSZ92KMIg32cBEHt22QkGD1OPMsCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/oyIBs9N8cmY76b5zMYcbqKOfEUKwj8m4Nb9lyJMFwY=; b=CgDspgWdtE4lxyo01k/REs4AIf
 9d/XUNYKXRKF/412bGy1pudGeH7aNyEZVVxZ2rz/BlEo9FrGA98Vc7hYeJXo+OTCX4gzUzp1fOLZx
 rhyWANt+9Ska4rQDmtyL76T7rmj/tPRG+AXbX3pNGAARe+lZlx9OilWep/6woXs+hr74=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lg38M-001HFp-9R
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 May 2021 10:27:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC2B06191B;
 Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620642443;
 bh=WcxroFtZr1e4TuhJOkqTwxZysaSMNSQlGqNc1/W2LME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jmMpoOyXSxvXbiW3NVOz1xmsf1qch4xwOmpAguGmc27zObBw38SeK7WTtEYkRRZHe
 2MOrlea5r5x0A3Kq7ldqwysWZeKM06pnuiBYGapDOh4V1HwieIaAYFRrxt0B3R+m8i
 R8kk5EVYwiIOfwhX0K2x7iZy9zo4qm5cSzSv8XpGrx6jSpPBrAPeHY2U94VUBsXVl9
 dksEUtUtnJO0s/19xoHxoeohsOUvkaeGi978YATNugJ0UQPVEm0LYBbAN8nuSOjEQ8
 n5frd91cfh00vxTFsxyhHQ4tbg09vL+8vlx3adfNIZYgKyHtsC//d9N7qWKwArbGFi
 4ChdyfHm+5cuQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1lg38D-000UQ4-Kp; Mon, 10 May 2021 12:27:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Date: Mon, 10 May 2021 12:26:39 +0200
Message-Id: <c320db751bc326efbd1d619c0f8007d9965a32ab.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1lg38M-001HFp-9R
Subject: [f2fs-dev] [PATCH 27/53] docs: filesystems: f2fs.rst: avoid using
 UTF-8 chars
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

V2hpbGUgVVRGLTggY2hhcmFjdGVycyBjYW4gYmUgdXNlZCBhdCB0aGUgTGludXggZG9jdW1lbnRh
dGlvbiwKdGhlIGJlc3QgaXMgdG8gdXNlIHRoZW0gb25seSB3aGVuIEFTQ0lJIGRvZXNuJ3Qgb2Zm
ZXIgYSBnb29kIHJlcGxhY2VtZW50LgpTbywgcmVwbGFjZSB0aGUgb2NjdXJlbmNlcyBvZiB0aGUg
Zm9sbG93aW5nIFVURi04IGNoYXJhY3RlcnM6CgoJLSBVKzIwMTMgKCfigJMnKTogRU4gREFTSAoJ
LSBVKzIwMWMgKCfigJwnKTogTEVGVCBET1VCTEUgUVVPVEFUSU9OIE1BUksKCS0gVSsyMDFkICgn
4oCdJyk6IFJJR0hUIERPVUJMRSBRVU9UQVRJT04gTUFSSwoKU2lnbmVkLW9mZi1ieTogTWF1cm8g
Q2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPgotLS0KIERvY3VtZW50
YXRpb24vZmlsZXN5c3RlbXMvZjJmcy5yc3QgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2ZpbGVzeXN0ZW1zL2YyZnMucnN0IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9mMmZzLnJz
dAppbmRleCA5OTJiZjkxZWVlYzguLjE5ZDJjZjQ3N2ZjMyAxMDA2NDQKLS0tIGEvRG9jdW1lbnRh
dGlvbi9maWxlc3lzdGVtcy9mMmZzLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1z
L2YyZnMucnN0CkBAIC00Miw3ICs0Miw3IEBAIGFyZWFzIG9uIGRpc2sgZm9yIGZhc3Qgd3JpdGlu
Zywgd2UgZGl2aWRlICB0aGUgbG9nIGludG8gc2VnbWVudHMgYW5kIHVzZSBhCiBzZWdtZW50IGNs
ZWFuZXIgdG8gY29tcHJlc3MgdGhlIGxpdmUgaW5mb3JtYXRpb24gZnJvbSBoZWF2aWx5IGZyYWdt
ZW50ZWQKIHNlZ21lbnRzLiIgZnJvbSBSb3NlbmJsdW0sIE0uIGFuZCBPdXN0ZXJob3V0LCBKLiBL
LiwgMTk5MiwgIlRoZSBkZXNpZ24gYW5kCiBpbXBsZW1lbnRhdGlvbiBvZiBhIGxvZy1zdHJ1Y3R1
cmVkIGZpbGUgc3lzdGVtIiwgQUNNIFRyYW5zLiBDb21wdXRlciBTeXN0ZW1zCi0xMCwgMSwgMjbi
gJM1Mi4KKzEwLCAxLCAyNi01Mi4KIAogV2FuZGVyaW5nIFRyZWUgUHJvYmxlbQogLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpAQCAtODYsOCArODYsOCBAQCBGbGFzaCBBd2FyZW5lc3MKIAogV2FuZGVy
aW5nIFRyZWUgUHJvYmxlbQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotLSBVc2UgYSB0ZXJtLCDi
gJxub2Rl4oCdLCB0aGF0IHJlcHJlc2VudHMgaW5vZGVzIGFzIHdlbGwgYXMgdmFyaW91cyBwb2lu
dGVyIGJsb2NrcwotLSBJbnRyb2R1Y2UgTm9kZSBBZGRyZXNzIFRhYmxlIChOQVQpIGNvbnRhaW5p
bmcgdGhlIGxvY2F0aW9ucyBvZiBhbGwgdGhlIOKAnG5vZGXigJ0KKy0gVXNlIGEgdGVybSwgIm5v
ZGUiLCB0aGF0IHJlcHJlc2VudHMgaW5vZGVzIGFzIHdlbGwgYXMgdmFyaW91cyBwb2ludGVyIGJs
b2NrcworLSBJbnRyb2R1Y2UgTm9kZSBBZGRyZXNzIFRhYmxlIChOQVQpIGNvbnRhaW5pbmcgdGhl
IGxvY2F0aW9ucyBvZiBhbGwgdGhlICJub2RlIgogICBibG9ja3M7IHRoaXMgd2lsbCBjdXQgb2Zm
IHRoZSB1cGRhdGUgcHJvcGFnYXRpb24uCiAKIENsZWFuaW5nIE92ZXJoZWFkCi0tIAoyLjMwLjIK
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
