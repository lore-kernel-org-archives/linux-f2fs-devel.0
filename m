Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FAACA0EFF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Date:Message-ID:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gs+11NwA5jbQYgAOEZbK6A0JxGGGFIHSWAoLR1tONPc=; b=XIpsKkPGpOvALg7mN8/P64Ula2
	xTCnvMZbsmCL+2BLpCahjKmQ6zJgFBvx1EW8SHUxnoO93pQ3vCrK6LdZPVJ8dVoUJOE3kqKREFzV5
	we1yez3y3x7aqYuVCSAzf+e5kutx9mXF+YMoAKV6so2yU8Z2jxxI4eJs2hACBmeQOwc4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1urB2j-0006Mc-RT;
	Wed, 27 Aug 2025 07:58:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pawel.zajdlicz@growdeal.pl>) id 1urB2h-0006MU-Ox
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 Aug 2025 07:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nU0fzD5wnLwbt9yoUSBeMInFHzMm7DGirLXtUO2ZpV8=; b=KR1A7RJrqNr33jNZLg8X3W9TBq
 8w41fElJVa6o7/bpYWddVwQQO70uiRZo8Mu9rDHECtn+LD5n1itIupfgP2jHuLt8rE3mvME3T6ZeI
 qMNw2mUi6zQ8BZw02gj1bL53Eq5x/QbXRMz6NpzUaQLWkYehRd3pmCsslejdQ5w6yyUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nU0fzD5wnLwbt9yoUSBeMInFHzMm7DGirLXtUO2ZpV8=; b=c
 pmTSvf6M91VDTTsTDlnLEtco7C6Db954V09fyV7Uj0VSC3R/RjcpMFB254t2kdjcJAtyf5M2fHbmJ
 nyVZeiNebCAouyj2q3A4vh47EjWprB0U7cs95Qf3d2CbCf8b7FPw/EOR5qVQxeacNC2djh7XI2wDJ
 pvkvbkmS/4RBeHEk=;
Received: from mail.growdeal.pl ([141.95.55.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1urB2h-0004hK-60 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 Aug 2025 07:58:03 +0000
Received: by mail.growdeal.pl (Postfix, from userid 1002)
 id 9727624ECA; Wed, 27 Aug 2025 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growdeal.pl; s=mail;
 t=1756281471; bh=nU0fzD5wnLwbt9yoUSBeMInFHzMm7DGirLXtUO2ZpV8=;
 h=Date:From:To:Subject:From;
 b=iIPZPsGhhP1qHw3ZGBFwzvGMsmZKGDNHf9Ink83mJcFVn+VSa2rirxue1s1S6tC/Z
 XylixkR9xCN8Vsf8lg8287ryz19TGs43v9vl8cPhi05PUh7Gre2fdTl+GKwoBPJR50
 V2bFbW5p1bv8/88ZD0NPhy8fGYiONQjcEfsQfQlMMdgwPvIisCIIPaQnmasUs1RQu/
 jt4WOh4WOOEuq4Rke0zfo4FM32lJYgN6QWcS64Eo+RrFJQI8QtT3LFPPbeR/Pv/F27
 3WonoZv4XOLV0sW2k7cwTqfYPPvxdlKu1GhIWMrJwfyHVqpYMjOeVS/nyegeCnwElh
 8ocgZqb6mfkNg==
Received: by mail.growdeal.pl for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Aug 2025 07:56:09 GMT
Message-ID: <20250827064500-0.1.4c.248f9.0.jc2qlpvlsl@growdeal.pl>
Date: Wed, 27 Aug 2025 07:56:09 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.growdeal.pl
MIME-Version: 1.0
X-Headers-End: 1urB2h-0004hK-60
Subject: [f2fs-dev] Rekrutacja handlowca
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
From: =?UTF-8?Q? Pawe=C5=82_Zajdlicz ?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?UTF-8?Q? Pawe=C5=82_Zajdlicz ?= <pawel.zajdlicz@growdeal.pl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

V2l0YW0sCgpDenkgbWFqxIUgUGHFhHN0d2EgYWt0dWFsbmllIHBvdHJ6ZWJ5IHogemFrcmVzdSBy
ZWtydXRhY2ppIG9zw7NiIGRvIGR6aWHFgnUgaGFuZGxvd2Vnbz8gCgpQb21hZ2FteSBza3V0ZWN6
bmllIHJla3J1dG93YcSHIG9zb2J5IG5hIHN0YW5vd2lza2EgUHJ6ZWRzdGF3aWNpZWxhIEhhbmRs
b3dlZ28sIFNhbGVzIE1hbmFnZXJhLCBhIHRha8W8ZSBLYWRyeSBNYW5hZ2Vyc2tpZWogdyBvYnN6
YXJ6ZSBzcHJ6ZWRhxbx5LgoKQ3p5IG1vxbxlbXkgcG9yb3ptYXdpYcSHPwoKClBvemRyYXdpYW0K
UGF3ZcWCIFphamRsaWN6CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
