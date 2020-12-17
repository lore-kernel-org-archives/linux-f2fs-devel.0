Return-Path: <SRS0=2T6g=FV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF88C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 01:24:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3CE20866;
	Thu, 17 Dec 2020 01:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3CE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kpi1P-0005QL-H1; Thu, 17 Dec 2020 01:23:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mirq-linux@rere.qmqm.pl>)
 id 1kpi1O-0005Q5-EP; Thu, 17 Dec 2020 01:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xW9ibLoV5/qLNGN3Busmpz2Fsg3WeYdpFtrM6aESBL8=; b=lDAMQpB1yunpVJfte/gBDs+cOB
 E0YiZOPREnFW8YW7UIzomh+VQCck3PeavmBJN4Z0hb/4vLr9XQ9OSS72JazZ7k/OEdRHk2Qov8VG0
 bcEn7U2SYFZhrkl/GTKNJJxZXn+QOzCd3oc8MtlxVO6JNJ5h4MyYs3VqDcj026DaYUXk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xW9ibLoV5/qLNGN3Busmpz2Fsg3WeYdpFtrM6aESBL8=; b=CAcqce44mAl2/GVw6zpi181l8K
 0F8pCXSrSNh4kIJF5cXMUEgfYe4Cha5AgfPvQTrjvFjB4oYFM8wmXFeJF2k5ulN3DK7hMTM0iY56y
 kdMM03pFiqcNkAGIGQenHZeR3M1xSwaDVFmUzIyt9KQGd7OIKU3/P4ucI48dRz9rhuzI=;
Received: from rere.qmqm.pl ([91.227.64.183])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kpi1F-00GyJC-Bu; Thu, 17 Dec 2020 01:23:58 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 4CxDlk0Rxjz63;
 Thu, 17 Dec 2020 02:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1608168212; bh=xW9ibLoV5/qLNGN3Busmpz2Fsg3WeYdpFtrM6aESBL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F0QsVj+LedvuKyx7KZpPQpw/FaclNAFrecY5kvlTJPqc3hYXnLY7op+/R4JKKwzDF
 ecWxaZk85UXkipmWiu3WwIoa/34ijll1c4Ngi+s3cv69sH0T1McNVJBKLGObCRXzpH
 Jc5sXYV/LlIoS8hF/K6iOIvo6Ao6HNI661kpnm0A7SSzIMH6G+R8ZIfES4MKDY1r9m
 YTolpcJL32aBuI62lC7xiIntdYzi+kFihpB5y/tgq/67LV/cyol3x5aVHUxOh+cqLo
 HQDZEaBtrtIWxCvaz1hyzR5Xvs2NUwWZTjiZDF4cPyy0vuCpkz+K+Qj4lm/PcwXW3R
 6vAZMtyNYVphQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date: Thu, 17 Dec 2020 02:23:38 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Nick Terrell <terrelln@fb.com>
Message-ID: <20201217012337.GA24705@qmqm.qmqm.pl>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
 <X9lOHkAE67EP/sXo@sol.localdomain>
 <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
 <20201216005806.GA26841@gondor.apana.org.au>
 <20201216185052.GL6430@twin.jikos.cz>
 <6C449BCE-E7DB-4EE6-B4F5-FED3977BD8F0@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6C449BCE-E7DB-4EE6-B4F5-FED3977BD8F0@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1kpi1F-00GyJC-Bu
Subject: Re: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "squashfs-devel@lists.sourceforge.net" <squashfs-devel@lists.sourceforge.net>,
 Nick Terrell <nickrterrell@gmail.com>, Yann Collet <cyan@fb.com>,
 Petr Malat <oss@malat.biz>, David Sterba <dsterba@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Kernel Team <Kernel-team@fb.com>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Niket Agarwal <niketa@fb.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Johannes Weiner <jweiner@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMTA6MDc6MzhQTSArMDAwMCwgTmljayBUZXJyZWxsIHdy
b3RlOgpbLi4uXQo+IEl0IGlzIHZlcnkgbGFyZ2UuIElmIGl0IGhlbHBzLCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UgSeKAmXZlIHByb3ZpZGVkIHRoaXMgbGluayBbMF0sCj4gd2hpY2ggcHJvdmlkZXMg
dGhlIGRpZmYgYmV0d2VlbiB1cHN0cmVhbSB6c3RkIGFzLWlzIGFuZCB0aGUgaW1wb3J0ZWQgenN0
ZCwKPiB3aGljaCBoYXMgYmVlbiBtb2RpZmllZCBieSB0aGUgYXV0b21hdGVkIHRvb2xpbmcgdG8g
d29yayBpbiB0aGUga2VybmVsLgo+IFswXSBodHRwczovL2dpdGh1Yi5jb20vdGVycmVsbG4vbGlu
dXgvY29tbWl0L2FjMmVlNjVkY2I3MzE4YWZlNDI2YWQwOGY2YTg0NGZhZjNhZWJiNDEKCkkgbG9v
a3MgbGlrZSB5b3UgY291bGQgcmVtb3ZlIGEgYml0IG1vcmUgZGVhZCBjb2RlIGJ5IG5vdGluZyBf
X0dOVUNfXyA+PSA0CihnY2MtNC45IGlzIGN1cnJlbnRseSB0aGUgb2xkZXN0IHN1cHBvcnRlZCBb
MV0pLgoKWzFdIERvY3VtZW50YXRpb24vcHJvY2Vzcy9jaGFuZ2VzLnJzdAoKQmVzdCBSZWdhcmRz
Ck1pY2hhxYIgTWlyb3PFgmF3CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
