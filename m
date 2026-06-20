Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F5CD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:MIME-Version:Message-ID:Date:To:From:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VKigQ+oa14xKuTkXY9Vf9nctsNjJ472WyepT4XhoXrM=; b=amxTfYlx7c13eRQtwBuwNc9wyF
	WcW6Vhan+4G60oZ7aQknvEtFC+cbkIM+ZOkOXuvPuytbd85Ch7FeeivpmSjnvFvecJSfRMOWfTjxC
	FCeJv9/IsHTpDRLQVGKB4fTKypVe+00jcDqURUnj/2Ir/VV725L3mjFNTBPj6LMkjjbc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1waszD-0006uf-Mw;
	Sat, 20 Jun 2026 10:31:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <adam.christiansen@elshams.com>) id 1waszB-0006uZ-Pp
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wNFzFDz+mS7qyogcYtdY2Lij/kJAcuEN9RJk5ANoHcw=; b=gazsY6F2c0ZVmZYNhwP8UJAnc7
 +BibQffc8uV7cN51lekfSprXgweT0qungILRCeoT17MHM+AetagyprxMZ5VoxHELUEFsDPt5AJbH1
 7Pqqq15VLIV5XQCW0dfDnQi+PN8yOyswOu1pWidpy5LDbC1tpwZRu7FrXXocZjkRSBng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wNFzFDz+mS7qyogcYtdY2Lij/kJAcuEN9RJk5ANoHcw=; b=J
 kDd2O2m0LsxgU1dePFikOVymVQvvg0YgSeFFMHK0KLeL89BbMlNHelFiqr/TEbSXD+KLTEoXjcZnc
 dbEFL2eMkEBfwkIiKoFrczbKxPDMhUe8V30skBP/WidPjvY9kPSqzABPC/f/i+ADKhv/YF0uLDGUS
 Tp62DE0700hRpoRk=;
Received: from [95.215.32.33] (helo=svn.publicvm.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1waszB-0001aX-KB for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:31:38 +0000
Received: from [127.0.0.1] (account jocus@svn.publicvm.com HELO [95.215.32.33])
 by svn.publicvm.com (CommuniGate Pro SMTP 6.2.14 _community_)
 with ESMTPA id 5701791 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 03:31:10 -0700
From: Adam Christiansen <adam.christiansen@elshams.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: 20 Jun 2026 03:31:10 -0700
Message-ID: <20260620033110.782D6EED2FB84842@elshams.com>
MIME-Version: 1.0
X-Headers-End: 1waszB-0001aX-KB
Subject: [f2fs-dev] Your investment partner
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
Reply-To: Adam Christiansen <adamjchristiansen01@proton.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

I am Adam, an investment broker. I connect business owners with lenders and investors for loans, working capital and expansion funding.

Is securing financing something your business is currently exploring?
A simple yes or no reply works perfectly.

Thanks,

Morgan Investment Broker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
