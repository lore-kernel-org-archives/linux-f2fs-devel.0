Return-Path: <SRS0=qzJ6=IX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC9C433C1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Mar 2021 19:24:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB555619D3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Mar 2021 19:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB555619D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lPVbC-0002FV-II; Thu, 25 Mar 2021 19:24:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lPVau-0002Cl-C3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Mar 2021 19:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JSUr/XOaEVfpig1rRAlt1JfAOegleaKd78OyKX26PkQ=; b=GqSm/xR2YbhBgD8bsxMLm0DryP
 Rp9cAovJeCplhOBq94pii0o0sY00xAn9ydgNq5QUjVljTU6syCTYyJW8LL1jGSagtbE0i/zaGjkmN
 tggny3ksMuf6KCxbyoGSvOtau+7T1UFvEgLF3Behl6IPlZrwOPgpLrpD6qr219EjLxeQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JSUr/XOaEVfpig1rRAlt1JfAOegleaKd78OyKX26PkQ=; b=jUPnTaQL3EiYrpEL/2Yh/dVyCF
 VvkpRD5HhSF0GO0fe1547EMfitJg7o0Dsbs//JpSYUAZvxNrL0al6Mo5WUxTq2Vr90o62+8WuzOXL
 lUZA0WLz29jiIw25Tg4C/c/i5YYsYYmFrkI8LBbiu0Xg7o8FYUnwj+2CLMvC43HBgMEY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lPVaq-0005EC-14
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Mar 2021 19:24:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF6A61A14;
 Thu, 25 Mar 2021 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616700265;
 bh=v2b29AUs3Bj/0T+rnMHy1+6cbej0x22tQEJGkL//C2o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sKekDYOHQGkQrJyiIor6517Zyy72wryWiMa63GsFEKRAmvlFTHCyND4FYrVxI9E2s
 5WcmtWrMrq55/IEN/Fj1e7sF5TD9Y8+m6Ch1TonvaNjWx09asB+b8Kor3DBqkVs/3S
 pR1mRJ8GJcr7QfJ9psJ3KWDHoTOCA/p5QIMiKLjhpmNle9BnDRt7ivFuMheGSbVkfl
 QzBLEgzYJmPhmekTUOovHtpywzqvAVo7eOrIQa8Ew13NlqF7hTJnWUyDyd1Lh2dLFB
 NPYdg73QaAmle3YLwj/1pycssLmnLZWeqoxTO2ELxeBvpjJe4o7x9C6irGJvniqDXF
 KlFcvoHbXjHEw==
Date: Thu, 25 Mar 2021 12:24:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <YFzjZ7u31PtAB9vQ@sol.localdomain>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-4-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325000811.1379641-4-shreeya.patel@collabora.com>
X-Headers-End: 1lPVaq-0005EC-14
Subject: Re: [f2fs-dev] [PATCH v4 3/5] fs: unicode: Rename function names
 from utf8 to unicode
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
Cc: tytso@mit.edu, drosen@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 andre.almeida@collabora.com, linux-ext4@vger.kernel.org, krisman@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 25, 2021 at 05:38:09AM +0530, Shreeya Patel wrote:
> Rename the function names from utf8 to unicode for taking the first step
> towards the transformation of utf8-core file into the unicode subsystem
> layer file.
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Can you add some more explanation about why this change is beneficial?  The
functions still seem tied to UTF-8 specifically.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
