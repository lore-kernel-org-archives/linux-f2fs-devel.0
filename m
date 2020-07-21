Return-Path: <SRS0=FAg2=BA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27735C433E8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2020 00:47:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C89208E4;
	Tue, 21 Jul 2020 00:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jufrYHQY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="A/Y6U92+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zXjQJuTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C89208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jxgR5-0002fU-76; Tue, 21 Jul 2020 00:47:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jxgR3-0002ev-BC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jul 2020 00:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBgrV+eTvwjThrJdRMA7qThhYinOXoc6RS11+lev5MU=; b=jufrYHQYkz3oS92lY7o97poa0q
 W3H5Li4LcyiTejuwrmcMtLhGTxy81bSdXtloGRc56oPVmxgDB8Gf1l+XIiRr35qAijzt+6/0JEXMU
 FZ7H77lu0Adr/D+qiS1c9a0+39oL90FgwjuJ1YjdHigEgNIacahx/g9omLDUqzKD3N5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hBgrV+eTvwjThrJdRMA7qThhYinOXoc6RS11+lev5MU=; b=A/Y6U92+v6RKh8hAKJ4JToZujK
 IvKsECjtrXX0VFXB00bUnKk7N/V2Ae9szWbbD9GellaWJ5aGjtDN/xPP4+YVXmREZhMh35vCdB4oG
 GZI4SvTHM4go/gesgkHiHbgQYUNqGpkRWp3k9rEmWi+iYP094YEkXepcpvlaQF+YFTyA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jxgR2-002I4V-6X
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jul 2020 00:47:09 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9DD2A208E4;
 Tue, 21 Jul 2020 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595292422;
 bh=0QnEc0nhtyk6CxnNn+Ogs09Y6WAEOsObn2/QrbH0wAg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zXjQJuTgwjsyBP/XIuwwWrk6+fGv2stjiMFEQrUAFDaawwAvnoRXp1XPdTNkjL7f7
 Yq2vvfw7fzPXBERGoijQO416KaAO0tQVnbatWBAqcRkPJO4GA4bQePcshNfWFYfpj8
 Fp8fFI1madGtLCD/K0QHmHE4XguNU6m/Ot+r+LoM=
Date: Mon, 20 Jul 2020 17:47:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200721004701.GD7464@sol.localdomain>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-8-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720233739.824943-8-satyat@google.com>
X-Headers-End: 1jxgR2-002I4V-6X
Subject: Re: [f2fs-dev] [PATCH v4 7/7] fscrypt: update documentation for
 direct I/O support
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 20, 2020 at 11:37:39PM +0000, Satya Tangirala wrote:
> Update fscrypt documentation to reflect the addition of direct I/O support
> and document the necessary conditions for direct I/O on encrypted files.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
