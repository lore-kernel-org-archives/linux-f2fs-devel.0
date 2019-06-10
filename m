Return-Path: <SRS0=/iKT=UJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FA2C468C1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jun 2019 04:15:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD34207E0;
	Mon, 10 Jun 2019 04:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QD+QyQ4m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="X7WyHvrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD34207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1haBia-0002Cy-Bn; Mon, 10 Jun 2019 04:15:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1haBiY-0002Cq-Cw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 04:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzTh5A7RytNG1mW9+/N28jmG3ftJUVynsDCWyDyG8g4=; b=QD+QyQ4mw2IDjtC5S9bX0rZ26A
 mz8rNXvotvqHKyQvkxVDklMVAp9qqSL+vfyA6q+XZmCGybSjXRqaqNUXZ1a3FhY3H0eBG/6I8PgJc
 FTGSaRBq1Pyfhi6CIxEWEI0HSQnbfWu1We9GpNEuGNo4DHpCoKzsgOsIVu+YTN/8CPR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kzTh5A7RytNG1mW9+/N28jmG3ftJUVynsDCWyDyG8g4=; b=X7WyHvrA1St4L3jzI80YgMb8QH
 YdXyVqMIYMwrvTbGy6D+9zj4ZDfuC9uOHstjpCdWhDQX1J1AR64wMDDKsD7LcMF24/tZ7yQVzV+k2
 rsOQzJeQEiwA5ZqhBoe6SYzkDsX6sxSP/5zo4xx+tgsY1+2IC/4N2gXLTkkL1zHotL/8=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haBiX-0056em-IC
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 04:15:35 +0000
Received: from callcc.thunk.org ([66.31.38.53]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A4FMNQ008935
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jun 2019 00:15:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 34E40420481; Mon, 10 Jun 2019 00:15:22 -0400 (EDT)
Date: Mon, 10 Jun 2019 00:15:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Wang Shilong <wangshilong1991@gmail.com>
Message-ID: <20190610041522.GB15963@mit.edu>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1haBiX-0056em-IC
Subject: Re: [f2fs-dev] [PATCH 1/2] ext4: only set project inherit bit for
 directory
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
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
 Wang Shilong <wshilong@ddn.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190610041522.iRdK9M1Ea0YPfygK58mV8FKkXsQHE-W6HQb2At-XCwc@z>

On Thu, Jun 06, 2019 at 01:32:24PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Thanks, applied to the ext4 tree.

				- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
