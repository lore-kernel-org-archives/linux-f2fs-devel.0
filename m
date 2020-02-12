Return-Path: <SRS0=+fGn=4A=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2FCC2BA83
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:12:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE19206ED
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="At2/6rdJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="P7+fchP4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="raqwjbi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE19206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j1lG8-0000y4-Rd; Wed, 12 Feb 2020 06:12:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1j1lG6-0000xw-Jh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Feb 2020 06:12:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rzNkjeCFYcb6d0RkYynAXPXg3HiNHMUXjzcEueMuP0g=; b=At2/6rdJgzm289vvn+JCQu9TDS
 KnksS7xQexhW02KV/GIARUvpj0ODS+69eBlGFlRtlRd5DvAmCOowqPbQ6FWEzT+AVHk0jsWboDbgi
 lbaZal9ggnL1EtJiH2MLVBjp9nz6sCz3qtAVbuTZ92gAxNjXh2o8bMIAyCTg3HGBtJt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rzNkjeCFYcb6d0RkYynAXPXg3HiNHMUXjzcEueMuP0g=; b=P7+fchP42hU/qQKIOD4Tyyrbbl
 XNmL2KMwdHEJM7x0tz6lteizs6bToX/WTAz1HEqLCP7+7+eLjMz7f5aiQHKoCOQpb3bDl3Oke5okg
 kHwQ10Pjc1qLFIEkp1iUdw5CbZMr5hie5zKCoFSm2pY04T/soiuzK/I+TOwmllZVSIe8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j1lG5-0015Uo-Iy
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Feb 2020 06:12:26 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B3BA206ED;
 Wed, 12 Feb 2020 06:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581487939;
 bh=p9QKtIbrdilhU/XB3DWdE+4oKrcq3A9n3NGMmoeBPPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=raqwjbi5gzH8b9eutCh93MIHFdCbV4Wd2lKnKmfYD/QYHULXrN9X+9e4beJMl+GEX
 N2j6JhwVSj+WuZ1bBya666D8Nfjg9adnCIYhTBJxds5KN4J+3gapEwGTSRfdSshtLM
 kPRpOc7TJOmyAU2t6AMvrD+6TK3HcTCdB73dYpW4=
Date: Tue, 11 Feb 2020 22:12:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Rosenberg <drosen@google.com>
Message-ID: <20200212061217.GK870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-1-drosen@google.com>
X-Headers-End: 1j1lG5-0015Uo-Iy
Subject: Re: [f2fs-dev] [PATCH v7 0/8] Support fof Casefolding and Encryption
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
Cc: kernel-team@android.com, Theodore Ts'o <tytso@mit.edu>,
 Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Feb 07, 2020 at 05:35:44PM -0800, Daniel Rosenberg wrote:
> Support fof Casefolding and Encryption

You should fix the typo in the subject in the next version.  I assumed you'd
notice, but both v6 and v7 have this...

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
