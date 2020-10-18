Return-Path: <SRS0=H1E6=DZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460E2C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 18 Oct 2020 13:08:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C735221655;
	Sun, 18 Oct 2020 13:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JlfzB4Hl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QprKqbEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C735221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kU8Ps-00074m-CR; Sun, 18 Oct 2020 13:08:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dstartup004@gmail.com>) id 1kU8Pq-00074e-CV
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Oct 2020 13:08:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Reply-To:From:
 Date:Subject:To:Sender:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AedL6SKU/CxD1w0uEWFKZAzeTt1nb/4xZKheYuRioUQ=; b=JlfzB4HlKD/Ioqzv0JhIA9n8ix
 FHDDpTceJUmZlskwdBlgO+0GEF2LVBrTOe86te7zQ/WlzUGEBQscWxT1eOdn/5KQWshBZFrONU1pm
 R+kjpxk+xtDfefF8+3bm2RK30Md9A5uTB7FHVzySlIhVi1sWH1amMFMrLK4B61HYC5i4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Reply-To:From:Date:Subject:To:Sender
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AedL6SKU/CxD1w0uEWFKZAzeTt1nb/4xZKheYuRioUQ=; b=Q
 prKqbEusA4EVJYI7tyrTshu9cMaxJp3QeTYls3LpOoHNPRrw+8wyg6/on9vc2PlN9xMGpuql9+/tu
 8BuQHolS8Vj3XVwsg0I3xJO5qBFr8akXR8oPRDF1k22//Iankzjyngiuqw770o3GMySCVfq31Kna+
 1lUxSlFVnY22j+9U=;
Received: from shared-ala231.rev.nazwa.pl ([85.128.157.231])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1kU8Pk-002a3m-8q
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Oct 2020 13:08:02 +0000
X-Virus-Scanned: by amavisd-new using ClamAV (6)
Received: from filrybakhl.nazwa.pl (akl52.rev.netart.pl [85.128.142.52])
 by filrybakhl.nazwa.pl (Postfix) with ESMTP id D08F41C3AE5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2020 15:07:47 +0200 (CEST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2020 15:07:47 +0200
From: LEGAL EDGE <dstartup004@gmail.com>
Message-ID: <63e44c3c185fd86d2bb6547f6e912b68@rybakowscy.pl>
MIME-Version: 1.0
X-HTTP-Posting-URI: https://rybakowscy.pl/wp-content/cEXQ7DlxRK2.php
X-HTTP-Client: 173.199.123.113
X-Headers-End: 1kU8Pk-002a3m-8q
Subject: [f2fs-dev] Business Trustee Needed
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
Reply-To: legaledge.invest@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compliment of the day. I will like to discuss a long-term business opportunity with you. Kindly contact me back for more details and information.  I await your prompt response.

Yours,
LEGAL EDGE
Sheather Artemia Guimerey
61488892067



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
