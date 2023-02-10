Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D9C636D4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Feb 2023 21:40:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pQb8C-0002r2-Vo;
	Fri, 10 Feb 2023 21:40:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pQb89-0002qr-7Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Feb 2023 21:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=52AWAKHdi96uAUc4+BXLMbw+UZtc1924XxrvBKfGjfM=; b=NDfiiWfb83nXQ31kcddwt2OeKn
 uWFn7oAHCM3jLOhuq4Uzqo9p4k87LIybcHqwIiZOLXNthhH+9We21YVYdHmWI5uCH1x7VNhVPGHVj
 lZMyvpYgIB47bPXEIsFf/Ip0vG8opukUF1JrCsp7KQRpy7JSpKiw5VhsNm8Ar6nezw+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=52AWAKHdi96uAUc4+BXLMbw+UZtc1924XxrvBKfGjfM=; b=j
 xdV11enw5h9y6grGA27Rpq7hfhKGdJzmEtfgXWeTuS0kuZSuvKk8cd90I++pWfVQcZutPr6YWWrUy
 2Vrwgau8f+Tpa4llGJZaBmkUOdqeNQ3U8v1pO5MyYj2l6kyqUEQ8dXIp66CUEvO9u9GM8ABA5VElj
 /9E9jk1F5r5w9T9o=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pQb87-0005Ms-3J for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Feb 2023 21:40:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E611B825E7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Feb 2023 21:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF674C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Feb 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676065217;
 bh=1Q5YptQo31g9TnELAuYkVyxsQVCDZFIJDvDeiFlQPnQ=;
 h=Subject:From:Date:To:From;
 b=GypIlo+q0k8PjzsbaU5H7GIsgrS7J5Gse/4TpwnWzvTeIl/z2FYDNpX9AG+3upThN
 YHMSqQhUPFqeoeojbb9/SbRBSf2uzVg1JkPc5EPaY78cClaQ4yrI5bj64krmcFhTSj
 V7wTeDlH5KydJq2amv5FxMgjLzpqYwt5wdADC0E7LitVRr5Z4+gJg3cuKWyUAT8hPa
 usnx7jwFZWMIXjlKyVF/K8r5MekrHMn/0dDx0wrcdXB9AKrFQMjwNaS1oEOK++6SnJ
 vbwzODRkTTOKEoZJkrtFl199JNkjJ4B6FGUsW53mC4hCPTYWYg7kQD4cffDmIEQcOd
 vu+jNMXWhb8kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 A2C37E55EFD for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Feb 2023 21:40:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167606521759.8706.16722343800203845012.git-patchwork-summary@kernel.org>
Date: Fri, 10 Feb 2023 21:40:17 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pQb87-0005Ms-3J
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG86CgpUaGUgZm9sbG93aW5nIHBhdGNoZXMgd2VyZSBtYXJrZWQgImFjY2VwdGVkIiwgYmVj
YXVzZSB0aGV5IHdlcmUgYXBwbGllZCB0bwpqYWVnZXVrL2YyZnMuZ2l0IChkZXYpOgoKUGF0Y2g6
IFtmMmZzLWRldl0gZjJmczogbWFrZSBrb2JqX3R5cGUgc3RydWN0dXJlcyBjb25zdGFudAogIFN1
Ym1pdHRlcjogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgogIENvbW1p
dHRlcjogSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4KICBQYXRjaHdvcms6IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9mMmZzL2xpc3QvP3Nlcmllcz03MjAxNTYK
ICBMb3JlIGxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzAyMDkta29ial90eXBl
LWYyZnMtdjEtMS1iNmZlZWRiZGQ0YThAd2Vpc3NzY2h1aC5uZXQKCgpUb3RhbCBwYXRjaGVzOiAx
CgotLSAKRGVldC1kb290LWRvdCwgSSBhbSBhIGJvdC4KaHR0cHM6Ly9rb3JnLmRvY3Mua2VybmVs
Lm9yZy9wYXRjaHdvcmsvcHdib3QuaHRtbAoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
