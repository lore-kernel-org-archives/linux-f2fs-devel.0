Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB42C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Jun 2023 12:02:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q5mR6-0005NQ-8G;
	Sun, 04 Jun 2023 12:02:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <reni@bess.co.id>) id 1q5mR4-0005NG-VT
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Jun 2023 12:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AkVaycPHATF4Z96h7qyGSVuaFGZSQeH59skbFfclPN8=; b=O8d6xN7Y/TI93Lkf0NznxH1HPG
 9ngNt0Nwv+YjHAauicylGl0kb/g3I7T7T5Xy6wze6ICHw55JIBI4Hb+FJJ179aCqvhiKbEmLmDx6v
 xwZBWpRxA0WAwWiyPk2JoWR+lVb2T5OKRWHA1zRqoBe6uP4DgTmwqPjFnPkzKQzQvcQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AkVaycPHATF4Z96h7qyGSVuaFGZSQeH59skbFfclPN8=; b=V
 KhUQzzZeFofnHg3RqykNnZJmQLzehOQeL9tG4uaKwm6x5y7bFWAJ5K2p8dClL7iO5+lJGvNPAKl7B
 yu9QaZcqhmGgDmiY5+qlz0FtIE/KYP4zY+ssVHHDjyYs2KrmqM6UGQ8TY48xXjJwUCCHRyJOmJpFd
 dSMWZDrhY3yYlhY4=;
Received: from [202.157.188.57] (helo=synergy.bess.co.id)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q5mR4-0003nX-Ai for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Jun 2023 12:02:14 +0000
Received: from localhost (localhost [127.0.0.1])
 by synergy.bess.co.id (Postfix) with ESMTP id 9E400A204CE6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  4 Jun 2023 18:45:37 +0700 (WIB)
Received: from synergy.bess.co.id ([127.0.0.1])
 by localhost (synergy.bess.co.id [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Vealmb9jagXK
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  4 Jun 2023 18:45:37 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
 by synergy.bess.co.id (Postfix) with ESMTP id 6F190A1FA234
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  4 Jun 2023 18:45:37 +0700 (WIB)
X-Virus-Scanned: amavisd-new at bess.co.id
Received: from synergy.bess.co.id ([127.0.0.1])
 by localhost (synergy.bess.co.id [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 33DjVGOj_yCW
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  4 Jun 2023 18:45:37 +0700 (WIB)
Received: from bess.co.id (unknown [156.0.213.29])
 by synergy.bess.co.id (Postfix) with ESMTPSA id 47B78A1F9ADC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  4 Jun 2023 18:45:35 +0700 (WIB)
From: Mr Philippe <reni@bess.co.id>
To: linux-f2fs-devel@lists.sourceforge.net
Date: 04 Jun 2023 13:45:35 +0200
Message-ID: <20230604134535.E0571B72AE00C2A9@bess.co.id>
MIME-Version: 1.0
X-VA-Spam-Flag: YES
X-Headers-End: 1q5mR4-0003nX-Ai
Subject: [f2fs-dev] [SPAM] Re: Bonjour
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
Reply-To: phillippemartinez@outlook.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Qm9uam91ciwKSmUgbWUgcHLDqXNlbnRlIE1vbnNpZXVyIFBoaWxpcHBlIE1BUlRJTkVaLCBqZSB2
b3VzIGNvbnRhY3RlIHN1aXRlIArDoCB1biBkb24gZGUgMSA1MjUgMDAwIOKCrCBxdWUgamUgdmV1
eCB2b3VzIG9mZnJpciwgY2FyIG1lcyBqb3VycyAKc29udCBjb21wdMOpcy4gUG91ciBwbHVzIGRl
IHJlbnNlaWduZW1lbnRzLCBqZSB2b3VzIHByaWUgZGUgYmllbiAKdm91bG9pciBtZSBjb250YWN0
ZXIgw6AgbW9uIGFkcmVzc2UgY291cnJpZWwgcGVyc29ubmVsOiAKcGhpbGxpcHBlbWFydGluZXpA
b3V0bG9vay5jb20KUXVlIGxlIFNlaWduZXVyIGRpZXUgY3LDqWF0ZXVyIGR1IGNpZWwgZXQgZGUg
bGEgdGVycmUgZXhhdWNlIHZvcyAKcHJpw6hyZXMsIEFtZW4uCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
