Return-Path: <SRS0=oeUr=63=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B02C2D0F6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2020 03:06:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA792176D;
	Wed, 13 May 2020 03:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fDYuo/i/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Lxcgkiwb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBJ5YQv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA792176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jYhjF-0005oU-UF; Wed, 13 May 2020 03:06:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jYhjF-0005oO-5r
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 May 2020 03:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6lRc527hDqspTAGWlA6FJhwYcAYZ8v4zl7cyozxRSg0=; b=fDYuo/i/G2hN2YIZDR6gEoyEgL
 /+aLlEIQM2Cl0XyBIrM/Axj33WgavP0hEagtrxw4dJO9scK/Io5ftz0Wbo1tmFgH7SnpPcF0SyGi9
 owQr++pEDXmVltnwxv8h5J0eBYCVEZqqOtOwSFQWDrSlXEd6YaZbjYqqRvyWgi4TED3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6lRc527hDqspTAGWlA6FJhwYcAYZ8v4zl7cyozxRSg0=; b=Lxcgkiwbwr2OO0D0WqI+y5eVY3
 iqLYgAVoDSHZ91p+XbNB+v4gvHhhIja5k0L1yZ8So5VBxjyuieJiYe4b9pviQ9l+jHwoGY6Qv1ACp
 Hc5UTaE7dBvperc7VQv3Mx4mCA35kKxd13dZ+14vjUGFE9/vrbbEfeEUsygf/7veEVmQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jYhj9-00480L-OJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 May 2020 03:06:41 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49BB12176D;
 Wed, 13 May 2020 03:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589339190;
 bh=6a9BGuNMOSYRQS1ZxzXqpxbWopV28GpPsuZDDKjLf68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XBJ5YQv7zqIJqlTjbjaek7JZn8sJW0TLMnzrCErzt8wrRpY3oPrNjyxb0OPeeMqSk
 J7mESAq77RDWvpR4KYxFwjufOwYWSMjMRikq8ikdt6xIqRsUf1E8LNfMFo0hyAabxQ
 F+wijFS5G4ipYowVWG4YYuPKAKHqAiVwa0ui+PRA=
Date: Tue, 12 May 2020 20:06:29 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20200513030629.GA108075@google.com>
References: <20200512233251.118314-1-ebiggers@kernel.org>
 <20200512233251.118314-2-ebiggers@kernel.org>
 <20200513005355.GE1596452@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513005355.GE1596452@mit.edu>
X-Headers-End: 1jYhj9-00480L-OJ
Subject: Re: [f2fs-dev] [PATCH 1/4] linux/parser.h: add include guards
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/12, Theodore Y. Ts'o wrote:
> On Tue, May 12, 2020 at 04:32:48PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > <linux/parser.h> is missing include guards.  Add them.
> > 
> > This is needed to allow declaring a function in <linux/fscrypt.h> that
> > takes a substring_t parameter.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
