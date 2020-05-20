Return-Path: <SRS0=FyES=7C=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657E3C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2020 22:52:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEF220708;
	Wed, 20 May 2020 22:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MX5e2o2m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IsEb71A6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFFvwdXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEF220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jbXa4-0001Ew-PJ; Wed, 20 May 2020 22:52:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jbXa3-0001Du-M8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 May 2020 22:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K60aOG9lHhg1C12vo+/9E58mb3t4H2kfeRPjXOJMk7w=; b=MX5e2o2mWGZNz/5iP0xSjQ8IQ1
 CH5y3YFmPGSAkkkVMnpQPckUksxyHYN7INkKIVUF16d5Hy5iI0NcPqTiUZI7uSxfqTEqABNVseGKa
 YuDjHk/MpvYpCWt46grq2oV+jOvQGzNQTwnQH7p4UGvY2Kj60ayr05v6mwdoXYzhFmeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K60aOG9lHhg1C12vo+/9E58mb3t4H2kfeRPjXOJMk7w=; b=IsEb71A6440QJGEKg8c/+2So7V
 xAloR1pPsFpMnzTct8IX3QqH1ZMQTCWen/g0VDC6ICXxrG06iOoJgSCFTmciVCT/KwnD8ssRvJzLJ
 4aru08QIotZLsQM7Ntlaoxli3d+GfSdAodTiI8XPpVUNP9U1H8O2YWdmysR/hQ+fbcfc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jbXZv-002eCY-Ot
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 May 2020 22:52:49 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 777DE20708;
 Wed, 20 May 2020 22:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590015157;
 bh=cOMMRvik++uT4gLMAQuu3TGKuohy9FAsvrDOcWA2UL4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GFFvwdXWnLW8I75OtVEHT5iTSVEuoTlKH07dKwKDA4jLpm5/0+10iHpLdymDfzGtv
 bWMJLIBzDwX2jNUjtDMzOm6X6SfDiLpqTzd1PapkngDTF7WQDagn1n8G5+z+YlI6fU
 C42Oko4lWBYvFejCpnFGc5xuGqFrqiTcC25punns=
Date: Wed, 20 May 2020 15:52:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20200520225236.GB19246@sol.localdomain>
References: <20200511192118.71427-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200511192118.71427-1-ebiggers@kernel.org>
X-Headers-End: 1jbXZv-002eCY-Ot
Subject: Re: [f2fs-dev] [PATCH 0/2] fs-verity: misc cleanups
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
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, May 11, 2020 at 12:21:16PM -0700, Eric Biggers wrote:
> In fs/verity/ and fsverity.h, fix all kerneldoc warnings, and fix some
> coding style inconsistencies in function declarations.
> 
> Eric Biggers (2):
>   fs-verity: fix all kerneldoc warnings
>   fs-verity: remove unnecessary extern keywords
> 
>  fs/verity/enable.c           |  2 ++
>  fs/verity/fsverity_private.h |  4 ++--
>  fs/verity/measure.c          |  2 ++
>  fs/verity/open.c             |  1 +
>  fs/verity/signature.c        |  3 +++
>  fs/verity/verify.c           |  3 +++
>  include/linux/fsverity.h     | 19 +++++++++++--------
>  7 files changed, 24 insertions(+), 10 deletions(-)
> 

All applied to fscrypt.git#fsverity for 5.8.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
