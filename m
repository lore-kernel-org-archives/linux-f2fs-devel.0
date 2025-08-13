Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD050CA0EE0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Aug 2025 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wp2FXbua+NnAvNAOpDlO0Ce2Ybx6VIUOY5nAdVa+U3o=; b=fj2aUxHS6rgjElTywLEPFo9xz9
	6YpSQ1gVlUY0Lcmseq4JGe/r8L8oaXOSaCxL8dqKsw7WAR5UZs0JmEcY0Ux6GeUSFLk5OApgxynWH
	GMuW2rNWOzEshcs0BIGKHJv0eEzkqDIOrqPwAn4+imrStX/VNj1OYGBZRmXNIW4RghuM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1um9c3-0001cu-Pl;
	Wed, 13 Aug 2025 11:25:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <agata.lorenc@profitkey.pl>) id 1um9bs-0001cg-27
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Aug 2025 11:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UbKn3eq96haC/y6nyG5aIGnYr/CHw5y2gV8o2pDmMkU=; b=CvrU99SBaruqPL7BHwRkSSPoMQ
 jrvFSnCFAOMpwpJB+2bRzhBKeTbMEaqOsUpHW2UZxuEMNVXRCEJ2jYN0UMfRh3sldR+QrbLxsnz29
 43azRpzII+Yjv4CVC5cFpYrlumSifmRRcIHuDTnA+xKvWgFqYrznshOxcYnw3twYU5PI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UbKn3eq96haC/y6nyG5aIGnYr/CHw5y2gV8o2pDmMkU=; b=L
 8/CU+dZisvDw8tRHPq9Ljj6v9fM/Sz6FokPNcduyg8vTw/mU9kir8cm340S9BdtFun8xj9sMOlIh7
 B8f+ocPkw3JI22ctk8TMtI+kARBdqIoKmGIT589JlK9u1QfJPkhRZwEmAvCCOjRd9ZOC+egZhVeuf
 2XTNrTmqcivL9y/s=;
Received: from [141.95.53.180] (helo=mail.profitkey.pl)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1um9bd-0002tM-PQ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Aug 2025 11:25:36 +0000
Received: by mail.profitkey.pl (Postfix, from userid 1002)
 id B682837693; Wed, 13 Aug 2025 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=profitkey.pl; s=mail;
 t=1755073835; bh=UbKn3eq96haC/y6nyG5aIGnYr/CHw5y2gV8o2pDmMkU=;
 h=Date:From:To:Subject:From;
 b=BhZhpEFnFXSxdY3/dvisUs6MT6PIZSlHP7K8KJLDeKSLMRjHPGlh1vQ0KBHa55JMx
 jWS1MOzM252+nafvHyIbq+7twozKu/LxAEz/U6W2aCkWW0Ua/flbS+BGviuznLfqoU
 Zf/7BVq27g1RimV2biQV0BTGQ6jxVWnNeHeTQ+2mPi/sdZjM8XsOM36Hc2qN08HLWE
 +obkLg+KINVVy6/g7ZCIWfdh35wcZpczClaA2kw5Qne+EDoHWtXJTC6JGjN7Hv6yQy
 LpQpvGFhB6fcPa8Ow5VBeK1Lg2lkH/3BPenGNxeMe1FEFRj2NP8NNVgPfCvYmkmwp6
 oaBbs6lz/wUMw==
Received: by mail.profitkey.pl for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 13 Aug 2025 08:00:57 GMT
Message-ID: <20250813064500-0.1.40.1kd3t.0.l6ulm37lm1@profitkey.pl>
Date: Wed, 13 Aug 2025 08:00:57 GMT
From: "Agata Lorenc" <agata.lorenc@profitkey.pl>
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.profitkey.pl
MIME-Version: 1.0
X-Headers-End: 1um9bd-0002tM-PQ
Subject: [f2fs-dev] Karta lunchowa
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

U3phbm93bmkgUGHFhHN0d28sCgpjenkgemFzdGFuYXdpYWxpIHNpxJkgUGHFhHN0d28sIGphayB6
d2nEmWtzennEhyB6YWRvd29sZW5pZSBwcmFjb3duaWvDs3cgaSBqZWRub2N6ZcWbbmllIHphb3N6
Y3rEmWR6acSHIG5hIGtvc3p0YWNoIHphdHJ1ZG5pZW5pYT8gCgpPYmVjbmllIGplc3QgbW/FvGxp
d2/Fm8SHIHp3b2xuaWVuaWEgeiBvcMWCYXQgWlVTIGHFvCBkbyA0NTAgesWCIG1pZXNpxJljem5p
ZSBuYSBrYcW8ZGVnbyBwcmFjb3duaWthIHBvcHJ6ZXogZG9maW5hbnNvd2FuaWUgcG9zacWCa8Oz
dy4gCgpaYSBwb21vY8SFIGthcnR5IGx1bmNoIHByYWNvd25pY3kgbW9nxIUgcMWCYWNpxIcgdyBy
ZXN0YXVyYWNqYWNoLCB6YW1hd2lhxIcgamVkemVuaWUgb25saW5lLCBrb3J6eXN0YcSHIHogY2F0
ZXJpbmd1IGN6eSByb2JpxIcgemFrdXB5IHNwb8W8eXdjemUuIFRvIGRvc2tvbmHFgmUgbmFyesSZ
ZHppZSBtb3R5d2FjeWpuZSwga3TDs3JlIHRha8W8ZSB3eXLDs8W8bmlhIGZpcm3EmSBuYSByeW5r
dSBwcmFjeS4KCkNoxJl0bmllIG9wb3dpZW0gd2nEmWNlaiBuYSB0ZW4gdGVtYXQsIGN6eSBtb2ds
aWJ5xZtteSBwb3Jvem1hd2lhxIcgdyBuYWpibGnFvHN6eW0gY3phc2llPwoKClBvemRyYXdpYW0K
QWdhdGEgTG9yZW5jClNlbmlvciBIUiBNYW5hZ2VyCgoKCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QK
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
