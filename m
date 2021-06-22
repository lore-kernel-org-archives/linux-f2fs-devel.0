Return-Path: <SRS0=LspV=LQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C865C48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:10:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF46F600D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF46F600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lvi2p-0003y9-7j; Tue, 22 Jun 2021 15:10:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1lvi2n-0003xz-BI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Jun 2021 15:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X06GfhUuae84khvKqcNZYod+psjtA/ceV+8SDOTJuQQ=; b=WJbwQkgbRGCeviCqrN8xB4ersn
 +WtslQG75KhxghVBkhVMDF+zWLOWSdBvVzPAc4sUO9mtV2tmuwA2+rGUR8zNyKdPrk01RcpiPA0Tr
 wwNj7j/gTtH5DmCkfsMwDuC6n+TNAgLA49XGXi/D2E43ngMiXOhkIFjJWufwhj74a5qg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X06GfhUuae84khvKqcNZYod+psjtA/ceV+8SDOTJuQQ=; b=VQTVjH9NGVSSXWZwkoB+JJe4Yk
 3WbgMk0fZx0T5WE1IQosk9nmR9HQmWNkEqf9nP3CrAqn2k9QPVFD6YXBSf5ndBfa3rCcTpZzuN9R6
 Ax1E36BEoPMJDPPp40xFWhBmeJl9GgRSeMU8v9F9YN7j67GUIYAoisml7+eWVIfBrsac=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lvi2h-007QeY-Ji
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Jun 2021 15:10:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2038B600D3;
 Tue, 22 Jun 2021 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624374617;
 bh=0HDMdoBlUeZK0tFRZdne+++P8caT6G7FmLWZO2pSOwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z2m9s7EgcYEWDpWVS1ouYfTMmjU6DGDg0hZYaCO2RVgcVTtwHTVA6qlOrB7xELQus
 UFIjmvZv2WusXaO5M8UWkUzzCe4M1YQQM/CxXXzr6NYDNj9+zMwuR7uLR7VIPRSyi5
 X66RUvg+WlZ+NXyL2yNroZWhfUdUxhs9vQuVUWUO39uSUnx2f3iyFyD5/LqYV+pSnF
 IkSvHUyJxSKw4HV4TI2Mp0+qKdaQ9uvtd7clCBBBOFM7ebrkGgEBKwmE1QcyQCUi74
 gcDg136qUEnhdhhMf4gVLGZ7k+E6xwq8WDioWg6rtKcc7ssAuKYxTooi6QNvkTAvuK
 LnNz8GzuLGv4A==
Date: Tue, 22 Jun 2021 08:10:15 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Message-ID: <YNH9V+gHPHkji1ah@google.com>
References: <20210611073111.947552-1-robinh3123@gmail.com>
 <20210622133357.GA1003@bug>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210622133357.GA1003@bug>
X-Headers-End: 1lvi2h-007QeY-Ji
Subject: Re: [f2fs-dev] [PATCH] sload.f2fs: Reword "IMMUTABLE" in
 strings/comments
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
Cc: Robin Hsu <robinh3123@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/22, Pavel Machek wrote:
> Hi!
> 
> > Since the IMMUTABLE flag for compression is now changed
> > to F2FS_COMPRESS_RELEASED, some 'IMMUTABLE' words should be changed too:
> > 	1. sload help page
> > 	2. inline comments
> > 
> > Signed-off-by: Robin Hsu <robinhsu@google.com>
> 
> > @@ -650,7 +651,7 @@ void f2fs_parse_options(int argc, char *argv[])
> >  				}
> >  				c.compress.min_blocks = val;
> >  				break;
> > -			case 'r': /* compress file to set IMMUTABLE */
> > +			case 'r': /* for setting F2FS_COMOPRESS_RELEASE */
> 
> Typo.

Ah, fixed. Thank you~

> 
> Best regards,
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
