Return-Path: <SRS0=2T6g=FV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1FC4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 18:09:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA46D2388E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 18:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA46D2388E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kpxiF-0004a3-9w; Thu, 17 Dec 2020 18:09:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1kpxiE-0004Zv-1B
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 18:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfmpmW/ZYo0JRDfOddeJgg2mPWPnRbVhJMuOnbtPYoI=; b=AuJG5yVA/ge+o5HdJwhZ3MG2Km
 d82VklVSmvV6Muz0HjOUNTlVmaJqIY37R/POskINLs1oNa4al0pW5vDkQ4DyBse1NYFsuBXA7riEX
 T5WH7ST1NqSQ8r/7g8fmeouz/H8jeJH0/CMcMWEmNUzolTOHE1B6SzTixR604NIwArjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lfmpmW/ZYo0JRDfOddeJgg2mPWPnRbVhJMuOnbtPYoI=; b=OZm5Kd3zkIpDqZ/yOQLB+xA8h2
 CvzB9iktt/Q6gjcuS2OFVRAZjD0TutQNCt2XiLdBVgRNco2vPJZWyOmaM8QYkGn5iNBcrf5CA8jtj
 WsMfB4fEwn6N8RiZrQYfm+cTA82QwfZ4g2q/m+lfNvqOxFQ+DHTEl1yJIn+FV68oSh8s=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kpxi2-000GBr-HF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 18:09:13 +0000
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BHI8n91025024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Dec 2020 13:08:50 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id CB08C420280; Thu, 17 Dec 2020 13:08:49 -0500 (EST)
Date: Thu, 17 Dec 2020 13:08:49 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Satya Tangirala <satyat@google.com>
Message-ID: <X9uesUH1oetyyoA0@mit.edu>
References: <20201217150435.1505269-1-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201217150435.1505269-1-satyat@google.com>
X-Headers-End: 1kpxi2-000GBr-HF
Subject: Re: [f2fs-dev] [PATCH v2 0/3] add support for metadata encryption
 to F2FS
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Dec 17, 2020 at 03:04:32PM +0000, Satya Tangirala wrote:
> This patch series adds support for metadata encryption to F2FS using
> blk-crypto.

Is there a companion patch series needed so that f2fstools can
check/repair a file system with metadata encryption enabled?

	       	    	   	- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
