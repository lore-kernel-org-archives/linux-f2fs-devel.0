Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25DBC021B8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:46:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tnD3b-0006Lf-Fk;
	Wed, 26 Feb 2025 08:46:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <adrian.liszka@novaplan.pl>) id 1tnD3Y-0006LV-5f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Feb 2025 08:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=M9qApcwgI8Z544VYvUS+/6IJsa
 LYZv8HkBZ42gG+KOeWUa/LKrIQk5jfZww6WZDRM/vgnROGmVz6P+3VNrTOS1dd9imW/jtAYU2KAot
 7wUQZLsWKO3N3fJ2jygSUDFEova/oMYdHQgrr3bwbxsV/yxgiPb+eGkKCQNbUvZo6sEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=Q
 epeC2iF3FtNY2sIJZ98haltAMejmfJloRfe6aflqGt4Me5j/BopjK3Jd6BVEERCUsO+1nUSMx07dU
 ap7kTjVvg4Ue/7qvxhvKs4JmPTWboWmvlFj19VAcapW7jXmvQjxK42Ux0Pps5Yiv0+weXeTl4BzZ7
 c1noNhbLV3wN7ynQ=;
Received: from mail.novaplan.pl ([51.195.118.1])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tnD3U-0004TW-8J for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Feb 2025 08:46:15 +0000
Received: by mail.novaplan.pl (Postfix, from userid 1002)
 id E3951A3F35; Wed, 26 Feb 2025 09:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novaplan.pl; s=mail;
 t=1740559560; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
 h=Date:From:To:Subject:From;
 b=jMxydtqNfVBTNXrHNzmDNWbqPv4dw0pLmb30Aj7wmwIVVl1hO4J0SNKs7ZkfsqBf4
 RdrnRoBalsL2vwEkVXmYLPGACoSi9OgHGoMjXSkVJ4Qn3bRcqsFt0CaYmKZ5cVg87d
 kVILcHPCRL6EEKsmG5ZPei3TEnkcrlkXgpwoGq2RvYaSXqhtjFR0QIczZme237B5v1
 9p0v5mt7aB00fYbvD7/SyCFqrpSvc433UHhUALqKS9FYe8/RgYxHWlaG+FK/CVad22
 q7Pmc5Qxyet9vaNG0+LN18JgDc5IXXKoqoOcQcfdE3ykws70JBlEvl3VeEMWcDMgiP
 r6FjogvjkqTow==
Received: by mail.novaplan.pl for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Feb 2025 08:45:31 GMT
Message-ID: <20250226084500-0.1.k3.1bwby.0.1pgp2kf2ep@novaplan.pl>
Date: Wed, 26 Feb 2025 08:45:31 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.novaplan.pl
MIME-Version: 1.0
X-Headers-End: 1tnD3U-0004TW-8J
Subject: [f2fs-dev] =?utf-8?q?Prosz=C4=99_o_kontakt?=
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
From: Adrian Liszka via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Adrian Liszka <adrian.liszka@novaplan.pl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RHppZcWEIGRvYnJ5LAoKQ3p5IGplc3QgbW/FvGxpd2/Fm8SHIG5hd2nEhXphbmlhIHdzcMOzxYJw
cmFjeSB6IFBhxYRzdHdlbT8KClogY2jEmWNpxIUgcG9yb3ptYXdpYW0geiBvc29ixIUgemFqbXVq
xIVjxIUgc2nEmSBkemlhxYJhbmlhbWkgendpxIV6YW55bWkgemUgc3ByemVkYcW8xIUuCgpQb21h
Z2FteSBza3V0ZWN6bmllIHBvenlza2l3YcSHIG5vd3ljaCBrbGllbnTDs3cuCgpaYXByYXN6YW0g
ZG8ga29udGFrdHUuCgoKWiBwb3pkcm93aWVuaWFtaQpBZHJpYW4gTGlzemthCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
