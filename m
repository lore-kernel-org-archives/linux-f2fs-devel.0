Return-Path: <SRS0=5IYH=7Q=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCCC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:36:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634002068D;
	Wed,  3 Jun 2020 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jdluPd3d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PU25g0tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634002068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jgWNE-0008Hw-Ui; Wed, 03 Jun 2020 16:36:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pmenzel@molgen.mpg.de>) id 1jgWND-0008Ho-2C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jun 2020 16:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mlv0lfllGuYXDokRiS7+1hg8+1IEsmnkDVjAR/9dGiQ=; b=jdluPd3d4tD1vFabcQRFNpFBrM
 97/humihPgBL//EZeLlGBlMDp6UTIn2u5hsuOjg2NHRMJcxGTsHR3vrs4+pgFlvsnm5c9zIT2QrQw
 HS3aT6vR3zOSLX5nVly/TN306ycQCrLYqxle35FzI5K18r9LRyBY+F6RQHnJWOSu0hUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:
 Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mlv0lfllGuYXDokRiS7+1hg8+1IEsmnkDVjAR/9dGiQ=; b=P
 U25g0tfFNRj/PHQNSO9z28zhVPi/O9qxWa6Q3IMzP1vVOyQF8fJVbF1aywpB2vRCrKAs6akymi+9b
 XkwkFLnRyQ9iAzkqewewxM8gmFTEowUFQmOrO0yjED/iFH/noge7bPk1ED+5PBzbOR2vOHBW0LsXW
 hI6zeeJ7UGwkloag=;
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jgWNA-0048ix-Kc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jun 2020 16:36:15 +0000
Received: from [192.168.0.7] (ip5f5af288.dynamic.kabel-deutschland.de
 [95.90.242.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 09D9520643CC0;
 Wed,  3 Jun 2020 18:09:29 +0200 (CEST)
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <92704294-45ae-7c3a-8cd5-e6f2352f2c53@molgen.mpg.de>
Date: Wed, 3 Jun 2020 18:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-US
X-Headers-End: 1jgWNA-0048ix-Kc
Subject: [f2fs-dev] fsck.f2fs output on screen during start-up
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Dear F2FS folks,


With Debian Sid/unstable using a F2FS formatted Samsung SSD 850 PRO 
512GB as root partition, it looks like systemd always run a file system 
check and fsck.f2fs always prints something to the screen (frame 
buffer), saying something with *Fix corruption*.

     Info: Fix the reported corruption.

Unfortunately, I am unable to find the message in the systemd journal or 
Linux log (`dmesg`).

Do you know, what fsck.f2fs is doing differently from the other file 
system check variants?


Kind regards,

Paul


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
