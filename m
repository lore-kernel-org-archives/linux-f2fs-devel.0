Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD7C54798
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:54:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1riJog-00068c-Ni;
	Thu, 07 Mar 2024 19:54:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patrick.p@mail.smcegy.com>) id 1riJof-00068W-6z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Mar 2024 19:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FAsDsfGhRgHLhiPEp5G/wiEHNNbE0kr6ZZQI+0qFbSs=; b=nWSUZp8U247gCdMTJYv1SQIwo5
 ZM/mZl9opHuRG6hVeet+T08HuRhTbSF8YI3cFQHv3VASy292mZSRzicV2FldY0YQcsmakwZiOx5I+
 OSUK1x4RWDz7IG6smqW6Eac0tiXCfMVE5I76uZFVRkBuSm9cSfZCqD+nRds6+wO67pL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FAsDsfGhRgHLhiPEp5G/wiEHNNbE0kr6ZZQI+0qFbSs=; b=F
 ZaUsn1+b4/17c0z2iYfsFb5+uKpxQX75K192z/OTpXhqgxUM2Cvr6Jex9pI9bnwshjbrRic+WYwKL
 FMU0gIL0DbewkX5/8xjf6kRHaMZoWF9TQK+OhBtz8Ds8eOA+we/2Q8t/d9soDOtYvdz3QWleQUA/L
 SF/ZyaG+yU0G97PQ=;
Received: from [41.33.78.12] (helo=mail.smcegy.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1riJoY-0005DG-Fa for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Mar 2024 19:54:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.smcegy.com (Postfix) with ESMTP id 1D96724DFDE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  7 Mar 2024 19:50:34 +0000 (UTC)
Received: from mail.smcegy.com ([127.0.0.1])
 by localhost (mail.smcegy.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Rk9PnQaeI454 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  7 Mar 2024 19:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.smcegy.com (Postfix) with ESMTP id D4C092CF969
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  7 Mar 2024 19:42:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.smcegy.com D4C092CF969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.smcegy.com;
 s=7119B320-7438-11EE-B128-5F92ED995318; t=1709840523;
 bh=FAsDsfGhRgHLhiPEp5G/wiEHNNbE0kr6ZZQI+0qFbSs=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Exq4l0c2Gv+wmQkW5h4I9Yoihkmjo50HeLavvUbmqPA1DK/FKnB6jasQ9ArghaTCx
 zszkjhI851g6Z/ELRI0jRoGHYXOTk5hYq6TmPwo8gLefMgRfvKoxv1g57hxMBJvpmj
 pfg0sGBS8WLvYhUfPaLUvbMfkEdcJ/QU2hG48FeziJuLQpH2ayzBMOQfLSu17CHrKh
 e/r5mR4wKGtnZ1tcg8Pg4hQv6kl0TrQ0vJ11X6c7+UYTJY4Ez3NoaL5t1uHE2llF4u
 29mxjb96qYJ4A5Ao4EKfESIm9Yg/7DlrzvfLR80nJTquWU09zUBfbPHbof3p8EU3Rr
 3r3Iz3w1oBrWg==
X-Virus-Scanned: amavis at mail.smcegy.com
Received: from mail.smcegy.com ([127.0.0.1])
 by localhost (mail.smcegy.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 5X19hp7te8rL for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  7 Mar 2024 19:42:03 +0000 (UTC)
Received: from mail.smcegy.com (unknown [192.168.41.254])
 by mail.smcegy.com (Postfix) with ESMTP id 864132ACC7C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  7 Mar 2024 19:28:11 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: 07 Mar 2024 20:28:09 +0100
Message-ID: <20240307202809.C666DE11BBD7F36E@mail.smcegy.com>
MIME-Version: 1.0
X-Headers-End: 1riJoY-0005DG-Fa
Subject: Re: [f2fs-dev] Bonjour
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
From: Mr Philippe via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: phillippemartinez@outlook.com
Cc: Mr Philippe <patrick.p@mail.smcegy.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Qm9uam91ciwKSmUgbWUgcHLDqXNlbnRlIE1vbnNpZXVyIFBoaWxpcHBlIE1BUlRJTkVaLCBqZSB2
b3VzIGNvbnRhY3RlIHN1aXRlIArDoCB1biBkb24gZGUgMSA1MjUgMDAwIOKCrCBxdWUgamUgdmV1
eCB2b3VzIG9mZnJpciwgY2FyIG1lcyBqb3VycyAKc29udCBjb21wdMOpcy4gUG91ciBwbHVzIGRl
IHJlbnNlaWduZW1lbnRzLCBqZSB2b3VzIHByaWUgZGUgYmllbiAKdm91bG9pciBtZSBjb250YWN0
ZXIgw6AgbW9uIGFkcmVzc2UgY291cnJpZWwgcGVyc29ubmVsOiAKcGhpbGxpcHBlbWFydGluZXpA
b3V0bG9vay5jb20KUXVlIGxlIFNlaWduZXVyIERpZXUgY3LDqWF0ZXVyIGR1IGNpZWwgZXQgZGUg
bGEgdGVycmUgZXhhdWNlIHZvcyAKcHJpw6hyZXMsIEFtZW4uCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
