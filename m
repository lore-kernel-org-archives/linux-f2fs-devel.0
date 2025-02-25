Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7779CC021B8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:57:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tmqlH-00086k-OA;
	Tue, 25 Feb 2025 08:57:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vincenc.turek@commetrax.com>) id 1tmqlF-00086e-OO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Feb 2025 08:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KU5M+gej51QK4mmXhCmNzqpjd/eQ19esTpkUg1bqEZI=; b=A9meO+iKw6G7wtzXNKwkIRu0mV
 C/rt6Kpxo1fH9runbyDsxpUCftQcpZmaSG9veS70wusdSjY5f3Q+UAiNll7cW4W8ORm3HLJMYe9c6
 kNti/5sPAPEwjGP/FAfwQw5xwVGVYUP2WgHVg/V5pS4oqPv7gkbCZ2Lucl+agJpLrZ+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KU5M+gej51QK4mmXhCmNzqpjd/eQ19esTpkUg1bqEZI=; b=k
 GMGJkDeiEh6OvhLdrrUpSFeqPVwYJaJxE2gFqoIvLejkYFKKIZpC6a/l3+fNLLAffZfHNOMsDpmo8
 O47Gmqc+xwq/n+VESRnENUyWwAdMVk65Qaa6Bu6uMpxVK2ZMev+hxHGvzAHZYp+POGXaai3QRBGfd
 ZpiWmoz5we/odIl8=;
Received: from mail.commetrax.com ([141.95.18.165])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tmqlE-0004BI-Dp for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Feb 2025 08:57:53 +0000
Received: by mail.commetrax.com (Postfix, from userid 1002)
 id 7789C24511; Tue, 25 Feb 2025 09:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
 s=mail; t=1740473804;
 bh=KU5M+gej51QK4mmXhCmNzqpjd/eQ19esTpkUg1bqEZI=;
 h=Date:From:To:Subject:From;
 b=I8B3JGoyvjwQOz4C9Xh0L1J6wnFY+cfCQ8VaG17jtxkJU/ggKaJ3rvUP0Mlc/n+2H
 Te2p/SeCaRauRXn0mphVI+BGtrTzKyQ0XAZyuz9NuZDIIdc8UWxhI1twLVT+HNHDam
 3XKZBrrJr1Ytz/HymFodZuVsnwfb/AZWIb83VuNn0LF+XYHDn2qU/a4xFyPQLoCTIw
 B0YiA/HpBhL4gj6DB5XLSamzuCrnlDWNSVgMbEiF4sv3TR6tywfCr6xRDh5b2w2C2p
 eFURJ5ggV6v71U5PIAoSVJhlTY7hKERcZw99oH6kAYmz9HDg2hhq5LhWsnffKh8sSc
 sfN341jwC5VNA==
Received: by mail.commetrax.com for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Feb 2025 08:56:10 GMT
Message-ID: <20250225084500-0.1.82.lput.0.c05p1rs5q8@commetrax.com>
Date: Tue, 25 Feb 2025 08:56:10 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.commetrax.com
MIME-Version: 1.0
X-Headers-End: 1tmqlE-0004BI-Dp
Subject: [f2fs-dev] Packaging
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
From: Vincenc Turek via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Vincenc Turek <vincenc.turek@commetrax.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

We have been manufacturing plastic packaging for food and household/building chemicals since 1995.

We offer a wide range of products as well as the possibility of custom-made solutions tailored to individual needs.

If you are considering expanding your packaging range or are looking for reliable suppliers, we would be happy to prepare a proposal tailored to your expectations.

May we suggest some preliminary solutions?


Best regards
Vincenc Turek


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
