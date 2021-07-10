Return-Path: <SRS0=5ZV8=MC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5022DC07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Jul 2021 08:26:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B2F613B7;
	Sat, 10 Jul 2021 08:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B2F613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=preonzaschouler.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m28Jr-0003c1-3U; Sat, 10 Jul 2021 08:26:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <postmaster@preonzaschouler.com>) id 1m28Jp-0003bb-UH
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 08:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4FLc6FHpY8EW2SJHI2obkBHfxqRIKhWyhynkWpAQJkY=; b=JvqjrGOph5l21484tlmcNClrRs
 IBmbUe23fPkaJ4AV5lNzkLA9POcYpDePk5rKrCztsW9yRjOSjZeUZP9S46Rft39z0GL6KbMLp2Y/s
 VoPy7w1rnTTrS7UGJ4UR3eqGHepE5PTvstTIGP4setnDApnw+TESmkvHOzQMNXdMeiOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4FLc6FHpY8EW2SJHI2obkBHfxqRIKhWyhynkWpAQJkY=; b=d
 2AU50+d7n1v6VxH0J05xw2hX9lVGdyE6Hsi6G501S4hgJxQmLeAJtY1595IgDUd2SpF7piUdi5V+n
 vL8PNPTLTSt4NkoVfa5PmQWDvfSbAHZf5kcVV+iK1UBVKwsnqQwoT/wWyI5qgzvOB+2rrw+0Df8T+
 no1STLh31AZbH7TU=;
Received: from slot0.preonzaschouler.com ([195.133.18.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m28Jk-00079z-F8
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 08:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim;
 d=preonzaschouler.com; 
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=postmaster@preonzaschouler.com; 
 bh=OnQ5fLc2IiEXjfLmGHsi4tJd7Qg=;
 b=Zaegm33dOfMNXGGU20uf70lmikaKCxfKzRPYMrcf0sIFfRpHPnxLyTNiQasTIbj0ZcBjMDmBsHqy
 ocRwwdXvmvCj8BYRLYSBHkS7w5HQLF0cBeMqcJEiD5jwjI9REOtx+ofc7stKnFNKUHsX3OrYig82
 /gwuBdY8Z9NZhKA6pjJttscpTJLieo8qsSth0ffOaf7izs/JU31qDQAE2/7TDwtyPf0NK+ZAO3JC
 eGxnck2M/Ynf26itUNZr3W8QCmcs21qnzwqDPovkpUVLvyUYT20OZv23T0tM9S9Kc1ul7WC7vq3y
 55tByNAOI0tYX9PVgL/rsPf/szRmG2OXVXZU4g==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=preonzaschouler.com;
 b=APUyNYwt1y3i1E22Zqff35jY7h/uhe0s+xTr2e6l6HRj+NM9ZNmWXa/7m0rMWK9vx8sCrclawXVm
 g8RpR6CF/F7OCNV+7rWlsRfiwx8gPmIQ0iB7kalNPgDLUbWEUJ49xsmVHuc3OykC4wzhnhFrgKH4
 T1kBsVmV34fsdqdgJwQ0z7xonVgzUU0IzitT7BgaaDF3RdiDLVyXGZIv/VANtyv7ukgyiTJYwbQ6
 ucA6VywlH3F0zR7CoWH0CVb/VaVA8UXwufaH8PnQM8SwuiMVEVrdwyrZQGLxUSJtss0AYoBM0Kze
 SezcqNAcQe6KlqF5/erVE6nFs204EDz2Iwe1mA==;
From: "Sharon Degree" <postmaster@preonzaschouler.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: 10 Jul 2021 10:05:40 +0200
Message-ID: <20210710100540.C825F0F9432E3A99@preonzaschouler.com>
MIME-Version: 1.0
X-Headers-End: 1m28Jk-00079z-F8
Subject: [f2fs-dev] NEW ORDER REQUEST
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
Reply-To: sales@denysmyth.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

I am Sharon Degree the product sourcing manager of DANYSMYTH 
CORP.

I have a customer who has large demand of your product

Kindly confirm if i can send the order over so that we can
conclude on the quantity and price.

Please confirm to me also the delivery time.

Thank you as i await your feedback.


Best Regards

Sharon Degree

---------------------------------------
DANYSMYTH CORP
Via Camillo De Nardis, 49
80127 - Napoli (NA)
Italia
IVA IT07526020636
Email: sales@denysmyth.com
+39 82 5604081




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
